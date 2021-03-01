SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: card_art_types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.card_art_types (
    id integer NOT NULL,
    art_type_code text NOT NULL,
    art_type_name text NOT NULL,
    art_type_rank integer NOT NULL
);


--
-- Name: card_art_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.card_art_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: card_art_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.card_art_types_id_seq OWNED BY public.card_art_types.id;


--
-- Name: card_artists; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.card_artists (
    id integer NOT NULL,
    artist_name text NOT NULL
);


--
-- Name: card_artists_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.card_artists_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: card_artists_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.card_artists_id_seq OWNED BY public.card_artists.id;


--
-- Name: card_classes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.card_classes (
    id integer NOT NULL,
    class text NOT NULL
);


--
-- Name: card_classes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.card_classes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: card_classes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.card_classes_id_seq OWNED BY public.card_classes.id;


--
-- Name: card_faces; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.card_faces (
    id integer NOT NULL,
    face_sid text NOT NULL,
    set_number integer NOT NULL,
    image_str text NOT NULL,
    code text NOT NULL,
    rules_text text,
    flavor_text text,
    card_template_id integer,
    card_set_id integer,
    card_rarity_id integer,
    card_art_type_id integer,
    card_frame_style_id integer,
    card_frame_color_id integer,
    card_artist_id integer
);


--
-- Name: card_faces_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.card_faces_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: card_faces_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.card_faces_id_seq OWNED BY public.card_faces.id;


--
-- Name: card_finish_types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.card_finish_types (
    id integer NOT NULL,
    finish_type_code text NOT NULL,
    finish_type_name text NOT NULL,
    finish_type_rank integer NOT NULL
);


--
-- Name: card_finish_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.card_finish_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: card_finish_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.card_finish_types_id_seq OWNED BY public.card_finish_types.id;


--
-- Name: card_frame_colors; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.card_frame_colors (
    id integer NOT NULL,
    frame_color text NOT NULL
);


--
-- Name: card_frame_colors_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.card_frame_colors_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: card_frame_colors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.card_frame_colors_id_seq OWNED BY public.card_frame_colors.id;


--
-- Name: card_frame_styles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.card_frame_styles (
    id integer NOT NULL,
    frame_style text NOT NULL
);


--
-- Name: card_frame_styles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.card_frame_styles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: card_frame_styles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.card_frame_styles_id_seq OWNED BY public.card_frame_styles.id;


--
-- Name: card_groups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.card_groups (
    id integer NOT NULL,
    group_code text NOT NULL,
    group_name text NOT NULL,
    date_printed date,
    date_released date
);


--
-- Name: card_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.card_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: card_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.card_groups_id_seq OWNED BY public.card_groups.id;


--
-- Name: card_layouts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.card_layouts (
    id integer NOT NULL,
    layout text NOT NULL
);


--
-- Name: card_layouts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.card_layouts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: card_layouts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.card_layouts_id_seq OWNED BY public.card_layouts.id;


--
-- Name: card_names; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.card_names (
    id integer NOT NULL,
    name text NOT NULL
);


--
-- Name: card_names_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.card_names_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: card_names_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.card_names_id_seq OWNED BY public.card_names.id;


--
-- Name: card_print_faces; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.card_print_faces (
    id integer NOT NULL,
    card_print_id integer NOT NULL,
    card_face_id integer NOT NULL
);


--
-- Name: card_print_faces_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.card_print_faces_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: card_print_faces_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.card_print_faces_id_seq OWNED BY public.card_print_faces.id;


--
-- Name: card_prints; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.card_prints (
    id integer NOT NULL,
    print_sid text NOT NULL,
    card_finish_type_id integer,
    card_layout_id integer,
    card_group_id integer
);


--
-- Name: card_prints_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.card_prints_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: card_prints_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.card_prints_id_seq OWNED BY public.card_prints.id;


--
-- Name: card_rarities; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.card_rarities (
    id integer NOT NULL,
    rarity_code text NOT NULL,
    rarity_name text NOT NULL,
    rarity_rank integer NOT NULL
);


--
-- Name: card_rarities_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.card_rarities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: card_rarities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.card_rarities_id_seq OWNED BY public.card_rarities.id;


