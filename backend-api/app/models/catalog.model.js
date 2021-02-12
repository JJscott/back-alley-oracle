const knex = require('../helpers/database')

exports.findAllCardNames = async () => {
  let result = [];
  await knex('cardNames')
    .orderBy('name')
    .then(rows => {
      result = rows.map(row => row.name);
    });
  return result;
}

exports.findAllCardClasses = async () => {
  let result = [];
  await knex('cardClasses')
    .orderByRaw(`(class = 'Generic') DESC, class ASC`)
    .then(rows => {
      result = rows.map(row => row.class);
    });
  return result;
}

exports.findAllCardTypes = async () => {
  let result = [];
  await knex('cardTypes')
    .orderBy('type')
    .then(rows => {
      result = rows.map(row => row.type);
    });
  return result;
}

exports.findAllCardSubtypes = async () => {
  let result = [];
  await knex('cardSubtypes')
    .orderBy('subtype')
    .then(rows => {
      result = rows.map(row => row.subtype);
    });
  return result;
}

exports.findAllCardTypesAndSubtypes = async () => {
  let result = [];
  await knex('cardTypes')
    .select('type', 'subtype')
    .distinct('type', 'subtype')
    .leftJoin('cardTemplates', 'cardTemplates.cardTypeId', 'cardTypes.id')
    .leftJoin('cardTemplateSubtypes', 'cardTemplateSubtypes.cardTemplateId', 'cardTemplates.id')
    .leftJoin('cardSubtypes', 'cardSubtypes.id', 'cardTemplateSubtypes.cardSubtypeId')
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
  await knex('cardSpecializations')
    .orderBy('specialization')
    .then(rows => {
      result = rows.map(row => row.specialization);
    });
  return result;
}

exports.findAllCardKeywords = async () => {
  let result = [];
  await knex('cardKeywords')
    .orderBy('keyword')
    .then(rows => {
      result = rows.map(row => row.keyword);
    });
  return result;
}

exports.findAllCardRarities = async () => {
  let result = [];
  await knex('cardRarities')
    .orderBy('rarityRank')
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
  await knex('cardArtTypes')
    .orderBy('artTypeRank')
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
  await knex('cardFinishTypes')
    .orderBy('finishTypeRank')
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
