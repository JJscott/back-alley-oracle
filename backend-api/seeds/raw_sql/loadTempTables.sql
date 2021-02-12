-- loads temp table into the normalized tables and sets up database


-- Ensure we cleanup temp data if last one failed

-- Create a tally table of value 1-100
DROP TABLE IF EXISTS tallyLoader;
CREATE TABLE tallyLoader (n INT NOT NULL PRIMARY KEY);
INSERT INTO tallyLoader (n)
SELECT a.N + b.N * 10 + 1 n
FROM 
	(SELECT 0 AS N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) a
	,(SELECT 0 AS N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) b
ORDER BY n;

-- -- Create a levenshtein distance function
-- DROP FUNCTION IF EXISTS LEVENSHTEIN;

-- DELIMITER $$
-- CREATE FUNCTION LEVENSHTEIN( s1 VARCHAR(255), s2 VARCHAR(255) )
-- 	RETURNS INT
-- 	DETERMINISTIC
-- 	BEGIN
-- 		DECLARE s1_len, s2_len, i, j, c, c_temp, cost INT;
-- 		DECLARE s1_char CHAR;
-- 		-- max strlen=255
-- 		DECLARE cv0, cv1 VARBINARY(256);

-- 		SET s1_len = CHAR_LENGTH(s1), s2_len = CHAR_LENGTH(s2), cv1 = 0x00, j = 1, i = 1, c = 0;

-- 		IF s1 = s2 THEN
-- 			RETURN 0;
-- 		ELSEIF s1_len = 0 THEN
-- 			RETURN s2_len;
-- 		ELSEIF s2_len = 0 THEN
-- 			RETURN s1_len;
-- 		ELSE
-- 			WHILE j <= s2_len DO
-- 				SET cv1 = CONCAT(cv1, UNHEX(HEX(j))), j = j + 1;
-- 			END WHILE;
-- 			WHILE i <= s1_len DO
-- 				SET s1_char = SUBSTRING(s1, i, 1), c = i, cv0 = UNHEX(HEX(i)), j = 1;
-- 				WHILE j <= s2_len DO
-- 					SET c = c + 1;
-- 					IF s1_char = SUBSTRING(s2, j, 1) THEN
-- 						SET cost = 0; ELSE SET cost = 1;
-- 					END IF;
-- 					SET c_temp = CONV(HEX(SUBSTRING(cv1, j, 1)), 16, 10) + cost;
-- 					IF c > c_temp THEN SET c = c_temp; END IF;
-- 					SET c_temp = CONV(HEX(SUBSTRING(cv1, j+1, 1)), 16, 10) + 1;
-- 					IF c > c_temp THEN
-- 						SET c = c_temp;
-- 					END IF;
-- 					SET cv0 = CONCAT(cv0, UNHEX(HEX(c))), j = j + 1;
-- 				END WHILE;
-- 				SET cv1 = cv0, i = i + 1;
-- 			END WHILE;
-- 		END IF;
-- 		RETURN c;
-- 	END$$
-- DELIMITER ;



-- Alter tables to create FULLTEXT search possible
-- ALTER TABLE cardBases
-- ADD FULLTEXT(name) WITH PARSER NGRAM;

-- ALTER TABLE prints
-- ADD FULLTEXT(rulesText) WITH PARSER NGRAM;


-- 
-- SETS
-- 

-- SET TYPES
INSERT IGNORE INTO cardSetTypes (setTypeName, setTypeRank, booster, draftable, promo) VALUES
('core', 0, 1, 1, 0),
('support', 1, 1, 0, 0),
('deck', 2, 0, 0, 0),
('promo', 3, 0, 0, 1);

-- SETS
INSERT IGNORE INTO cardSets (setCode, setName, cardSetTypeId, parentSetId)
SELECT DISTINCT setCode, setName, cardSetTypes.id, NULL
FROM tempCardSets
LEFT JOIN cardSetTypes ON tempCardSets.setType = cardSetTypes.setTypeName;

-- UPDATE children
-- SET children.cardSetParentId = parent.
-- WHERE

-- GROUPS

INSERT IGNORE INTO cardGroups (groupCode, groupName, datePrinted, dateReleased)
SELECT DISTINCT groupCode, groupName, datePrinted, dateReleased
FROM tempCardGroups;





-- 
-- CARD TEMPLATES
-- 

-- NAMES
INSERT IGNORE INTO cardNames (name)
SELECT DISTINCT name
FROM tempCardTemplates
WHERE name IS NOT NULL;

-- CLASSES
INSERT IGNORE INTO cardClasses (class)
SELECT DISTINCT class
FROM tempCardTemplates
WHERE class IS NOT NULL;

