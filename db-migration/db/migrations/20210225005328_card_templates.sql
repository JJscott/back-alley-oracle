-- migrate:up

CREATE TABLE card_names (
    id SERIAL PRIMARY KEY,
    name TEXT UNIQUE NOT NULL
);

CREATE TABLE card_classes (
    id SERIAL PRIMARY KEY,
    class TEXT UNIQUE NOT NULL
);

CREATE TABLE card_types (
    id SERIAL PRIMARY KEY,
    type TEXT UNIQUE NOT NULL
);

CREATE TABLE card_subtypes (
    id SERIAL PRIMARY KEY,
    subtype TEXT UNIQUE NOT NULL
);

CREATE TABLE card_specializations (
    id SERIAL PRIMARY KEY,
    specialization TEXT UNIQUE NOT NULL
);

CREATE TABLE card_templates (
    id SERIAL PRIMARY KEY,
    template_sid TEXT UNIQUE NOT NULL,
    pitch INT,
    cost INT,
    cost_var TEXT,
    power INT,
    power_var TEXT,
    defense INT,
    defense_var TEXT,
    intellect INT,
    life INT,
    handedness INT,
    legendary BOOLEAN NOT NULL,
    card_name_id INT REFERENCES card_names (id),
    card_class_id INT REFERENCES card_classes (id),
    card_type_id INT REFERENCES card_types (id),
    card_specialization_id INT REFERENCES card_specializations (id)
);

CREATE TABLE card_template_subtypes (
    id SERIAL PRIMARY KEY,
    card_template_id INT NOT NULL REFERENCES card_templates (id),
    card_subtype_id INT NOT NULL REFERENCES card_subtypes (id)
);





-- migrate:down

DROP TABLE card_template_subtypes;
DROP TABLE card_templates;
DROP TABLE card_specializations;
DROP TABLE card_subtypes;
DROP TABLE card_types;
DROP TABLE card_classes;
DROP TABLE card_names;