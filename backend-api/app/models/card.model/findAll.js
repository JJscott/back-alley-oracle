const knex = require('../../helpers/database')
const { rowToCard, rowsToCycles } = require('./rowToCard')
const { logger } = require('../../helpers/logger')
const moduleLogger = logger.child({ module: 'card.model' })



const numericWhereClause = (key, op, value, query) => {
    let sql;
    if (Array.isArray(value)) {      
        switch (op) {
            case '=' : sql = `${key} IN( ? )`; break;
            case '!=': sql = `${key} NOT IN( ? )`; break;
            case '<' : sql = `${key} < LEAST( ? )`; break;
            case '<=': sql = `${key} <= LEAST( ? )`; break;
            case '>' : sql = `${key} > GREATEST( ? )`; break;
            case '>=': sql = `${key} >= GREATEST( ? )`; break;
            //TODO throw
        }
    }
    else {
        switch (op) {
            case '=' : sql = `${key} = ?`; break;
            case '!=': sql = `${key} != ?`; break;
            case '<' : sql = `${key} < ?`; break;
            case '<=': sql = `${key} <= ?`; break;
            case '>' : sql = `${key} > ?`; break;
            case '>=': sql = `${key} >= ?`; break;
            //TODO throw
        }
    }
    return query.whereRaw(sql, [value]);
};



const stringExactWhereClause = (key, op, value, query) => {
    let sql;
    if (Array.isArray(value)) {
        switch (op) {
            case ':' : sql = `${key} IN ( ? )`; break;
            case '!:': sql = `${key} NOT IN ( ? )`; break;
            //TODO throw
        }
    }
    else {
        switch (op) {
            case ':' : sql = `${key} = ?`; break;
            case '!:': sql = `${key} != ?`; break;
            //TODO throw
        }
    }
    return query.whereRaw(sql, [value]);
};



const stringLikeWhereClause = (key, op, value, query) => {
    let q = query;
    if (op === ':') {
        if (Array.isArray(value)) {
            value.forEach(str => { q = q.where(key,'ILIKE',`%${str}%`); });
        } else {
            q = q.where(key,'ILIKE',`%${value}%`);
        }
    }
    //TODO throw
    return q;
};



const subtypeWhereClause = (key, op, value, query) => {
    const subquery = knex
        .select('card_template_subtypes.card_template_id')
        .from('card_template_subtypes')
        .join('card_subtypes', 'card_template_subtypes.card_subtype_id', 'card_subtypes.id')
        .whereRaw('subtype IN ( ? )', [value]);
    switch (op) {
        case ':' : return query.whereIn('template_id', subquery);
        case '!:': return query.whereNotIn('template_id', subquery);
    }
    // TODO throw
};



const findAllPrints = async (query, pageOptions) => {
    await knex
        .count('*', {as:'total'})
        .from(query)
        .then(rows => { totalCount = rows[0].total; })
        .catch(err => { moduleLogger.error(err); throw err; });
    
    await knex
        .select('*')
        .from(query)
        .limit(pageOptions.limit)
        .offset((pageOptions.page-1) * pageOptions.limit)
        .then(rows => { cardRows = rows.map(rowToCard); })
        .catch(err => { moduleLogger.error(err); throw err; });

    return {
        totalCount: totalCount,
        rows: cardRows
    };
};



const findAllCards = async (query, pageOptions) => {
    // remove duplicate templates
    query = knex
        .select()
        .from(query)
        .where('template_rank', 1)
        .as('results');

    await knex
        .count('*', {as:'total'})
        .from(query)
        .then(rows => { totalCount = rows[0].total; })
        .catch(err => { moduleLogger.error(err); throw err; });

    await knex
        .select('*')
        .from(query)
        .limit(pageOptions.limit)
        .offset((pageOptions.page-1) * pageOptions.limit)
        .then(rows => { cardRows = rows.map(rowToCard); })
        .catch(err => { moduleLogger.error(err); throw err; });

    return {
        totalCount: totalCount,
        rows: cardRows
    };
};



const findAllCycles = async (query, pageOptions) => {
    // remove duplicate templates and group by name
    query = knex
        .select(knex.raw(`
            *,
            DENSE_RANK() OVER (
                ORDER BY name
            ) AS cycle_group`))
        .from(query)
        .where('template_rank', 1)
        .orderBy(['cycle_group', 'pitch'])
        .as('results');

    const pageStart = (pageOptions.page - 1) * pageOptions.limit;
    const pageEnd = pageOptions.page * pageOptions.limit;
    
    await knex
        .max({ total: 'cycle_group' })
        .from(query)
        .then(rows => { totalCount = rows[0].total; })
        .catch(err => { moduleLogger.error(err); throw err; });

    await knex
        .select('*')
        .from(query)
        .where('cycle_group', '>=', pageStart)
        .where('cycle_group', '<', pageEnd)
        .then(rows => { cycleRows = rowsToCycles(rows); })
        .catch(err => { moduleLogger.error(err); throw err; });
    return {
        totalCount: totalCount,
        rows: cycleRows
    };
};



exports.findAll = async ({
    searchOptions={},
    pageOptions={page:1,limit:60},
    // orderBy='templateSid ASC',
    unique='cards'
} = {}) => {

    let result = [];

    // unique card
    let query = knex
        .select(knex.raw(`
            *,
            ROW_NUMBER() OVER (
                PARTITION BY card_template_id 
                ORDER BY
                    set_type_rank ASC,
                    date_released DESC NULL LAST,
                    finish_type_rank ASC,
                    art_type_rank ASC
            ) AS template_rank`))
        .from('mv_cards')
        .as('results');

    // iterate through each key-value pair in searchOptions
    searchOptions.forEach(({key, op, value}) => {
        console.log(`${key} ${op} ${value}`);
        switch (key) {
        case 'pitch':
        case 'cost':
        case 'power':
        case 'defense':
        case 'life':
        case 'intellect':
        case 'handedness':
            numericWhereClause(key, op, value, query);
            break;
        case 'class':
        case 'specialization':
        case 'type':
            stringExactWhereClause(key, op, value, query);
            break;
        case 'name':
        case 'rules_text':
        case 'flavor_text':
            stringLikeWhereClause(key, op, value, query);
            break;
        case 'subtype':
            subtypeWhereClause(key, op, value, query);
            break;
        //TODO throw
        }
    });

    if (unique == 'prints') {
        return await findAllPrints(query, pageOptions);
    }
    else if (unique === 'cards') {
        return await findAllCards(query, pageOptions);
    }
    else if (unique === 'cycles') {
        return await findAllCycles(query, pageOptions);
    }
}