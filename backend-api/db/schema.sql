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
-- Name: cardartists; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cardartists (
    id integer NOT NULL,
    artistname text NOT NULL
);


--
-- Name: cardartists_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cardartists_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cardartists_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cardartists_id_seq OWNED BY public.cardartists.id;


--
-- Name: cardarttypes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cardarttypes (
    id integer NOT NULL,
    arttypecode text NOT NULL,
    arttypename text NOT NULL,
    arttyperank integer NOT NULL
);


--
-- Name: cardarttypes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cardarttypes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cardarttypes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cardarttypes_id_seq OWNED BY public.cardarttypes.id;


--
-- Name: cardclasses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cardclasses (
    id integer NOT NULL,
    class text NOT NULL
);


--
-- Name: cardclasses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cardclasses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cardclasses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cardclasses_id_seq OWNED BY public.cardclasses.id;


--
-- Name: cardfaces; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cardfaces (
    id integer NOT NULL,
    facesid text NOT NULL,
    setnumber integer NOT NULL,
    imagestr text NOT NULL,
    code text NOT NULL,
    rulestext text,
    flavortext text,
    cardtemplateid integer,
    cardsetid integer,
    cardrarityid integer,
    cardarttypeid integer,
    cardframestyleid integer,
    cardframealtcolorid integer,
    cardartistid integer
);


--
-- Name: cardfaces_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cardfaces_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cardfaces_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cardfaces_id_seq OWNED BY public.cardfaces.id;


--
-- Name: cardfinishtypes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cardfinishtypes (
    id integer NOT NULL,
    finishtypecode text NOT NULL,
    finishtypename text NOT NULL,
    finishtyperank integer NOT NULL
);


--
-- Name: cardfinishtypes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cardfinishtypes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cardfinishtypes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cardfinishtypes_id_seq OWNED BY public.cardfinishtypes.id;


--
-- Name: cardframealtcolors; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cardframealtcolors (
    id integer NOT NULL,
    framealtcolor text NOT NULL
);


--
-- Name: cardframealtcolors_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cardframealtcolors_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cardframealtcolors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cardframealtcolors_id_seq OWNED BY public.cardframealtcolors.id;


--
-- Name: cardframestyles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cardframestyles (
    id integer NOT NULL,
    framestyle text NOT NULL
);


--
-- Name: cardframestyles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cardframestyles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cardframestyles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cardframestyles_id_seq OWNED BY public.cardframestyles.id;


--
-- Name: cardgroups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cardgroups (
    id integer NOT NULL,
    groupcode text NOT NULL,
    groupname text NOT NULL,
    dateprinted date,
    datereleased date
);


--
-- Name: cardgroups_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cardgroups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cardgroups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cardgroups_id_seq OWNED BY public.cardgroups.id;


--
-- Name: cardlayouts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cardlayouts (
    id integer NOT NULL,
    layout text NOT NULL
);


--
-- Name: cardlayouts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cardlayouts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cardlayouts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cardlayouts_id_seq OWNED BY public.cardlayouts.id;


--
-- Name: cardnames; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cardnames (
    id integer NOT NULL,
    name text NOT NULL
);


--
-- Name: cardnames_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cardnames_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cardnames_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cardnames_id_seq OWNED BY public.cardnames.id;


--
-- Name: cardprintfaces; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cardprintfaces (
    id integer NOT NULL,
    cardprintid integer NOT NULL,
    cardfaceid integer NOT NULL
);


--
-- Name: cardprintfaces_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cardprintfaces_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cardprintfaces_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cardprintfaces_id_seq OWNED BY public.cardprintfaces.id;


--
-- Name: cardprints; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cardprints (
    id integer NOT NULL,
    printsid text NOT NULL,
    cardfinishtypeid integer,
    cardlayoutid integer,
    cardgroupid integer
);


--
-- Name: cardprints_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cardprints_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cardprints_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cardprints_id_seq OWNED BY public.cardprints.id;