--
-- Name: card_set_types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.card_set_types (
    id integer NOT NULL,
    set_type_name text NOT NULL,
    set_type_rank integer NOT NULL,
    booster boolean NOT NULL,
    draftable boolean NOT NULL,
    promo boolean NOT NULL
);


--
-- Name: card_set_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.card_set_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: card_set_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.card_set_types_id_seq OWNED BY public.card_set_types.id;


--
-- Name: card_sets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.card_sets (
    id integer NOT NULL,
    set_code text NOT NULL,
    set_name text NOT NULL,
    card_set_type_id integer,
    parent_set_id integer
);


--
-- Name: card_sets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.card_sets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: card_sets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.card_sets_id_seq OWNED BY public.card_sets.id;


--
-- Name: card_specializations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.card_specializations (
    id integer NOT NULL,
    specialization text NOT NULL
);


--
-- Name: card_specializations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.card_specializations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: card_specializations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.card_specializations_id_seq OWNED BY public.card_specializations.id;


--
-- Name: card_subtypes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.card_subtypes (
    id integer NOT NULL,
    subtype text NOT NULL
);


--
-- Name: card_subtypes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.card_subtypes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: card_subtypes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.card_subtypes_id_seq OWNED BY public.card_subtypes.id;


--
-- Name: card_template_subtypes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.card_template_subtypes (
    id integer NOT NULL,
    card_template_id integer NOT NULL,
    card_subtype_id integer NOT NULL
);


--
-- Name: card_template_subtypes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.card_template_subtypes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: card_template_subtypes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.card_template_subtypes_id_seq OWNED BY public.card_template_subtypes.id;


--
-- Name: card_templates; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.card_templates (
    id integer NOT NULL,
    template_sid text NOT NULL,
    pitch integer,
    cost integer,
    cost_var text,
    power integer,
    power_var text,
    defense integer,
    defense_var text,
    intellect integer,
    life integer,
    handedness integer,
    legendary boolean NOT NULL,
    card_name_id integer,
    card_class_id integer,
    card_type_id integer,
    card_specialization_id integer
);


--
-- Name: card_templates_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.card_templates_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: card_templates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.card_templates_id_seq OWNED BY public.card_templates.id;


--
-- Name: card_types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.card_types (
    id integer NOT NULL,
    type text NOT NULL
);


--
-- Name: card_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.card_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: card_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.card_types_id_seq OWNED BY public.card_types.id;


--
-- Name: mv_cards; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.mv_cards AS
 SELECT front_print_face.id AS card_id,
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
    card_set_types.booster,
    card_set_types.draftable,
    card_set_types.promo,
    card_rarities.rarity_code,
    card_rarities.rarity_name,
    card_art_types.art_type_code,
    card_art_types.art_type_name,
    card_frame_styles.frame_style,
    card_frame_colors.frame_color,
    card_artists.artist_name,
    card_prints.id AS print_id,
    card_prints.print_sid,
    card_finish_types.finish_type_code,
    card_finish_types.finish_type_name,
    card_layouts.layout,
    card_groups.group_code,
    card_groups.group_name,
    card_groups.date_printed,
    card_groups.date_released,
    back_print_face.card_face_id AS back_card_face_id,
    back_faces.image_str AS back_face_image_str
   FROM (((((((((((((((((((((public.card_prints
     JOIN public.card_print_faces front_print_face ON ((front_print_face.card_print_id = card_prints.id)))
     LEFT JOIN public.card_print_faces back_print_face ON (((back_print_face.card_print_id = front_print_face.card_print_id) AND (back_print_face.id <> front_print_face.id))))
     JOIN public.card_faces ON ((card_faces.id = front_print_face.card_face_id)))
     LEFT JOIN public.card_faces back_faces ON ((back_faces.id = back_print_face.card_face_id)))
     JOIN public.card_templates ON ((card_templates.id = card_faces.card_template_id)))
     LEFT JOIN public.card_names ON ((card_names.id = card_templates.card_name_id)))
     LEFT JOIN public.card_classes ON ((card_classes.id = card_templates.card_class_id)))
     LEFT JOIN public.card_specializations ON ((card_specializations.id = card_templates.card_specialization_id)))
     LEFT JOIN public.card_types ON ((card_types.id = card_templates.card_type_id)))
     LEFT JOIN public.card_template_subtypes ON ((card_template_subtypes.card_template_id = card_templates.id)))
     LEFT JOIN ( SELECT card_template_subtypes_1.card_template_id,
            array_agg(card_subtypes.subtype) AS subtypes_arr
           FROM (public.card_template_subtypes card_template_subtypes_1
             LEFT JOIN public.card_subtypes ON ((card_subtypes.id = card_template_subtypes_1.card_subtype_id)))
          GROUP BY card_template_subtypes_1.card_template_id) card_subtypes_arr ON ((card_subtypes_arr.card_template_id = card_templates.id)))
     LEFT JOIN public.card_sets ON ((card_sets.id = card_faces.card_set_id)))
     LEFT JOIN public.card_set_types ON ((card_set_types.id = card_sets.card_set_type_id)))
     LEFT JOIN public.card_rarities ON ((card_rarities.id = card_faces.card_rarity_id)))
     LEFT JOIN public.card_art_types ON ((card_art_types.id = card_faces.card_art_type_id)))
     LEFT JOIN public.card_frame_styles ON ((card_frame_styles.id = card_faces.card_frame_style_id)))
     LEFT JOIN public.card_frame_colors ON ((card_frame_colors.id = card_faces.card_frame_color_id)))
     LEFT JOIN public.card_artists ON ((card_artists.id = card_faces.card_artist_id)))
     LEFT JOIN public.card_finish_types ON ((card_finish_types.id = card_prints.card_finish_type_id)))
     LEFT JOIN public.card_layouts ON ((card_layouts.id = card_prints.card_layout_id)))
     LEFT JOIN public.card_groups ON ((card_groups.id = card_prints.card_group_id)))
  WITH NO DATA;


