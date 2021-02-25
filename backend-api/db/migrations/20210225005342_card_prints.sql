-- migrate:up

CREATE TABLE cardFinishTypes (
    id SERIAL PRIMARY KEY,
    finishTypeCode TEXT UNIQUE NOT NULL,
    finishTypeName TEXT UNIQUE NOT NULL,
    finishTypeRank INT UNIQUE NOT NULL
);

CREATE TABLE cardLayouts (
    id SERIAL PRIMARY KEY,
    layout TEXT UNIQUE NOT NULL
);

CREATE TABLE cardPrints (
    id SERIAL PRIMARY KEY,
    printSid TEXT UNIQUE NOT NULL,
    cardFinishTypeId INT REFERENCES cardFinishTypes (id),
    cardLayoutId INT REFERENCES cardLayouts (id),
    cardGroupId INT REFERENCES cardGroups (id)
);

CREATE TABLE cardPrintFaces (
    id SERIAL PRIMARY KEY,
    cardPrintId INT NOT NULL REFERENCES cardPrints (id), 
    cardFaceId INT NOT NULL REFERENCES cardFaces (id)
);



-- migrate:down

DROP TABLE cardPrintFaces;
DROP TABLE cardPrints;
DROP TABLE cardLayouts;
DROP TABLE cardFinishTypes;
