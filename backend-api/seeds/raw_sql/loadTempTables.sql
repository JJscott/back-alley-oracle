-- loads temp table into the normalized tables and sets up database

-- Ensure we cleanup data if last one failed
TRUNCATE TABLE card_print_faces CASCADE;
TRUNCATE TABLE card_set_types CASCADE;
TRUNCATE TABLE card_sets CASCADE;
TRUNCATE TABLE card_groups CASCADE;
TRUNCATE TABLE card_names CASCADE;
TRUNCATE TABLE card_classes CASCADE;
TRUNCATE TABLE card_types CASCADE;
TRUNCATE TABLE card_subtypes CASCADE;
TRUNCATE TABLE card_specializations CASCADE;
TRUNCATE TABLE card_templates CASCADE;
TRUNCATE TABLE card_template_subtypes CASCADE;
TRUNCATE TABLE card_rarities CASCADE;
TRUNCATE TABLE card_art_types CASCADE;
TRUNCATE TABLE card_frame_styles CASCADE;
TRUNCATE TABLE card_frame_colors CASCADE;
TRUNCATE TABLE card_artists CASCADE;
TRUNCATE TABLE card_faces CASCADE;
TRUNCATE TABLE card_finish_types CASCADE;
TRUNCATE TABLE card_layouts CASCADE;
TRUNCATE TABLE card_prints CASCADE;





-- 
-- SETS
-- 

-- SET TYPES
INSERT INTO card_set_types (set_type_name, set_type_rank, booster, draftable, promo) VALUES
('core', 0, TRUE, TRUE, FALSE),
('support', 1, TRUE, FALSE, FALSE),
('deck', 2, FALSE, FALSE, FALSE),
('promo', 3, FALSE, FALSE, TRUE);

-- SETS
INSERT INTO card_sets (set_code, set_name, card_set_type_id)
SELECT DISTINCT set_code, set_name, card_set_types.id
FROM temp_card_sets
LEFT JOIN card_set_types ON card_set_types.set_type_name = temp_card_sets.set_type;

-- UPDATE children
-- SET children.cardSetParentId = parent.
-- WHERE

-- GROUPS

INSERT INTO card_groups (group_code, group_name, date_printed, date_released)
SELECT DISTINCT group_code, group_name, date_printed, date_released
FROM temp_card_groups;





-- 
-- CARD TEMPLATES
-- 

-- NAMES
INSERT INTO card_names (name)
SELECT DISTINCT name
FROM temp_card_templates
WHERE name IS NOT NULL;

-- CLASSES
INSERT INTO card_classes (class)
SELECT DISTINCT class
FROM temp_card_templates
WHERE class IS NOT NULL;

-- TYPES
INSERT INTO card_types (type)
SELECT DISTINCT type
FROM temp_card_templates
WHERE type IS NOT NULL;

-- SUBTYPES
INSERT INTO card_subtypes (subtype)
SELECT DISTINCT regexp_split_to_table(temp_card_templates.subtypes, E',') AS subtype
FROM temp_card_templates
ORDER BY subtype;

-- SPECIALIZATIONS
INSERT INTO card_specializations (specialization)
SELECT DISTINCT specialization
FROM temp_card_templates
WHERE specialization IS NOT NULL;

-- CARD TEMPLATES
INSERT INTO card_templates (
	template_sid, pitch, cost, cost_var, power, power_var,
	defense, defense_var, intellect, life, handedness, legendary,
	card_name_id, card_class_id, card_type_id, card_specialization_id)
SELECT
	template_id_gen, pitch, cost, cost_var, power, power_var,
	defense, defense_var, intellect, life, handedness, legendary,
	card_names.id, card_classes.id, card_types.id, card_specializations.id
FROM temp_card_templates
LEFT JOIN card_names ON temp_card_templates.name = card_names.name
LEFT JOIN card_classes ON temp_card_templates.class = card_classes.class
LEFT JOIN card_types ON temp_card_templates.type = card_types.type
LEFT JOIN card_specializations ON temp_card_templates.specialization = card_specializations.specialization;

-- CONNECT TEMPLATE AND SUBTYPES
INSERT INTO card_template_subtypes (card_template_id, card_subtype_id)
SELECT DISTINCT id_subtype.id, card_subtypes.id
FROM (
	SELECT card_templates.id, regexp_split_to_table(temp_card_templates.subtypes, E',') AS subtype
	FROM temp_card_templates
	LEFT JOIN card_templates ON card_templates.template_sid = temp_card_templates.template_id_gen
) id_subtype
LEFT JOIN card_subtypes ON card_subtypes.subtype = id_subtype.subtype;






