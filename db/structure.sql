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

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS '';


--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA public;


--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: adjournment_days; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.adjournment_days (
    id integer NOT NULL,
    date date NOT NULL,
    google_event_id character varying(255) NOT NULL,
    session_id integer NOT NULL,
    house_id integer NOT NULL,
    recess_date_id integer,
    created_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: adjournment_days_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.adjournment_days_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: adjournment_days_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.adjournment_days_id_seq OWNED BY public.adjournment_days.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: calendar_syncs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.calendar_syncs (
    id integer NOT NULL,
    synced_at timestamp without time zone NOT NULL
);


--
-- Name: calendar_sync_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.calendar_sync_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: calendar_sync_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.calendar_sync_id_seq OWNED BY public.calendar_syncs.id;


--
-- Name: detailed_sync_logs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.detailed_sync_logs (
    id bigint NOT NULL,
    calendar_name text,
    google_calendar_id text,
    message text,
    successful boolean,
    emailed boolean,
    events_count integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: detailed_sync_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.detailed_sync_logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: detailed_sync_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.detailed_sync_logs_id_seq OWNED BY public.detailed_sync_logs.id;


--
-- Name: dissolution_days; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dissolution_days (
    id integer NOT NULL,
    date date NOT NULL,
    google_event_id character varying(255),
    dissolution_period_id integer NOT NULL
);


--
-- Name: dissolution_days_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.dissolution_days_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: dissolution_days_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.dissolution_days_id_seq OWNED BY public.dissolution_days.id;


--
-- Name: dissolution_periods; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dissolution_periods (
    id integer NOT NULL,
    number integer NOT NULL,
    start_date date NOT NULL,
    end_date date
);


--
-- Name: dissolution_periods_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.dissolution_periods_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: dissolution_periods_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.dissolution_periods_id_seq OWNED BY public.dissolution_periods.id;


--
-- Name: houses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.houses (
    id integer NOT NULL,
    name character varying(50) NOT NULL
);


--
-- Name: houses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.houses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: houses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.houses_id_seq OWNED BY public.houses.id;


--
-- Name: parliament_periods; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.parliament_periods (
    id integer NOT NULL,
    number integer NOT NULL,
    start_date date NOT NULL,
    end_date date,
    wikidata_id character varying(20)
);


--
-- Name: parliament_periods_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.parliament_periods_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: parliament_periods_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.parliament_periods_id_seq OWNED BY public.parliament_periods.id;


--
-- Name: procedures; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.procedures (
    id integer NOT NULL,
    display_order integer NOT NULL,
    name character varying(255) NOT NULL,
    active boolean NOT NULL,
    typical_day_count integer,
    has_day_count_caveats boolean
);


--
-- Name: procedures_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.procedures_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: procedures_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.procedures_id_seq OWNED BY public.procedures.id;


--
-- Name: prorogation_days; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.prorogation_days (
    id integer NOT NULL,
    date date NOT NULL,
    google_event_id character varying(255),
    prorogation_period_id integer NOT NULL
);


--
-- Name: prorogation_days_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.prorogation_days_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: prorogation_days_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.prorogation_days_id_seq OWNED BY public.prorogation_days.id;


--
-- Name: prorogation_periods; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.prorogation_periods (
    id integer NOT NULL,
    number integer NOT NULL,
    start_date date NOT NULL,
    end_date date,
    parliament_period_id integer NOT NULL
);


--
-- Name: prorogation_periods_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.prorogation_periods_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: prorogation_periods_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.prorogation_periods_id_seq OWNED BY public.prorogation_periods.id;


--
-- Name: recess_dates; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.recess_dates (
    id integer NOT NULL,
    description character varying(255) NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    google_event_id character varying(255) NOT NULL,
    house_id integer NOT NULL,
    created_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: recess_dates_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.recess_dates_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: recess_dates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.recess_dates_id_seq OWNED BY public.recess_dates.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sessions (
    id integer NOT NULL,
    number integer NOT NULL,
    start_date date NOT NULL,
    end_date date,
    citation character varying(255),
    regnal_year_citation character varying(255),
    wikidata_id character varying(20),
    parliament_period_id integer NOT NULL
);


--
-- Name: sessions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.sessions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sessions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.sessions_id_seq OWNED BY public.sessions.id;


--
-- Name: sitting_days; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sitting_days (
    id integer NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    google_event_id character varying(255) NOT NULL,
    session_id integer NOT NULL,
    house_id integer NOT NULL,
    created_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: sitting_days_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.sitting_days_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sitting_days_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.sitting_days_id_seq OWNED BY public.sitting_days.id;


--
-- Name: sync_tokens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sync_tokens (
    id integer NOT NULL,
    google_calendar_id character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    google_calendar_name text,
    house_id integer,
    successful boolean DEFAULT false
);


--
-- Name: sync_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.sync_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sync_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.sync_tokens_id_seq OWNED BY public.sync_tokens.id;


--
-- Name: virtual_sitting_days; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.virtual_sitting_days (
    id integer NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    google_event_id character varying(255) NOT NULL,
    session_id integer NOT NULL,
    house_id integer NOT NULL,
    created_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: virtual_sitting_days_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.virtual_sitting_days_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: virtual_sitting_days_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.virtual_sitting_days_id_seq OWNED BY public.virtual_sitting_days.id;


--
-- Name: adjournment_days id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.adjournment_days ALTER COLUMN id SET DEFAULT nextval('public.adjournment_days_id_seq'::regclass);


--
-- Name: calendar_syncs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.calendar_syncs ALTER COLUMN id SET DEFAULT nextval('public.calendar_sync_id_seq'::regclass);


--
-- Name: detailed_sync_logs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.detailed_sync_logs ALTER COLUMN id SET DEFAULT nextval('public.detailed_sync_logs_id_seq'::regclass);


--
-- Name: dissolution_days id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dissolution_days ALTER COLUMN id SET DEFAULT nextval('public.dissolution_days_id_seq'::regclass);


--
-- Name: dissolution_periods id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dissolution_periods ALTER COLUMN id SET DEFAULT nextval('public.dissolution_periods_id_seq'::regclass);


--
-- Name: houses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.houses ALTER COLUMN id SET DEFAULT nextval('public.houses_id_seq'::regclass);


--
-- Name: parliament_periods id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.parliament_periods ALTER COLUMN id SET DEFAULT nextval('public.parliament_periods_id_seq'::regclass);


--
-- Name: procedures id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.procedures ALTER COLUMN id SET DEFAULT nextval('public.procedures_id_seq'::regclass);


--
-- Name: prorogation_days id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.prorogation_days ALTER COLUMN id SET DEFAULT nextval('public.prorogation_days_id_seq'::regclass);


--
-- Name: prorogation_periods id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.prorogation_periods ALTER COLUMN id SET DEFAULT nextval('public.prorogation_periods_id_seq'::regclass);


--
-- Name: recess_dates id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recess_dates ALTER COLUMN id SET DEFAULT nextval('public.recess_dates_id_seq'::regclass);


--
-- Name: sessions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions ALTER COLUMN id SET DEFAULT nextval('public.sessions_id_seq'::regclass);


--
-- Name: sitting_days id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sitting_days ALTER COLUMN id SET DEFAULT nextval('public.sitting_days_id_seq'::regclass);


--
-- Name: sync_tokens id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sync_tokens ALTER COLUMN id SET DEFAULT nextval('public.sync_tokens_id_seq'::regclass);


--
-- Name: virtual_sitting_days id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.virtual_sitting_days ALTER COLUMN id SET DEFAULT nextval('public.virtual_sitting_days_id_seq'::regclass);


--
-- Name: adjournment_days adjournment_days_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.adjournment_days
    ADD CONSTRAINT adjournment_days_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: calendar_syncs calendar_syncs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.calendar_syncs
    ADD CONSTRAINT calendar_syncs_pkey PRIMARY KEY (id);


--
-- Name: detailed_sync_logs detailed_sync_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.detailed_sync_logs
    ADD CONSTRAINT detailed_sync_logs_pkey PRIMARY KEY (id);


--
-- Name: dissolution_days dissolution_days_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dissolution_days
    ADD CONSTRAINT dissolution_days_pkey PRIMARY KEY (id);


--
-- Name: dissolution_periods dissolution_periods_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dissolution_periods
    ADD CONSTRAINT dissolution_periods_pkey PRIMARY KEY (id);


--
-- Name: houses houses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.houses
    ADD CONSTRAINT houses_pkey PRIMARY KEY (id);


--
-- Name: parliament_periods parliament_periods_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.parliament_periods
    ADD CONSTRAINT parliament_periods_pkey PRIMARY KEY (id);


--
-- Name: procedures procedures_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.procedures
    ADD CONSTRAINT procedures_pkey PRIMARY KEY (id);


--
-- Name: prorogation_days prorogation_days_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.prorogation_days
    ADD CONSTRAINT prorogation_days_pkey PRIMARY KEY (id);


--
-- Name: prorogation_periods prorogation_periods_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.prorogation_periods
    ADD CONSTRAINT prorogation_periods_pkey PRIMARY KEY (id);


--
-- Name: recess_dates recess_dates_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recess_dates
    ADD CONSTRAINT recess_dates_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: sitting_days sitting_days_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sitting_days
    ADD CONSTRAINT sitting_days_pkey PRIMARY KEY (id);


--
-- Name: sync_tokens sync_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sync_tokens
    ADD CONSTRAINT sync_tokens_pkey PRIMARY KEY (id);


--
-- Name: virtual_sitting_days virtual_sitting_days_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.virtual_sitting_days
    ADD CONSTRAINT virtual_sitting_days_pkey PRIMARY KEY (id);


--
-- Name: dissolution_days fk_dissolution_period; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dissolution_days
    ADD CONSTRAINT fk_dissolution_period FOREIGN KEY (dissolution_period_id) REFERENCES public.dissolution_periods(id);


--
-- Name: sitting_days fk_house; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sitting_days
    ADD CONSTRAINT fk_house FOREIGN KEY (house_id) REFERENCES public.houses(id);


--
-- Name: virtual_sitting_days fk_house; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.virtual_sitting_days
    ADD CONSTRAINT fk_house FOREIGN KEY (house_id) REFERENCES public.houses(id);


--
-- Name: recess_dates fk_house; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.recess_dates
    ADD CONSTRAINT fk_house FOREIGN KEY (house_id) REFERENCES public.houses(id);


--
-- Name: adjournment_days fk_house; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.adjournment_days
    ADD CONSTRAINT fk_house FOREIGN KEY (house_id) REFERENCES public.houses(id);


--
-- Name: prorogation_periods fk_parliament_period; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.prorogation_periods
    ADD CONSTRAINT fk_parliament_period FOREIGN KEY (parliament_period_id) REFERENCES public.parliament_periods(id);


--
-- Name: sessions fk_parliament_period; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT fk_parliament_period FOREIGN KEY (parliament_period_id) REFERENCES public.parliament_periods(id);


--
-- Name: prorogation_days fk_prorogation_period; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.prorogation_days
    ADD CONSTRAINT fk_prorogation_period FOREIGN KEY (prorogation_period_id) REFERENCES public.prorogation_periods(id);


--
-- Name: sync_tokens fk_rails_b16a338843; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sync_tokens
    ADD CONSTRAINT fk_rails_b16a338843 FOREIGN KEY (house_id) REFERENCES public.houses(id);


--
-- Name: adjournment_days fk_recess_date; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.adjournment_days
    ADD CONSTRAINT fk_recess_date FOREIGN KEY (recess_date_id) REFERENCES public.recess_dates(id);


--
-- Name: sitting_days fk_session; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sitting_days
    ADD CONSTRAINT fk_session FOREIGN KEY (session_id) REFERENCES public.sessions(id);


--
-- Name: virtual_sitting_days fk_session; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.virtual_sitting_days
    ADD CONSTRAINT fk_session FOREIGN KEY (session_id) REFERENCES public.sessions(id);


--
-- Name: adjournment_days fk_session; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.adjournment_days
    ADD CONSTRAINT fk_session FOREIGN KEY (session_id) REFERENCES public.sessions(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20250512203816'),
('20250217170405'),
('20250207155008'),
('20250207155007');