--
-- Name: cardrarities; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cardrarities (
    id integer NOT NULL,
    raritycode text NOT NULL,
    rarityname text NOT NULL,
    rarityrank integer NOT NULL
);


--
-- Name: cardrarities_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cardrarities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cardrarities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cardrarities_id_seq OWNED BY public.cardrarities.id;


--
-- Name: cardsets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cardsets (
    id integer NOT NULL,
    setcode text NOT NULL,
    setname text NOT NULL,
    cardsettypeid integer,
    parentsetid integer
);


--
-- Name: cardsets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cardsets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cardsets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cardsets_id_seq OWNED BY public.cardsets.id;


--
-- Name: cardsettypes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cardsettypes (
    id integer NOT NULL,
    settypename text NOT NULL,
    settyperank integer NOT NULL,
    booster boolean NOT NULL,
    draftable boolean NOT NULL,
    promo boolean NOT NULL
);


--
-- Name: cardsettypes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cardsettypes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cardsettypes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cardsettypes_id_seq OWNED BY public.cardsettypes.id;


--
-- Name: cardspecializations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cardspecializations (
    id integer NOT NULL,
    specialization text NOT NULL
);


--
-- Name: cardspecializations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cardspecializations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cardspecializations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cardspecializations_id_seq OWNED BY public.cardspecializations.id;


--
-- Name: cardsubtypes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cardsubtypes (
    id integer NOT NULL,
    subtype text NOT NULL
);


--
-- Name: cardsubtypes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cardsubtypes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cardsubtypes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cardsubtypes_id_seq OWNED BY public.cardsubtypes.id;


--
-- Name: cardtemplates; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cardtemplates (
    id integer NOT NULL,
    templatesid text NOT NULL,
    pitch integer,
    cost integer,
    varcost text,
    power integer,
    varpower text,
    defense integer,
    vardefense text,
    intellect integer,
    life integer,
    handedness integer,
    legendary boolean NOT NULL,
    cardnameid integer,
    cardclassid integer,
    cardtypeid integer,
    cardspecializationid integer
);


--
-- Name: cardtemplates_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cardtemplates_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cardtemplates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cardtemplates_id_seq OWNED BY public.cardtemplates.id;


--
-- Name: cardtemplatesubtypes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cardtemplatesubtypes (
    id integer NOT NULL,
    cardtemplateid integer NOT NULL,
    cardsubtypeid integer NOT NULL
);


--
-- Name: cardtemplatesubtypes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cardtemplatesubtypes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cardtemplatesubtypes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cardtemplatesubtypes_id_seq OWNED BY public.cardtemplatesubtypes.id;


--
-- Name: cardtypes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cardtypes (
    id integer NOT NULL,
    type text NOT NULL
);


--
-- Name: cardtypes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cardtypes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cardtypes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cardtypes_id_seq OWNED BY public.cardtypes.id;