-- 
-- CARD FACES
-- 

-- RARITIES
INSERT INTO card_rarities (rarity_code, rarity_name, rarity_rank) VALUES
('T', 'Token', 0),
('C', 'Common', 1),
('R', 'Rare', 2),
('S', 'Super Rare', 3),
('M', 'Majestic', 4),
('L', 'Legendary', 5),
('F', 'Fabled', 6),
('P', 'Promotional', 7);

-- ARTS
INSERT INTO card_art_types (art_type_code, art_type_name, art_type_rank) VALUES
('NA', 'Normal Art', 0),
('EA', 'Extended Art', 1),
('FA', 'Full Art', 2),
('OA', 'Overlap Art', 3);

-- FRAMESTYLES
INSERT INTO card_frame_styles (frame_style)
SELECT DISTINCT frame_style
FROM temp_card_faces
WHERE frame_style IS NOT NULL;

-- FRAMEALTCOLORS
INSERT INTO card_frame_colors (frame_color)
SELECT DISTINCT frame_color
FROM temp_card_faces
WHERE frame_color IS NOT NULL;

-- ARTISTS
INSERT INTO card_artists (artist_name)
SELECT DISTINCT artist_name
FROM temp_card_faces
WHERE artist_name IS NOT NULL;

-- CARD FACES
INSERT INTO card_faces (
	face_sid, set_number, image_str, code, rules_text, flavor_text,
	card_template_id, card_set_id, card_rarity_id, card_art_type_id,
	card_frame_style_id, card_frame_color_id, card_artist_id)
SELECT
	face_id_gen, set_number, image_str, code, rules_text, flavor_text,
	card_templates.id, card_sets.id, card_rarities.id, card_art_types.id,
	card_frame_styles.id, card_frame_colors.id, card_artists.id
FROM temp_card_faces
LEFT JOIN card_templates ON temp_card_faces.template_id_ref = card_templates.template_sid
LEFT JOIN card_sets ON temp_card_faces.set_code = card_sets.set_code
LEFT JOIN card_rarities ON temp_card_faces.rarity_code = card_rarities.rarity_code
LEFT JOIN card_art_types ON temp_card_faces.art_type_code = card_art_types.art_type_code
LEFT JOIN card_frame_styles ON temp_card_faces.frame_style = card_frame_styles.frame_style
LEFT JOIN card_frame_colors ON temp_card_faces.frame_color = card_frame_colors.frame_color
LEFT JOIN card_artists ON temp_card_faces.artist_name = card_artists.artist_name;



-- 
-- CARD PRINTS
-- 

-- FINISH (FOILS)
INSERT INTO card_finish_types (finish_type_code, finish_type_name, finish_type_rank) VALUES
('NF', 'Non Foil', 0),
('RF', 'Rainbow Foil', 10),
('CF', 'Cold Foil', 20),
('GF', 'Cold Foil - Gold', 30);

-- LAYOUTS
INSERT INTO card_layouts (layout)
SELECT DISTINCT layout
FROM temp_card_prints
WHERE layout IS NOT NULL;

-- CARD PRINTS
INSERT INTO card_prints (print_sid, card_finish_type_id, card_layout_id, card_group_id)
SELECT print_id_gen, card_finish_types.id, card_layouts.id, card_groups.id
FROM temp_card_prints
LEFT JOIN card_finish_types ON temp_card_prints.finish_type_code = card_finish_types.finish_type_code
LEFT JOIN card_layouts ON temp_card_prints.layout = card_layouts.layout
LEFT JOIN card_groups ON temp_card_prints.group_code = card_groups.group_code;

-- CONNECT PRINT AND FACES
INSERT INTO card_print_faces (card_print_id, card_face_id)
SELECT DISTINCT id_face.id, card_faces.id
FROM (
	SELECT card_prints.id, regexp_split_to_table(temp_card_prints.face_id_ref, E',') AS face
	FROM temp_card_prints
	LEFT JOIN card_prints ON card_prints.print_sid = temp_card_prints.print_id_gen
) id_face
LEFT JOIN card_faces ON id_face.face = card_faces.face_sid;





-- 
-- CLEANUP
-- 

-- TEMP TABLES
DROP TABLE IF EXISTS temp_card_templates;
DROP TABLE IF EXISTS temp_card_faces;
DROP TABLE IF EXISTS temp_card_prints;
DROP TABLE IF EXISTS temp_card_sets;
DROP TABLE IF EXISTS temp_card_groups;
