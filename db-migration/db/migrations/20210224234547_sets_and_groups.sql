-- migrate:up

CREATE TABLE card_set_types (
    id SERIAL PRIMARY KEY,
    set_type_name TEXT UNIQUE NOT NULL,
    set_type_rank INT UNIQUE NOT NULL,
    booster BOOLEAN NOT NULL,
    draftable BOOLEAN NOT NULL,
    promo BOOLEAN NOT NULL
);

CREATE TABLE card_sets (
    id SERIAL PRIMARY KEY,
    set_code TEXT UNIQUE NOT NULL,
    set_name TEXT UNIQUE NOT NULL,
    card_set_type_id INT REFERENCES card_set_types (id),
    parent_set_id INT REFERENCES card_sets (id)
);

CREATE TABLE card_groups (
    id SERIAL PRIMARY KEY,
    group_code TEXT UNIQUE NOT NULL,
    group_name TEXT UNIQUE NOT NULL,
    date_printed DATE,
    date_released DATE
);





-- migrate:down

DROP TABLE card_groups;
DROP TABLE card_sets;
DROP TABLE card_set_types;