-- TYPES
INSERT IGNORE INTO cardTypes (type)
SELECT DISTINCT type
FROM tempCardTemplates
WHERE type IS NOT NULL;

-- SUBTYPES
INSERT IGNORE INTO cardSubtypes (subtype)
SELECT DISTINCT SUBSTRING_INDEX(SUBSTRING_INDEX(tempCardTemplates.subtypes, ',', tallyLoader.n), ',', -1) subtype
FROM tempCardTemplates CROSS JOIN tallyLoader
WHERE tallyLoader.n <= 1 + (LENGTH(tempCardTemplates.subtypes) - LENGTH(REPLACE(tempCardTemplates.subtypes, ',', '')))
ORDER BY subtype;

-- SPECIALIZATIONS
INSERT IGNORE INTO cardSpecializations (specialization)
SELECT DISTINCT specialization
FROM tempCardTemplates
WHERE specialization IS NOT NULL;

-- KEYWORDS
INSERT IGNORE INTO cardKeywords (keyword)
SELECT DISTINCT SUBSTRING_INDEX(SUBSTRING_INDEX(tempCardTemplates.keywords, ',', tallyLoader.n), ',', -1) keyword
FROM tempCardTemplates CROSS JOIN tallyLoader
WHERE tallyLoader.n <= 1 + (LENGTH(tempCardTemplates.keywords) - LENGTH(REPLACE(tempCardTemplates.keywords, ',', '')))
ORDER BY keyword;

-- CARD TEMPLATES
INSERT INTO cardTemplates (
	templateSid, pitch, cost, varCost, power, varPower,
	defense, varDefense, intellect, life, handedness, legendary,
	cardNameId, cardClassId, cardTypeId, cardSpecializationId)
SELECT
	templateId_gen, pitch, cost, varCost, power, varPower,
	defense, varDefense, intellect, life, handedness, legendary,
	cardNames.id, cardClasses.id, cardTypes.id, cardSpecializations.id
FROM tempCardTemplates
LEFT JOIN cardNames ON tempCardTemplates.name = cardNames.name
LEFT JOIN cardClasses ON tempCardTemplates.class = cardClasses.class
LEFT JOIN cardTypes ON tempCardTemplates.type = cardTypes.type
LEFT JOIN cardSpecializations ON tempCardTemplates.specialization = cardSpecializations.specialization;

-- CONNECT TEMPLATE AND SUBTYPES
INSERT IGNORE INTO cardTemplateSubtypes (cardTemplateId, cardSubtypeId)
SELECT DISTINCT idSubtype.id, cardSubtypes.id
FROM (
	SELECT cardTemplates.id, SUBSTRING_INDEX(SUBSTRING_INDEX(tempCardTemplates.subtypes, ',', tallyLoader.n), ',', -1) subtype
	FROM tempCardTemplates
	CROSS JOIN tallyLoader
	LEFT JOIN cardTemplates ON tempCardTemplates.templateId_gen = cardTemplates.templateSid
	WHERE tallyLoader.n <= 1 + (LENGTH(tempCardTemplates.subtypes) - LENGTH(REPLACE(tempCardTemplates.subtypes, ',', '')))
) idSubtype
LEFT JOIN cardSubtypes ON idSubtype.subtype = cardSubtypes.subtype;

-- CONNECT TEMPLATE AND KEYWORDS
INSERT IGNORE INTO cardTemplateKeywords (cardTemplateId, cardKeywordId)
SELECT DISTINCT idKeyword.id, cardKeywords.id
FROM (
	SELECT cardTemplates.id, SUBSTRING_INDEX(SUBSTRING_INDEX(tempCardTemplates.keywords, ',', tallyLoader.n), ',', -1) keyword
	FROM tempCardTemplates
	CROSS JOIN tallyLoader
	LEFT JOIN cardTemplates ON tempCardTemplates.templateId_gen = cardTemplates.templateSid
	WHERE tallyLoader.n <= 1 + (LENGTH(tempCardTemplates.keywords) - LENGTH(REPLACE(tempCardTemplates.keywords, ',', '')))
) idKeyword
LEFT JOIN cardKeywords ON idKeyword.keyword = cardKeywords.keyword;





-- 
-- CARD FACES
-- 

-- RARITIES
INSERT IGNORE INTO cardRarities (rarityCode, rarityName, rarityRank) VALUES
('T', 'Token', 0),
('C', 'Common', 1),
('R', 'Rare', 2),
('S', 'Super Rare', 3),
('M', 'Majestic', 4),
('L', 'Legendary', 5),
('F', 'Fabled', 6),
('P', 'Promotional', 7);