--
-- Name: mv_cardsets; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.mv_cardsets AS
 SELECT card_sets.id AS set_id,
    card_sets.set_code,
    card_sets.set_name,
    card_set_types.set_type_name,
    card_set_types.set_type_rank,
    card_set_types.booster,
    card_set_types.draftable,
    card_set_types.promo
   FROM (public.card_sets
     LEFT JOIN public.card_set_types ON ((card_set_types.id = card_sets.card_set_type_id)))
  WITH NO DATA;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: card_art_types id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_art_types ALTER COLUMN id SET DEFAULT nextval('public.card_art_types_id_seq'::regclass);


--
-- Name: card_artists id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_artists ALTER COLUMN id SET DEFAULT nextval('public.card_artists_id_seq'::regclass);


--
-- Name: card_classes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_classes ALTER COLUMN id SET DEFAULT nextval('public.card_classes_id_seq'::regclass);


--
-- Name: card_faces id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_faces ALTER COLUMN id SET DEFAULT nextval('public.card_faces_id_seq'::regclass);


--
-- Name: card_finish_types id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_finish_types ALTER COLUMN id SET DEFAULT nextval('public.card_finish_types_id_seq'::regclass);


--
-- Name: card_frame_colors id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_frame_colors ALTER COLUMN id SET DEFAULT nextval('public.card_frame_colors_id_seq'::regclass);


--
-- Name: card_frame_styles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_frame_styles ALTER COLUMN id SET DEFAULT nextval('public.card_frame_styles_id_seq'::regclass);


--
-- Name: card_groups id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_groups ALTER COLUMN id SET DEFAULT nextval('public.card_groups_id_seq'::regclass);


--
-- Name: card_layouts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_layouts ALTER COLUMN id SET DEFAULT nextval('public.card_layouts_id_seq'::regclass);


--
-- Name: card_names id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_names ALTER COLUMN id SET DEFAULT nextval('public.card_names_id_seq'::regclass);


--
-- Name: card_print_faces id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_print_faces ALTER COLUMN id SET DEFAULT nextval('public.card_print_faces_id_seq'::regclass);


--
-- Name: card_prints id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_prints ALTER COLUMN id SET DEFAULT nextval('public.card_prints_id_seq'::regclass);


--
-- Name: card_rarities id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_rarities ALTER COLUMN id SET DEFAULT nextval('public.card_rarities_id_seq'::regclass);


--
-- Name: card_set_types id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_set_types ALTER COLUMN id SET DEFAULT nextval('public.card_set_types_id_seq'::regclass);


--
-- Name: card_sets id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_sets ALTER COLUMN id SET DEFAULT nextval('public.card_sets_id_seq'::regclass);


