const knex = require('../helpers/database')

exports.findAllCardNames = async () => {
  let result = [];
  await knex('card_names')
    .orderBy('name')
    .then(rows => {
      result = rows.map(row => row.name);
    });
  return result;
}

exports.findAllCardClasses = async () => {
  let result = [];
  await knex('card_classes')
    .orderByRaw(`(class = 'Generic') DESC, class ASC`)
    .then(rows => {
      result = rows.map(row => row.class);
    });
  return result;
}

exports.findAllCardTypes = async () => {
  let result = [];
  await knex('card_types')
    .orderBy('type')
    .then(rows => {
      result = rows.map(row => row.type);
    });
  return result;
}

exports.findAllCardSubtypes = async () => {
  let result = [];
  await knex('card_subtypes')
    .orderBy('subtype')
    .then(rows => {
      result = rows.map(row => row.subtype);
    });
  return result;
}

exports.findAllCardTypesAndSubtypes = async () => {
  let result = [];
  await knex('card_types')
    .select('type', 'subtype')
    .distinct('type', 'subtype')
    .leftJoin('card_templates', 'card_templates.card_type_id', 'card_types.id')
    .leftJoin('card_template_subtypes', 'card_template_subtypes.card_template_id', 'card_templates.id')
    .leftJoin('card_subtypes', 'card_subtypes.id', 'card_template_subtypes.card_subtype_id')
    .orderBy('type')
    .orderBy('subtype')
    .then(rows => {
      result = rows.map(row => {
        return {
          type: row.type,
          subtype: row.subtype
        };
      });
    });
  return result;
}

exports.findAllCardSpecializations = async () => {
  let result = [];
  await knex('card_specializations')
    .orderBy('specialization')
    .then(rows => {
      result = rows.map(row => row.specialization);
    });
  return result;
}

exports.findAllCardKeywords = async () => {
  let result = [];
  await knex('card_keywords')
    .orderBy('keyword')
    .then(rows => {
      result = rows.map(row => row.keyword);
    });
  return result;
}

exports.findAllCardRarities = async () => {
  let result = [];
  await knex('card_rarities')
    .orderBy('rarity_rank')
    .then(rows => {
      result = rows.map(row => {
        return {
          code: row.rarityCode,
          name: row.rarityName
        };
      });
    });
  return result;
}

exports.findAllCardArtTypes = async () => {
  let result = [];
  await knex('card_art_types')
    .orderBy('art_type_rank')
    .then(rows => {
      result = rows.map(row => {
        return {
          code: row.artTypeCode,
          name: row.artTypeName
        };
      });
    });
  return result;
}

exports.findAllCardFinishTypes = async () => {
  let result = [];
  await knex('card_finish_types')
    .orderBy('finish_type_rank')
    .then(rows => {
      result = rows.map(row => {
        return {
          code: row.finishTypeCode,
          name: row.finishTypeName
        };
      });
    });
  return result;
}