--
-- Name: mv_cards; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.mv_cards AS
 SELECT frontprintface.id AS cardid,
    cardtemplates.id AS templateid,
    cardtemplates.templatesid,
    cardtemplates.pitch,
    cardtemplates.cost,
    cardtemplates.varcost,
    cardtemplates.power,
    cardtemplates.varpower,
    cardtemplates.defense,
    cardtemplates.vardefense,
    cardtemplates.intellect,
    cardtemplates.life,
    cardtemplates.handedness,
    cardtemplates.legendary,
    cardnames.name,
    cardclasses.class,
    cardspecializations.specialization,
    cardtypes.type,
    cardsubtypescsv.subtypes_csv,
    cardfaces.id AS faceid,
    cardfaces.facesid,
    cardfaces.setnumber,
    cardfaces.imagestr,
    cardfaces.code,
    cardfaces.rulestext,
    cardfaces.flavortext,
    cardfaces.cardtemplateid,
    cardsets.setcode,
    cardsets.setname,
    cardsettypes.settypename,
    cardsettypes.settyperank,
    cardsettypes.booster,
    cardsettypes.draftable,
    cardsettypes.promo,
    cardrarities.raritycode,
    cardrarities.rarityname,
    cardrarities.rarityrank,
    cardarttypes.arttypecode,
    cardarttypes.arttypename,
    cardarttypes.arttyperank,
    cardframestyles.framestyle,
    cardframealtcolors.framealtcolor,
    cardartists.artistname,
    cardprints.id AS printid,
    cardprints.printsid,
    cardfinishtypes.finishtypecode,
    cardfinishtypes.finishtypename,
    cardfinishtypes.finishtyperank,
    cardlayouts.layout,
    cardgroups.groupcode,
    cardgroups.groupname,
    cardgroups.dateprinted,
    cardgroups.datereleased,
    frontprintface.cardfaceid AS frontcardfaceid,
    backprintface.cardfaceid AS backcardfaceid,
    backfaces.imagestr AS backfaceimagestr
   FROM (((((((((((((((((((((public.cardprints
     JOIN public.cardprintfaces frontprintface ON ((frontprintface.cardprintid = cardprints.id)))
     LEFT JOIN public.cardprintfaces backprintface ON (((backprintface.cardprintid = frontprintface.cardprintid) AND (backprintface.id <> frontprintface.id))))
     JOIN public.cardfaces ON ((cardfaces.id = frontprintface.cardfaceid)))
     JOIN public.cardfaces backfaces ON ((backfaces.id = backprintface.cardfaceid)))
     JOIN public.cardtemplates ON ((cardtemplates.id = cardfaces.cardtemplateid)))
     LEFT JOIN public.cardnames ON ((cardnames.id = cardtemplates.cardnameid)))
     LEFT JOIN public.cardclasses ON ((cardclasses.id = cardtemplates.cardclassid)))
     LEFT JOIN public.cardspecializations ON ((cardspecializations.id = cardtemplates.cardspecializationid)))
     LEFT JOIN public.cardtypes ON ((cardtypes.id = cardtemplates.cardtypeid)))
     LEFT JOIN public.cardtemplatesubtypes ON ((cardtemplatesubtypes.cardtemplateid = cardtemplates.id)))
     LEFT JOIN ( SELECT cardtemplatesubtypes_1.cardtemplateid,
            array_agg(cardsubtypes.subtype) AS subtypes_csv
           FROM (public.cardtemplatesubtypes cardtemplatesubtypes_1
             LEFT JOIN public.cardsubtypes ON ((cardsubtypes.id = cardtemplatesubtypes_1.cardsubtypeid)))
          GROUP BY cardtemplatesubtypes_1.cardtemplateid) cardsubtypescsv ON ((cardsubtypescsv.cardtemplateid = cardtemplates.id)))
     LEFT JOIN public.cardsets ON ((cardsets.id = cardfaces.cardsetid)))
     LEFT JOIN public.cardsettypes ON ((cardsettypes.id = cardsets.cardsettypeid)))
     LEFT JOIN public.cardrarities ON ((cardrarities.id = cardfaces.cardrarityid)))
     LEFT JOIN public.cardarttypes ON ((cardarttypes.id = cardfaces.cardarttypeid)))
     LEFT JOIN public.cardframestyles ON ((cardframestyles.id = cardfaces.cardframestyleid)))
     LEFT JOIN public.cardframealtcolors ON ((cardframealtcolors.id = cardfaces.cardframealtcolorid)))
     LEFT JOIN public.cardartists ON ((cardartists.id = cardfaces.cardartistid)))
     LEFT JOIN public.cardfinishtypes ON ((cardfinishtypes.id = cardprints.cardfinishtypeid)))
     LEFT JOIN public.cardlayouts ON ((cardlayouts.id = cardprints.cardlayoutid)))
     LEFT JOIN public.cardgroups ON ((cardgroups.id = cardprints.cardgroupid)))
  WITH NO DATA;