--
-- Name: card_specializations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_specializations ALTER COLUMN id SET DEFAULT nextval('public.card_specializations_id_seq'::regclass);


--
-- Name: card_subtypes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_subtypes ALTER COLUMN id SET DEFAULT nextval('public.card_subtypes_id_seq'::regclass);


--
-- Name: card_template_subtypes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_template_subtypes ALTER COLUMN id SET DEFAULT nextval('public.card_template_subtypes_id_seq'::regclass);


--
-- Name: card_templates id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_templates ALTER COLUMN id SET DEFAULT nextval('public.card_templates_id_seq'::regclass);


--
-- Name: card_types id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_types ALTER COLUMN id SET DEFAULT nextval('public.card_types_id_seq'::regclass);


--
-- Name: card_art_types card_art_types_art_type_code_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_art_types
    ADD CONSTRAINT card_art_types_art_type_code_key UNIQUE (art_type_code);


--
-- Name: card_art_types card_art_types_art_type_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_art_types
    ADD CONSTRAINT card_art_types_art_type_name_key UNIQUE (art_type_name);


--
-- Name: card_art_types card_art_types_art_type_rank_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_art_types
    ADD CONSTRAINT card_art_types_art_type_rank_key UNIQUE (art_type_rank);


--
-- Name: card_art_types card_art_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_art_types
    ADD CONSTRAINT card_art_types_pkey PRIMARY KEY (id);


--
-- Name: card_artists card_artists_artist_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_artists
    ADD CONSTRAINT card_artists_artist_name_key UNIQUE (artist_name);


--
-- Name: card_artists card_artists_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_artists
    ADD CONSTRAINT card_artists_pkey PRIMARY KEY (id);


--
-- Name: card_classes card_classes_class_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_classes
    ADD CONSTRAINT card_classes_class_key UNIQUE (class);


--
-- Name: card_classes card_classes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_classes
    ADD CONSTRAINT card_classes_pkey PRIMARY KEY (id);


--
-- Name: card_faces card_faces_face_sid_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_faces
    ADD CONSTRAINT card_faces_face_sid_key UNIQUE (face_sid);


--
-- Name: card_faces card_faces_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_faces
    ADD CONSTRAINT card_faces_pkey PRIMARY KEY (id);


--
-- Name: card_finish_types card_finish_types_finish_type_code_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_finish_types
    ADD CONSTRAINT card_finish_types_finish_type_code_key UNIQUE (finish_type_code);


--
-- Name: card_finish_types card_finish_types_finish_type_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_finish_types
    ADD CONSTRAINT card_finish_types_finish_type_name_key UNIQUE (finish_type_name);


--
-- Name: card_finish_types card_finish_types_finish_type_rank_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_finish_types
    ADD CONSTRAINT card_finish_types_finish_type_rank_key UNIQUE (finish_type_rank);


--
-- Name: card_finish_types card_finish_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_finish_types
    ADD CONSTRAINT card_finish_types_pkey PRIMARY KEY (id);


--
-- Name: card_frame_colors card_frame_colors_frame_color_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_frame_colors
    ADD CONSTRAINT card_frame_colors_frame_color_key UNIQUE (frame_color);


--
-- Name: card_frame_colors card_frame_colors_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_frame_colors
    ADD CONSTRAINT card_frame_colors_pkey PRIMARY KEY (id);


--
-- Name: card_frame_styles card_frame_styles_frame_style_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_frame_styles
    ADD CONSTRAINT card_frame_styles_frame_style_key UNIQUE (frame_style);


--
-- Name: card_frame_styles card_frame_styles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_frame_styles
    ADD CONSTRAINT card_frame_styles_pkey PRIMARY KEY (id);


--
-- Name: card_groups card_groups_group_code_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_groups
    ADD CONSTRAINT card_groups_group_code_key UNIQUE (group_code);


--
-- Name: card_groups card_groups_group_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_groups
    ADD CONSTRAINT card_groups_group_name_key UNIQUE (group_name);


--
-- Name: card_groups card_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_groups
    ADD CONSTRAINT card_groups_pkey PRIMARY KEY (id);


--
-- Name: card_layouts card_layouts_layout_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_layouts
    ADD CONSTRAINT card_layouts_layout_key UNIQUE (layout);


