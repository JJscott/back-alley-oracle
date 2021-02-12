
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
      CREATE VIEW dnCardSets AS
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
      LEFT JOIN cardSetTypes ON cardSets.cardSetTypeId = cardSetTypes.id;`
    )
    .raw(`
      CREATE VIEW dnCardTemplates AS
      SELECT 
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
        cardKeywordsCSV.keywords_csv
      FROM cardTemplates
      LEFT JOIN cardNames ON cardTemplates.cardNameId = cardNames.id
      LEFT JOIN cardClasses ON cardTemplates.cardClassId = cardClasses.id
      LEFT JOIN cardSpecializations ON cardTemplates.cardSpecializationId = cardSpecializations.id
      LEFT JOIN cardTypes ON cardTemplates.cardTypeId = cardTypes.id
      LEFT JOIN cardTemplateSubtypes ON cardTemplates.id = cardTemplateSubtypes.cardTemplateId
      LEFT JOIN (
        SELECT cardTemplateId, GROUP_CONCAT(cardSubtypes.subtype) subtypes_csv
        FROM cardTemplateSubtypes
        LEFT JOIN cardSubtypes ON cardTemplateSubtypes.cardSubtypeId = cardSubtypes.id
        GROUP BY cardTemplateId
      ) cardSubtypesCSV ON cardTemplates.id = cardSubtypesCSV.cardTemplateId
      LEFT JOIN cardTemplateKeywords ON cardTemplates.id = cardTemplateKeywords.cardTemplateId
      LEFT JOIN (
        SELECT cardTemplateId, GROUP_CONCAT(cardKeywords.keyword) keywords_csv
        FROM cardTemplateKeywords
        LEFT JOIN cardKeywords ON cardTemplateKeywords.cardKeywordId = cardKeywords.id
        GROUP BY cardTemplateId
      ) cardKeywordsCSV ON cardTemplates.id = cardKeywordsCSV.cardTemplateId;`
    )
    .raw(`
      CREATE VIEW dnCardFaces AS
      SELECT 
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
        cardArtists.artistName
      FROM cardFaces
      LEFT JOIN cardSets ON cardFaces.cardSetId = cardSets.id
      LEFT JOIN cardSetTypes ON cardSets.cardSetTypeId = cardSetTypes.id
      LEFT JOIN cardRarities ON cardFaces.cardRarityId = cardRarities.id
      LEFT JOIN cardArtTypes ON cardFaces.cardArtTypeId = cardArtTypes.id
      LEFT JOIN cardFrameStyles ON cardFaces.cardFrameStyleId = cardFrameStyles.id
      LEFT JOIN cardFrameAltColors ON cardFaces.cardFrameAltColorId = cardFrameAltColors.id
      LEFT JOIN cardArtists ON cardFaces.cardArtistId = cardArtists.id;`
    )
    .raw(`
      CREATE VIEW dnCardPrints AS
      SELECT
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
        frontPrintFace.id AS frontPrintFaceId,
        frontPrintFace.cardFaceId AS frontCardFaceId,
        backPrintFace.cardFaceId AS backCardFaceId
      FROM cardPrints
      LEFT JOIN cardFinishTypes
        ON cardPrints.cardFinishTypeId = cardFinishTypes.id
      LEFT JOIN cardLayouts
        ON cardPrints.cardLayoutId = cardLayouts.id
      LEFT JOIN cardGroups
        ON cardPrints.cardGroupId = cardGroups.id
      LEFT JOIN cardPrintFaces frontPrintFace
        ON cardPrints.id = frontPrintFace.cardPrintId
      LEFT JOIN cardPrintFaces backPrintFace
        ON frontPrintFace.cardPrintId = backPrintFace.cardPrintId
        AND backPrintFace.id <> frontPrintFace.id;`
    )
    .raw(`
      CREATE VIEW dnUniqueTemplateCardPrints AS
      SELECT unique_prints.*
      FROM (
        SELECT
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
          frontPrintFace.id AS frontPrintFaceId,
          frontPrintFace.cardFaceId AS frontCardFaceId,
          backPrintFace.cardFaceId AS backCardFaceId,
          ROW_NUMBER() OVER (
            PARTITION BY cardTemplateId 
            ORDER BY
              booster DESC,
              dateReleased DESC,
              finishTypeRank ASC,
              artTypeRank ASC
        ) unique_row_num
        FROM cardPrints
        LEFT JOIN cardFinishTypes
          ON cardPrints.cardFinishTypeId = cardFinishTypes.id
        LEFT JOIN cardLayouts
          ON cardPrints.cardLayoutId = cardLayouts.id
        LEFT JOIN cardGroups
          ON cardPrints.cardGroupId = cardGroups.id
        LEFT JOIN cardPrintFaces frontPrintFace
          ON cardPrints.id = frontPrintFace.cardPrintId
        LEFT JOIN cardFaces
          ON frontPrintFace.cardFaceId = cardFaces.id
        LEFT JOIN cardArtTypes
          ON cardFaces.cardArtTypeId = cardArtTypes.id
        LEFT JOIN cardSets
          ON cardFaces.cardSetId = cardSets.id
        LEFT JOIN cardSetTypes
          ON cardSets.cardSetTypeId = cardSetTypes.id
        LEFT JOIN cardPrintFaces backPrintFace
        ON frontPrintFace.cardPrintId = backPrintFace.cardPrintId
          AND backPrintFace.id <> frontPrintFace.id
      ) unique_prints
      WHERE unique_prints.unique_row_num = 1;`
    )
};

exports.down = function(knex) {
  return knex.schema
    // Views
    .raw('DROP VIEW IF EXISTS dnUniqueTemplateCardPrints')
    .raw('DROP VIEW IF EXISTS dnCardPrints')
    .raw('DROP VIEW IF EXISTS dnCardFaces')
    .raw('DROP VIEW IF EXISTS dnCardTemplates')
    .raw('DROP VIEW IF EXISTS dnCardSets')
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
    // Set
    .dropTable('cardGroups')
    .dropTable('cardSets')
    .dropTable('cardSetTypes')
};