--
-- Name: mv_cardsets; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.mv_cardsets AS
 SELECT cardsets.id AS setid,
    cardsets.setcode,
    cardsets.setname,
    cardsettypes.settypename,
    cardsettypes.settyperank,
    cardsettypes.booster,
    cardsettypes.draftable,
    cardsettypes.promo
   FROM (public.cardsets
     LEFT JOIN public.cardsettypes ON ((cardsettypes.id = cardsets.cardsettypeid)))
  WITH NO DATA;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: cardartists id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardartists ALTER COLUMN id SET DEFAULT nextval('public.cardartists_id_seq'::regclass);


--
-- Name: cardarttypes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardarttypes ALTER COLUMN id SET DEFAULT nextval('public.cardarttypes_id_seq'::regclass);


--
-- Name: cardclasses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardclasses ALTER COLUMN id SET DEFAULT nextval('public.cardclasses_id_seq'::regclass);


--
-- Name: cardfaces id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardfaces ALTER COLUMN id SET DEFAULT nextval('public.cardfaces_id_seq'::regclass);


--
-- Name: cardfinishtypes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardfinishtypes ALTER COLUMN id SET DEFAULT nextval('public.cardfinishtypes_id_seq'::regclass);


--
-- Name: cardframealtcolors id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardframealtcolors ALTER COLUMN id SET DEFAULT nextval('public.cardframealtcolors_id_seq'::regclass);


--
-- Name: cardframestyles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardframestyles ALTER COLUMN id SET DEFAULT nextval('public.cardframestyles_id_seq'::regclass);


--
-- Name: cardgroups id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardgroups ALTER COLUMN id SET DEFAULT nextval('public.cardgroups_id_seq'::regclass);


--
-- Name: cardlayouts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardlayouts ALTER COLUMN id SET DEFAULT nextval('public.cardlayouts_id_seq'::regclass);


--
-- Name: cardnames id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardnames ALTER COLUMN id SET DEFAULT nextval('public.cardnames_id_seq'::regclass);


--
-- Name: cardprintfaces id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardprintfaces ALTER COLUMN id SET DEFAULT nextval('public.cardprintfaces_id_seq'::regclass);


--
-- Name: cardprints id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardprints ALTER COLUMN id SET DEFAULT nextval('public.cardprints_id_seq'::regclass);


--
-- Name: cardrarities id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardrarities ALTER COLUMN id SET DEFAULT nextval('public.cardrarities_id_seq'::regclass);


--
-- Name: cardsets id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardsets ALTER COLUMN id SET DEFAULT nextval('public.cardsets_id_seq'::regclass);


--
-- Name: cardsettypes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardsettypes ALTER COLUMN id SET DEFAULT nextval('public.cardsettypes_id_seq'::regclass);


--
-- Name: cardspecializations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardspecializations ALTER COLUMN id SET DEFAULT nextval('public.cardspecializations_id_seq'::regclass);


--
-- Name: cardsubtypes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardsubtypes ALTER COLUMN id SET DEFAULT nextval('public.cardsubtypes_id_seq'::regclass);


--
-- Name: cardtemplates id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardtemplates ALTER COLUMN id SET DEFAULT nextval('public.cardtemplates_id_seq'::regclass);


--
-- Name: cardtemplatesubtypes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardtemplatesubtypes ALTER COLUMN id SET DEFAULT nextval('public.cardtemplatesubtypes_id_seq'::regclass);


--
-- Name: cardtypes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardtypes ALTER COLUMN id SET DEFAULT nextval('public.cardtypes_id_seq'::regclass);


--
-- Name: cardartists cardartists_artistname_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardartists
    ADD CONSTRAINT cardartists_artistname_key UNIQUE (artistname);


--
-- Name: cardartists cardartists_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardartists
    ADD CONSTRAINT cardartists_pkey PRIMARY KEY (id);


--
-- Name: cardarttypes cardarttypes_arttypecode_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardarttypes
    ADD CONSTRAINT cardarttypes_arttypecode_key UNIQUE (arttypecode);


--
-- Name: cardarttypes cardarttypes_arttypename_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardarttypes
    ADD CONSTRAINT cardarttypes_arttypename_key UNIQUE (arttypename);