--
-- Name: card_layouts card_layouts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_layouts
    ADD CONSTRAINT card_layouts_pkey PRIMARY KEY (id);


--
-- Name: card_names card_names_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_names
    ADD CONSTRAINT card_names_name_key UNIQUE (name);


--
-- Name: card_names card_names_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_names
    ADD CONSTRAINT card_names_pkey PRIMARY KEY (id);


--
-- Name: card_print_faces card_print_faces_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_print_faces
    ADD CONSTRAINT card_print_faces_pkey PRIMARY KEY (id);


--
-- Name: card_prints card_prints_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_prints
    ADD CONSTRAINT card_prints_pkey PRIMARY KEY (id);


--
-- Name: card_prints card_prints_print_sid_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_prints
    ADD CONSTRAINT card_prints_print_sid_key UNIQUE (print_sid);


--
-- Name: card_rarities card_rarities_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_rarities
    ADD CONSTRAINT card_rarities_pkey PRIMARY KEY (id);


--
-- Name: card_rarities card_rarities_rarity_code_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_rarities
    ADD CONSTRAINT card_rarities_rarity_code_key UNIQUE (rarity_code);


--
-- Name: card_rarities card_rarities_rarity_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_rarities
    ADD CONSTRAINT card_rarities_rarity_name_key UNIQUE (rarity_name);


--
-- Name: card_rarities card_rarities_rarity_rank_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_rarities
    ADD CONSTRAINT card_rarities_rarity_rank_key UNIQUE (rarity_rank);


--
-- Name: card_set_types card_set_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_set_types
    ADD CONSTRAINT card_set_types_pkey PRIMARY KEY (id);


--
-- Name: card_set_types card_set_types_set_type_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_set_types
    ADD CONSTRAINT card_set_types_set_type_name_key UNIQUE (set_type_name);


--
-- Name: card_set_types card_set_types_set_type_rank_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_set_types
    ADD CONSTRAINT card_set_types_set_type_rank_key UNIQUE (set_type_rank);


--
-- Name: card_sets card_sets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_sets
    ADD CONSTRAINT card_sets_pkey PRIMARY KEY (id);


--
-- Name: card_sets card_sets_set_code_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_sets
    ADD CONSTRAINT card_sets_set_code_key UNIQUE (set_code);


--
-- Name: card_sets card_sets_set_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_sets
    ADD CONSTRAINT card_sets_set_name_key UNIQUE (set_name);


--
-- Name: card_specializations card_specializations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_specializations
    ADD CONSTRAINT card_specializations_pkey PRIMARY KEY (id);


--
-- Name: card_specializations card_specializations_specialization_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_specializations
    ADD CONSTRAINT card_specializations_specialization_key UNIQUE (specialization);


--
-- Name: card_subtypes card_subtypes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_subtypes
    ADD CONSTRAINT card_subtypes_pkey PRIMARY KEY (id);


--
-- Name: card_subtypes card_subtypes_subtype_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_subtypes
    ADD CONSTRAINT card_subtypes_subtype_key UNIQUE (subtype);


--
-- Name: card_template_subtypes card_template_subtypes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_template_subtypes
    ADD CONSTRAINT card_template_subtypes_pkey PRIMARY KEY (id);


--
-- Name: card_templates card_templates_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_templates
    ADD CONSTRAINT card_templates_pkey PRIMARY KEY (id);


--
-- Name: card_templates card_templates_template_sid_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_templates
    ADD CONSTRAINT card_templates_template_sid_key UNIQUE (template_sid);


--
-- Name: card_types card_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_types
    ADD CONSTRAINT card_types_pkey PRIMARY KEY (id);


--
-- Name: card_types card_types_type_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_types
    ADD CONSTRAINT card_types_type_key UNIQUE (type);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: card_faces card_faces_card_art_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_faces
    ADD CONSTRAINT card_faces_card_art_type_id_fkey FOREIGN KEY (card_art_type_id) REFERENCES public.card_art_types(id);


--
-- Name: card_faces card_faces_card_artist_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_faces
    ADD CONSTRAINT card_faces_card_artist_id_fkey FOREIGN KEY (card_artist_id) REFERENCES public.card_artists(id);


