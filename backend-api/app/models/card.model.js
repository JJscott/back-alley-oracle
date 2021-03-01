const knex = require('../helpers/database')
const { logger } = require('../helpers/logger');
const moduleLogger = logger.child({ module: 'card.model' });

// hasher
const Hashids = require('hashids/cjs')
const cardIdHasher = new Hashids('oracle', 10);


const rowToCard = row => {
  if (!(row)) return [];

  const hashId = cardIdHasher.encode(row.card_id);

  let card = {};

  // card
  card.hash_id = hashId;
  card.object = 'card';

  // template
  card.template_sid = row.template_sid;
  card.name = row.name;
  if (row.pitch !== null) card.pitch = row.pitch;
  if (row.cost !== null) card.cost = row.cost;
  if (row.cost_var !== null) card.varCost = row.cost_var;
  if (row.power !== null) card.power = row.power;
  if (row.power_var !== null) card.power = row.power;
  if (row.defense !== null) card.defense = row.defense;
  if (row.defense_var !== null) card.defense = row.defense;
  if (row.intellect !== null) card.intellect = row.intellect;
  if (row.life !== null) card.life = row.life;
  if (row.handedness !== null) card.handedness = row.handedness;
  if (row.specialization !== null) card.specialization = row.specialization;
  card.legendary = row.legendary;
  card.class = row.class;
  card.type = row.type;
  card.subtypes = (row.subtypes_arr !== null) ? row.subtypes_arr : [];

  // face
  card.face_sid = row.face_sid;
  card.artist_name = row.artist_name;
  card.set_number = row.set_number;
  card.set_code = row.set_code;
  card.set_name = row.set_name;
  card.set_type = row.set_type_name;
  card.booster = row.booster;
  card.draftable = row.draftable;
  card.promo = row.promo;
  card.code = row.code;
  card.rules_text = row.rules_text;
  card.flavor_text = row.flavor_text;
  card.rarity_code = row.rarity_code;
  card.rarity_name = row.rarity_name;
  card.art_type_code = row.art_type_code;
  card.art_type_name = row.art_type_name;
  card.frame_style = row.frame_style;
  if (row.frame_color !== null) card.frame_color = row.frame_color;

  card.image_uris = {
    png: process.env.IMG_URL + 'raw/' + row.image_str + '.png',
    normal: process.env.IMG_URL + 'raw/' + row.image_str + '.png',
    small: process.env.IMG_URL + 'raw/' + row.image_str + '.png',
    thumb: process.env.IMG_URL + 'raw/' + row.image_str + '.png',
  };

  // print
  card.card_print_sid = row.card_print_sid;
  card.finish_type_code = row.finish_type_code;
  card.finish_type_name = row.finish_type_name;
  card.layout = row.layout;
  card.group_code = row.group_code;
  card.group_name = row.group_name;
  card.date_printed = row.date_printed;
  card.date_released = row.date_released;
  // ?? nzId ??
  // tcgPlayerId
  // cardMerchantId

  card.squire_uri = `${process.env.WEB_URL}cards/${hashId}`;

  // if (row.pitch !== null)
  // card.printsUri = `${process.env.API_URL}cards/search?q=name:"${row.name}"%20${}`;

  return card;
};



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
        q = q.where(key,'ILIKE',`%${str}%`);
      });
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











// TODO add a strict option that if more than one result is found throw and error?
exports.getOne = async (hashId) => {
  const cardId = cardIdHasher.decode(hashId)[0];
  console.log(hashId);
  console.log(cardId);
  let result = [];

  await knex
    .select('*')
    .from({prints:'mv_cards'})
    .where('card_id', cardId)
    .then(rows => {
      result = rowToCard(rows[0]);
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
    .from('mv_cards')
    .orderByRaw('random()')
    .limit(1)
    .then(rows => {
      result = rowToCard(rows[0]);
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
  let query = knex
    .select()
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
      cardRows = rows.map(rowToCard);
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
