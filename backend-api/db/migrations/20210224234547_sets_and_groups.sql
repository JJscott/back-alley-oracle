-- migrate:up

CREATE TABLE cardSetTypes (
    id SERIAL PRIMARY KEY,
    setTypeName TEXT UNIQUE NOT NULL,
    setTypeRank INT UNIQUE NOT NULL,
    booster BOOLEAN NOT NULL,
    draftable BOOLEAN NOT NULL,
    promo BOOLEAN NOT NULL
);

CREATE TABLE cardSets (
    id SERIAL PRIMARY KEY,
    setCode TEXT UNIQUE NOT NULL,
    setName TEXT UNIQUE NOT NULL,
    cardSetTypeId INTEGER REFERENCES cardSetTypes (id),
    parentSetId INTEGER REFERENCES cardSets (id)
);

CREATE TABLE cardGroups (
    id SERIAL PRIMARY KEY,
    groupCode TEXT UNIQUE NOT NULL,
    groupName TEXT UNIQUE NOT NULL,
    datePrinted DATE,
    dateReleased DATE
);



-- migrate:down

DROP TABLE cardGroups;
DROP TABLE cardSets;
DROP TABLE cardSetTypes;