-- migrate:up

CREATE TABLE cardRarities (
    id SERIAL PRIMARY KEY,
    rarityCode TEXT UNIQUE NOT NULL,
    rarityName TEXT UNIQUE NOT NULL,
    rarityRank INT UNIQUE NOT NULL
);

CREATE TABLE cardArtTypes (
    id SERIAL PRIMARY KEY,
    artTypeCode TEXT UNIQUE NOT NULL,
    artTypeName TEXT UNIQUE NOT NULL,
    artTypeRank INT UNIQUE NOT NULL
);

CREATE TABLE cardFrameStyles (
    id SERIAL PRIMARY KEY,
    frameStyle TEXT UNIQUE NOT NULL
);

CREATE TABLE cardFrameAltColors (
    id SERIAL PRIMARY KEY,
    frameAltColor TEXT UNIQUE NOT NULL
);

CREATE TABLE cardArtists (
    id SERIAL PRIMARY KEY,
    artistName TEXT UNIQUE NOT NULL
);

CREATE TABLE cardFaces (
    id SERIAL PRIMARY KEY,
    faceSid TEXT UNIQUE NOT NULL,
    setNumber INT NOT NULL,
    imageStr TEXT NOT NULL,
    code TEXT NOT NULL,
    rulesText TEXT,
    flavorText TEXT,
    cardTemplateId INT REFERENCES cardTemplates (id),
    cardSetId INT REFERENCES cardSets (id),
    cardRarityId INT REFERENCES cardRarities (id),
    cardArtTypeId INT REFERENCES cardArtTypes (id),
    cardFrameStyleId INT REFERENCES cardFrameStyles (id),
    cardFrameAltColorId INT REFERENCES cardFrameAltColors (id),
    cardArtistId INT REFERENCES cardArtists (id)
);



-- migrate:down

DROP TABLE cardFaces;
DROP TABLE cardArtists;
DROP TABLE cardFrameAltColors;
DROP TABLE cardFrameStyles;
DROP TABLE cardArtTypes;
DROP TABLE cardRarities;