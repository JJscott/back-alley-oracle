-- migrate:up

CREATE MATERIALIZED VIEW mv_cardSets AS
SELECT 
    card_sets.id AS set_id,
    card_sets.set_code,
    card_sets.set_name,
    card_set_types.set_type_name,
    card_set_types.set_type_rank,
    card_set_types.booster,
    card_set_types.draftable,
    card_set_types.promo
FROM card_sets
LEFT JOIN card_set_types ON card_set_types.id = card_sets.card_set_type_id;


CREATE MATERIALIZED VIEW mv_cards AS
SELECT
    front_print_face.id AS card_id,
    -- cardTemplates
    card_templates.id AS template_id,
    card_templates.template_sid,
    card_templates.pitch,
    card_templates.cost,
    card_templates.cost_var,
    card_templates.power,
    card_templates.power_var,
    card_templates.defense,
    card_templates.defense_var,
    card_templates.intellect,
    card_templates.life,
    card_templates.handedness,
    card_templates.legendary,
    card_names.name,
    card_classes.class,
    card_specializations.specialization,
    card_types.type,
    card_subtypes_arr.subtypes_arr,
    -- cardFaces
    card_faces.id AS face_id,
    card_faces.face_sid,
    card_faces.set_number,
    card_faces.image_str,
    card_faces.code,
    card_faces.rules_text,
    card_faces.flavor_text,
    card_faces.card_template_id,
    card_sets.set_code,
    card_sets.set_name,
    card_set_types.set_type_name,
    card_set_types.set_type_rank,
    card_set_types.booster,
    card_set_types.draftable,
    card_set_types.promo,
    card_rarities.rarity_code,
    card_rarities.rarity_name,
    card_art_types.art_type_code,
    card_art_types.art_type_name,
    card_art_types.art_type_rank,
    card_frame_styles.frame_style,
    card_frame_colors.frame_color,
    card_artists.artist_name,
    -- cardPrints
    card_prints.id AS print_id,
    card_prints.print_sid,
    card_finish_types.finish_type_code,
    card_finish_types.finish_type_name,
    card_finish_types.finish_type_rank,
    card_layouts.layout,
    card_groups.group_code,
    card_groups.group_name,
    card_groups.date_printed,
    card_groups.date_released,
    -- backFace
    back_print_face.card_face_id AS back_card_face_id,
    back_faces.image_str AS back_face_image_str
FROM card_prints
    INNER JOIN card_print_faces front_print_face ON front_print_face.card_print_id = card_prints.id
    LEFT JOIN card_print_faces back_print_face ON back_print_face.card_print_id = front_print_face.card_print_id AND back_print_face.id <> front_print_face.id
    INNER JOIN card_faces ON card_faces.id = front_print_face.card_face_id
    LEFT JOIN card_faces back_faces ON back_faces.id = back_print_face.card_face_id
    INNER JOIN card_templates ON card_templates.id = card_faces.card_template_id
    LEFT JOIN card_names ON card_names.id = card_templates.card_name_id
    LEFT JOIN card_classes ON card_classes.id = card_templates.card_class_id
    LEFT JOIN card_specializations ON card_specializations.id = card_templates.card_specialization_id
    LEFT JOIN card_types ON card_types.id = card_templates.card_type_id
    LEFT JOIN card_template_subtypes ON card_template_subtypes.card_template_id = card_templates.id
    LEFT JOIN (
        SELECT card_template_id, ARRAY_AGG(card_subtypes.subtype) subtypes_arr
        FROM card_template_subtypes
            LEFT JOIN card_subtypes ON card_subtypes.id = card_template_subtypes.card_subtype_id
        GROUP BY card_template_id
    ) card_subtypes_arr ON card_subtypes_arr.card_template_id = card_templates.id
    LEFT JOIN card_sets ON card_sets.id = card_faces.card_set_id
    LEFT JOIN card_set_types ON card_set_types.id = card_sets.card_set_type_id
    LEFT JOIN card_rarities ON card_rarities.id = card_faces.card_rarity_id
    LEFT JOIN card_art_types ON card_art_types.id = card_faces.card_art_type_id
    LEFT JOIN card_frame_styles ON card_frame_styles.id = card_faces.card_frame_style_id
    LEFT JOIN card_frame_colors ON card_frame_colors.id = card_faces.card_frame_color_id
    LEFT JOIN card_artists ON card_artists.id = card_faces.card_artist_id
    LEFT JOIN card_finish_types ON card_finish_types.id = card_prints.card_finish_type_id
    LEFT JOIN card_layouts ON card_layouts.id = card_prints.card_layout_id
    LEFT JOIN card_groups ON card_groups.id = card_prints.card_group_id;



-- migrate:down

DROP MATERIALIZED VIEW mv_cards;
DROP MATERIALIZED VIEW mv_cardSets;