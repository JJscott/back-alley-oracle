-- migrate:up

CREATE TABLE card_rarities (
    id SERIAL PRIMARY KEY,
    rarity_code TEXT UNIQUE NOT NULL,
    rarity_name TEXT UNIQUE NOT NULL,
    rarity_rank INT UNIQUE NOT NULL
);

CREATE TABLE card_art_types (
    id SERIAL PRIMARY KEY,
    art_type_code TEXT UNIQUE NOT NULL,
    art_type_name TEXT UNIQUE NOT NULL,
    art_type_rank INT UNIQUE NOT NULL
);

CREATE TABLE card_frame_styles (
    id SERIAL PRIMARY KEY,
    frame_style TEXT UNIQUE NOT NULL
);

CREATE TABLE card_frame_colors (
    id SERIAL PRIMARY KEY,
    frame_color TEXT UNIQUE NOT NULL
);

CREATE TABLE card_artists (
    id SERIAL PRIMARY KEY,
    artist_name TEXT UNIQUE NOT NULL
);

CREATE TABLE card_faces (
    id SERIAL PRIMARY KEY,
    face_sid TEXT UNIQUE NOT NULL,
    set_number INT NOT NULL,
    image_str TEXT NOT NULL,
    code TEXT NOT NULL,
    rules_text TEXT,
    flavor_text TEXT,
    card_template_id INT REFERENCES card_templates (id),
    card_set_id INT REFERENCES card_sets (id),
    card_rarity_id INT REFERENCES card_rarities (id),
    card_art_type_id INT REFERENCES card_art_types (id),
    card_frame_style_id INT REFERENCES card_frame_styles (id),
    card_frame_color_id INT REFERENCES card_frame_colors (id),
    card_artist_id INT REFERENCES card_artists (id)
);





-- migrate:down

DROP TABLE card_faces;
DROP TABLE card_artists;
DROP TABLE card_frame_colors;
DROP TABLE card_frame_styles;
DROP TABLE card_art_types;
DROP TABLE card_rarities;