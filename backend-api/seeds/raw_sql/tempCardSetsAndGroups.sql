
DROP TABLE IF EXISTS tempCardSets;
DROP TABLE IF EXISTS tempCardGroups;

CREATE TABLE tempCardSets (
	`setCode` VARCHAR(50) CHARACTER SET UTF8MB4,
	`parentSetCode` VARCHAR(50) CHARACTER SET UTF8MB4,
	`setName` VARCHAR(50) CHARACTER SET UTF8MB4,
	`setType` VARCHAR(50) CHARACTER SET UTF8MB4
);

INSERT IGNORE INTO tempCardSets (setCode, parentSetCode, setName, setType) VALUES
	('OXO', NULL, 'Slingshot Underground', 'promo'),
	('LSS', NULL, 'Legend Story Studios Promos', 'promo'),
	('LGS', NULL, 'Local Game Store Promos', 'promo'),
	('FAB', NULL, 'Premier Orginized Play Promos', 'promo'),
	('HER', NULL, 'Hero Promos', 'promo'),
	('IRA', NULL, 'Ira Welcome Deck', 'promo'),
	('WTR', NULL, 'Welcome to Rathe', 'core'),
	('BVO', 'WTR', 'Bravo Hero Deck', 'deck'),
	('RNR', 'WTR', 'Rhinar Hero Deck', 'deck'),
	('KSU', 'WTR', 'Kastu Hero Deck', 'deck'),
	('TEA', 'WTR', 'Dorinthea Hero Deck', 'deck'),
	('XXX', 'WTR', 'Orginized Play Event Tokens', 'promo'),
	('U-WTR', 'WTR', 'Welcome to Rathe Unlimited', 'core'),
	('ARC', NULL, 'Arcane Rising', 'core'),
	('U-ARC', 'ARC', 'Arcane Rising Unlimited', 'core'),
	('CRU', NULL, 'Crucible of War', 'support');

CREATE TABLE IF NOT EXISTS tempCardGroups (
    `groupCode` VARCHAR(7) CHARACTER SET UTF8MB4,
    `groupName` VARCHAR(36) CHARACTER SET UTF8MB4,
    `datePrinted` DATETIME,
    `dateReleased` DATETIME
);

INSERT INTO tempCardGroups VALUES
    ('IRA','Ira Welcome Deck','2018-12-01 00:00:00','2019-08-31 00:00:00'),
    ('BVO','Bravo Hero Deck','2019-08-01 00:00:00','2019-10-11 00:00:00'),
    ('RNR','Rhinar Hero Deck','2019-08-01 00:00:00','2019-10-11 00:00:00'),
    ('KSU','Kastu Hero Deck','2019-08-01 00:00:00','2019-10-11 00:00:00'),
    ('TEA','Dorinthea Hero Deck','2019-08-01 00:00:00','2019-10-11 00:00:00'),
    ('WTR','Welcome to Rathe Alpha Edition','2019-08-01 00:00:00','2019-10-11 00:00:00'),
    ('U-WTR','Welcome to Rathe Unlimited Edition','2020-09-01 00:00:00','2020-10-30 00:00:00'),
    ('ARC','Arcane Rising First Edition','2019-12-01 00:00:00','2020-03-27 00:00:00'),
    ('U-ARC','Arcane Rising Unlimited Edition','2020-10-01 00:00:00','2020-11-13 00:00:00'),
    ('CRU','Crucible of War First Edition',NULL,'2020-08-28 00:00:00'),
    ('AES1','Armory Event Seson 1 (In-store Play)','2019-08-01 00:00:00',NULL),
    ('AES2','Armory Event Seson 2 (In-store Play)','2019-12-01 00:00:00',NULL),
    ('MAP-LSS','Mighty Ape Promotion','2019-08-01 00:00:00',NULL),
    ('POP2019','Premier Orginized Play (2019)','2019-08-01 00:00:00',NULL),
    ('PRP-ARC','Arcane Rising Pre-Release Promo','2019-12-01 00:00:00',NULL),
    ('BBP-ARC','Arcane Rising Buy-a-Box Promo','2019-12-01 00:00:00',NULL),
    ('BBP-CRU','Crucible of War Buy-a-Box Promos','2020-07-01 00:00:00',NULL),
    ('POP2020','Premier Orginized Play (2020)','2019-12-01 00:00:00',NULL),
    ('TCP-FAB','Team Covenant Promotion','2020-07-01 00:00:00',NULL),
    ('OXO','Slingshot Underground','2018-12-01 00:00:00','2018-12-25 00:00:00'),
    ('XXX','Orginized Play Event Tokens','2019-08-01 00:00:00',NULL);