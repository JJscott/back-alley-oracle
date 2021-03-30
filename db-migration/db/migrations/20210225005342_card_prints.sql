-- migrate:up

CREATE TABLE card_finish_types (
    id SERIAL PRIMARY KEY,
    finish_type_code TEXT UNIQUE NOT NULL,
    finish_type_name TEXT UNIQUE NOT NULL,
    finish_type_rank INT UNIQUE NOT NULL
);

CREATE TABLE card_layouts (
    id SERIAL PRIMARY KEY,
    layout TEXT UNIQUE NOT NULL
);

CREATE TABLE card_prints (
    id SERIAL PRIMARY KEY,
    print_sid TEXT UNIQUE NOT NULL,
    card_finish_type_id INT REFERENCES card_finish_types (id),
    card_layout_id INT REFERENCES card_layouts (id),
    card_group_id INT REFERENCES card_groups (id)
);

CREATE TABLE card_print_faces (
    id SERIAL PRIMARY KEY,
    card_print_id INT NOT NULL REFERENCES card_prints (id), 
    card_face_id INT NOT NULL REFERENCES card_faces (id)
);





-- migrate:down

DROP TABLE card_print_faces;
DROP TABLE card_prints;
DROP TABLE card_layouts;
DROP TABLE card_finish_types;