--
-- Name: cardarttypes cardarttypes_arttyperank_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardarttypes
    ADD CONSTRAINT cardarttypes_arttyperank_key UNIQUE (arttyperank);


--
-- Name: cardarttypes cardarttypes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardarttypes
    ADD CONSTRAINT cardarttypes_pkey PRIMARY KEY (id);


--
-- Name: cardclasses cardclasses_class_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardclasses
    ADD CONSTRAINT cardclasses_class_key UNIQUE (class);


--
-- Name: cardclasses cardclasses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardclasses
    ADD CONSTRAINT cardclasses_pkey PRIMARY KEY (id);


--
-- Name: cardfaces cardfaces_facesid_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardfaces
    ADD CONSTRAINT cardfaces_facesid_key UNIQUE (facesid);


--
-- Name: cardfaces cardfaces_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardfaces
    ADD CONSTRAINT cardfaces_pkey PRIMARY KEY (id);


--
-- Name: cardfinishtypes cardfinishtypes_finishtypecode_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardfinishtypes
    ADD CONSTRAINT cardfinishtypes_finishtypecode_key UNIQUE (finishtypecode);


--
-- Name: cardfinishtypes cardfinishtypes_finishtypename_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardfinishtypes
    ADD CONSTRAINT cardfinishtypes_finishtypename_key UNIQUE (finishtypename);


--
-- Name: cardfinishtypes cardfinishtypes_finishtyperank_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardfinishtypes
    ADD CONSTRAINT cardfinishtypes_finishtyperank_key UNIQUE (finishtyperank);


--
-- Name: cardfinishtypes cardfinishtypes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardfinishtypes
    ADD CONSTRAINT cardfinishtypes_pkey PRIMARY KEY (id);


--
-- Name: cardframealtcolors cardframealtcolors_framealtcolor_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardframealtcolors
    ADD CONSTRAINT cardframealtcolors_framealtcolor_key UNIQUE (framealtcolor);


--
-- Name: cardframealtcolors cardframealtcolors_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardframealtcolors
    ADD CONSTRAINT cardframealtcolors_pkey PRIMARY KEY (id);


--
-- Name: cardframestyles cardframestyles_framestyle_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardframestyles
    ADD CONSTRAINT cardframestyles_framestyle_key UNIQUE (framestyle);


--
-- Name: cardframestyles cardframestyles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardframestyles
    ADD CONSTRAINT cardframestyles_pkey PRIMARY KEY (id);


--
-- Name: cardgroups cardgroups_groupcode_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardgroups
    ADD CONSTRAINT cardgroups_groupcode_key UNIQUE (groupcode);


--
-- Name: cardgroups cardgroups_groupname_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardgroups
    ADD CONSTRAINT cardgroups_groupname_key UNIQUE (groupname);


--
-- Name: cardgroups cardgroups_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardgroups
    ADD CONSTRAINT cardgroups_pkey PRIMARY KEY (id);


--
-- Name: cardlayouts cardlayouts_layout_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardlayouts
    ADD CONSTRAINT cardlayouts_layout_key UNIQUE (layout);


--
-- Name: cardlayouts cardlayouts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardlayouts
    ADD CONSTRAINT cardlayouts_pkey PRIMARY KEY (id);


--
-- Name: cardnames cardnames_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardnames
    ADD CONSTRAINT cardnames_name_key UNIQUE (name);


--
-- Name: cardnames cardnames_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardnames
    ADD CONSTRAINT cardnames_pkey PRIMARY KEY (id);


--
-- Name: cardprintfaces cardprintfaces_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardprintfaces
    ADD CONSTRAINT cardprintfaces_pkey PRIMARY KEY (id);


--
-- Name: cardprints cardprints_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardprints
    ADD CONSTRAINT cardprints_pkey PRIMARY KEY (id);


--
-- Name: cardprints cardprints_printsid_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardprints
    ADD CONSTRAINT cardprints_printsid_key UNIQUE (printsid);