-- ARTS
INSERT IGNORE INTO cardArtTypes (artTypeCode, artTypeName, artTypeRank) VALUES
('NA', 'Normal Art', 0),
('EA', 'Extended Art', 1),
('FA', 'Full Art', 2),
('OA', 'Overlap Art', 3);

-- FRAMESTYLES
INSERT IGNORE INTO cardFrameStyles (frameStyle)
SELECT DISTINCT frameStyle
FROM tempCardFaces
WHERE frameStyle IS NOT NULL;

-- FRAMEALTCOLORS
INSERT IGNORE INTO cardFrameAltColors (frameAltColor)
SELECT DISTINCT frameAltColor
FROM tempCardFaces
WHERE frameAltColor IS NOT NULL;

-- ARTISTS
INSERT IGNORE INTO cardArtists (artistName)
SELECT DISTINCT artistName
FROM tempCardFaces
WHERE artistName IS NOT NULL;

-- CARD FACES
INSERT INTO cardFaces (
	faceSid, setNumber, imageStr, code, rulesText, flavorText,
	cardTemplateId, cardSetId, cardRarityId, cardArtTypeId,
	cardFrameStyleId, cardFrameAltColorId, cardArtistId)
SELECT
	faceId_gen, setNumber, imageStr, code, rulesText, flavorText,
	cardTemplates.id, cardSets.id, cardRarities.id, cardArtTypes.id,
	cardFrameStyles.id, cardFrameAltColors.id, cardArtists.id
FROM tempCardFaces
LEFT JOIN cardTemplates ON tempCardFaces.templateId_ref = cardTemplates.templateSid
LEFT JOIN cardSets ON tempCardFaces.setCode = cardSets.setCode
LEFT JOIN cardRarities ON tempCardFaces.rarityCode = cardRarities.rarityCode
LEFT JOIN cardArtTypes ON tempCardFaces.artTypeCode = cardArtTypes.artTypeCode
LEFT JOIN cardFrameStyles ON tempCardFaces.frameStyle = cardFrameStyles.frameStyle
LEFT JOIN cardFrameAltColors ON tempCardFaces.frameAltColor = cardFrameAltColors.frameAltColor
LEFT JOIN cardArtists ON tempCardFaces.artistName = cardArtists.artistName;



-- 
-- CARD PRINTS
-- 

-- FINISH (FOILS)
INSERT IGNORE INTO cardFinishTypes (finishTypeCode, finishTypeName, finishTypeRank) VALUES
('NF', 'Non Foil', 0),
('RF', 'Rainbow Foil', 10),
('CF', 'Cold Foil', 20),
('GF', 'Cold Foil - Gold', 30);

-- LAYOUTS
INSERT IGNORE INTO cardLayouts (layout)
SELECT DISTINCT layout
FROM tempCardPrints
WHERE layout IS NOT NULL;

-- CARD PRINTS
INSERT INTO cardPrints (printSid, cardFinishTypeId, cardLayoutId, cardGroupId)
SELECT printId_gen, cardFinishTypes.id, cardLayouts.id, cardGroups.id
FROM tempCardPrints
LEFT JOIN cardFinishTypes ON tempCardPrints.finishTypeCode = cardFinishTypes.finishTypeCode
LEFT JOIN cardLayouts ON tempCardPrints.layout = cardLayouts.layout
LEFT JOIN cardGroups ON tempCardPrints.groupCode = cardGroups.groupCode;

-- CONNECT PRINT AND FACES
INSERT IGNORE INTO cardPrintFaces (cardPrintId, cardFaceId)
SELECT DISTINCT idFace.id, cardFaces.id
FROM (
	SELECT cardPrints.id, SUBSTRING_INDEX(SUBSTRING_INDEX(tempCardPrints.faceIds_ref, ',', tallyLoader.n), ',', -1) face
	FROM tempCardPrints
	CROSS JOIN tallyLoader
	LEFT JOIN cardPrints ON tempCardPrints.printId_gen = cardPrints.printSid
	WHERE tallyLoader.n <= 1 + (LENGTH(tempCardPrints.faceIds_ref) - LENGTH(REPLACE(tempCardPrints.faceIds_ref, ',', '')))
) idFace
LEFT JOIN cardFaces ON idFace.face = cardFaces.faceSid;





-- 
-- CLEANUP
-- 

-- TEMP TABLES
DROP TABLE tallyLoader;

DROP TABLE IF EXISTS tempCardTemplates;
DROP TABLE IF EXISTS tempCardFaces;
DROP TABLE IF EXISTS tempCardPrints;
DROP TABLE IF EXISTS tempCardSets;
DROP TABLE IF EXISTS tempCardGroups;
