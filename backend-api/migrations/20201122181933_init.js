
exports.up = function(knex) {
  return knex.schema

    // Set / Group
    .createTable('cardSetTypes', table => {
      table.increments('id').primary();
      table.string('setTypeName').notNullable().unique();
      table.integer('setTypeRank').notNullable().unique();
      table.boolean('booster').notNullable();
      table.boolean('draftable').notNullable();
      table.boolean('promo').notNullable();
    })
    .createTable('cardSets', table => {
      table.increments('id').primary();
      table.string('setCode').notNullable().unique();
      table.string('setName').notNullable().unique();
      table.integer('cardSetTypeId').unsigned().references('cardSetTypes.id');
      table.integer('parentSetId').unsigned().references('cardSets.id');
    })
    .createTable('cardGroups', table => {
      table.increments('id').primary();
      table.string('groupCode').notNullable().unique();
      table.string('groupName').notNullable().unique();
      table.date('datePrinted');
      table.date('dateReleased');
    })

    // Card Template
    .createTable('cardNames', table => {
      table.increments('id').primary();
      table.string('name').notNullable().unique();
    })
    .createTable('cardClasses', table => {
      table.increments('id').primary();
      table.string('class').notNullable().unique();
    })
    .createTable('cardTypes', table => {
      table.increments('id').primary();
      table.string('type').notNullable().unique();
    })
    .createTable('cardSubtypes', table => {
      table.increments('id').primary();
      table.string('subtype').notNullable().unique();
    })
    .createTable('cardSpecializations', table => {
      table.increments('id').primary();
      table.string('specialization').notNullable().unique();
    })
    .createTable('cardKeywords', table => {
      table.increments('id').primary();
      table.string('keyword').notNullable().unique();
    })
    .createTable('cardTemplates', table => {
      table.increments('id').primary();
      table.string('templateSid').notNullable().unique();
      table.integer('pitch');
      table.integer('cost');
      table.string('varCost');
      table.integer('power');
      table.string('varPower');
      table.integer('defense');
      table.string('varDefense');
      table.integer('intellect');
      table.integer('life');
      table.integer('handedness');
      table.boolean('legendary').notNullable();
      table.integer('cardNameId').unsigned().references('cardNames.id');
      table.integer('cardClassId').unsigned().references('cardClasses.id');
      table.integer('cardTypeId').unsigned().references('cardTypes.id');
      table.integer('cardSpecializationId').unsigned().references('cardSpecializations.id');
    })
    .createTable('cardTemplateSubtypes', table => {
      table.increments('id').primary();
      table.integer('cardTemplateId').unsigned().references('cardTemplates.id');
      table.integer('cardSubtypeId').unsigned().references('cardSubtypes.id');
    })
    .createTable('cardTemplateKeywords', table => {
      table.increments('id').primary();
      table.integer('cardTemplateId').unsigned().references('cardTemplates.id');
      table.integer('cardKeywordId').unsigned().references('cardKeywords.id');
    })

    // Card Face
    .createTable('cardRarities', table => {
      table.increments('id').primary();
      table.string('rarityCode').notNullable().unique();
      table.string('rarityName').notNullable().unique();
      table.integer('rarityRank').notNullable().unique();
    })
    .createTable('cardArtTypes', table => {
      table.increments('id').primary();
      table.string('artTypeCode').notNullable().unique();
      table.string('artTypeName').notNullable().unique();
      table.integer('artTypeRank').notNullable().unique();
    })
    .createTable('cardFrameStyles', table => {
      table.increments('id').primary();
      table.string('frameStyle').notNullable().unique();
    })
    .createTable('cardFrameAltColors', table => {
      table.increments('id').primary();
      table.string('frameAltColor').notNullable().unique();
    })
    .createTable('cardArtists', table => {
      table.increments('id').primary();
      table.string('artistName').notNullable().unique();
    })
    .createTable('cardFaces', table => {
      table.increments('id').primary();
      table.string('faceSid').notNullable().unique();
      table.integer('setNumber').notNullable();
      table.string('imageStr').notNullable();
      table.string('code').notNullable();
      table.string('rulesText', 1000);
      table.string('flavorText', 1000);
      table.integer('cardTemplateId').unsigned().references('cardTemplates.id');
      table.integer('cardSetId').unsigned().references('cardSets.id');
      table.integer('cardRarityId').unsigned().references('cardRarities.id');
      table.integer('cardArtTypeId').unsigned().references('cardArtTypes.id');
      table.integer('cardFrameStyleId').unsigned().references('cardFrameStyles.id');
      table.integer('cardFrameAltColorId').unsigned().references('cardFrameAltColors.id');
      table.integer('cardArtistId').unsigned().references('cardArtists.id');
    })

    // Card Print
    .createTable('cardFinishTypes', table => {
      table.increments('id').primary();
      table.string('finishTypeCode').notNullable().unique();
      table.string('finishTypeName').notNullable().unique();
      table.integer('finishTypeRank').notNullable().unique();
    })
    .createTable('cardLayouts', table => {
      table.increments('id').primary();
      table.string('layout').notNullable().unique();
    })
    .createTable('cardPrints', table => {
      table.increments('id').primary();
      table.string('printSid').notNullable().unique();
      table.integer('cardFinishTypeId').unsigned().references('cardFinishTypes.id');
      table.integer('cardLayoutId').unsigned().references('cardLayouts.id');
      table.integer('cardGroupId').unsigned().references('cardGroups.id');
    })
    .createTable('cardPrintFaces', table => {
      table.increments('id').primary();
      table.integer('cardPrintId').unsigned().references('cardPrints.id');
      table.integer('cardFaceId').unsigned().references('cardFaces.id');
    })

    // Helper views
    .raw(`
      SELECT DATABASE();
      CREATE VIEW v_cardSets AS
      SELECT 
        cardSets.id AS setId,
        cardSets.setCode,
        cardSets.setName,
        cardSetTypes.setTypeName,
        cardSetTypes.setTypeRank,
        cardSetTypes.booster,
        cardSetTypes.draftable,
        cardSetTypes.promo
      FROM cardSets
      LEFT JOIN cardSetTypes ON cardSets.cardSetTypeId = cardSetTypes.id;
    `)
    .raw(`
      CREATE VIEW v_cards AS
      SELECT
        frontPrintFace.id AS cardId,
        cardTemplates.id AS templateId,
        cardTemplates.templateSid,
        cardTemplates.pitch,
        cardTemplates.cost,
        cardTemplates.varCost,
        cardTemplates.power,
        cardTemplates.varPower,
        cardTemplates.defense,
        cardTemplates.varDefense,
        cardTemplates.intellect,
        cardTemplates.life,
        cardTemplates.handedness,
        cardTemplates.legendary,
        cardNames.name,
        cardClasses.class,
        cardSpecializations.specialization,
        cardTypes.type,
        cardSubtypesCSV.subtypes_csv,
        cardKeywordsCSV.keywords_csv,
        cardFaces.id AS faceId,
        cardFaces.faceSid,
        cardFaces.setNumber,
        cardFaces.imageStr,
        cardFaces.code,
        cardFaces.rulesText,
        cardFaces.flavorText,
        cardFaces.cardTemplateId,
        cardSets.setCode,
        cardSets.setName,
        cardSetTypes.setTypeName,
        cardSetTypes.setTypeRank,
        cardSetTypes.booster,
        cardSetTypes.draftable,
        cardSetTypes.promo,
        cardRarities.rarityCode,
        cardRarities.rarityName,
        cardRarities.rarityRank,
        cardArtTypes.artTypeCode,
        cardArtTypes.artTypeName,
        cardArtTypes.artTypeRank,
        cardFrameStyles.frameStyle,
        cardFrameAltColors.frameAltColor,
        cardArtists.artistName,
        cardPrints.id AS printId,
        cardPrints.printSid,
        cardFinishTypes.finishTypeCode,
        cardFinishTypes.finishTypeName,
        cardFinishTypes.finishTypeRank,
        cardLayouts.layout,
        cardGroups.groupCode,
        cardGroups.groupName,
        cardGroups.datePrinted,
        cardGroups.dateReleased,
        frontPrintFace.cardFaceId AS frontCardFaceId,
        backPrintFace.cardFaceId AS backCardFaceId
      FROM cardPrints
      INNER JOIN cardPrintFaces frontPrintFace ON frontPrintFace.cardPrintId = cardPrints.id
      LEFT JOIN cardPrintFaces backPrintFace ON backPrintFace.cardPrintId = frontPrintFace.cardPrintId AND backPrintFace.id <> frontPrintFace.id
      INNER JOIN cardFaces ON cardFaces.id = frontPrintFace.cardFaceId
      INNER JOIN cardTemplates ON cardTemplates.id = cardFaces.cardTemplateId
      LEFT JOIN cardNames ON cardNames.id = cardTemplates.cardNameId
      LEFT JOIN cardClasses ON cardClasses.id = cardTemplates.cardClassId
      LEFT JOIN cardSpecializations ON cardSpecializations.id = cardTemplates.cardSpecializationId
      LEFT JOIN cardTypes ON cardTypes.id = cardTemplates.cardTypeId
      LEFT JOIN cardTemplateSubtypes ON cardTemplateSubtypes.cardTemplateId = cardTemplates.id
      LEFT JOIN (
        SELECT cardTemplateId, GROUP_CONCAT(cardSubtypes.subtype) subtypes_csv
        FROM cardTemplateSubtypes
        LEFT JOIN cardSubtypes ON cardSubtypes.id = cardTemplateSubtypes.cardSubtypeId
        GROUP BY cardTemplateId
      ) cardSubtypesCSV ON cardSubtypesCSV.cardTemplateId = cardTemplates.id
      LEFT JOIN cardTemplateKeywords ON cardTemplateKeywords.cardTemplateId = cardTemplates.id
      LEFT JOIN (
        SELECT cardTemplateId, GROUP_CONCAT(cardKeywords.keyword) keywords_csv
        FROM cardTemplateKeywords
        LEFT JOIN cardKeywords ON cardKeywords.id = cardTemplateKeywords.cardKeywordId
        GROUP BY cardTemplateId
      ) cardKeywordsCSV ON cardKeywordsCSV.cardTemplateId = cardTemplates.id
      LEFT JOIN cardSets ON cardSets.id = cardFaces.cardSetId
      LEFT JOIN cardSetTypes ON cardSetTypes.id = cardSets.cardSetTypeId
      LEFT JOIN cardRarities ON cardRarities.id = cardFaces.cardRarityId
      LEFT JOIN cardArtTypes ON cardArtTypes.id = cardFaces.cardArtTypeId
      LEFT JOIN cardFrameStyles ON cardFrameStyles.id = cardFaces.cardFrameStyleId
      LEFT JOIN cardFrameAltColors ON cardFrameAltColors.id = cardFaces.cardFrameAltColorId
      LEFT JOIN cardArtists ON cardArtists.id = cardFaces.cardArtistId
      LEFT JOIN cardFinishTypes ON cardFinishTypes.id = cardPrints.cardFinishTypeId
      LEFT JOIN cardLayouts ON cardLayouts.id = cardPrints.cardLayoutId
      LEFT JOIN cardGroups ON cardGroups.id = cardPrints.cardGroupId;
    `)
};

exports.down = function(knex) {
  return knex.schema
    // Views
    .raw('DROP VIEW IF EXISTS v_cards')
    .raw('DROP VIEW IF EXISTS v_cardSets')
    // Card Print
    .dropTable('cardPrintFaces')
    .dropTable('cardPrints')
    .dropTable('cardLayouts')
    .dropTable('cardFinishTypes')
    // Card Face
    .dropTable('cardFaces')
    .dropTable('cardArtists')
    .dropTable('cardFrameAltColors')
    .dropTable('cardFrameStyles')
    .dropTable('cardArtTypes')
    .dropTable('cardRarities')
    // Card Template
    .dropTable('cardTemplateKeywords')
    .dropTable('cardTemplateSubtypes')
    .dropTable('cardTemplates')
    .dropTable('cardKeywords')
    .dropTable('cardSpecializations')
    .dropTable('cardSubtypes')
    .dropTable('cardTypes')
    .dropTable('cardClasses')
    .dropTable('cardNames')
    // Set / Group
    .dropTable('cardGroups')
    .dropTable('cardSets')
    .dropTable('cardSetTypes')
};