--
-- Name: cardrarities cardrarities_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardrarities
    ADD CONSTRAINT cardrarities_pkey PRIMARY KEY (id);


--
-- Name: cardrarities cardrarities_raritycode_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardrarities
    ADD CONSTRAINT cardrarities_raritycode_key UNIQUE (raritycode);


--
-- Name: cardrarities cardrarities_rarityname_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardrarities
    ADD CONSTRAINT cardrarities_rarityname_key UNIQUE (rarityname);


--
-- Name: cardrarities cardrarities_rarityrank_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardrarities
    ADD CONSTRAINT cardrarities_rarityrank_key UNIQUE (rarityrank);


--
-- Name: cardsets cardsets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardsets
    ADD CONSTRAINT cardsets_pkey PRIMARY KEY (id);


--
-- Name: cardsets cardsets_setcode_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardsets
    ADD CONSTRAINT cardsets_setcode_key UNIQUE (setcode);


--
-- Name: cardsets cardsets_setname_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardsets
    ADD CONSTRAINT cardsets_setname_key UNIQUE (setname);


--
-- Name: cardsettypes cardsettypes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardsettypes
    ADD CONSTRAINT cardsettypes_pkey PRIMARY KEY (id);


--
-- Name: cardsettypes cardsettypes_settypename_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardsettypes
    ADD CONSTRAINT cardsettypes_settypename_key UNIQUE (settypename);


--
-- Name: cardsettypes cardsettypes_settyperank_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardsettypes
    ADD CONSTRAINT cardsettypes_settyperank_key UNIQUE (settyperank);


--
-- Name: cardspecializations cardspecializations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardspecializations
    ADD CONSTRAINT cardspecializations_pkey PRIMARY KEY (id);


--
-- Name: cardspecializations cardspecializations_specialization_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardspecializations
    ADD CONSTRAINT cardspecializations_specialization_key UNIQUE (specialization);


--
-- Name: cardsubtypes cardsubtypes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardsubtypes
    ADD CONSTRAINT cardsubtypes_pkey PRIMARY KEY (id);


--
-- Name: cardsubtypes cardsubtypes_subtype_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardsubtypes
    ADD CONSTRAINT cardsubtypes_subtype_key UNIQUE (subtype);


--
-- Name: cardtemplates cardtemplates_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardtemplates
    ADD CONSTRAINT cardtemplates_pkey PRIMARY KEY (id);


--
-- Name: cardtemplates cardtemplates_templatesid_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardtemplates
    ADD CONSTRAINT cardtemplates_templatesid_key UNIQUE (templatesid);


--
-- Name: cardtemplatesubtypes cardtemplatesubtypes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardtemplatesubtypes
    ADD CONSTRAINT cardtemplatesubtypes_pkey PRIMARY KEY (id);


--
-- Name: cardtypes cardtypes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardtypes
    ADD CONSTRAINT cardtypes_pkey PRIMARY KEY (id);


--
-- Name: cardtypes cardtypes_type_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardtypes
    ADD CONSTRAINT cardtypes_type_key UNIQUE (type);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: cardfaces cardfaces_cardartistid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardfaces
    ADD CONSTRAINT cardfaces_cardartistid_fkey FOREIGN KEY (cardartistid) REFERENCES public.cardartists(id);


--
-- Name: cardfaces cardfaces_cardarttypeid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardfaces
    ADD CONSTRAINT cardfaces_cardarttypeid_fkey FOREIGN KEY (cardarttypeid) REFERENCES public.cardarttypes(id);


--
-- Name: cardfaces cardfaces_cardframealtcolorid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardfaces
    ADD CONSTRAINT cardfaces_cardframealtcolorid_fkey FOREIGN KEY (cardframealtcolorid) REFERENCES public.cardframealtcolors(id);


--
-- Name: cardfaces cardfaces_cardframestyleid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardfaces
    ADD CONSTRAINT cardfaces_cardframestyleid_fkey FOREIGN KEY (cardframestyleid) REFERENCES public.cardframestyles(id);


