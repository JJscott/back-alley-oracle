-- migrate:up

CREATE MATERIALIZED VIEW mv_cardSets AS
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
LEFT JOIN cardSetTypes ON cardSetTypes.id = cardSets.cardSetTypeId;


CREATE MATERIALIZED VIEW mv_cards AS
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
    backPrintFace.cardFaceId AS backCardFaceId,
    backFaces.imageStr AS backFaceImageStr
FROM cardPrints
    INNER JOIN cardPrintFaces frontPrintFace ON frontPrintFace.cardPrintId = cardPrints.id
    LEFT JOIN cardPrintFaces backPrintFace ON backPrintFace.cardPrintId = frontPrintFace.cardPrintId AND backPrintFace.id <> frontPrintFace.id
    INNER JOIN cardFaces ON cardFaces.id = frontPrintFace.cardFaceId
    INNER JOIN cardFaces backFaces ON backFaces.id = backPrintFace.cardFaceId
    INNER JOIN cardTemplates ON cardTemplates.id = cardFaces.cardTemplateId
    LEFT JOIN cardNames ON cardNames.id = cardTemplates.cardNameId
    LEFT JOIN cardClasses ON cardClasses.id = cardTemplates.cardClassId
    LEFT JOIN cardSpecializations ON cardSpecializations.id = cardTemplates.cardSpecializationId
    LEFT JOIN cardTypes ON cardTypes.id = cardTemplates.cardTypeId
    LEFT JOIN cardTemplateSubtypes ON cardTemplateSubtypes.cardTemplateId = cardTemplates.id
    LEFT JOIN (
        SELECT cardTemplateId, ARRAY_AGG(cardSubtypes.subtype) subtypes_csv
        FROM cardTemplateSubtypes
            LEFT JOIN cardSubtypes ON cardSubtypes.id = cardTemplateSubtypes.cardSubtypeId
        GROUP BY cardTemplateId
    ) cardSubtypesCSV ON cardSubtypesCSV.cardTemplateId = cardTemplates.id
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



-- migrate:down

DROP MATERIALIZED VIEW mv_cards;
DROP MATERIALIZED VIEW mv_cardSets;