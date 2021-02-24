const knex = require('../helpers/database')
const { logger } = require('../helpers/logger');
const moduleLogger = logger.child({ module: 'card.model' });



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
      value.forEach(str => {
        q = q.where(key,'LIKE',`%${str}%`);
      });
    } else {
      q = q.where(key,'LIKE',`%${value}%`);
    }
  }
  //TODO throw
  return q;
};

const subtypeWhereClause = (key, op, value, query) => {
  const subquery = knex
    .select('cardTemplateSubtypes.cardTemplateId')
    .from('cardTemplateSubtypes')
    .join('cardSubtypes', 'cardTemplateSubtypes.cardSubtypeId', 'cardSubtypes.id')
    .whereRaw('subtype IN ( ? )', [value]);
  switch (op) {
    case ':' : return query.whereIn('templateId', subquery);
    case '!:': return query.whereNotIn('templateId', subquery);
  }
  // TODO throw
};

const keywordWhereClause = (key, op, value, query) => {
  const subquery = knex
    .select('cardTemplateKeywords.cardTemplateId')
    .from('cardTemplateKeywords')
    .join('cardKeywords', 'cardTemplateKeywords.cardKeywordId', 'cardKeywords.id')
    .whereRaw('keyword IN ( ? )', [value]);
  switch (op) {
    case ':' : return query.whereIn('templateId', subquery);
    case '!:': return query.whereNotIn('templateId', subquery);
  }
  // TODO throw
};











// TODO add a strict option that if more than one result is found throw and error?
exports.getOne = async ({ searchOptions={} }) => {
  let result = [];
  await knex
    .select('prints.*', 'faces.*', 'templates.*')
    .from({prints:'v_cards'})
    .where(searchOptions)
    .then(rows => {
      result = rows[0] || [];
    })
    .catch(err => {
      moduleLogger.error(err);
      throw err;
    });
  return result;
}



exports.getRandom = async () => {
  let result = [];
  await knex
    .select('*')
    .from('v_cards')
    .groupBy('printId') // need groupBy to ensure even distribution for prints
    .orderByRaw('RAND()')
    .limit(1)
    .then(rows => {
      result = rows[0] || [];
    })
    .catch(err => {
      moduleLogger.error(err);
      throw err;
    });
  return result;
}



exports.findAll = async ({
  searchOptions={},
  // pageOptions={page:1,limit:60},
  // orderBy='templateSid ASC',
  // unique='templateId'
} = {}) => {

  let result = [];


  // unique card
  let inner_query = knex.raw(`
    SELECT
      v_cards.*,
      ROW_NUMBER() OVER (
        PARTITION BY cardTemplateId 
        ORDER BY
          booster DESC,
          dateReleased DESC,
          finishTypeRank ASC,
          artTypeRank ASC
      ) row_num
    FROM v_cards
  `);

  let query = knex
    .with('ordered', inner_query)
    .select()
    .from('ordered')
    .where('row_num', 1)
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
      case 'rulesText':
      case 'flavorText':
        stringLikeWhereClause(key, op, value, query);
        break;
      case 'subtype':
        subtypeWhereClause(key, op, value, query);
        break;
      case 'keyword':
        keywordWhereClause(key, op, value, query);
        break;
      //TODO throw
    }
  });

  let totalCount;
  let cardRows;

  await knex
    .count('*', {as:'total'}) // frontPrintFaceId
    .from(query)
    .then(rows => {
      console.log(rows);
      totalCount = rows[0].total;
    })
    .catch(err => {
      moduleLogger.error(err);
      throw err;
    });

  await knex
    .select('*')
    .from(query)
    // .limit(pageOptions.limit)
    // .offset((pageOptions.page-1) * pageOptions.limit)
    .then(rows => {
      cardRows = rows;
    })
    .catch(err => {
      moduleLogger.error(err);
      throw err;
    });

  return {
    totalCount: totalCount,
    rows: cardRows
  };
}



// // requires array of printIds 
// // returns a map of cardFaceId to card face information
// exports.getBackFaces = async (backFaceIds=[]) => {
//   let faceRows = [];
//   await knex
//     .select('faces.*', 'templates.*')
//     .from({faces:'dnCardFaces'})
//     .leftJoin({templates:'dnCardTemplates'}, 'templates.id', 'faces.cardTemplateId')
//     .whereIn('faceId', backFaceIds)
//     .then(rows => {
//       result = rows[0] || [];
//     });
//   return result;
// }




// exports.findAllCycles = async ({ searchOptions={} }) => {
//   let result = [];

//   // query to find card data
//   const cardQuery = knex
//     .select('prints.*', 'faces.*', 'templates.*')
//     .from({prints:'dnCardPrints'})
//     .leftJoin({faces:'dnCardFaces'}, 'faces.faceId', 'prints.frontCardFaceId')
//     .leftJoin({templates:'dnCardTemplates'}, 'templates.templateId', 'faces.cardTemplateId')
//     .where(searchOptions)
//     .limit(1)
//     .as(target)

//   await knex
//     .select('prints.*', 'faces.*', 'templates.*')
//     .from({prints:'dnCardPrints'})
//     .leftJoin({faces:'dnCardFaces'}, 'faces.faceId', 'prints.frontCardFaceId')
//     .leftJoin({templates:'dnCardTemplates'}, 'templates.templateId', 'faces.cardTemplateId')
//     .where(searchOptions)
//     .then(rows => {
//       result = rows[0] || [];
//     })
//     .catch(err => {
//       moduleLogger.error(err);
//       throw err;
//     });
//   return result;
// }