--
-- Name: cardfaces cardfaces_cardrarityid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardfaces
    ADD CONSTRAINT cardfaces_cardrarityid_fkey FOREIGN KEY (cardrarityid) REFERENCES public.cardrarities(id);


--
-- Name: cardfaces cardfaces_cardsetid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardfaces
    ADD CONSTRAINT cardfaces_cardsetid_fkey FOREIGN KEY (cardsetid) REFERENCES public.cardsets(id);


--
-- Name: cardfaces cardfaces_cardtemplateid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardfaces
    ADD CONSTRAINT cardfaces_cardtemplateid_fkey FOREIGN KEY (cardtemplateid) REFERENCES public.cardtemplates(id);


--
-- Name: cardprintfaces cardprintfaces_cardfaceid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardprintfaces
    ADD CONSTRAINT cardprintfaces_cardfaceid_fkey FOREIGN KEY (cardfaceid) REFERENCES public.cardfaces(id);


--
-- Name: cardprintfaces cardprintfaces_cardprintid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardprintfaces
    ADD CONSTRAINT cardprintfaces_cardprintid_fkey FOREIGN KEY (cardprintid) REFERENCES public.cardprints(id);


--
-- Name: cardprints cardprints_cardfinishtypeid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardprints
    ADD CONSTRAINT cardprints_cardfinishtypeid_fkey FOREIGN KEY (cardfinishtypeid) REFERENCES public.cardfinishtypes(id);


--
-- Name: cardprints cardprints_cardgroupid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardprints
    ADD CONSTRAINT cardprints_cardgroupid_fkey FOREIGN KEY (cardgroupid) REFERENCES public.cardgroups(id);


--
-- Name: cardprints cardprints_cardlayoutid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardprints
    ADD CONSTRAINT cardprints_cardlayoutid_fkey FOREIGN KEY (cardlayoutid) REFERENCES public.cardlayouts(id);


--
-- Name: cardsets cardsets_cardsettypeid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardsets
    ADD CONSTRAINT cardsets_cardsettypeid_fkey FOREIGN KEY (cardsettypeid) REFERENCES public.cardsettypes(id);


--
-- Name: cardsets cardsets_parentsetid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardsets
    ADD CONSTRAINT cardsets_parentsetid_fkey FOREIGN KEY (parentsetid) REFERENCES public.cardsets(id);


--
-- Name: cardtemplates cardtemplates_cardclassid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardtemplates
    ADD CONSTRAINT cardtemplates_cardclassid_fkey FOREIGN KEY (cardclassid) REFERENCES public.cardclasses(id);


--
-- Name: cardtemplates cardtemplates_cardnameid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardtemplates
    ADD CONSTRAINT cardtemplates_cardnameid_fkey FOREIGN KEY (cardnameid) REFERENCES public.cardnames(id);


--
-- Name: cardtemplates cardtemplates_cardspecializationid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardtemplates
    ADD CONSTRAINT cardtemplates_cardspecializationid_fkey FOREIGN KEY (cardspecializationid) REFERENCES public.cardspecializations(id);


--
-- Name: cardtemplates cardtemplates_cardtypeid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardtemplates
    ADD CONSTRAINT cardtemplates_cardtypeid_fkey FOREIGN KEY (cardtypeid) REFERENCES public.cardtypes(id);


--
-- Name: cardtemplatesubtypes cardtemplatesubtypes_cardsubtypeid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardtemplatesubtypes
    ADD CONSTRAINT cardtemplatesubtypes_cardsubtypeid_fkey FOREIGN KEY (cardsubtypeid) REFERENCES public.cardsubtypes(id);


--
-- Name: cardtemplatesubtypes cardtemplatesubtypes_cardtemplateid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cardtemplatesubtypes
    ADD CONSTRAINT cardtemplatesubtypes_cardtemplateid_fkey FOREIGN KEY (cardtemplateid) REFERENCES public.cardtemplates(id);


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