--
-- Name: card_faces card_faces_card_frame_color_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_faces
    ADD CONSTRAINT card_faces_card_frame_color_id_fkey FOREIGN KEY (card_frame_color_id) REFERENCES public.card_frame_colors(id);


--
-- Name: card_faces card_faces_card_frame_style_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_faces
    ADD CONSTRAINT card_faces_card_frame_style_id_fkey FOREIGN KEY (card_frame_style_id) REFERENCES public.card_frame_styles(id);


--
-- Name: card_faces card_faces_card_rarity_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_faces
    ADD CONSTRAINT card_faces_card_rarity_id_fkey FOREIGN KEY (card_rarity_id) REFERENCES public.card_rarities(id);


--
-- Name: card_faces card_faces_card_set_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_faces
    ADD CONSTRAINT card_faces_card_set_id_fkey FOREIGN KEY (card_set_id) REFERENCES public.card_sets(id);


--
-- Name: card_faces card_faces_card_template_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_faces
    ADD CONSTRAINT card_faces_card_template_id_fkey FOREIGN KEY (card_template_id) REFERENCES public.card_templates(id);


--
-- Name: card_print_faces card_print_faces_card_face_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_print_faces
    ADD CONSTRAINT card_print_faces_card_face_id_fkey FOREIGN KEY (card_face_id) REFERENCES public.card_faces(id);


--
-- Name: card_print_faces card_print_faces_card_print_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_print_faces
    ADD CONSTRAINT card_print_faces_card_print_id_fkey FOREIGN KEY (card_print_id) REFERENCES public.card_prints(id);


--
-- Name: card_prints card_prints_card_finish_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_prints
    ADD CONSTRAINT card_prints_card_finish_type_id_fkey FOREIGN KEY (card_finish_type_id) REFERENCES public.card_finish_types(id);


--
-- Name: card_prints card_prints_card_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_prints
    ADD CONSTRAINT card_prints_card_group_id_fkey FOREIGN KEY (card_group_id) REFERENCES public.card_groups(id);


--
-- Name: card_prints card_prints_card_layout_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_prints
    ADD CONSTRAINT card_prints_card_layout_id_fkey FOREIGN KEY (card_layout_id) REFERENCES public.card_layouts(id);


--
-- Name: card_sets card_sets_card_set_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_sets
    ADD CONSTRAINT card_sets_card_set_type_id_fkey FOREIGN KEY (card_set_type_id) REFERENCES public.card_set_types(id);


--
-- Name: card_sets card_sets_parent_set_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_sets
    ADD CONSTRAINT card_sets_parent_set_id_fkey FOREIGN KEY (parent_set_id) REFERENCES public.card_sets(id);


--
-- Name: card_template_subtypes card_template_subtypes_card_subtype_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_template_subtypes
    ADD CONSTRAINT card_template_subtypes_card_subtype_id_fkey FOREIGN KEY (card_subtype_id) REFERENCES public.card_subtypes(id);


--
-- Name: card_template_subtypes card_template_subtypes_card_template_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_template_subtypes
    ADD CONSTRAINT card_template_subtypes_card_template_id_fkey FOREIGN KEY (card_template_id) REFERENCES public.card_templates(id);


--
-- Name: card_templates card_templates_card_class_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_templates
    ADD CONSTRAINT card_templates_card_class_id_fkey FOREIGN KEY (card_class_id) REFERENCES public.card_classes(id);


--
-- Name: card_templates card_templates_card_name_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_templates
    ADD CONSTRAINT card_templates_card_name_id_fkey FOREIGN KEY (card_name_id) REFERENCES public.card_names(id);


--
-- Name: card_templates card_templates_card_specialization_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_templates
    ADD CONSTRAINT card_templates_card_specialization_id_fkey FOREIGN KEY (card_specialization_id) REFERENCES public.card_specializations(id);


--
-- Name: card_templates card_templates_card_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.card_templates
    ADD CONSTRAINT card_templates_card_type_id_fkey FOREIGN KEY (card_type_id) REFERENCES public.card_types(id);


--
-- PostgreSQL database dump complete
--


--
-- Dbmate schema migrations
--

INSERT INTO public.schema_migrations (version) VALUES
    ('20210224234547'),
    ('20210225005328'),
    ('20210225005335'),
    ('20210225005342'),
    ('20210225030431');
