-- migrate:up

CREATE TABLE cardNames (
    id SERIAL PRIMARY KEY,
    name TEXT UNIQUE NOT NULL
);

CREATE TABLE cardClasses (
    id SERIAL PRIMARY KEY,
    class TEXT UNIQUE NOT NULL
);

CREATE TABLE cardTypes (
    id SERIAL PRIMARY KEY,
    type TEXT UNIQUE NOT NULL
);

CREATE TABLE cardSubtypes (
    id SERIAL PRIMARY KEY,
    subtype TEXT UNIQUE NOT NULL
);

CREATE TABLE cardSpecializations (
    id SERIAL PRIMARY KEY,
    specialization TEXT UNIQUE NOT NULL
);

CREATE TABLE cardTemplates (
    id SERIAL PRIMARY KEY,
    templateSid TEXT UNIQUE NOT NULL,
    pitch INT,
    cost INT,
    varCost TEXT,
    power INT,
    varPower TEXT,
    defense INT,
    varDefense TEXT,
    intellect INT,
    life INT,
    handedness INT,
    legendary BOOLEAN NOT NULL,
    cardNameId INT REFERENCES cardNames (id),
    cardClassId INT REFERENCES cardClasses (id),
    cardTypeId INT REFERENCES cardTypes (id),
    cardSpecializationId INT REFERENCES cardSpecializations (id)
);

CREATE TABLE cardTemplateSubtypes (
    id SERIAL PRIMARY KEY,
    cardTemplateId INT NOT NULL REFERENCES cardTemplates(id),
    cardSubtypeId INT NOT NULL REFERENCES cardSubtypes(id)
);



-- migrate:down

DROP TABLE cardTemplateSubtypes;
DROP TABLE cardTemplates;
DROP TABLE cardSpecializations;
DROP TABLE cardSubtypes;
DROP TABLE cardTypes;
DROP TABLE cardClasses;
DROP TABLE cardNames;