--
-- PostgreSQL database dump
--

-- Dumped from database version 12.3
-- Dumped by pg_dump version 12.3

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
-- Name: adjournment_days; Type: TABLE; Schema: public; Owner: robert
--

CREATE TABLE public.adjournment_days (
    id integer NOT NULL,
    date date NOT NULL,
    google_event_id character varying(255) NOT NULL,
    session_id integer NOT NULL,
    house_id integer NOT NULL
);


ALTER TABLE public.adjournment_days OWNER TO robert;

--
-- Name: adjournment_days_id_seq; Type: SEQUENCE; Schema: public; Owner: robert
--

CREATE SEQUENCE public.adjournment_days_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.adjournment_days_id_seq OWNER TO robert;

--
-- Name: adjournment_days_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: robert
--

ALTER SEQUENCE public.adjournment_days_id_seq OWNED BY public.adjournment_days.id;


--
-- Name: dissolution_days; Type: TABLE; Schema: public; Owner: robert
--

CREATE TABLE public.dissolution_days (
    id integer NOT NULL,
    date date NOT NULL,
    google_event_id character varying(255),
    dissolution_period_id integer NOT NULL
);


ALTER TABLE public.dissolution_days OWNER TO robert;

--
-- Name: dissolution_days_id_seq; Type: SEQUENCE; Schema: public; Owner: robert
--

CREATE SEQUENCE public.dissolution_days_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dissolution_days_id_seq OWNER TO robert;

--
-- Name: dissolution_days_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: robert
--

ALTER SEQUENCE public.dissolution_days_id_seq OWNED BY public.dissolution_days.id;


--
-- Name: dissolution_periods; Type: TABLE; Schema: public; Owner: robert
--

CREATE TABLE public.dissolution_periods (
    id integer NOT NULL,
    number integer NOT NULL,
    start_date date NOT NULL,
    end_date date
);


ALTER TABLE public.dissolution_periods OWNER TO robert;

--
-- Name: dissolution_periods_id_seq; Type: SEQUENCE; Schema: public; Owner: robert
--

CREATE SEQUENCE public.dissolution_periods_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dissolution_periods_id_seq OWNER TO robert;

--
-- Name: dissolution_periods_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: robert
--

ALTER SEQUENCE public.dissolution_periods_id_seq OWNED BY public.dissolution_periods.id;


--
-- Name: houses; Type: TABLE; Schema: public; Owner: robert
--

CREATE TABLE public.houses (
    id integer NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.houses OWNER TO robert;

--
-- Name: houses_id_seq; Type: SEQUENCE; Schema: public; Owner: robert
--

CREATE SEQUENCE public.houses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.houses_id_seq OWNER TO robert;

--
-- Name: houses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: robert
--

ALTER SEQUENCE public.houses_id_seq OWNED BY public.houses.id;


--
-- Name: parliament_periods; Type: TABLE; Schema: public; Owner: robert
--

CREATE TABLE public.parliament_periods (
    id integer NOT NULL,
    number integer NOT NULL,
    start_date date NOT NULL,
    end_date date
);


ALTER TABLE public.parliament_periods OWNER TO robert;

--
-- Name: parliament_periods_id_seq; Type: SEQUENCE; Schema: public; Owner: robert
--

CREATE SEQUENCE public.parliament_periods_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.parliament_periods_id_seq OWNER TO robert;

--
-- Name: parliament_periods_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: robert
--

ALTER SEQUENCE public.parliament_periods_id_seq OWNED BY public.parliament_periods.id;


--
-- Name: procedures; Type: TABLE; Schema: public; Owner: robert
--

CREATE TABLE public.procedures (
    id integer NOT NULL,
    display_order integer NOT NULL,
    name character varying(255) NOT NULL,
    active boolean NOT NULL
);


ALTER TABLE public.procedures OWNER TO robert;

--
-- Name: procedures_id_seq; Type: SEQUENCE; Schema: public; Owner: robert
--

CREATE SEQUENCE public.procedures_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.procedures_id_seq OWNER TO robert;

--
-- Name: procedures_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: robert
--

ALTER SEQUENCE public.procedures_id_seq OWNED BY public.procedures.id;


--
-- Name: prorogation_days; Type: TABLE; Schema: public; Owner: robert
--

CREATE TABLE public.prorogation_days (
    id integer NOT NULL,
    date date NOT NULL,
    google_event_id character varying(255),
    prorogation_period_id integer NOT NULL
);


ALTER TABLE public.prorogation_days OWNER TO robert;

--
-- Name: prorogation_days_id_seq; Type: SEQUENCE; Schema: public; Owner: robert
--

CREATE SEQUENCE public.prorogation_days_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.prorogation_days_id_seq OWNER TO robert;

--
-- Name: prorogation_days_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: robert
--

ALTER SEQUENCE public.prorogation_days_id_seq OWNED BY public.prorogation_days.id;


--
-- Name: prorogation_periods; Type: TABLE; Schema: public; Owner: robert
--

CREATE TABLE public.prorogation_periods (
    id integer NOT NULL,
    number integer NOT NULL,
    start_date date NOT NULL,
    end_date date,
    parliament_period_id integer NOT NULL
);


ALTER TABLE public.prorogation_periods OWNER TO robert;

--
-- Name: prorogation_periods_id_seq; Type: SEQUENCE; Schema: public; Owner: robert
--

CREATE SEQUENCE public.prorogation_periods_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.prorogation_periods_id_seq OWNER TO robert;

--
-- Name: prorogation_periods_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: robert
--

ALTER SEQUENCE public.prorogation_periods_id_seq OWNED BY public.prorogation_periods.id;


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: robert
--

CREATE TABLE public.sessions (
    id integer NOT NULL,
    number integer NOT NULL,
    start_date date NOT NULL,
    end_date date,
    parliament_period_id integer NOT NULL
);


ALTER TABLE public.sessions OWNER TO robert;

--
-- Name: sessions_id_seq; Type: SEQUENCE; Schema: public; Owner: robert
--

CREATE SEQUENCE public.sessions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sessions_id_seq OWNER TO robert;

--
-- Name: sessions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: robert
--

ALTER SEQUENCE public.sessions_id_seq OWNED BY public.sessions.id;


--
-- Name: sitting_days; Type: TABLE; Schema: public; Owner: robert
--

CREATE TABLE public.sitting_days (
    id integer NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    google_event_id character varying(255) NOT NULL,
    session_id integer NOT NULL,
    house_id integer NOT NULL
);


ALTER TABLE public.sitting_days OWNER TO robert;

--
-- Name: sitting_days_id_seq; Type: SEQUENCE; Schema: public; Owner: robert
--

CREATE SEQUENCE public.sitting_days_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sitting_days_id_seq OWNER TO robert;

--
-- Name: sitting_days_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: robert
--

ALTER SEQUENCE public.sitting_days_id_seq OWNED BY public.sitting_days.id;


--
-- Name: sync_tokens; Type: TABLE; Schema: public; Owner: robert
--

CREATE TABLE public.sync_tokens (
    id integer NOT NULL,
    google_calendar_id character varying(255) NOT NULL,
    token character varying(255) NOT NULL
);


ALTER TABLE public.sync_tokens OWNER TO robert;

--
-- Name: sync_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: robert
--

CREATE SEQUENCE public.sync_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sync_tokens_id_seq OWNER TO robert;

--
-- Name: sync_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: robert
--

ALTER SEQUENCE public.sync_tokens_id_seq OWNED BY public.sync_tokens.id;


--
-- Name: virtual_sitting_days; Type: TABLE; Schema: public; Owner: robert
--

CREATE TABLE public.virtual_sitting_days (
    id integer NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    google_event_id character varying(255) NOT NULL,
    session_id integer NOT NULL,
    house_id integer NOT NULL
);


ALTER TABLE public.virtual_sitting_days OWNER TO robert;

--
-- Name: virtual_sitting_days_id_seq; Type: SEQUENCE; Schema: public; Owner: robert
--

CREATE SEQUENCE public.virtual_sitting_days_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.virtual_sitting_days_id_seq OWNER TO robert;

--
-- Name: virtual_sitting_days_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: robert
--

ALTER SEQUENCE public.virtual_sitting_days_id_seq OWNED BY public.virtual_sitting_days.id;


--
-- Name: adjournment_days id; Type: DEFAULT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.adjournment_days ALTER COLUMN id SET DEFAULT nextval('public.adjournment_days_id_seq'::regclass);


--
-- Name: dissolution_days id; Type: DEFAULT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.dissolution_days ALTER COLUMN id SET DEFAULT nextval('public.dissolution_days_id_seq'::regclass);


--
-- Name: dissolution_periods id; Type: DEFAULT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.dissolution_periods ALTER COLUMN id SET DEFAULT nextval('public.dissolution_periods_id_seq'::regclass);


--
-- Name: houses id; Type: DEFAULT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.houses ALTER COLUMN id SET DEFAULT nextval('public.houses_id_seq'::regclass);


--
-- Name: parliament_periods id; Type: DEFAULT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.parliament_periods ALTER COLUMN id SET DEFAULT nextval('public.parliament_periods_id_seq'::regclass);


--
-- Name: procedures id; Type: DEFAULT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.procedures ALTER COLUMN id SET DEFAULT nextval('public.procedures_id_seq'::regclass);


--
-- Name: prorogation_days id; Type: DEFAULT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.prorogation_days ALTER COLUMN id SET DEFAULT nextval('public.prorogation_days_id_seq'::regclass);


--
-- Name: prorogation_periods id; Type: DEFAULT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.prorogation_periods ALTER COLUMN id SET DEFAULT nextval('public.prorogation_periods_id_seq'::regclass);


--
-- Name: sessions id; Type: DEFAULT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.sessions ALTER COLUMN id SET DEFAULT nextval('public.sessions_id_seq'::regclass);


--
-- Name: sitting_days id; Type: DEFAULT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.sitting_days ALTER COLUMN id SET DEFAULT nextval('public.sitting_days_id_seq'::regclass);


--
-- Name: sync_tokens id; Type: DEFAULT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.sync_tokens ALTER COLUMN id SET DEFAULT nextval('public.sync_tokens_id_seq'::regclass);


--
-- Name: virtual_sitting_days id; Type: DEFAULT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.virtual_sitting_days ALTER COLUMN id SET DEFAULT nextval('public.virtual_sitting_days_id_seq'::regclass);


--
-- Data for Name: adjournment_days; Type: TABLE DATA; Schema: public; Owner: robert
--

COPY public.adjournment_days (id, date, google_event_id, session_id, house_id) FROM stdin;
1	2019-12-21	0r0aboj74bmstnfmdb3mhbh61k	1	1
2	2019-12-22	0r0aboj74bmstnfmdb3mhbh61k	1	1
3	2019-12-23	0r0aboj74bmstnfmdb3mhbh61k	1	1
4	2019-12-24	0r0aboj74bmstnfmdb3mhbh61k	1	1
5	2019-12-25	0r0aboj74bmstnfmdb3mhbh61k	1	1
6	2019-12-26	0r0aboj74bmstnfmdb3mhbh61k	1	1
7	2019-12-27	0r0aboj74bmstnfmdb3mhbh61k	1	1
8	2019-12-28	0r0aboj74bmstnfmdb3mhbh61k	1	1
9	2019-12-29	0r0aboj74bmstnfmdb3mhbh61k	1	1
10	2019-12-30	0r0aboj74bmstnfmdb3mhbh61k	1	1
11	2019-12-31	0r0aboj74bmstnfmdb3mhbh61k	1	1
12	2020-01-01	0r0aboj74bmstnfmdb3mhbh61k	1	1
13	2020-01-02	0r0aboj74bmstnfmdb3mhbh61k	1	1
14	2020-01-03	0r0aboj74bmstnfmdb3mhbh61k	1	1
15	2020-01-04	0r0aboj74bmstnfmdb3mhbh61k	1	1
16	2020-01-05	0r0aboj74bmstnfmdb3mhbh61k	1	1
17	2020-01-06	0r0aboj74bmstnfmdb3mhbh61k	1	1
18	2020-01-11	55rf9hujhqhkjkqt20lkpdmvev	1	1
19	2020-01-12	44q69uo86q9ah1d9nlb019iqd7	1	1
20	2020-01-18	1655u8cee9i9mkh9v6ro593hrl	1	1
21	2020-01-19	42hmsii42jmhv2iv16uklok3sc	1	1
22	2020-01-25	44nqnhp5b6d6i3mcs7a1j7ieqc	1	1
23	2020-01-26	1kjq79a77nvduhqor22ebsri8g	1	1
24	2020-02-01	6j12rlj3ee1lok8kusfibudokj	1	1
25	2020-02-02	44h1cit7sqr41eg5seadcaed6g	1	1
26	2020-02-08	62gcfgl76neqtnrjpfhqi3csus	1	1
27	2020-02-09	1s7neuogl9tdebfac5smalk9ok	1	1
28	2020-02-14	53gbv46rl2e1h9m6bb5ohluino	1	1
29	2020-02-15	53gbv46rl2e1h9m6bb5ohluino	1	1
30	2020-02-16	53gbv46rl2e1h9m6bb5ohluino	1	1
31	2020-02-17	53gbv46rl2e1h9m6bb5ohluino	1	1
32	2020-02-18	53gbv46rl2e1h9m6bb5ohluino	1	1
33	2020-02-19	53gbv46rl2e1h9m6bb5ohluino	1	1
34	2020-02-20	53gbv46rl2e1h9m6bb5ohluino	1	1
35	2020-02-21	53gbv46rl2e1h9m6bb5ohluino	1	1
36	2020-02-22	53gbv46rl2e1h9m6bb5ohluino	1	1
37	2020-02-23	53gbv46rl2e1h9m6bb5ohluino	1	1
38	2020-01-10	4lf479cjko3teh7oe0av0chl9r	1	1
39	2020-01-17	2ib4i98h5i1galcskp0c2bggdk	1	1
40	2020-01-24	3o825fa8ctleju1dcn2f6or2b2	1	1
41	2020-01-31	2abdij8uohtdopuqv7fho1sro5	1	1
42	2020-02-28	3aa5ku2upuqfj6l0a9gia4osm8	1	1
43	2020-02-29	6k9o17c6tt664kpjiab0ldvtlk	1	1
44	2020-03-01	6d15ibcc4ea2kr4tan22cdl6kc	1	1
45	2020-03-06	4e27p9vc78tg3gh9olgp593sfq	1	1
46	2020-03-07	14pl675sqokqtec2krq3ap83b3	1	1
47	2020-03-08	4f257o4halhf3vril7majcqjm6	1	1
48	2020-03-14	7v0aj1gs1tv2kpvquac5lad00m	1	1
49	2020-03-15	2j3hgk6ug9hv6994k680jnnqe8	1	1
50	2020-03-20	35jllr840ngfghg4kcn9bcc3ev	1	1
51	2020-03-21	4647gafj24u30cbste4l7141ah	1	1
52	2020-03-22	3ss1mvlk62t747387asnr02cn4	1	1
53	2020-03-26	3a95gra1fpi1cabrmkbqge8h2k	1	1
54	2020-03-27	3a95gra1fpi1cabrmkbqge8h2k	1	1
55	2020-03-28	3a95gra1fpi1cabrmkbqge8h2k	1	1
56	2020-03-29	3a95gra1fpi1cabrmkbqge8h2k	1	1
57	2020-03-30	3a95gra1fpi1cabrmkbqge8h2k	1	1
58	2020-03-31	3a95gra1fpi1cabrmkbqge8h2k	1	1
59	2020-04-01	3a95gra1fpi1cabrmkbqge8h2k	1	1
60	2020-04-02	3a95gra1fpi1cabrmkbqge8h2k	1	1
61	2020-04-03	3a95gra1fpi1cabrmkbqge8h2k	1	1
62	2020-04-04	3a95gra1fpi1cabrmkbqge8h2k	1	1
63	2020-04-05	3a95gra1fpi1cabrmkbqge8h2k	1	1
64	2020-04-06	3a95gra1fpi1cabrmkbqge8h2k	1	1
65	2020-04-07	3a95gra1fpi1cabrmkbqge8h2k	1	1
66	2020-04-08	3a95gra1fpi1cabrmkbqge8h2k	1	1
67	2020-04-09	3a95gra1fpi1cabrmkbqge8h2k	1	1
68	2020-04-10	3a95gra1fpi1cabrmkbqge8h2k	1	1
69	2020-04-11	3a95gra1fpi1cabrmkbqge8h2k	1	1
70	2020-04-12	3a95gra1fpi1cabrmkbqge8h2k	1	1
71	2020-04-13	3a95gra1fpi1cabrmkbqge8h2k	1	1
72	2020-04-14	3a95gra1fpi1cabrmkbqge8h2k	1	1
73	2020-04-15	3a95gra1fpi1cabrmkbqge8h2k	1	1
74	2020-04-16	3a95gra1fpi1cabrmkbqge8h2k	1	1
75	2020-04-17	3a95gra1fpi1cabrmkbqge8h2k	1	1
76	2020-04-18	3a95gra1fpi1cabrmkbqge8h2k	1	1
77	2020-04-19	3a95gra1fpi1cabrmkbqge8h2k	1	1
78	2020-04-20	3a95gra1fpi1cabrmkbqge8h2k	1	1
79	2020-04-23	69nop2frcqc5usqomkuoaf55mm	1	1
80	2020-04-24	57hg54iq5oo0c02kdgal1jhupc	1	1
81	2020-04-25	4g4vvngnl7jcucs9r0ee3m8g21	1	1
82	2020-04-26	6ha3btc2oam6uobfqv2qqhp42o	1	1
83	2020-04-30	4frrdu8ptbf93jvluc8ginfs99	1	1
84	2020-05-01	3b7lp3l0fjmf6qp8km28v36e2f	1	1
85	2020-05-02	1formvk985bkkt8m248l8c8qd2	1	1
86	2020-05-03	18pma80ujdp9bodofn405p2t3t	1	1
87	2020-05-07	2b6rd5qshj8v1ci8h2h4r5bbg9	1	1
88	2020-05-08	162o16dk1kmhev2jqvu4dpbkbi	1	1
89	2020-05-09	0cp3kef4m8mjttdjt7pkgf4nul	1	1
90	2020-05-10	2f75qniessgsjubrt568cja47t	1	1
91	2020-05-14	2j0u4v4bmck3o5lftlnirffiou	1	1
92	2020-05-15	2ro6ogjj9pf0g9kmgsb1tf6mf9	1	1
93	2020-05-16	5coe14smvthqlqmrff9oph3tf2	1	1
94	2020-05-17	222635kpdjvkcn3ttlu24ddmi4	1	1
100	2020-07-17	31obulq5u6cbjv2smpdgoo8dol	1	1
101	2020-07-18	31obulq5u6cbjv2smpdgoo8dol	1	1
102	2020-07-19	31obulq5u6cbjv2smpdgoo8dol	1	1
151	2020-09-12	0i4msalm9umj6m6ihq5jkst0lh	1	1
152	2020-09-13	0i4msalm9umj6m6ihq5jkst0lh	1	1
178	2020-10-17	0128i95q8re7nmb3q1oilf8or9	1	1
179	2020-10-18	0128i95q8re7nmb3q1oilf8or9	1	1
183	2020-10-31	6pp6cnlklk7l9psjnprs21nrr5	1	1
184	2020-11-01	6pp6cnlklk7l9psjnprs21nrr5	1	1
185	2017-06-23	594u1gmtt52n06sivchh0jflp7	3	1
186	2017-06-24	594u1gmtt52n06sivchh0jflp7	3	1
187	2017-06-25	594u1gmtt52n06sivchh0jflp7	3	1
188	2020-05-21	35qcfnv7m2btfronhaim92hiad	1	1
189	2017-06-30	4hi04mr0akofoo9gaq4q4j6i0h	3	1
190	2017-07-01	4hi04mr0akofoo9gaq4q4j6i0h	3	1
191	2017-07-02	4hi04mr0akofoo9gaq4q4j6i0h	3	1
192	2017-07-14	0mdiij4q8hqgnsoeni2lo2oihn	3	1
193	2017-07-15	0mdiij4q8hqgnsoeni2lo2oihn	3	1
194	2017-07-16	0mdiij4q8hqgnsoeni2lo2oihn	3	1
195	2017-07-21	5goqahkbeaoal6hnl1obomurj7	3	1
196	2017-07-22	5goqahkbeaoal6hnl1obomurj7	3	1
197	2017-07-23	5goqahkbeaoal6hnl1obomurj7	3	1
198	2017-07-24	5goqahkbeaoal6hnl1obomurj7	3	1
199	2017-07-25	5goqahkbeaoal6hnl1obomurj7	3	1
200	2017-07-26	5goqahkbeaoal6hnl1obomurj7	3	1
201	2017-07-27	5goqahkbeaoal6hnl1obomurj7	3	1
202	2017-07-28	5goqahkbeaoal6hnl1obomurj7	3	1
203	2017-07-29	5goqahkbeaoal6hnl1obomurj7	3	1
204	2017-07-30	5goqahkbeaoal6hnl1obomurj7	3	1
205	2017-07-31	5goqahkbeaoal6hnl1obomurj7	3	1
206	2017-08-01	5goqahkbeaoal6hnl1obomurj7	3	1
207	2017-08-02	5goqahkbeaoal6hnl1obomurj7	3	1
208	2017-08-03	5goqahkbeaoal6hnl1obomurj7	3	1
209	2017-08-04	5goqahkbeaoal6hnl1obomurj7	3	1
210	2017-08-05	5goqahkbeaoal6hnl1obomurj7	3	1
211	2017-08-06	5goqahkbeaoal6hnl1obomurj7	3	1
212	2017-08-07	5goqahkbeaoal6hnl1obomurj7	3	1
213	2017-08-08	5goqahkbeaoal6hnl1obomurj7	3	1
214	2017-08-09	5goqahkbeaoal6hnl1obomurj7	3	1
215	2017-08-10	5goqahkbeaoal6hnl1obomurj7	3	1
216	2017-08-11	5goqahkbeaoal6hnl1obomurj7	3	1
217	2017-08-12	5goqahkbeaoal6hnl1obomurj7	3	1
218	2017-08-13	5goqahkbeaoal6hnl1obomurj7	3	1
219	2017-08-14	5goqahkbeaoal6hnl1obomurj7	3	1
220	2017-08-15	5goqahkbeaoal6hnl1obomurj7	3	1
221	2017-08-16	5goqahkbeaoal6hnl1obomurj7	3	1
222	2017-08-17	5goqahkbeaoal6hnl1obomurj7	3	1
223	2017-08-18	5goqahkbeaoal6hnl1obomurj7	3	1
224	2017-08-19	5goqahkbeaoal6hnl1obomurj7	3	1
225	2017-08-20	5goqahkbeaoal6hnl1obomurj7	3	1
226	2017-08-21	5goqahkbeaoal6hnl1obomurj7	3	1
227	2017-08-22	5goqahkbeaoal6hnl1obomurj7	3	1
228	2017-08-23	5goqahkbeaoal6hnl1obomurj7	3	1
229	2017-08-24	5goqahkbeaoal6hnl1obomurj7	3	1
230	2017-08-25	5goqahkbeaoal6hnl1obomurj7	3	1
231	2017-08-26	5goqahkbeaoal6hnl1obomurj7	3	1
232	2017-08-27	5goqahkbeaoal6hnl1obomurj7	3	1
233	2017-08-28	5goqahkbeaoal6hnl1obomurj7	3	1
234	2017-08-29	5goqahkbeaoal6hnl1obomurj7	3	1
235	2017-08-30	5goqahkbeaoal6hnl1obomurj7	3	1
236	2017-08-31	5goqahkbeaoal6hnl1obomurj7	3	1
237	2017-09-01	5goqahkbeaoal6hnl1obomurj7	3	1
238	2017-09-02	5goqahkbeaoal6hnl1obomurj7	3	1
239	2017-09-03	5goqahkbeaoal6hnl1obomurj7	3	1
240	2017-09-04	5goqahkbeaoal6hnl1obomurj7	3	1
241	2017-09-15	2iuo5nffeodtpodpv3aqtvr204	3	1
242	2017-09-16	2iuo5nffeodtpodpv3aqtvr204	3	1
243	2017-09-17	2iuo5nffeodtpodpv3aqtvr204	3	1
244	2017-09-18	2iuo5nffeodtpodpv3aqtvr204	3	1
245	2017-09-19	2iuo5nffeodtpodpv3aqtvr204	3	1
246	2017-09-20	2iuo5nffeodtpodpv3aqtvr204	3	1
247	2017-09-21	2iuo5nffeodtpodpv3aqtvr204	3	1
248	2017-09-22	2iuo5nffeodtpodpv3aqtvr204	3	1
249	2017-09-23	2iuo5nffeodtpodpv3aqtvr204	3	1
250	2017-09-24	2iuo5nffeodtpodpv3aqtvr204	3	1
251	2017-09-25	2iuo5nffeodtpodpv3aqtvr204	3	1
252	2017-09-26	2iuo5nffeodtpodpv3aqtvr204	3	1
253	2017-09-27	2iuo5nffeodtpodpv3aqtvr204	3	1
254	2017-09-28	2iuo5nffeodtpodpv3aqtvr204	3	1
255	2017-09-29	2iuo5nffeodtpodpv3aqtvr204	3	1
256	2017-09-30	2iuo5nffeodtpodpv3aqtvr204	3	1
257	2017-10-01	2iuo5nffeodtpodpv3aqtvr204	3	1
258	2017-10-02	2iuo5nffeodtpodpv3aqtvr204	3	1
259	2017-10-03	2iuo5nffeodtpodpv3aqtvr204	3	1
260	2017-10-04	2iuo5nffeodtpodpv3aqtvr204	3	1
261	2017-10-05	2iuo5nffeodtpodpv3aqtvr204	3	1
262	2017-10-06	2iuo5nffeodtpodpv3aqtvr204	3	1
263	2017-10-07	2iuo5nffeodtpodpv3aqtvr204	3	1
264	2017-10-08	2iuo5nffeodtpodpv3aqtvr204	3	1
265	2020-05-22	7s6t7c2mllvd43ktd65fgf3988	1	1
266	2017-10-13	2g49bcoe3vasagq2slot9g1k3g	3	1
267	2017-10-14	2g49bcoe3vasagq2slot9g1k3g	3	1
268	2017-10-15	2g49bcoe3vasagq2slot9g1k3g	3	1
269	2017-10-21	4il7mj3k7i2rib50sjsvimp5se	3	1
270	2017-10-22	4il7mj3k7i2rib50sjsvimp5se	3	1
271	2017-10-27	21cbknc1d1qblcsnr3u9m1ara3	3	1
272	2017-10-28	21cbknc1d1qblcsnr3u9m1ara3	3	1
273	2017-10-29	21cbknc1d1qblcsnr3u9m1ara3	3	1
274	2017-11-04	4226lbnrqbkaa66uof248ufiap	3	1
275	2017-11-05	4226lbnrqbkaa66uof248ufiap	3	1
276	2017-11-08	5g4b2qh69jsoj4pdnvjpqpao82	3	1
277	2017-11-09	5g4b2qh69jsoj4pdnvjpqpao82	3	1
278	2017-11-10	5g4b2qh69jsoj4pdnvjpqpao82	3	1
279	2017-11-11	5g4b2qh69jsoj4pdnvjpqpao82	3	1
280	2017-11-12	5g4b2qh69jsoj4pdnvjpqpao82	3	1
281	2017-11-17	1b8c2kbg8qoqdvr47e1bopm327	3	1
282	2017-11-18	1b8c2kbg8qoqdvr47e1bopm327	3	1
283	2017-11-19	1b8c2kbg8qoqdvr47e1bopm327	3	1
284	2017-11-24	4np47lgieilr60ag2hfj2smi98	3	1
285	2017-11-25	4np47lgieilr60ag2hfj2smi98	3	1
286	2017-11-26	4np47lgieilr60ag2hfj2smi98	3	1
287	2017-12-02	3f4hoa9r48r2jqs95chudjgssj	3	1
288	2017-12-03	3f4hoa9r48r2jqs95chudjgssj	3	1
289	2020-05-23	7c1pk29n7tbbrkpmplcq57dk86	1	1
290	2017-12-08	4s2khl13cr8l4hnbl4pd5iktkf	3	1
291	2017-12-09	4s2khl13cr8l4hnbl4pd5iktkf	3	1
292	2017-12-10	4s2khl13cr8l4hnbl4pd5iktkf	3	1
293	2017-12-15	76mlnb2t0krfmflb6j2t6uuu7u	3	1
294	2017-12-16	76mlnb2t0krfmflb6j2t6uuu7u	3	1
295	2017-12-17	76mlnb2t0krfmflb6j2t6uuu7u	3	1
296	2017-12-22	27rfckmaa8s616dvfgbmdabu5l	3	1
297	2017-12-23	27rfckmaa8s616dvfgbmdabu5l	3	1
298	2017-12-24	27rfckmaa8s616dvfgbmdabu5l	3	1
299	2017-12-25	27rfckmaa8s616dvfgbmdabu5l	3	1
300	2017-12-26	27rfckmaa8s616dvfgbmdabu5l	3	1
301	2017-12-27	27rfckmaa8s616dvfgbmdabu5l	3	1
302	2017-12-28	27rfckmaa8s616dvfgbmdabu5l	3	1
303	2017-12-29	27rfckmaa8s616dvfgbmdabu5l	3	1
304	2017-12-30	27rfckmaa8s616dvfgbmdabu5l	3	1
305	2017-12-31	27rfckmaa8s616dvfgbmdabu5l	3	1
306	2018-01-01	27rfckmaa8s616dvfgbmdabu5l	3	1
307	2018-01-02	27rfckmaa8s616dvfgbmdabu5l	3	1
308	2018-01-03	27rfckmaa8s616dvfgbmdabu5l	3	1
309	2018-01-04	27rfckmaa8s616dvfgbmdabu5l	3	1
310	2018-01-05	27rfckmaa8s616dvfgbmdabu5l	3	1
311	2018-01-06	27rfckmaa8s616dvfgbmdabu5l	3	1
312	2018-01-07	27rfckmaa8s616dvfgbmdabu5l	3	1
313	2018-01-12	3b34utige8n1u45tj9fj08cfal	3	1
314	2018-01-13	3b34utige8n1u45tj9fj08cfal	3	1
315	2018-01-14	3b34utige8n1u45tj9fj08cfal	3	1
316	2018-01-20	1g1l3vdo8ba7kvjksikula3kih	3	1
317	2018-01-21	1g1l3vdo8ba7kvjksikula3kih	3	1
318	2018-01-26	5r60o0m07ii0hrebhit63ubd1d	3	1
319	2018-01-27	5r60o0m07ii0hrebhit63ubd1d	3	1
320	2018-01-28	5r60o0m07ii0hrebhit63ubd1d	3	1
321	2018-02-03	36m1hh7qkff0iadanhospju5ir	3	1
322	2018-02-04	36m1hh7qkff0iadanhospju5ir	3	1
323	2018-02-09	4qf7o85jljq586ml9enfn88cbl	3	1
324	2018-02-10	4qf7o85jljq586ml9enfn88cbl	3	1
325	2018-02-11	4qf7o85jljq586ml9enfn88cbl	3	1
326	2018-02-12	4qf7o85jljq586ml9enfn88cbl	3	1
327	2018-02-13	4qf7o85jljq586ml9enfn88cbl	3	1
328	2018-02-14	4qf7o85jljq586ml9enfn88cbl	3	1
329	2018-02-15	4qf7o85jljq586ml9enfn88cbl	3	1
330	2018-02-16	4qf7o85jljq586ml9enfn88cbl	3	1
331	2018-02-17	4qf7o85jljq586ml9enfn88cbl	3	1
332	2018-02-18	4qf7o85jljq586ml9enfn88cbl	3	1
333	2018-02-19	4qf7o85jljq586ml9enfn88cbl	3	1
334	2018-02-24	14ikmltphk796p7lrjln7l399a	3	1
335	2018-02-25	14ikmltphk796p7lrjln7l399a	3	1
336	2018-03-02	435t90npfg2ck2fei08p3bfm9o	3	1
337	2018-03-03	435t90npfg2ck2fei08p3bfm9o	3	1
338	2018-03-04	435t90npfg2ck2fei08p3bfm9o	3	1
339	2018-03-09	4i81kn07i15lau4blnqhtkmehs	3	1
340	2018-03-10	4i81kn07i15lau4blnqhtkmehs	3	1
341	2018-03-11	4i81kn07i15lau4blnqhtkmehs	3	1
342	2018-03-17	1vmfda8co76c5oakjmrd8mq8hn	3	1
343	2018-03-18	1vmfda8co76c5oakjmrd8mq8hn	3	1
344	2018-03-23	7kr21tb09d5i766sb8h0kr0k9s	3	1
345	2018-03-24	7kr21tb09d5i766sb8h0kr0k9s	3	1
346	2018-03-25	7kr21tb09d5i766sb8h0kr0k9s	3	1
347	2018-03-30	321rf0o7ne5ott78ee5ocqgtn3	3	1
348	2018-03-31	321rf0o7ne5ott78ee5ocqgtn3	3	1
349	2018-04-01	321rf0o7ne5ott78ee5ocqgtn3	3	1
350	2018-04-02	321rf0o7ne5ott78ee5ocqgtn3	3	1
351	2018-04-03	321rf0o7ne5ott78ee5ocqgtn3	3	1
352	2018-04-04	321rf0o7ne5ott78ee5ocqgtn3	3	1
353	2018-04-05	321rf0o7ne5ott78ee5ocqgtn3	3	1
354	2018-04-06	321rf0o7ne5ott78ee5ocqgtn3	3	1
355	2018-04-07	321rf0o7ne5ott78ee5ocqgtn3	3	1
356	2018-04-08	321rf0o7ne5ott78ee5ocqgtn3	3	1
357	2018-04-09	321rf0o7ne5ott78ee5ocqgtn3	3	1
358	2018-04-10	321rf0o7ne5ott78ee5ocqgtn3	3	1
359	2018-04-11	321rf0o7ne5ott78ee5ocqgtn3	3	1
360	2018-04-12	321rf0o7ne5ott78ee5ocqgtn3	3	1
361	2018-04-13	321rf0o7ne5ott78ee5ocqgtn3	3	1
362	2018-04-14	321rf0o7ne5ott78ee5ocqgtn3	3	1
363	2018-04-15	321rf0o7ne5ott78ee5ocqgtn3	3	1
364	2018-04-20	5ru4cfce0kjvee9rvf11jhsgh6	3	1
365	2018-04-21	5ru4cfce0kjvee9rvf11jhsgh6	3	1
366	2018-04-22	5ru4cfce0kjvee9rvf11jhsgh6	3	1
367	2018-04-28	2nhg1ntf2g7b13lebho66v1g5a	3	1
368	2018-04-29	2nhg1ntf2g7b13lebho66v1g5a	3	1
369	2018-05-04	0cfki8qmr6de5278kakv39p7sm	3	1
370	2018-05-05	0cfki8qmr6de5278kakv39p7sm	3	1
371	2018-05-06	0cfki8qmr6de5278kakv39p7sm	3	1
372	2018-05-07	0cfki8qmr6de5278kakv39p7sm	3	1
373	2018-05-12	2jgshelr0isb7iu16ubck6mbig	3	1
374	2018-05-13	2jgshelr0isb7iu16ubck6mbig	3	1
375	2018-05-18	07i07ri2bqu84petm8vaf3lie4	3	1
376	2018-05-19	07i07ri2bqu84petm8vaf3lie4	3	1
377	2018-05-20	07i07ri2bqu84petm8vaf3lie4	3	1
378	2018-05-25	7nu7akgo01raifmj9codhk7jqt	3	1
379	2018-05-26	7nu7akgo01raifmj9codhk7jqt	3	1
380	2018-05-27	7nu7akgo01raifmj9codhk7jqt	3	1
381	2018-05-28	7nu7akgo01raifmj9codhk7jqt	3	1
382	2018-05-29	7nu7akgo01raifmj9codhk7jqt	3	1
383	2018-05-30	7nu7akgo01raifmj9codhk7jqt	3	1
384	2018-05-31	7nu7akgo01raifmj9codhk7jqt	3	1
385	2018-06-01	7nu7akgo01raifmj9codhk7jqt	3	1
386	2018-06-02	7nu7akgo01raifmj9codhk7jqt	3	1
387	2018-06-03	7nu7akgo01raifmj9codhk7jqt	3	1
388	2018-06-08	7kodlqcagfmvgrdqornt3qcoeq	3	1
389	2018-06-09	7kodlqcagfmvgrdqornt3qcoeq	3	1
390	2018-06-10	7kodlqcagfmvgrdqornt3qcoeq	3	1
391	2018-06-16	1nn53orbd96nvecr86uh8drgvn	3	1
392	2018-06-17	1nn53orbd96nvecr86uh8drgvn	3	1
393	2018-06-22	0it06hurcjlga0s8l9qbqct93r	3	1
394	2018-06-23	0it06hurcjlga0s8l9qbqct93r	3	1
395	2018-06-24	0it06hurcjlga0s8l9qbqct93r	3	1
396	2018-06-29	49q9tb15rnklmg7h3m73uoc79l	3	1
397	2018-06-30	49q9tb15rnklmg7h3m73uoc79l	3	1
398	2018-07-01	49q9tb15rnklmg7h3m73uoc79l	3	1
399	2018-07-07	5qrsnebk4tmuohsa4e0g2a634i	3	1
400	2018-07-08	5qrsnebk4tmuohsa4e0g2a634i	3	1
401	2018-07-13	71pb9bhub7ot07vu511s5hja0r	3	1
402	2018-07-14	71pb9bhub7ot07vu511s5hja0r	3	1
403	2018-07-15	71pb9bhub7ot07vu511s5hja0r	3	1
404	2018-07-20	1fj3t6dl3juc5hq5malld38fk7	3	1
405	2018-07-21	1fj3t6dl3juc5hq5malld38fk7	3	1
406	2018-07-22	1fj3t6dl3juc5hq5malld38fk7	3	1
407	2018-07-25	5200sadmddof9g3k54d3dm7nm0	3	1
408	2018-07-26	5200sadmddof9g3k54d3dm7nm0	3	1
409	2018-07-27	5200sadmddof9g3k54d3dm7nm0	3	1
410	2018-07-28	5200sadmddof9g3k54d3dm7nm0	3	1
411	2018-07-29	5200sadmddof9g3k54d3dm7nm0	3	1
412	2018-07-30	5200sadmddof9g3k54d3dm7nm0	3	1
413	2018-07-31	5200sadmddof9g3k54d3dm7nm0	3	1
414	2018-08-01	5200sadmddof9g3k54d3dm7nm0	3	1
415	2018-08-02	5200sadmddof9g3k54d3dm7nm0	3	1
416	2018-08-03	5200sadmddof9g3k54d3dm7nm0	3	1
417	2018-08-04	5200sadmddof9g3k54d3dm7nm0	3	1
418	2018-08-05	5200sadmddof9g3k54d3dm7nm0	3	1
419	2018-08-06	5200sadmddof9g3k54d3dm7nm0	3	1
420	2018-08-07	5200sadmddof9g3k54d3dm7nm0	3	1
421	2018-08-08	5200sadmddof9g3k54d3dm7nm0	3	1
422	2018-08-09	5200sadmddof9g3k54d3dm7nm0	3	1
423	2018-08-10	5200sadmddof9g3k54d3dm7nm0	3	1
424	2018-08-11	5200sadmddof9g3k54d3dm7nm0	3	1
425	2018-08-12	5200sadmddof9g3k54d3dm7nm0	3	1
426	2018-08-13	5200sadmddof9g3k54d3dm7nm0	3	1
427	2018-08-14	5200sadmddof9g3k54d3dm7nm0	3	1
428	2018-08-15	5200sadmddof9g3k54d3dm7nm0	3	1
429	2018-08-16	5200sadmddof9g3k54d3dm7nm0	3	1
430	2018-08-17	5200sadmddof9g3k54d3dm7nm0	3	1
431	2018-08-18	5200sadmddof9g3k54d3dm7nm0	3	1
432	2018-08-19	5200sadmddof9g3k54d3dm7nm0	3	1
433	2018-08-20	5200sadmddof9g3k54d3dm7nm0	3	1
434	2018-08-21	5200sadmddof9g3k54d3dm7nm0	3	1
435	2018-08-22	5200sadmddof9g3k54d3dm7nm0	3	1
436	2018-08-23	5200sadmddof9g3k54d3dm7nm0	3	1
437	2018-08-24	5200sadmddof9g3k54d3dm7nm0	3	1
438	2018-08-25	5200sadmddof9g3k54d3dm7nm0	3	1
439	2018-08-26	5200sadmddof9g3k54d3dm7nm0	3	1
440	2018-08-27	5200sadmddof9g3k54d3dm7nm0	3	1
441	2018-08-28	5200sadmddof9g3k54d3dm7nm0	3	1
442	2018-08-29	5200sadmddof9g3k54d3dm7nm0	3	1
443	2018-08-30	5200sadmddof9g3k54d3dm7nm0	3	1
444	2018-08-31	5200sadmddof9g3k54d3dm7nm0	3	1
445	2018-09-01	5200sadmddof9g3k54d3dm7nm0	3	1
446	2018-09-02	5200sadmddof9g3k54d3dm7nm0	3	1
447	2018-09-03	5200sadmddof9g3k54d3dm7nm0	3	1
448	2018-09-07	1i4e3q3ukksfll37r5bnm4qv5t	3	1
449	2018-09-08	1i4e3q3ukksfll37r5bnm4qv5t	3	1
450	2018-09-09	1i4e3q3ukksfll37r5bnm4qv5t	3	1
451	2018-09-14	6q29bqhudh6hqf10esatbchej4	3	1
452	2018-09-15	6q29bqhudh6hqf10esatbchej4	3	1
453	2018-09-16	6q29bqhudh6hqf10esatbchej4	3	1
454	2018-09-17	6q29bqhudh6hqf10esatbchej4	3	1
455	2018-09-18	6q29bqhudh6hqf10esatbchej4	3	1
456	2018-09-19	6q29bqhudh6hqf10esatbchej4	3	1
457	2018-09-20	6q29bqhudh6hqf10esatbchej4	3	1
458	2018-09-21	6q29bqhudh6hqf10esatbchej4	3	1
459	2018-09-22	6q29bqhudh6hqf10esatbchej4	3	1
460	2018-09-23	6q29bqhudh6hqf10esatbchej4	3	1
461	2018-09-24	6q29bqhudh6hqf10esatbchej4	3	1
462	2018-09-25	6q29bqhudh6hqf10esatbchej4	3	1
463	2018-09-26	6q29bqhudh6hqf10esatbchej4	3	1
464	2018-09-27	6q29bqhudh6hqf10esatbchej4	3	1
465	2018-09-28	6q29bqhudh6hqf10esatbchej4	3	1
466	2018-09-29	6q29bqhudh6hqf10esatbchej4	3	1
467	2018-09-30	6q29bqhudh6hqf10esatbchej4	3	1
468	2018-10-01	6q29bqhudh6hqf10esatbchej4	3	1
469	2018-10-02	6q29bqhudh6hqf10esatbchej4	3	1
470	2018-10-03	6q29bqhudh6hqf10esatbchej4	3	1
471	2018-10-04	6q29bqhudh6hqf10esatbchej4	3	1
472	2018-10-05	6q29bqhudh6hqf10esatbchej4	3	1
473	2018-10-06	6q29bqhudh6hqf10esatbchej4	3	1
474	2018-10-07	6q29bqhudh6hqf10esatbchej4	3	1
475	2018-10-08	6q29bqhudh6hqf10esatbchej4	3	1
476	2018-10-12	3u9itrfughpolq32v37hsl2uuq	3	1
477	2018-10-13	3u9itrfughpolq32v37hsl2uuq	3	1
478	2018-10-14	3u9itrfughpolq32v37hsl2uuq	3	1
479	2018-10-19	49lhh1okovbveedobcpv3oksle	3	1
480	2018-10-20	49lhh1okovbveedobcpv3oksle	3	1
481	2018-10-21	49lhh1okovbveedobcpv3oksle	3	1
482	2018-10-27	16ukg2oc24e131sflv8dm4lht2	3	1
483	2018-10-28	16ukg2oc24e131sflv8dm4lht2	3	1
484	2018-11-02	5j1t8a04lvpnhao9kgljm6rlie	3	1
485	2018-11-03	5j1t8a04lvpnhao9kgljm6rlie	3	1
486	2018-11-04	5j1t8a04lvpnhao9kgljm6rlie	3	1
487	2018-11-07	2gdhs181msh7co1a7kq6ta4v2q	3	1
488	2018-11-08	2gdhs181msh7co1a7kq6ta4v2q	3	1
489	2018-11-09	2gdhs181msh7co1a7kq6ta4v2q	3	1
490	2018-11-10	2gdhs181msh7co1a7kq6ta4v2q	3	1
491	2018-11-11	2gdhs181msh7co1a7kq6ta4v2q	3	1
492	2018-11-16	727fi436gemnev3ftumdmarm5q	3	1
493	2018-11-17	727fi436gemnev3ftumdmarm5q	3	1
494	2018-11-18	727fi436gemnev3ftumdmarm5q	3	1
495	2018-11-24	0nrcrvr6g9n51qcl1frv02vgnm	3	1
496	2018-11-25	0nrcrvr6g9n51qcl1frv02vgnm	3	1
497	2018-11-30	7u88j5k78eln2js8d3q033rqp2	3	1
498	2018-12-01	7u88j5k78eln2js8d3q033rqp2	3	1
499	2018-12-02	7u88j5k78eln2js8d3q033rqp2	3	1
500	2018-12-07	71dm3su61lv3jm4lcd2ob4hdtm	3	1
501	2018-12-08	71dm3su61lv3jm4lcd2ob4hdtm	3	1
502	2018-12-09	71dm3su61lv3jm4lcd2ob4hdtm	3	1
503	2018-12-21	7qc22letmk1il54fosgkublcqq	3	1
504	2018-12-22	7qc22letmk1il54fosgkublcqq	3	1
505	2018-12-23	7qc22letmk1il54fosgkublcqq	3	1
506	2018-12-24	7qc22letmk1il54fosgkublcqq	3	1
507	2018-12-25	7qc22letmk1il54fosgkublcqq	3	1
508	2018-12-26	7qc22letmk1il54fosgkublcqq	3	1
509	2018-12-27	7qc22letmk1il54fosgkublcqq	3	1
510	2018-12-28	7qc22letmk1il54fosgkublcqq	3	1
511	2018-12-29	7qc22letmk1il54fosgkublcqq	3	1
512	2018-12-30	7qc22letmk1il54fosgkublcqq	3	1
513	2018-12-31	7qc22letmk1il54fosgkublcqq	3	1
514	2019-01-01	7qc22letmk1il54fosgkublcqq	3	1
515	2019-01-02	7qc22letmk1il54fosgkublcqq	3	1
516	2019-01-03	7qc22letmk1il54fosgkublcqq	3	1
517	2019-01-04	7qc22letmk1il54fosgkublcqq	3	1
518	2019-01-05	7qc22letmk1il54fosgkublcqq	3	1
519	2019-01-06	7qc22letmk1il54fosgkublcqq	3	1
520	2020-05-24	375vcjemgfpnpc9dv4e87eld3q	1	1
521	2020-05-25	5b3827r7olul429875espmj5e8	1	1
522	2020-05-26	6ltompbepvtsnhpg7k3lif3rb7	1	1
523	2020-05-27	5n4491s5rpuds7cleg817b49gf	1	1
524	2020-05-28	410e2pnacpad3i3egr3c3dkgm0	1	1
525	2020-05-29	31gv09c2purfgbka322co0ik98	1	1
526	2019-01-12	59u0r5u3ai1hd8bekso5ufl20c	3	1
527	2019-01-13	59u0r5u3ai1hd8bekso5ufl20c	3	1
528	2019-01-18	5j2koe96216t27pjtatmjelii4	3	1
529	2019-01-19	5j2koe96216t27pjtatmjelii4	3	1
530	2019-01-20	5j2koe96216t27pjtatmjelii4	3	1
531	2019-01-25	2r9a387ra9fhd7o8vi9c7pr6qv	3	1
532	2019-01-26	2r9a387ra9fhd7o8vi9c7pr6qv	3	1
533	2019-01-27	2r9a387ra9fhd7o8vi9c7pr6qv	3	1
534	2019-02-01	60jtoe81ai5hp9263kv5i3esha	3	1
535	2019-02-02	60jtoe81ai5hp9263kv5i3esha	3	1
536	2019-02-03	60jtoe81ai5hp9263kv5i3esha	3	1
537	2019-02-09	1s1ojd8qknqm8eitnkl2oq31uf	3	1
538	2019-02-10	1s1ojd8qknqm8eitnkl2oq31uf	3	1
539	2019-02-15	6a391ot564vuiopi4afj5v8ves	3	1
540	2019-02-16	6a391ot564vuiopi4afj5v8ves	3	1
541	2019-02-17	6a391ot564vuiopi4afj5v8ves	3	1
542	2019-02-22	0micl12rousvjnso6p0ki12p35	3	1
543	2019-02-23	0micl12rousvjnso6p0ki12p35	3	1
544	2019-02-24	0micl12rousvjnso6p0ki12p35	3	1
545	2019-03-01	53blvj7pkvuhlcqt2gfae8f6dn	3	1
546	2019-03-02	53blvj7pkvuhlcqt2gfae8f6dn	3	1
547	2019-03-03	53blvj7pkvuhlcqt2gfae8f6dn	3	1
548	2019-03-08	3k7hd5d8t0ngeegnolv5jnpobe	3	1
549	2019-03-09	3k7hd5d8t0ngeegnolv5jnpobe	3	1
550	2019-03-10	3k7hd5d8t0ngeegnolv5jnpobe	3	1
551	2019-03-16	7b9fuuoc7v1a6jqqbgu0a05cch	3	1
552	2019-03-17	7b9fuuoc7v1a6jqqbgu0a05cch	3	1
553	2019-03-23	6ta6k93eo6ftaf1t3g7q0uqsti	3	1
554	2019-03-24	6ta6k93eo6ftaf1t3g7q0uqsti	3	1
555	2019-03-30	7rhatkiod9k1omge9mcbg3fr84	3	1
556	2019-03-31	7rhatkiod9k1omge9mcbg3fr84	3	1
557	2019-04-05	4s7ja1eovoiefk5lalkh68merl	3	1
558	2019-04-06	4s7ja1eovoiefk5lalkh68merl	3	1
559	2019-04-07	4s7ja1eovoiefk5lalkh68merl	3	1
560	2019-04-12	16qou6vup5p8nftg7d8f020106	3	1
561	2019-04-13	16qou6vup5p8nftg7d8f020106	3	1
562	2019-04-14	16qou6vup5p8nftg7d8f020106	3	1
563	2019-04-15	16qou6vup5p8nftg7d8f020106	3	1
564	2019-04-16	16qou6vup5p8nftg7d8f020106	3	1
565	2019-04-17	16qou6vup5p8nftg7d8f020106	3	1
566	2019-04-18	16qou6vup5p8nftg7d8f020106	3	1
567	2019-04-19	16qou6vup5p8nftg7d8f020106	3	1
568	2019-04-20	16qou6vup5p8nftg7d8f020106	3	1
569	2019-04-21	16qou6vup5p8nftg7d8f020106	3	1
570	2019-04-22	16qou6vup5p8nftg7d8f020106	3	1
571	2019-04-26	7tsh27fo6v9k488vk5iq7goueh	3	1
572	2019-04-27	7tsh27fo6v9k488vk5iq7goueh	3	1
573	2019-04-28	7tsh27fo6v9k488vk5iq7goueh	3	1
574	2019-05-03	75t8c9j3nqj8vs6hqn9u4vn11h	3	1
575	2019-05-04	75t8c9j3nqj8vs6hqn9u4vn11h	3	1
576	2019-05-05	75t8c9j3nqj8vs6hqn9u4vn11h	3	1
577	2019-05-06	75t8c9j3nqj8vs6hqn9u4vn11h	3	1
578	2019-05-10	26j0hvtnj9rrdu6npc7ta0023t	3	1
579	2019-05-11	26j0hvtnj9rrdu6npc7ta0023t	3	1
580	2019-05-12	26j0hvtnj9rrdu6npc7ta0023t	3	1
581	2019-05-17	1ua8o9vpfdnm6bgbu0jv75hovk	3	1
582	2019-05-18	1ua8o9vpfdnm6bgbu0jv75hovk	3	1
583	2019-05-19	1ua8o9vpfdnm6bgbu0jv75hovk	3	1
584	2019-05-24	0qlojr19s334v64f6c1epm1ohv	3	1
585	2019-05-25	0qlojr19s334v64f6c1epm1ohv	3	1
586	2019-05-26	0qlojr19s334v64f6c1epm1ohv	3	1
587	2019-05-27	0qlojr19s334v64f6c1epm1ohv	3	1
588	2019-05-28	0qlojr19s334v64f6c1epm1ohv	3	1
589	2019-05-29	0qlojr19s334v64f6c1epm1ohv	3	1
590	2019-05-30	0qlojr19s334v64f6c1epm1ohv	3	1
591	2019-05-31	0qlojr19s334v64f6c1epm1ohv	3	1
592	2019-06-01	0qlojr19s334v64f6c1epm1ohv	3	1
593	2019-06-02	0qlojr19s334v64f6c1epm1ohv	3	1
594	2019-06-03	0qlojr19s334v64f6c1epm1ohv	3	1
595	2020-05-30	4ejhtdakmmvipd9h1dl8sk130o	1	1
596	2019-06-07	5cs2h5ri5638c3ujcsf4ukh5rc	3	1
597	2019-06-08	5cs2h5ri5638c3ujcsf4ukh5rc	3	1
598	2019-06-09	5cs2h5ri5638c3ujcsf4ukh5rc	3	1
599	2019-06-14	3ddlm7k5q184id3ksfd0sa33si	3	1
600	2019-06-15	3ddlm7k5q184id3ksfd0sa33si	3	1
601	2019-06-16	3ddlm7k5q184id3ksfd0sa33si	3	1
602	2019-06-21	4a7kofclvto7dd8v3npj75rp62	3	1
603	2019-06-22	4a7kofclvto7dd8v3npj75rp62	3	1
604	2019-06-23	4a7kofclvto7dd8v3npj75rp62	3	1
605	2019-06-28	4brefvrf5cbcs3up19bu1k69sf	3	1
606	2019-06-29	4brefvrf5cbcs3up19bu1k69sf	3	1
607	2019-06-30	4brefvrf5cbcs3up19bu1k69sf	3	1
608	2019-07-05	7159d7oop403emqfdlt1ksskpl	3	1
609	2019-07-06	7159d7oop403emqfdlt1ksskpl	3	1
610	2019-07-07	7159d7oop403emqfdlt1ksskpl	3	1
611	2019-07-12	5i9aa8itiqesa8c9mkirmq64vm	3	1
612	2019-07-13	5i9aa8itiqesa8c9mkirmq64vm	3	1
613	2019-07-14	5i9aa8itiqesa8c9mkirmq64vm	3	1
614	2019-07-19	2pshoepnq5nhrlc24bq1m597mu	3	1
615	2019-07-20	2pshoepnq5nhrlc24bq1m597mu	3	1
616	2019-07-21	2pshoepnq5nhrlc24bq1m597mu	3	1
617	2019-07-26	0uc9eqef977tim14c8njc1oc5b	3	1
618	2019-07-27	0uc9eqef977tim14c8njc1oc5b	3	1
619	2019-07-28	0uc9eqef977tim14c8njc1oc5b	3	1
620	2019-07-29	0uc9eqef977tim14c8njc1oc5b	3	1
621	2019-07-30	0uc9eqef977tim14c8njc1oc5b	3	1
622	2019-07-31	0uc9eqef977tim14c8njc1oc5b	3	1
623	2019-08-01	0uc9eqef977tim14c8njc1oc5b	3	1
624	2019-08-02	0uc9eqef977tim14c8njc1oc5b	3	1
625	2019-08-03	0uc9eqef977tim14c8njc1oc5b	3	1
626	2019-08-04	0uc9eqef977tim14c8njc1oc5b	3	1
627	2019-08-05	0uc9eqef977tim14c8njc1oc5b	3	1
628	2019-08-06	0uc9eqef977tim14c8njc1oc5b	3	1
629	2019-08-07	0uc9eqef977tim14c8njc1oc5b	3	1
630	2019-08-08	0uc9eqef977tim14c8njc1oc5b	3	1
631	2019-08-09	0uc9eqef977tim14c8njc1oc5b	3	1
632	2019-08-10	0uc9eqef977tim14c8njc1oc5b	3	1
633	2019-08-11	0uc9eqef977tim14c8njc1oc5b	3	1
634	2019-08-12	0uc9eqef977tim14c8njc1oc5b	3	1
635	2019-08-13	0uc9eqef977tim14c8njc1oc5b	3	1
636	2019-08-14	0uc9eqef977tim14c8njc1oc5b	3	1
637	2019-08-15	0uc9eqef977tim14c8njc1oc5b	3	1
638	2019-08-16	0uc9eqef977tim14c8njc1oc5b	3	1
639	2019-08-17	0uc9eqef977tim14c8njc1oc5b	3	1
640	2019-08-18	0uc9eqef977tim14c8njc1oc5b	3	1
641	2019-08-19	0uc9eqef977tim14c8njc1oc5b	3	1
642	2019-08-20	0uc9eqef977tim14c8njc1oc5b	3	1
643	2019-08-21	0uc9eqef977tim14c8njc1oc5b	3	1
644	2019-08-22	0uc9eqef977tim14c8njc1oc5b	3	1
645	2019-08-23	0uc9eqef977tim14c8njc1oc5b	3	1
646	2019-08-24	0uc9eqef977tim14c8njc1oc5b	3	1
647	2019-08-25	0uc9eqef977tim14c8njc1oc5b	3	1
648	2019-08-26	0uc9eqef977tim14c8njc1oc5b	3	1
649	2019-08-27	0uc9eqef977tim14c8njc1oc5b	3	1
650	2019-08-28	0uc9eqef977tim14c8njc1oc5b	3	1
651	2019-08-29	0uc9eqef977tim14c8njc1oc5b	3	1
652	2019-08-30	0uc9eqef977tim14c8njc1oc5b	3	1
653	2019-08-31	0uc9eqef977tim14c8njc1oc5b	3	1
654	2019-09-01	0uc9eqef977tim14c8njc1oc5b	3	1
655	2019-09-02	0uc9eqef977tim14c8njc1oc5b	3	1
656	2019-09-06	3qlk8itj4cn2pjb52ahrree535	3	1
657	2019-09-07	3qlk8itj4cn2pjb52ahrree535	3	1
658	2019-09-08	3qlk8itj4cn2pjb52ahrree535	3	1
659	2019-09-10	06c4rieegdsc64gok02fe1qpi4	3	1
660	2019-09-11	06c4rieegdsc64gok02fe1qpi4	3	1
661	2019-09-12	06c4rieegdsc64gok02fe1qpi4	3	1
662	2019-09-13	06c4rieegdsc64gok02fe1qpi4	3	1
663	2019-09-14	06c4rieegdsc64gok02fe1qpi4	3	1
664	2019-09-15	06c4rieegdsc64gok02fe1qpi4	3	1
665	2019-09-16	06c4rieegdsc64gok02fe1qpi4	3	1
666	2019-09-17	06c4rieegdsc64gok02fe1qpi4	3	1
667	2019-09-18	06c4rieegdsc64gok02fe1qpi4	3	1
668	2019-09-19	06c4rieegdsc64gok02fe1qpi4	3	1
669	2019-09-20	06c4rieegdsc64gok02fe1qpi4	3	1
670	2019-09-21	06c4rieegdsc64gok02fe1qpi4	3	1
671	2019-09-22	06c4rieegdsc64gok02fe1qpi4	3	1
672	2019-09-23	06c4rieegdsc64gok02fe1qpi4	3	1
673	2019-09-24	06c4rieegdsc64gok02fe1qpi4	3	1
674	2019-09-27	0g7cf8l3jp1200vvrib6rh50s1	3	1
675	2019-09-28	0g7cf8l3jp1200vvrib6rh50s1	3	1
676	2019-09-29	0g7cf8l3jp1200vvrib6rh50s1	3	1
677	2019-10-04	59lfiagdd1lmh8n3oauva7s24p	3	1
678	2019-10-05	59lfiagdd1lmh8n3oauva7s24p	3	1
679	2019-10-06	59lfiagdd1lmh8n3oauva7s24p	3	1
680	2019-10-18	2lo39nddro60q25pbala8emh89	2	1
681	2019-10-20	0fmjunrkbetgh38hhpprnnu6rj	2	1
682	2019-10-25	2detg0a314g278t0k6q0u0hpp4	2	1
683	2019-10-26	2detg0a314g278t0k6q0u0hpp4	2	1
684	2019-10-27	2detg0a314g278t0k6q0u0hpp4	2	1
685	2019-11-01	0ad1ova576m56b7gea09t9u63p	2	1
686	2019-11-02	0ad1ova576m56b7gea09t9u63p	2	1
687	2019-11-03	0ad1ova576m56b7gea09t9u63p	2	1
688	2020-05-31	6c9lokrronqjpagvehf0knb3cv	1	1
689	2020-06-01	6p91vo01p93j4mfdjd011dc4af	1	1
690	2020-06-05	7et1j491et1j7da55qov7iue10	1	1
691	2020-06-06	7ato50p1d4nl99k8v1eb1gcnuv	1	1
692	2020-06-07	37ee292k1938s1jgo2c786v0fj	1	1
693	2020-06-12	1b85hqhom8r7ltb2677a0qhh78	1	1
694	2020-06-13	4ukdtdu74gnb9ihlvlud1p4uhe	1	1
695	2020-06-14	40ps8bu2i2ivollvc0s44nlh2d	1	1
696	2020-02-07	28i5q8co9j2fqgk3vu8h4aa4nj	1	1
698	2017-06-16	7blia4qtee20a6k7k9dpepnu75	3	1
699	2017-06-17	7blia4qtee20a6k7k9dpepnu75	3	1
700	2017-06-18	7blia4qtee20a6k7k9dpepnu75	3	1
701	2017-06-19	7blia4qtee20a6k7k9dpepnu75	3	1
702	2017-06-20	7blia4qtee20a6k7k9dpepnu75	3	1
703	2017-07-07	4d35nud98fg67c5qcbg6pr6upo	3	1
704	2017-07-08	4d35nud98fg67c5qcbg6pr6upo	3	1
705	2017-07-09	4d35nud98fg67c5qcbg6pr6upo	3	1
706	2017-09-08	1bk23os1f2dfa0v8kddua7cq0g	3	1
707	2017-09-09	1bk23os1f2dfa0v8kddua7cq0g	3	1
708	2017-09-10	1bk23os1f2dfa0v8kddua7cq0g	3	1
709	2020-06-19	08242r5u9um8982p4s8sumh2cm	1	1
710	2020-06-20	59dju9b6pl9qmt40kcip3qq37u	1	1
711	2020-06-21	59dju9b6pl9qmt40kcip3qq37u	1	1
712	2018-12-14	6cl2pgjqt07m66tu28m0e1lu4r	3	1
713	2018-12-15	45b0a7kcvmto3o5b34sakaa8o8	3	1
714	2018-12-16	45b0a7kcvmto3o5b34sakaa8o8	3	1
715	2020-06-26	6hdo8m503ehjrm25perimr96j2	1	1
716	2020-06-27	2458tt5ulavo73m09altg1sc3p	1	1
717	2020-06-28	2458tt5ulavo73m09altg1sc3p	1	1
720	2019-12-20	6f4ebllfcs4t9fcunq895dnpb8	1	2
721	2019-12-21	5cdvs4nhkg8mhu15jb1gltjel2	1	2
722	2019-12-22	5cdvs4nhkg8mhu15jb1gltjel2	1	2
723	2019-12-23	5cdvs4nhkg8mhu15jb1gltjel2	1	2
724	2019-12-24	5cdvs4nhkg8mhu15jb1gltjel2	1	2
725	2019-12-25	5cdvs4nhkg8mhu15jb1gltjel2	1	2
726	2019-12-26	5cdvs4nhkg8mhu15jb1gltjel2	1	2
727	2019-12-27	5cdvs4nhkg8mhu15jb1gltjel2	1	2
728	2019-12-28	5cdvs4nhkg8mhu15jb1gltjel2	1	2
729	2019-12-29	5cdvs4nhkg8mhu15jb1gltjel2	1	2
730	2019-12-30	5cdvs4nhkg8mhu15jb1gltjel2	1	2
731	2019-12-31	5cdvs4nhkg8mhu15jb1gltjel2	1	2
732	2020-01-01	5cdvs4nhkg8mhu15jb1gltjel2	1	2
733	2020-01-02	5cdvs4nhkg8mhu15jb1gltjel2	1	2
734	2020-01-03	5cdvs4nhkg8mhu15jb1gltjel2	1	2
735	2020-01-04	5cdvs4nhkg8mhu15jb1gltjel2	1	2
736	2020-01-05	5cdvs4nhkg8mhu15jb1gltjel2	1	2
737	2020-01-06	5cdvs4nhkg8mhu15jb1gltjel2	1	2
738	2020-01-11	46g1aulk7u1oduiltk0p1022eq	1	2
739	2020-01-12	5uueidok21vcictscttgmdoraj	1	2
740	2020-01-18	301le0qrm9chs2fhmp109k42r9	1	2
741	2020-01-19	6k2ano114i8cl9dcgkh9n14dkc	1	2
742	2020-01-25	1drovujs036ojhlr39uq4g5r7c	1	2
743	2020-01-26	3vslnvb09s35pl06mfeb70q9vf	1	2
744	2020-02-01	7m7tank714c9r95mvlocd2cn5o	1	2
745	2020-02-02	35b9vs5dipnpcodlkf11omb94e	1	2
746	2020-02-08	7mj0q2gtejq68p9e77q38m49hh	1	2
747	2020-02-09	43712sckpp89ufumcgq7gn441d	1	2
748	2020-02-14	0e1clf5igl32qpplla5a4fgkpt	1	2
749	2020-02-15	0e1clf5igl32qpplla5a4fgkpt	1	2
750	2020-02-16	0e1clf5igl32qpplla5a4fgkpt	1	2
751	2020-02-17	0e1clf5igl32qpplla5a4fgkpt	1	2
752	2020-02-18	0e1clf5igl32qpplla5a4fgkpt	1	2
753	2020-02-19	0e1clf5igl32qpplla5a4fgkpt	1	2
754	2020-02-20	0e1clf5igl32qpplla5a4fgkpt	1	2
755	2020-02-21	0e1clf5igl32qpplla5a4fgkpt	1	2
756	2020-02-22	0e1clf5igl32qpplla5a4fgkpt	1	2
757	2020-02-23	0e1clf5igl32qpplla5a4fgkpt	1	2
758	2020-01-10	3uiobun83t15vgfn7lpj2lpno3	1	2
759	2020-01-17	4l4me1e8pl01dot5q0isdncodj	1	2
760	2020-01-24	10tl3vhpoqp51pma5r8bj7vr7j	1	2
761	2020-01-31	7ll834s49g7trfbgdtv5spdhs6	1	2
762	2020-02-28	5p9bsfk99nenq7bqehac3ljln6	1	2
763	2020-02-29	4l97u04phimcoo1t8m5l407ae9	1	2
764	2020-03-01	3n2uf3jaruu7m0ejcfarrimqqn	1	2
765	2020-03-06	5s8j858j5qjf6q5g4ehnshbv8v	1	2
766	2020-03-07	7257pi464lhcllktolbsovaepj	1	2
767	2020-03-08	1720pkl94ktumbkjoqtr2dj3qm	1	2
768	2020-03-14	51kk4s21ihq4d5n7o74bi80v07	1	2
769	2020-03-15	7q2kejpb628ndi6mph1u2rnevf	1	2
770	2020-03-20	4m08ve6lonli4bcgh4j20r69av	1	2
771	2020-03-21	775dsh9r27l7sv2rr0nhl016ej	1	2
772	2020-03-22	7edk6gpp29pn75r3ndq1d21gsj	1	2
773	2020-03-26	08l5s76lek9e33doc395sp97m5	1	2
774	2020-03-27	08l5s76lek9e33doc395sp97m5	1	2
775	2020-03-28	08l5s76lek9e33doc395sp97m5	1	2
776	2020-03-29	08l5s76lek9e33doc395sp97m5	1	2
777	2020-03-30	08l5s76lek9e33doc395sp97m5	1	2
778	2020-03-31	08l5s76lek9e33doc395sp97m5	1	2
779	2020-04-01	08l5s76lek9e33doc395sp97m5	1	2
780	2020-04-02	08l5s76lek9e33doc395sp97m5	1	2
781	2020-04-03	08l5s76lek9e33doc395sp97m5	1	2
782	2020-04-04	08l5s76lek9e33doc395sp97m5	1	2
783	2020-04-05	08l5s76lek9e33doc395sp97m5	1	2
784	2020-04-06	08l5s76lek9e33doc395sp97m5	1	2
785	2020-04-07	08l5s76lek9e33doc395sp97m5	1	2
786	2020-04-08	08l5s76lek9e33doc395sp97m5	1	2
787	2020-04-09	08l5s76lek9e33doc395sp97m5	1	2
788	2020-04-10	08l5s76lek9e33doc395sp97m5	1	2
789	2020-04-11	08l5s76lek9e33doc395sp97m5	1	2
790	2020-04-12	08l5s76lek9e33doc395sp97m5	1	2
791	2020-04-13	08l5s76lek9e33doc395sp97m5	1	2
792	2020-04-14	08l5s76lek9e33doc395sp97m5	1	2
793	2020-04-15	08l5s76lek9e33doc395sp97m5	1	2
794	2020-04-16	08l5s76lek9e33doc395sp97m5	1	2
795	2020-04-17	08l5s76lek9e33doc395sp97m5	1	2
796	2020-04-18	08l5s76lek9e33doc395sp97m5	1	2
797	2020-04-19	08l5s76lek9e33doc395sp97m5	1	2
798	2020-04-20	08l5s76lek9e33doc395sp97m5	1	2
799	2020-04-24	76nur4rs3dlbrgolv50tuuk8cc	1	2
800	2020-04-25	0hskcug822rc92uem3q4dg6l6j	1	2
801	2020-04-26	3c9p8s70esbpa9nishel78hsbs	1	2
802	2020-04-27	1c2nj58306jhnha016or77rn9e	1	2
803	2020-05-01	2ke49nrm8euqqfn6um5uum1u5s	1	2
804	2020-05-02	41l4lm6msuhgel8uhrog7hcau4	1	2
805	2020-05-03	1kn1ohtn8kp1r67v4tfrssuh28	1	2
806	2020-05-04	2gqndqblo5bqtp2jqcnk04vl8f	1	2
807	2020-05-07	6rfof27ueoi3fescdoj81c3ufc	1	2
808	2020-05-08	682qcopvb4o0cnm323ctfhof5k	1	2
809	2020-05-09	1ejqr4cqtkadffq4jen9js1or7	1	2
810	2020-05-10	3kht44jq5msauai4upkg4slpul	1	2
811	2020-05-11	2igj9388t0hsks94eo5p9036hb	1	2
812	2020-05-15	7tj1hincn2cfkb98j0iljdivi5	1	2
813	2020-05-16	1rshbbpl4fn3d117slno5otaqt	1	2
814	2020-05-17	1crfmk3h0obrvpr31ae6j40egh	1	2
827	2020-10-30	7mja1uqhb8vtm7pq2n81h2ko0e	1	2
828	2020-10-31	3hu1m91bal8m6d8bh08aog2rt0	1	2
829	2020-11-01	3hu1m91bal8m6d8bh08aog2rt0	1	2
830	2017-06-23	1vtbnenr89vsnuibf6df44t5fa	3	2
831	2017-06-24	1vtbnenr89vsnuibf6df44t5fa	3	2
832	2017-06-25	1vtbnenr89vsnuibf6df44t5fa	3	2
833	2017-06-30	13jtkt0j1pgv2686h1okuot3p0	3	2
834	2017-07-01	13jtkt0j1pgv2686h1okuot3p0	3	2
835	2017-07-02	13jtkt0j1pgv2686h1okuot3p0	3	2
836	2017-07-14	2594d00mls8i6r7ktg7lmlmkm4	3	2
837	2017-07-15	2594d00mls8i6r7ktg7lmlmkm4	3	2
838	2017-07-16	2594d00mls8i6r7ktg7lmlmkm4	3	2
839	2017-07-21	4lojh02soig0kje8vdrc4llgu2	3	2
840	2017-07-22	4lojh02soig0kje8vdrc4llgu2	3	2
841	2017-07-23	4lojh02soig0kje8vdrc4llgu2	3	2
842	2017-07-24	4lojh02soig0kje8vdrc4llgu2	3	2
843	2017-07-25	4lojh02soig0kje8vdrc4llgu2	3	2
844	2017-07-26	4lojh02soig0kje8vdrc4llgu2	3	2
845	2017-07-27	4lojh02soig0kje8vdrc4llgu2	3	2
846	2017-07-28	4lojh02soig0kje8vdrc4llgu2	3	2
847	2017-07-29	4lojh02soig0kje8vdrc4llgu2	3	2
848	2017-07-30	4lojh02soig0kje8vdrc4llgu2	3	2
849	2017-07-31	4lojh02soig0kje8vdrc4llgu2	3	2
850	2017-08-01	4lojh02soig0kje8vdrc4llgu2	3	2
851	2017-08-02	4lojh02soig0kje8vdrc4llgu2	3	2
852	2017-08-03	4lojh02soig0kje8vdrc4llgu2	3	2
853	2017-08-04	4lojh02soig0kje8vdrc4llgu2	3	2
854	2017-08-05	4lojh02soig0kje8vdrc4llgu2	3	2
855	2017-08-06	4lojh02soig0kje8vdrc4llgu2	3	2
856	2017-08-07	4lojh02soig0kje8vdrc4llgu2	3	2
857	2017-08-08	4lojh02soig0kje8vdrc4llgu2	3	2
858	2017-08-09	4lojh02soig0kje8vdrc4llgu2	3	2
859	2017-08-10	4lojh02soig0kje8vdrc4llgu2	3	2
860	2017-08-11	4lojh02soig0kje8vdrc4llgu2	3	2
861	2017-08-12	4lojh02soig0kje8vdrc4llgu2	3	2
862	2017-08-13	4lojh02soig0kje8vdrc4llgu2	3	2
863	2017-08-14	4lojh02soig0kje8vdrc4llgu2	3	2
864	2017-08-15	4lojh02soig0kje8vdrc4llgu2	3	2
865	2017-08-16	4lojh02soig0kje8vdrc4llgu2	3	2
866	2017-08-17	4lojh02soig0kje8vdrc4llgu2	3	2
867	2017-08-18	4lojh02soig0kje8vdrc4llgu2	3	2
868	2017-08-19	4lojh02soig0kje8vdrc4llgu2	3	2
869	2017-08-20	4lojh02soig0kje8vdrc4llgu2	3	2
870	2017-08-21	4lojh02soig0kje8vdrc4llgu2	3	2
871	2017-08-22	4lojh02soig0kje8vdrc4llgu2	3	2
872	2017-08-23	4lojh02soig0kje8vdrc4llgu2	3	2
873	2017-08-24	4lojh02soig0kje8vdrc4llgu2	3	2
874	2017-08-25	4lojh02soig0kje8vdrc4llgu2	3	2
875	2017-08-26	4lojh02soig0kje8vdrc4llgu2	3	2
876	2017-08-27	4lojh02soig0kje8vdrc4llgu2	3	2
877	2017-08-28	4lojh02soig0kje8vdrc4llgu2	3	2
878	2017-08-29	4lojh02soig0kje8vdrc4llgu2	3	2
879	2017-08-30	4lojh02soig0kje8vdrc4llgu2	3	2
880	2017-08-31	4lojh02soig0kje8vdrc4llgu2	3	2
881	2017-09-01	4lojh02soig0kje8vdrc4llgu2	3	2
882	2017-09-02	4lojh02soig0kje8vdrc4llgu2	3	2
883	2017-09-03	4lojh02soig0kje8vdrc4llgu2	3	2
884	2017-09-04	4lojh02soig0kje8vdrc4llgu2	3	2
885	2017-09-15	6td5paod3m02utqqq8brfoobqk	3	2
886	2017-09-16	6td5paod3m02utqqq8brfoobqk	3	2
887	2017-09-17	6td5paod3m02utqqq8brfoobqk	3	2
888	2017-09-18	6td5paod3m02utqqq8brfoobqk	3	2
889	2017-09-19	6td5paod3m02utqqq8brfoobqk	3	2
890	2017-09-20	6td5paod3m02utqqq8brfoobqk	3	2
891	2017-09-21	6td5paod3m02utqqq8brfoobqk	3	2
892	2017-09-22	6td5paod3m02utqqq8brfoobqk	3	2
893	2017-09-23	6td5paod3m02utqqq8brfoobqk	3	2
894	2017-09-24	6td5paod3m02utqqq8brfoobqk	3	2
895	2017-09-25	6td5paod3m02utqqq8brfoobqk	3	2
896	2017-09-26	6td5paod3m02utqqq8brfoobqk	3	2
897	2017-09-27	6td5paod3m02utqqq8brfoobqk	3	2
898	2017-09-28	6td5paod3m02utqqq8brfoobqk	3	2
899	2017-09-29	6td5paod3m02utqqq8brfoobqk	3	2
900	2017-09-30	6td5paod3m02utqqq8brfoobqk	3	2
901	2017-10-01	6td5paod3m02utqqq8brfoobqk	3	2
902	2017-10-02	6td5paod3m02utqqq8brfoobqk	3	2
903	2017-10-03	6td5paod3m02utqqq8brfoobqk	3	2
904	2017-10-04	6td5paod3m02utqqq8brfoobqk	3	2
905	2017-10-05	6td5paod3m02utqqq8brfoobqk	3	2
906	2017-10-06	6td5paod3m02utqqq8brfoobqk	3	2
907	2017-10-07	6td5paod3m02utqqq8brfoobqk	3	2
908	2017-10-08	6td5paod3m02utqqq8brfoobqk	3	2
909	2020-05-22	6rr1ipv6m27g315rm19pqbeu1f	1	2
910	2017-10-13	35dita4ifgmuup2chates75vue	3	2
911	2017-10-14	35dita4ifgmuup2chates75vue	3	2
912	2017-10-15	35dita4ifgmuup2chates75vue	3	2
913	2017-10-20	2nf0me08udl9k5lufflrcsj4fl	3	2
914	2017-10-21	2nf0me08udl9k5lufflrcsj4fl	3	2
915	2017-10-22	2nf0me08udl9k5lufflrcsj4fl	3	2
916	2017-10-28	199m10keig8bk2f56u9qft3mco	3	2
917	2017-10-29	199m10keig8bk2f56u9qft3mco	3	2
918	2017-11-03	003vti77lkqm6gmndrcs6ba99d	3	2
919	2017-11-04	003vti77lkqm6gmndrcs6ba99d	3	2
920	2017-11-05	003vti77lkqm6gmndrcs6ba99d	3	2
921	2017-11-08	686t688l6t8sj1e9pfq6kk5ol7	3	2
922	2017-11-09	686t688l6t8sj1e9pfq6kk5ol7	3	2
923	2017-11-10	686t688l6t8sj1e9pfq6kk5ol7	3	2
924	2017-11-11	686t688l6t8sj1e9pfq6kk5ol7	3	2
925	2017-11-12	686t688l6t8sj1e9pfq6kk5ol7	3	2
926	2017-11-17	6ath48k0l0koq70garc54g5s8k	3	2
927	2017-11-18	6ath48k0l0koq70garc54g5s8k	3	2
928	2017-11-19	6ath48k0l0koq70garc54g5s8k	3	2
929	2017-11-25	5sce0djc3m95uq3upfprlvqmb6	3	2
930	2017-11-26	5sce0djc3m95uq3upfprlvqmb6	3	2
931	2017-12-01	2tgk5flo0nfg1dtajvehq5p8eg	3	2
932	2017-12-02	2tgk5flo0nfg1dtajvehq5p8eg	3	2
933	2017-12-03	2tgk5flo0nfg1dtajvehq5p8eg	3	2
934	2020-05-23	7lifv00lk69gvik707gh7045aa	1	2
935	2017-12-09	4plajfm2pek1k5722u2sqbpdeh	3	2
936	2017-12-10	4plajfm2pek1k5722u2sqbpdeh	3	2
937	2017-12-16	2gom3p05mi74nh8ojifln0phcu	3	2
938	2017-12-17	2gom3p05mi74nh8ojifln0phcu	3	2
939	2017-12-22	1ls56h8nip5j7shhkv4c0svvqv	3	2
940	2017-12-23	1ls56h8nip5j7shhkv4c0svvqv	3	2
941	2017-12-24	1ls56h8nip5j7shhkv4c0svvqv	3	2
942	2017-12-25	1ls56h8nip5j7shhkv4c0svvqv	3	2
943	2017-12-26	1ls56h8nip5j7shhkv4c0svvqv	3	2
944	2017-12-27	1ls56h8nip5j7shhkv4c0svvqv	3	2
945	2017-12-28	1ls56h8nip5j7shhkv4c0svvqv	3	2
946	2017-12-29	1ls56h8nip5j7shhkv4c0svvqv	3	2
947	2017-12-30	1ls56h8nip5j7shhkv4c0svvqv	3	2
948	2017-12-31	1ls56h8nip5j7shhkv4c0svvqv	3	2
949	2018-01-01	1ls56h8nip5j7shhkv4c0svvqv	3	2
950	2018-01-02	1ls56h8nip5j7shhkv4c0svvqv	3	2
951	2018-01-03	1ls56h8nip5j7shhkv4c0svvqv	3	2
952	2018-01-04	1ls56h8nip5j7shhkv4c0svvqv	3	2
953	2018-01-05	1ls56h8nip5j7shhkv4c0svvqv	3	2
954	2018-01-06	1ls56h8nip5j7shhkv4c0svvqv	3	2
955	2018-01-07	1ls56h8nip5j7shhkv4c0svvqv	3	2
956	2018-01-12	2j50k4k2u0kpbvnm9mfudkbm7d	3	2
957	2018-01-13	2j50k4k2u0kpbvnm9mfudkbm7d	3	2
958	2018-01-14	2j50k4k2u0kpbvnm9mfudkbm7d	3	2
959	2018-01-19	2jr33jcliufasc6t82vo72v5f7	3	2
960	2018-01-20	2jr33jcliufasc6t82vo72v5f7	3	2
961	2018-01-21	2jr33jcliufasc6t82vo72v5f7	3	2
962	2018-01-27	1fb2pc7jsn2oh2abtl8neprbdt	3	2
963	2018-01-28	1fb2pc7jsn2oh2abtl8neprbdt	3	2
964	2018-02-02	1i86p83oiomd5eqs7v104t58ao	3	2
965	2018-02-03	1i86p83oiomd5eqs7v104t58ao	3	2
966	2018-02-04	1i86p83oiomd5eqs7v104t58ao	3	2
967	2018-02-09	50dsjrn81o8e99h5ov01e3oo42	3	2
968	2018-02-10	50dsjrn81o8e99h5ov01e3oo42	3	2
969	2018-02-11	50dsjrn81o8e99h5ov01e3oo42	3	2
970	2018-02-12	50dsjrn81o8e99h5ov01e3oo42	3	2
971	2018-02-13	50dsjrn81o8e99h5ov01e3oo42	3	2
972	2018-02-14	50dsjrn81o8e99h5ov01e3oo42	3	2
973	2018-02-15	50dsjrn81o8e99h5ov01e3oo42	3	2
974	2018-02-16	50dsjrn81o8e99h5ov01e3oo42	3	2
975	2018-02-17	50dsjrn81o8e99h5ov01e3oo42	3	2
976	2018-02-18	50dsjrn81o8e99h5ov01e3oo42	3	2
977	2018-02-19	50dsjrn81o8e99h5ov01e3oo42	3	2
978	2018-02-24	4enb3j8gr016trcvirvqnhajd4	3	2
979	2018-02-25	4enb3j8gr016trcvirvqnhajd4	3	2
980	2018-03-02	3p6k17iq1g2ba54dfulj49j9fr	3	2
981	2018-03-03	3p6k17iq1g2ba54dfulj49j9fr	3	2
982	2018-03-04	3p6k17iq1g2ba54dfulj49j9fr	3	2
983	2018-03-09	01d2biv992hq6ntm9bgg4rb9r8	3	2
984	2018-03-10	01d2biv992hq6ntm9bgg4rb9r8	3	2
985	2018-03-11	01d2biv992hq6ntm9bgg4rb9r8	3	2
986	2018-03-16	4gvjsnsvtfjgv4qc13sbart0hh	3	2
987	2018-03-17	4gvjsnsvtfjgv4qc13sbart0hh	3	2
988	2018-03-18	4gvjsnsvtfjgv4qc13sbart0hh	3	2
989	2018-03-24	7s5ogdbdobbqso13ccvaq13k4d	3	2
990	2018-03-25	7s5ogdbdobbqso13ccvaq13k4d	3	2
991	2018-03-30	51t5eka61savrvh5vhpifa7pnm	3	2
992	2018-03-31	51t5eka61savrvh5vhpifa7pnm	3	2
993	2018-04-01	51t5eka61savrvh5vhpifa7pnm	3	2
994	2018-04-02	51t5eka61savrvh5vhpifa7pnm	3	2
995	2018-04-03	51t5eka61savrvh5vhpifa7pnm	3	2
996	2018-04-04	51t5eka61savrvh5vhpifa7pnm	3	2
997	2018-04-05	51t5eka61savrvh5vhpifa7pnm	3	2
998	2018-04-06	51t5eka61savrvh5vhpifa7pnm	3	2
999	2018-04-07	51t5eka61savrvh5vhpifa7pnm	3	2
1000	2018-04-08	51t5eka61savrvh5vhpifa7pnm	3	2
1001	2018-04-09	51t5eka61savrvh5vhpifa7pnm	3	2
1002	2018-04-10	51t5eka61savrvh5vhpifa7pnm	3	2
1003	2018-04-11	51t5eka61savrvh5vhpifa7pnm	3	2
1004	2018-04-12	51t5eka61savrvh5vhpifa7pnm	3	2
1005	2018-04-13	51t5eka61savrvh5vhpifa7pnm	3	2
1006	2018-04-14	51t5eka61savrvh5vhpifa7pnm	3	2
1007	2018-04-15	51t5eka61savrvh5vhpifa7pnm	3	2
1008	2018-04-20	04j2hlult14np275meith1g45k	3	2
1009	2018-04-21	04j2hlult14np275meith1g45k	3	2
1010	2018-04-22	04j2hlult14np275meith1g45k	3	2
1011	2018-04-28	3d0e2a54prjkduq00imehkmuvt	3	2
1012	2018-04-29	3d0e2a54prjkduq00imehkmuvt	3	2
1013	2018-05-04	4f93k0rvk1g8ah3e85i4mdlcah	3	2
1014	2018-05-05	4f93k0rvk1g8ah3e85i4mdlcah	3	2
1015	2018-05-06	4f93k0rvk1g8ah3e85i4mdlcah	3	2
1016	2018-05-07	4f93k0rvk1g8ah3e85i4mdlcah	3	2
1017	2018-05-12	6nkkcn714b8c9uc9utgrg5nqof	3	2
1018	2018-05-13	6nkkcn714b8c9uc9utgrg5nqof	3	2
1019	2018-05-18	7bgf0m8v6br7fpujmr830rbh9t	3	2
1020	2018-05-19	7bgf0m8v6br7fpujmr830rbh9t	3	2
1021	2018-05-20	7bgf0m8v6br7fpujmr830rbh9t	3	2
1022	2018-05-25	1a5ve1rioeicsmva5hibjecils	3	2
1023	2018-05-26	1a5ve1rioeicsmva5hibjecils	3	2
1024	2018-05-27	1a5ve1rioeicsmva5hibjecils	3	2
1025	2018-05-28	1a5ve1rioeicsmva5hibjecils	3	2
1026	2018-05-29	1a5ve1rioeicsmva5hibjecils	3	2
1027	2018-05-30	1a5ve1rioeicsmva5hibjecils	3	2
1028	2018-05-31	1a5ve1rioeicsmva5hibjecils	3	2
1029	2018-06-01	1a5ve1rioeicsmva5hibjecils	3	2
1030	2018-06-02	1a5ve1rioeicsmva5hibjecils	3	2
1031	2018-06-03	1a5ve1rioeicsmva5hibjecils	3	2
1032	2018-06-08	726hatjqt2mcr9n0kj04c12s0g	3	2
1033	2018-06-09	726hatjqt2mcr9n0kj04c12s0g	3	2
1034	2018-06-10	726hatjqt2mcr9n0kj04c12s0g	3	2
1035	2018-06-15	3b2ppifp00ickfinud3th79qq8	3	2
1036	2018-06-16	3b2ppifp00ickfinud3th79qq8	3	2
1037	2018-06-17	3b2ppifp00ickfinud3th79qq8	3	2
1038	2018-06-22	0airquers7qseclcc2abrg7ll2	3	2
1039	2018-06-23	0airquers7qseclcc2abrg7ll2	3	2
1040	2018-06-24	0airquers7qseclcc2abrg7ll2	3	2
1041	2018-06-30	752381gmjpkvjtrkjc16bm4rb4	3	2
1042	2018-07-01	752381gmjpkvjtrkjc16bm4rb4	3	2
1043	2018-07-06	11o1gdji67l5ubmf7vebv0730m	3	2
1044	2018-07-07	11o1gdji67l5ubmf7vebv0730m	3	2
1045	2018-07-08	11o1gdji67l5ubmf7vebv0730m	3	2
1046	2018-07-13	3gfmnlqrg40pjtt35msc5esfrs	3	2
1047	2018-07-14	3gfmnlqrg40pjtt35msc5esfrs	3	2
1048	2018-07-15	3gfmnlqrg40pjtt35msc5esfrs	3	2
1049	2018-07-21	4gm2q5q90p7i30pu4k7h6blqea	3	2
1050	2018-07-22	4gm2q5q90p7i30pu4k7h6blqea	3	2
1051	2018-07-25	1mo4m94j0l0h3ddt4139bio7a5	3	2
1052	2018-07-26	1mo4m94j0l0h3ddt4139bio7a5	3	2
1053	2018-07-27	1mo4m94j0l0h3ddt4139bio7a5	3	2
1054	2018-07-28	1mo4m94j0l0h3ddt4139bio7a5	3	2
1055	2018-07-29	1mo4m94j0l0h3ddt4139bio7a5	3	2
1056	2018-07-30	1mo4m94j0l0h3ddt4139bio7a5	3	2
1057	2018-07-31	1mo4m94j0l0h3ddt4139bio7a5	3	2
1058	2018-08-01	1mo4m94j0l0h3ddt4139bio7a5	3	2
1059	2018-08-02	1mo4m94j0l0h3ddt4139bio7a5	3	2
1060	2018-08-03	1mo4m94j0l0h3ddt4139bio7a5	3	2
1061	2018-08-04	1mo4m94j0l0h3ddt4139bio7a5	3	2
1062	2018-08-05	1mo4m94j0l0h3ddt4139bio7a5	3	2
1063	2018-08-06	1mo4m94j0l0h3ddt4139bio7a5	3	2
1064	2018-08-07	1mo4m94j0l0h3ddt4139bio7a5	3	2
1065	2018-08-08	1mo4m94j0l0h3ddt4139bio7a5	3	2
1066	2018-08-09	1mo4m94j0l0h3ddt4139bio7a5	3	2
1067	2018-08-10	1mo4m94j0l0h3ddt4139bio7a5	3	2
1068	2018-08-11	1mo4m94j0l0h3ddt4139bio7a5	3	2
1069	2018-08-12	1mo4m94j0l0h3ddt4139bio7a5	3	2
1070	2018-08-13	1mo4m94j0l0h3ddt4139bio7a5	3	2
1071	2018-08-14	1mo4m94j0l0h3ddt4139bio7a5	3	2
1072	2018-08-15	1mo4m94j0l0h3ddt4139bio7a5	3	2
1073	2018-08-16	1mo4m94j0l0h3ddt4139bio7a5	3	2
1074	2018-08-17	1mo4m94j0l0h3ddt4139bio7a5	3	2
1075	2018-08-18	1mo4m94j0l0h3ddt4139bio7a5	3	2
1076	2018-08-19	1mo4m94j0l0h3ddt4139bio7a5	3	2
1077	2018-08-20	1mo4m94j0l0h3ddt4139bio7a5	3	2
1078	2018-08-21	1mo4m94j0l0h3ddt4139bio7a5	3	2
1079	2018-08-22	1mo4m94j0l0h3ddt4139bio7a5	3	2
1080	2018-08-23	1mo4m94j0l0h3ddt4139bio7a5	3	2
1081	2018-08-24	1mo4m94j0l0h3ddt4139bio7a5	3	2
1082	2018-08-25	1mo4m94j0l0h3ddt4139bio7a5	3	2
1083	2018-08-26	1mo4m94j0l0h3ddt4139bio7a5	3	2
1084	2018-08-27	1mo4m94j0l0h3ddt4139bio7a5	3	2
1085	2018-08-28	1mo4m94j0l0h3ddt4139bio7a5	3	2
1086	2018-08-29	1mo4m94j0l0h3ddt4139bio7a5	3	2
1087	2018-08-30	1mo4m94j0l0h3ddt4139bio7a5	3	2
1088	2018-08-31	1mo4m94j0l0h3ddt4139bio7a5	3	2
1089	2018-09-01	1mo4m94j0l0h3ddt4139bio7a5	3	2
1090	2018-09-02	1mo4m94j0l0h3ddt4139bio7a5	3	2
1091	2018-09-03	1mo4m94j0l0h3ddt4139bio7a5	3	2
1092	2018-09-08	4b4u2vt6mi43asg6qen3hr9n6o	3	2
1093	2018-09-09	4b4u2vt6mi43asg6qen3hr9n6o	3	2
1094	2018-09-14	76pdrimibfov90astkgqpogdtj	3	2
1095	2018-09-15	76pdrimibfov90astkgqpogdtj	3	2
1096	2018-09-16	76pdrimibfov90astkgqpogdtj	3	2
1097	2018-09-17	76pdrimibfov90astkgqpogdtj	3	2
1098	2018-09-18	76pdrimibfov90astkgqpogdtj	3	2
1099	2018-09-19	76pdrimibfov90astkgqpogdtj	3	2
1100	2018-09-20	76pdrimibfov90astkgqpogdtj	3	2
1101	2018-09-21	76pdrimibfov90astkgqpogdtj	3	2
1102	2018-09-22	76pdrimibfov90astkgqpogdtj	3	2
1103	2018-09-23	76pdrimibfov90astkgqpogdtj	3	2
1104	2018-09-24	76pdrimibfov90astkgqpogdtj	3	2
1105	2018-09-25	76pdrimibfov90astkgqpogdtj	3	2
1106	2018-09-26	76pdrimibfov90astkgqpogdtj	3	2
1107	2018-09-27	76pdrimibfov90astkgqpogdtj	3	2
1108	2018-09-28	76pdrimibfov90astkgqpogdtj	3	2
1109	2018-09-29	76pdrimibfov90astkgqpogdtj	3	2
1110	2018-09-30	76pdrimibfov90astkgqpogdtj	3	2
1111	2018-10-01	76pdrimibfov90astkgqpogdtj	3	2
1112	2018-10-02	76pdrimibfov90astkgqpogdtj	3	2
1113	2018-10-03	76pdrimibfov90astkgqpogdtj	3	2
1114	2018-10-04	76pdrimibfov90astkgqpogdtj	3	2
1115	2018-10-05	76pdrimibfov90astkgqpogdtj	3	2
1116	2018-10-06	76pdrimibfov90astkgqpogdtj	3	2
1117	2018-10-07	76pdrimibfov90astkgqpogdtj	3	2
1118	2018-10-08	76pdrimibfov90astkgqpogdtj	3	2
1119	2018-10-12	0hl317ag77kec518jhc9393fna	3	2
1120	2018-10-13	0hl317ag77kec518jhc9393fna	3	2
1121	2018-10-14	0hl317ag77kec518jhc9393fna	3	2
1122	2018-10-19	293e19gahf4td58jrqg8h966ij	3	2
1123	2018-10-20	293e19gahf4td58jrqg8h966ij	3	2
1124	2018-10-21	293e19gahf4td58jrqg8h966ij	3	2
1125	2018-10-27	7k1jfo91evbpl07pvkhto7u8th	3	2
1126	2018-10-28	7k1jfo91evbpl07pvkhto7u8th	3	2
1127	2018-11-02	18jaof94144a1puovh2gsp4kj6	3	2
1128	2018-11-03	18jaof94144a1puovh2gsp4kj6	3	2
1129	2018-11-04	18jaof94144a1puovh2gsp4kj6	3	2
1130	2018-11-07	44l82jtkqsop7ki69gas4ovt6p	3	2
1131	2018-11-08	44l82jtkqsop7ki69gas4ovt6p	3	2
1132	2018-11-09	44l82jtkqsop7ki69gas4ovt6p	3	2
1133	2018-11-10	44l82jtkqsop7ki69gas4ovt6p	3	2
1134	2018-11-11	44l82jtkqsop7ki69gas4ovt6p	3	2
1135	2018-11-16	4pr1e1sn5fscn08e7at8gev40f	3	2
1136	2018-11-17	4pr1e1sn5fscn08e7at8gev40f	3	2
1137	2018-11-18	4pr1e1sn5fscn08e7at8gev40f	3	2
1138	2018-11-24	2cai0t4its8e408u1oav1daeh6	3	2
1139	2018-11-25	2cai0t4its8e408u1oav1daeh6	3	2
1140	2018-11-30	7leg4g40e5ri38sp0p8arouh1a	3	2
1141	2018-12-01	7leg4g40e5ri38sp0p8arouh1a	3	2
1142	2018-12-02	7leg4g40e5ri38sp0p8arouh1a	3	2
1143	2018-12-07	4j078nfivks44ndedn4gtrcbon	3	2
1144	2018-12-08	4j078nfivks44ndedn4gtrcbon	3	2
1145	2018-12-09	4j078nfivks44ndedn4gtrcbon	3	2
1146	2018-12-15	1u5kbo5gcsr16u8j201dc87s68	3	2
1147	2018-12-16	1u5kbo5gcsr16u8j201dc87s68	3	2
1148	2018-12-21	6acmnpoc4iq2aplm0ismbdsj6v	3	2
1149	2018-12-22	6acmnpoc4iq2aplm0ismbdsj6v	3	2
1150	2018-12-23	6acmnpoc4iq2aplm0ismbdsj6v	3	2
1151	2018-12-24	6acmnpoc4iq2aplm0ismbdsj6v	3	2
1152	2018-12-25	6acmnpoc4iq2aplm0ismbdsj6v	3	2
1153	2018-12-26	6acmnpoc4iq2aplm0ismbdsj6v	3	2
1154	2018-12-27	6acmnpoc4iq2aplm0ismbdsj6v	3	2
1155	2018-12-28	6acmnpoc4iq2aplm0ismbdsj6v	3	2
1156	2018-12-29	6acmnpoc4iq2aplm0ismbdsj6v	3	2
1157	2018-12-30	6acmnpoc4iq2aplm0ismbdsj6v	3	2
1158	2018-12-31	6acmnpoc4iq2aplm0ismbdsj6v	3	2
1159	2019-01-01	6acmnpoc4iq2aplm0ismbdsj6v	3	2
1160	2019-01-02	6acmnpoc4iq2aplm0ismbdsj6v	3	2
1161	2019-01-03	6acmnpoc4iq2aplm0ismbdsj6v	3	2
1162	2019-01-04	6acmnpoc4iq2aplm0ismbdsj6v	3	2
1163	2019-01-05	6acmnpoc4iq2aplm0ismbdsj6v	3	2
1164	2019-01-06	6acmnpoc4iq2aplm0ismbdsj6v	3	2
1165	2020-05-24	71qc8akfsvfnnhumfi6bls88mr	1	2
1166	2020-05-25	42qcnul1h2fgbakkc6m0h66i2o	1	2
1167	2020-05-26	4gqo4p6qpdfhtu3ti4ur1ma1pd	1	2
1168	2020-05-27	3ijavfr072cc0e4pul5fp3cl30	1	2
1169	2020-05-28	70cbr6htn4gav4gfg437gj0jod	1	2
1170	2020-05-29	5uppnfn3l04hh6h31n8of9fc19	1	2
1171	2019-01-11	2n1j18974cq1vb4ng4jnq0dcuo	3	2
1172	2019-01-12	2n1j18974cq1vb4ng4jnq0dcuo	3	2
1173	2019-01-13	2n1j18974cq1vb4ng4jnq0dcuo	3	2
1174	2019-01-19	0gqm534unbhid6phkvrorum8lh	3	2
1175	2019-01-20	0gqm534unbhid6phkvrorum8lh	3	2
1176	2019-01-25	667cuovm41tbncghb7vl6lh9qn	3	2
1177	2019-01-26	667cuovm41tbncghb7vl6lh9qn	3	2
1178	2019-01-27	667cuovm41tbncghb7vl6lh9qn	3	2
1179	2019-02-02	54fa4t35qlochnd6g22m7jg3mb	3	2
1180	2019-02-03	54fa4t35qlochnd6g22m7jg3mb	3	2
1181	2019-02-08	15i53rlbh1ce3oq87r7o9p4ulk	3	2
1182	2019-02-09	15i53rlbh1ce3oq87r7o9p4ulk	3	2
1183	2019-02-10	15i53rlbh1ce3oq87r7o9p4ulk	3	2
1184	2019-02-15	71thb9edvgi031ahsjuq8nnept	3	2
1185	2019-02-16	71thb9edvgi031ahsjuq8nnept	3	2
1186	2019-02-17	71thb9edvgi031ahsjuq8nnept	3	2
1187	2019-02-22	20i0fael3fvom7dbd153tvk5ro	3	2
1188	2019-02-23	20i0fael3fvom7dbd153tvk5ro	3	2
1189	2019-02-24	20i0fael3fvom7dbd153tvk5ro	3	2
1190	2019-03-02	718neg0eu406a9ec95h95j06qi	3	2
1191	2019-03-03	718neg0eu406a9ec95h95j06qi	3	2
1192	2019-03-08	5rtu8h9a4o67n0cjjjkh5aq5fs	3	2
1193	2019-03-09	5rtu8h9a4o67n0cjjjkh5aq5fs	3	2
1194	2019-03-10	5rtu8h9a4o67n0cjjjkh5aq5fs	3	2
1195	2019-03-16	1dt77h4h4jkh8qvaf5rddjhucg	3	2
1196	2019-03-17	1dt77h4h4jkh8qvaf5rddjhucg	3	2
1197	2019-03-22	5qj1sqvdb2h1r095e2dbtstvfn	3	2
1198	2019-03-23	5qj1sqvdb2h1r095e2dbtstvfn	3	2
1199	2019-03-24	5qj1sqvdb2h1r095e2dbtstvfn	3	2
1200	2019-03-29	1iflc3oaq46q8rdpdg92mtn2b3	3	2
1201	2019-03-30	1iflc3oaq46q8rdpdg92mtn2b3	3	2
1202	2019-03-31	1iflc3oaq46q8rdpdg92mtn2b3	3	2
1203	2019-04-05	368f32cdcsd61l97ss4obgaqg4	3	2
1204	2019-04-06	368f32cdcsd61l97ss4obgaqg4	3	2
1205	2019-04-07	368f32cdcsd61l97ss4obgaqg4	3	2
1206	2019-04-12	0rni096cdd9fu9imdgufr5c3rq	3	2
1207	2019-04-13	0rni096cdd9fu9imdgufr5c3rq	3	2
1208	2019-04-14	0rni096cdd9fu9imdgufr5c3rq	3	2
1209	2019-04-15	0rni096cdd9fu9imdgufr5c3rq	3	2
1210	2019-04-16	0rni096cdd9fu9imdgufr5c3rq	3	2
1211	2019-04-17	0rni096cdd9fu9imdgufr5c3rq	3	2
1212	2019-04-18	0rni096cdd9fu9imdgufr5c3rq	3	2
1213	2019-04-19	0rni096cdd9fu9imdgufr5c3rq	3	2
1214	2019-04-20	0rni096cdd9fu9imdgufr5c3rq	3	2
1215	2019-04-21	0rni096cdd9fu9imdgufr5c3rq	3	2
1216	2019-04-22	0rni096cdd9fu9imdgufr5c3rq	3	2
1217	2019-04-23	0rni096cdd9fu9imdgufr5c3rq	3	2
1218	2019-04-26	2h9f4b3lk3sfscctskastdm27v	3	2
1219	2019-04-27	2h9f4b3lk3sfscctskastdm27v	3	2
1220	2019-04-28	2h9f4b3lk3sfscctskastdm27v	3	2
1221	2019-05-03	42j3nv8te9mp96rnf75p909i25	3	2
1222	2019-05-04	42j3nv8te9mp96rnf75p909i25	3	2
1223	2019-05-05	42j3nv8te9mp96rnf75p909i25	3	2
1224	2019-05-06	42j3nv8te9mp96rnf75p909i25	3	2
1225	2019-05-10	7e2o956hms9b6on5kpmthof5t4	3	2
1226	2019-05-11	7e2o956hms9b6on5kpmthof5t4	3	2
1227	2019-05-12	7e2o956hms9b6on5kpmthof5t4	3	2
1228	2019-05-17	1ju5cmmdufpgjr7t2t38een775	3	2
1229	2019-05-18	1ju5cmmdufpgjr7t2t38een775	3	2
1230	2019-05-19	1ju5cmmdufpgjr7t2t38een775	3	2
1231	2019-05-24	0lqtvs7efkgu42u3sjgnm9s86v	3	2
1232	2019-05-25	0lqtvs7efkgu42u3sjgnm9s86v	3	2
1233	2019-05-26	0lqtvs7efkgu42u3sjgnm9s86v	3	2
1234	2019-05-27	0lqtvs7efkgu42u3sjgnm9s86v	3	2
1235	2019-05-28	0lqtvs7efkgu42u3sjgnm9s86v	3	2
1236	2019-05-29	0lqtvs7efkgu42u3sjgnm9s86v	3	2
1237	2019-05-30	0lqtvs7efkgu42u3sjgnm9s86v	3	2
1238	2019-05-31	0lqtvs7efkgu42u3sjgnm9s86v	3	2
1239	2019-06-01	0lqtvs7efkgu42u3sjgnm9s86v	3	2
1240	2019-06-02	0lqtvs7efkgu42u3sjgnm9s86v	3	2
1241	2019-06-03	0lqtvs7efkgu42u3sjgnm9s86v	3	2
1242	2020-05-30	0ltdf8b0ghll86hfa4otaevhmg	1	2
1243	2019-06-07	708o38dop84c62h45j2g4d9p7e	3	2
1244	2019-06-08	708o38dop84c62h45j2g4d9p7e	3	2
1245	2019-06-09	708o38dop84c62h45j2g4d9p7e	3	2
1246	2019-06-15	2g6160j0rbuebcne3jvl2qu5uu	3	2
1247	2019-06-16	2g6160j0rbuebcne3jvl2qu5uu	3	2
1248	2019-06-21	04ebuaj23l3530rhqcc6asj30c	3	2
1249	2019-06-22	04ebuaj23l3530rhqcc6asj30c	3	2
1250	2019-06-23	04ebuaj23l3530rhqcc6asj30c	3	2
1251	2019-06-28	50gk2aor53opkr0qtr49qlskfq	3	2
1252	2019-06-29	50gk2aor53opkr0qtr49qlskfq	3	2
1253	2019-06-30	50gk2aor53opkr0qtr49qlskfq	3	2
1254	2019-07-05	3pk8k3vm8pikcpkqg16bn730td	3	2
1255	2019-07-06	3pk8k3vm8pikcpkqg16bn730td	3	2
1256	2019-07-07	3pk8k3vm8pikcpkqg16bn730td	3	2
1257	2019-07-12	6vscel44vmikmq37urrms4urue	3	2
1258	2019-07-13	6vscel44vmikmq37urrms4urue	3	2
1259	2019-07-14	6vscel44vmikmq37urrms4urue	3	2
1260	2019-07-20	27ks1sdipejvpl22nluefpln8f	3	2
1261	2019-07-21	27ks1sdipejvpl22nluefpln8f	3	2
1262	2019-07-26	3m3pc652slbv3q4mcpq21qbdt6	3	2
1263	2019-07-27	3m3pc652slbv3q4mcpq21qbdt6	3	2
1264	2019-07-28	3m3pc652slbv3q4mcpq21qbdt6	3	2
1265	2019-07-29	3m3pc652slbv3q4mcpq21qbdt6	3	2
1266	2019-07-30	3m3pc652slbv3q4mcpq21qbdt6	3	2
1267	2019-07-31	3m3pc652slbv3q4mcpq21qbdt6	3	2
1268	2019-08-01	3m3pc652slbv3q4mcpq21qbdt6	3	2
1269	2019-08-02	3m3pc652slbv3q4mcpq21qbdt6	3	2
1270	2019-08-03	3m3pc652slbv3q4mcpq21qbdt6	3	2
1271	2019-08-04	3m3pc652slbv3q4mcpq21qbdt6	3	2
1272	2019-08-05	3m3pc652slbv3q4mcpq21qbdt6	3	2
1273	2019-08-06	3m3pc652slbv3q4mcpq21qbdt6	3	2
1274	2019-08-07	3m3pc652slbv3q4mcpq21qbdt6	3	2
1275	2019-08-08	3m3pc652slbv3q4mcpq21qbdt6	3	2
1276	2019-08-09	3m3pc652slbv3q4mcpq21qbdt6	3	2
1277	2019-08-10	3m3pc652slbv3q4mcpq21qbdt6	3	2
1278	2019-08-11	3m3pc652slbv3q4mcpq21qbdt6	3	2
1279	2019-08-12	3m3pc652slbv3q4mcpq21qbdt6	3	2
1280	2019-08-13	3m3pc652slbv3q4mcpq21qbdt6	3	2
1281	2019-08-14	3m3pc652slbv3q4mcpq21qbdt6	3	2
1282	2019-08-15	3m3pc652slbv3q4mcpq21qbdt6	3	2
1283	2019-08-16	3m3pc652slbv3q4mcpq21qbdt6	3	2
1284	2019-08-17	3m3pc652slbv3q4mcpq21qbdt6	3	2
1285	2019-08-18	3m3pc652slbv3q4mcpq21qbdt6	3	2
1286	2019-08-19	3m3pc652slbv3q4mcpq21qbdt6	3	2
1287	2019-08-20	3m3pc652slbv3q4mcpq21qbdt6	3	2
1288	2019-08-21	3m3pc652slbv3q4mcpq21qbdt6	3	2
1289	2019-08-22	3m3pc652slbv3q4mcpq21qbdt6	3	2
1290	2019-08-23	3m3pc652slbv3q4mcpq21qbdt6	3	2
1291	2019-08-24	3m3pc652slbv3q4mcpq21qbdt6	3	2
1292	2019-08-25	3m3pc652slbv3q4mcpq21qbdt6	3	2
1293	2019-08-26	3m3pc652slbv3q4mcpq21qbdt6	3	2
1294	2019-08-27	3m3pc652slbv3q4mcpq21qbdt6	3	2
1295	2019-08-28	3m3pc652slbv3q4mcpq21qbdt6	3	2
1296	2019-08-29	3m3pc652slbv3q4mcpq21qbdt6	3	2
1297	2019-08-30	3m3pc652slbv3q4mcpq21qbdt6	3	2
1298	2019-08-31	3m3pc652slbv3q4mcpq21qbdt6	3	2
1299	2019-09-01	3m3pc652slbv3q4mcpq21qbdt6	3	2
1300	2019-09-02	3m3pc652slbv3q4mcpq21qbdt6	3	2
1301	2019-09-07	1vhu01f03h3359bp6t45vs8rlp	3	2
1302	2019-09-08	1vhu01f03h3359bp6t45vs8rlp	3	2
1303	2019-09-10	3muk5ihb604flevopium0vs61b	3	2
1304	2019-09-11	3muk5ihb604flevopium0vs61b	3	2
1305	2019-09-12	3muk5ihb604flevopium0vs61b	3	2
1306	2019-09-13	3muk5ihb604flevopium0vs61b	3	2
1307	2019-09-14	3muk5ihb604flevopium0vs61b	3	2
1308	2019-09-15	3muk5ihb604flevopium0vs61b	3	2
1309	2019-09-16	3muk5ihb604flevopium0vs61b	3	2
1310	2019-09-17	3muk5ihb604flevopium0vs61b	3	2
1311	2019-09-18	3muk5ihb604flevopium0vs61b	3	2
1312	2019-09-19	3muk5ihb604flevopium0vs61b	3	2
1313	2019-09-20	3muk5ihb604flevopium0vs61b	3	2
1314	2019-09-21	3muk5ihb604flevopium0vs61b	3	2
1315	2019-09-22	3muk5ihb604flevopium0vs61b	3	2
1316	2019-09-23	3muk5ihb604flevopium0vs61b	3	2
1317	2019-09-24	3muk5ihb604flevopium0vs61b	3	2
1318	2019-09-27	4g480cafsr5bg589e0gqf0lm3d	3	2
1319	2019-09-28	4g480cafsr5bg589e0gqf0lm3d	3	2
1320	2019-09-29	4g480cafsr5bg589e0gqf0lm3d	3	2
1321	2019-10-04	4g0kb4r415p2fttpqgf0c5k7dn	3	2
1322	2019-10-05	4g0kb4r415p2fttpqgf0c5k7dn	3	2
1323	2019-10-06	4g0kb4r415p2fttpqgf0c5k7dn	3	2
1324	2019-10-18	640foueuc3vtqnf6ta6to9okoa	2	2
1325	2019-10-20	6o1ifar0v212fb5rmk7v5pfb4g	2	2
1326	2019-10-25	6h9g5jp682h8pk6vrdbn78ig05	2	2
1327	2019-10-26	6h9g5jp682h8pk6vrdbn78ig05	2	2
1328	2019-10-27	6h9g5jp682h8pk6vrdbn78ig05	2	2
1329	2019-11-01	07dje9b74u2767ommqjlgo7mle	2	2
1330	2019-11-02	07dje9b74u2767ommqjlgo7mle	2	2
1331	2019-11-03	07dje9b74u2767ommqjlgo7mle	2	2
1332	2020-05-31	7bhl4k7tv3gpe89bf2041ote49	1	2
1333	2020-06-01	5rvd7i503d03euvg3cgmldn3kl	1	2
1334	2020-06-05	15q88m1e9esaf8r04e7t6kk8he	1	2
1335	2020-06-06	6veiaj8lem4kerbllnka7dqmoa	1	2
1336	2020-06-07	4s68ilpoe1ed14leadhldpdaar	1	2
1374	2020-09-04	5kgm6pa50t6f13qabjqmfu4ck3	1	2
1375	2020-09-05	65f7prdpqtm9trpsd7vpkpt27a	1	2
1376	2020-09-06	65f7prdpqtm9trpsd7vpkpt27a	1	2
1377	2020-06-12	774agd65bdaaoer44hrrmteug8	1	2
1378	2020-06-13	1v9su3k9qufq1l293vvk1ab4d8	1	2
1379	2020-06-14	5ertuj45ts4aql35uc7m9dcnvm	1	2
1380	2020-09-18	45n1tj6qcbons8cks4oi50kpq4	1	2
1381	2020-09-19	3q6cc5s9ki52rsso2b6bccekki	1	2
1382	2020-09-20	3q6cc5s9ki52rsso2b6bccekki	1	2
1383	2020-09-25	0adgni4e2sci5s1dedcm5f8k0u	1	2
1384	2020-09-26	67boe3mpc3v2nvqo4mk4omso9v	1	2
1385	2020-09-27	67boe3mpc3v2nvqo4mk4omso9v	1	2
1386	2020-10-02	4m4t82is2bo89c29kf79mjueo0	1	2
1387	2020-10-03	3jjcrnia1b321ui608d5u699dt	1	2
1388	2020-10-04	3jjcrnia1b321ui608d5u699dt	1	2
1389	2020-10-09	3s5oslnaf000990fv8seh9647d	1	2
1390	2020-10-10	0ov0uja2g1g08rutnnj6cf6hkr	1	2
1391	2020-10-11	0ov0uja2g1g08rutnnj6cf6hkr	1	2
1392	2020-10-16	4dsem0vgai2u7scvoba7urf5v2	1	2
1393	2020-10-17	10bjj7hnrod2lghk3hjoggpakk	1	2
1394	2020-10-18	10bjj7hnrod2lghk3hjoggpakk	1	2
1395	2020-10-23	6hflj7kku7bo753unrc74c6lqm	1	2
1396	2020-10-24	0aqanmcgggtod43etmhht25523	1	2
1397	2020-10-25	0aqanmcgggtod43etmhht25523	1	2
1398	2017-06-15	2r51cabm6mdkl00v5g41unh6nl	3	2
1399	2017-06-16	2r51cabm6mdkl00v5g41unh6nl	3	2
1400	2017-06-17	2r51cabm6mdkl00v5g41unh6nl	3	2
1401	2017-06-18	2r51cabm6mdkl00v5g41unh6nl	3	2
1402	2017-06-19	2r51cabm6mdkl00v5g41unh6nl	3	2
1403	2017-06-20	2r51cabm6mdkl00v5g41unh6nl	3	2
1404	2017-07-07	2kcauah9fue4ak29gbkr237slg	3	2
1405	2017-07-08	2kcauah9fue4ak29gbkr237slg	3	2
1406	2017-07-09	2kcauah9fue4ak29gbkr237slg	3	2
1407	2017-09-09	480v36hb481t5c69vtj8nv1nm0	3	2
1408	2017-09-10	480v36hb481t5c69vtj8nv1nm0	3	2
1409	2020-06-19	5466k3lr6jbjddaaqh1hf9g0po	1	2
1410	2020-06-20	5466k3lr6jbjddaaqh1hf9g0po	1	2
1411	2020-06-21	5466k3lr6jbjddaaqh1hf9g0po	1	2
1412	2020-06-26	22p64i9kj9ae4s63usa0j2fp0h	1	2
1413	2020-06-27	22p64i9kj9ae4s63usa0j2fp0h	1	2
1414	2020-06-28	22p64i9kj9ae4s63usa0j2fp0h	1	2
1418	2020-07-03	7f84ptjnuacvemc2u9rihcr1ug	1	1
1419	2020-07-04	7f84ptjnuacvemc2u9rihcr1ug	1	1
1420	2020-07-05	7f84ptjnuacvemc2u9rihcr1ug	1	1
1421	2020-07-03	65v181q95dkfkcql4qoll95p44	1	2
1422	2020-07-04	65v181q95dkfkcql4qoll95p44	1	2
1423	2020-07-05	65v181q95dkfkcql4qoll95p44	1	2
1426	2020-07-18	3v4qj0qua89uj5car5bss5ga88	1	2
1427	2020-07-19	3v4qj0qua89uj5car5bss5ga88	1	2
1428	2020-07-25	42v5d5uco1fmilh1t107md1rrd	1	2
1429	2020-07-26	42v5d5uco1fmilh1t107md1rrd	1	2
1473	2020-09-05	6bq8hqb6bp1n0549kk8ic7tcl0	1	1
1474	2020-09-06	0ruabnbv2pf9jhcv3oj5lo86bl	1	1
1475	2020-09-04	5oneenc6h97aepbo1b9vcvqsq0	1	1
1517	2020-07-23	2hfo1hijtn55ecvffv2b2tak04	1	1
1518	2020-07-24	2hfo1hijtn55ecvffv2b2tak04	1	1
1519	2020-07-25	2hfo1hijtn55ecvffv2b2tak04	1	1
1520	2020-07-26	2hfo1hijtn55ecvffv2b2tak04	1	1
1521	2020-07-27	2hfo1hijtn55ecvffv2b2tak04	1	1
1522	2020-07-28	2hfo1hijtn55ecvffv2b2tak04	1	1
1523	2020-07-29	2hfo1hijtn55ecvffv2b2tak04	1	1
1524	2020-07-30	2hfo1hijtn55ecvffv2b2tak04	1	1
1525	2020-07-31	2hfo1hijtn55ecvffv2b2tak04	1	1
1526	2020-08-01	2hfo1hijtn55ecvffv2b2tak04	1	1
1527	2020-08-02	2hfo1hijtn55ecvffv2b2tak04	1	1
1528	2020-08-03	2hfo1hijtn55ecvffv2b2tak04	1	1
1529	2020-08-04	2hfo1hijtn55ecvffv2b2tak04	1	1
1530	2020-08-05	2hfo1hijtn55ecvffv2b2tak04	1	1
1531	2020-08-06	2hfo1hijtn55ecvffv2b2tak04	1	1
1532	2020-08-07	2hfo1hijtn55ecvffv2b2tak04	1	1
1533	2020-08-08	2hfo1hijtn55ecvffv2b2tak04	1	1
1534	2020-08-09	2hfo1hijtn55ecvffv2b2tak04	1	1
1535	2020-08-10	2hfo1hijtn55ecvffv2b2tak04	1	1
1536	2020-08-11	2hfo1hijtn55ecvffv2b2tak04	1	1
1537	2020-08-12	2hfo1hijtn55ecvffv2b2tak04	1	1
1538	2020-08-13	2hfo1hijtn55ecvffv2b2tak04	1	1
1539	2020-08-14	2hfo1hijtn55ecvffv2b2tak04	1	1
1540	2020-08-15	2hfo1hijtn55ecvffv2b2tak04	1	1
1541	2020-08-16	2hfo1hijtn55ecvffv2b2tak04	1	1
1542	2020-08-17	2hfo1hijtn55ecvffv2b2tak04	1	1
1543	2020-08-18	2hfo1hijtn55ecvffv2b2tak04	1	1
1544	2020-08-19	2hfo1hijtn55ecvffv2b2tak04	1	1
1545	2020-08-20	2hfo1hijtn55ecvffv2b2tak04	1	1
1546	2020-08-21	2hfo1hijtn55ecvffv2b2tak04	1	1
1547	2020-08-22	2hfo1hijtn55ecvffv2b2tak04	1	1
1548	2020-08-23	2hfo1hijtn55ecvffv2b2tak04	1	1
1549	2020-08-24	2hfo1hijtn55ecvffv2b2tak04	1	1
1550	2020-08-25	2hfo1hijtn55ecvffv2b2tak04	1	1
1551	2020-08-26	2hfo1hijtn55ecvffv2b2tak04	1	1
1552	2020-08-27	2hfo1hijtn55ecvffv2b2tak04	1	1
1553	2020-08-28	2hfo1hijtn55ecvffv2b2tak04	1	1
1554	2020-08-29	2hfo1hijtn55ecvffv2b2tak04	1	1
1555	2020-08-30	2hfo1hijtn55ecvffv2b2tak04	1	1
1556	2020-08-31	2hfo1hijtn55ecvffv2b2tak04	1	1
1557	2020-09-26	4pm9e9lduvris719slbdt6qu3b	1	1
1558	2020-09-27	4pm9e9lduvris719slbdt6qu3b	1	1
1559	2020-10-02	69hc6jrvkfmruiti0csq7rr0bf	1	1
1560	2020-10-03	06vccj0j9q4tlm43grjr1c0cks	1	1
1561	2020-10-04	06vccj0j9q4tlm43grjr1c0cks	1	1
1562	2020-10-09	65ukrbjgs2hc09uh08ed5n91ru	1	1
1563	2020-07-30	753gklu942s0vcp6s3v7v1jiqt	1	2
1564	2020-07-31	753gklu942s0vcp6s3v7v1jiqt	1	2
1565	2020-08-01	753gklu942s0vcp6s3v7v1jiqt	1	2
1566	2020-08-02	753gklu942s0vcp6s3v7v1jiqt	1	2
1567	2020-08-03	753gklu942s0vcp6s3v7v1jiqt	1	2
1568	2020-08-04	753gklu942s0vcp6s3v7v1jiqt	1	2
1569	2020-08-05	753gklu942s0vcp6s3v7v1jiqt	1	2
1570	2020-08-06	753gklu942s0vcp6s3v7v1jiqt	1	2
1571	2020-08-07	753gklu942s0vcp6s3v7v1jiqt	1	2
1572	2020-08-08	753gklu942s0vcp6s3v7v1jiqt	1	2
1573	2020-08-09	753gklu942s0vcp6s3v7v1jiqt	1	2
1574	2020-08-10	753gklu942s0vcp6s3v7v1jiqt	1	2
1575	2020-08-11	753gklu942s0vcp6s3v7v1jiqt	1	2
1576	2020-08-12	753gklu942s0vcp6s3v7v1jiqt	1	2
1577	2020-08-13	753gklu942s0vcp6s3v7v1jiqt	1	2
1578	2020-08-14	753gklu942s0vcp6s3v7v1jiqt	1	2
1579	2020-08-15	753gklu942s0vcp6s3v7v1jiqt	1	2
1580	2020-08-16	753gklu942s0vcp6s3v7v1jiqt	1	2
1581	2020-08-17	753gklu942s0vcp6s3v7v1jiqt	1	2
1582	2020-08-18	753gklu942s0vcp6s3v7v1jiqt	1	2
1583	2020-08-19	753gklu942s0vcp6s3v7v1jiqt	1	2
1584	2020-08-20	753gklu942s0vcp6s3v7v1jiqt	1	2
1585	2020-08-21	753gklu942s0vcp6s3v7v1jiqt	1	2
1586	2020-08-22	753gklu942s0vcp6s3v7v1jiqt	1	2
1587	2020-08-23	753gklu942s0vcp6s3v7v1jiqt	1	2
1588	2020-08-24	753gklu942s0vcp6s3v7v1jiqt	1	2
1589	2020-08-25	753gklu942s0vcp6s3v7v1jiqt	1	2
1590	2020-08-26	753gklu942s0vcp6s3v7v1jiqt	1	2
1591	2020-08-27	753gklu942s0vcp6s3v7v1jiqt	1	2
1592	2020-08-28	753gklu942s0vcp6s3v7v1jiqt	1	2
1593	2020-08-29	753gklu942s0vcp6s3v7v1jiqt	1	2
1594	2020-08-30	753gklu942s0vcp6s3v7v1jiqt	1	2
1595	2020-08-31	753gklu942s0vcp6s3v7v1jiqt	1	2
1596	2020-09-01	753gklu942s0vcp6s3v7v1jiqt	1	2
1597	2020-10-10	4hems4v2ve4p0j0cbgh46md6bv	1	1
1598	2020-10-11	4hems4v2ve4p0j0cbgh46md6bv	1	1
1599	2020-10-24	07mnk99h9fjbb67i13sr5j060k	1	1
1600	2020-10-25	07mnk99h9fjbb67i13sr5j060k	1	1
1601	2020-11-06	5teqmk8jdpb16of9ntm29nohj5	1	1
1602	2020-11-07	77t70l6k3ai1u0rlq19tneh6rc	1	1
1603	2020-11-08	77t70l6k3ai1u0rlq19tneh6rc	1	1
1604	2020-11-06	3g98knut3li6cam3jao0gonlr1	1	2
1605	2020-11-07	0ho451selri8878s7uar98ddj6	1	2
1606	2020-11-08	0ho451selri8878s7uar98ddj6	1	2
1607	2020-09-18	5ga7huoq9rb9e3b4virc6hi88u	1	1
1608	2020-09-19	20mr004gs6rfo0t775br6klg8h	1	1
1609	2020-09-20	44940hplk2v7ve3b187jo3hf0b	1	1
1610	2020-09-12	1600m331u2od1uqkvoqd1e34je	1	2
1611	2020-09-13	1600m331u2od1uqkvoqd1e34je	1	2
1612	2020-09-11	5gpm5efkgo5f4g0j02j81kg58v	1	2
1614	2020-07-10	06eqgjg8bd2ril90lus4du7uqh	1	1
1615	2020-07-11	54r0oos8c2r2demb7mns77lfs1	1	1
1616	2020-07-12	54r0oos8c2r2demb7mns77lfs1	1	1
1617	2020-07-11	1pqklekhvhthemqe06bp6dmami	1	2
1618	2020-07-12	1pqklekhvhthemqe06bp6dmami	1	2
\.


--
-- Data for Name: dissolution_days; Type: TABLE DATA; Schema: public; Owner: robert
--

COPY public.dissolution_days (id, date, google_event_id, dissolution_period_id) FROM stdin;
1	1802-06-30	\N	1
2	1802-07-01	\N	1
3	1802-07-02	\N	1
4	1802-07-03	\N	1
5	1802-07-04	\N	1
6	1802-07-05	\N	1
7	1802-07-06	\N	1
8	1802-07-07	\N	1
9	1802-07-08	\N	1
10	1802-07-09	\N	1
11	1802-07-10	\N	1
12	1802-07-11	\N	1
13	1802-07-12	\N	1
14	1802-07-13	\N	1
15	1802-07-14	\N	1
16	1802-07-15	\N	1
17	1802-07-16	\N	1
18	1802-07-17	\N	1
19	1802-07-18	\N	1
20	1802-07-19	\N	1
21	1802-07-20	\N	1
22	1802-07-21	\N	1
23	1802-07-22	\N	1
24	1802-07-23	\N	1
25	1802-07-24	\N	1
26	1802-07-25	\N	1
27	1802-07-26	\N	1
28	1802-07-27	\N	1
29	1802-07-28	\N	1
30	1802-07-29	\N	1
31	1802-07-30	\N	1
32	1802-07-31	\N	1
33	1802-08-01	\N	1
34	1802-08-02	\N	1
35	1802-08-03	\N	1
36	1802-08-04	\N	1
37	1802-08-05	\N	1
38	1802-08-06	\N	1
39	1802-08-07	\N	1
40	1802-08-08	\N	1
41	1802-08-09	\N	1
42	1802-08-10	\N	1
43	1802-08-11	\N	1
44	1802-08-12	\N	1
45	1802-08-13	\N	1
46	1802-08-14	\N	1
47	1802-08-15	\N	1
48	1802-08-16	\N	1
49	1802-08-17	\N	1
50	1802-08-18	\N	1
51	1802-08-19	\N	1
52	1802-08-20	\N	1
53	1802-08-21	\N	1
54	1802-08-22	\N	1
55	1802-08-23	\N	1
56	1802-08-24	\N	1
57	1802-08-25	\N	1
58	1802-08-26	\N	1
59	1802-08-27	\N	1
60	1802-08-28	\N	1
61	1802-08-29	\N	1
62	1802-08-30	\N	1
63	1802-08-31	\N	1
64	1802-09-01	\N	1
65	1802-09-02	\N	1
66	1802-09-03	\N	1
67	1802-09-04	\N	1
68	1802-09-05	\N	1
69	1802-09-06	\N	1
70	1802-09-07	\N	1
71	1802-09-08	\N	1
72	1802-09-09	\N	1
73	1802-09-10	\N	1
74	1802-09-11	\N	1
75	1802-09-12	\N	1
76	1802-09-13	\N	1
77	1802-09-14	\N	1
78	1802-09-15	\N	1
79	1802-09-16	\N	1
80	1802-09-17	\N	1
81	1802-09-18	\N	1
82	1802-09-19	\N	1
83	1802-09-20	\N	1
84	1802-09-21	\N	1
85	1802-09-22	\N	1
86	1802-09-23	\N	1
87	1802-09-24	\N	1
88	1802-09-25	\N	1
89	1802-09-26	\N	1
90	1802-09-27	\N	1
91	1802-09-28	\N	1
92	1802-09-29	\N	1
93	1802-09-30	\N	1
94	1802-10-01	\N	1
95	1802-10-02	\N	1
96	1802-10-03	\N	1
97	1802-10-04	\N	1
98	1802-10-05	\N	1
99	1802-10-06	\N	1
100	1802-10-07	\N	1
101	1802-10-08	\N	1
102	1802-10-09	\N	1
103	1802-10-10	\N	1
104	1802-10-11	\N	1
105	1802-10-12	\N	1
106	1802-10-13	\N	1
107	1802-10-14	\N	1
108	1802-10-15	\N	1
109	1802-10-16	\N	1
110	1802-10-17	\N	1
111	1802-10-18	\N	1
112	1802-10-19	\N	1
113	1802-10-20	\N	1
114	1802-10-21	\N	1
115	1802-10-22	\N	1
116	1802-10-23	\N	1
117	1802-10-24	\N	1
118	1802-10-25	\N	1
119	1802-10-26	\N	1
120	1802-10-27	\N	1
121	1802-10-28	\N	1
122	1802-10-29	\N	1
123	1802-10-30	\N	1
124	1802-10-31	\N	1
125	1802-11-01	\N	1
126	1802-11-02	\N	1
127	1802-11-03	\N	1
128	1802-11-04	\N	1
129	1802-11-05	\N	1
130	1802-11-06	\N	1
131	1802-11-07	\N	1
132	1802-11-08	\N	1
133	1802-11-09	\N	1
134	1802-11-10	\N	1
135	1802-11-11	\N	1
136	1802-11-12	\N	1
137	1802-11-13	\N	1
138	1802-11-14	\N	1
139	1802-11-15	\N	1
140	1806-10-25	\N	2
141	1806-10-26	\N	2
142	1806-10-27	\N	2
143	1806-10-28	\N	2
144	1806-10-29	\N	2
145	1806-10-30	\N	2
146	1806-10-31	\N	2
147	1806-11-01	\N	2
148	1806-11-02	\N	2
149	1806-11-03	\N	2
150	1806-11-04	\N	2
151	1806-11-05	\N	2
152	1806-11-06	\N	2
153	1806-11-07	\N	2
154	1806-11-08	\N	2
155	1806-11-09	\N	2
156	1806-11-10	\N	2
157	1806-11-11	\N	2
158	1806-11-12	\N	2
159	1806-11-13	\N	2
160	1806-11-14	\N	2
161	1806-11-15	\N	2
162	1806-11-16	\N	2
163	1806-11-17	\N	2
164	1806-11-18	\N	2
165	1806-11-19	\N	2
166	1806-11-20	\N	2
167	1806-11-21	\N	2
168	1806-11-22	\N	2
169	1806-11-23	\N	2
170	1806-11-24	\N	2
171	1806-11-25	\N	2
172	1806-11-26	\N	2
173	1806-11-27	\N	2
174	1806-11-28	\N	2
175	1806-11-29	\N	2
176	1806-11-30	\N	2
177	1806-12-01	\N	2
178	1806-12-02	\N	2
179	1806-12-03	\N	2
180	1806-12-04	\N	2
181	1806-12-05	\N	2
182	1806-12-06	\N	2
183	1806-12-07	\N	2
184	1806-12-08	\N	2
185	1806-12-09	\N	2
186	1806-12-10	\N	2
187	1806-12-11	\N	2
188	1806-12-12	\N	2
189	1806-12-13	\N	2
190	1806-12-14	\N	2
191	1807-04-30	\N	3
192	1807-05-01	\N	3
193	1807-05-02	\N	3
194	1807-05-03	\N	3
195	1807-05-04	\N	3
196	1807-05-05	\N	3
197	1807-05-06	\N	3
198	1807-05-07	\N	3
199	1807-05-08	\N	3
200	1807-05-09	\N	3
201	1807-05-10	\N	3
202	1807-05-11	\N	3
203	1807-05-12	\N	3
204	1807-05-13	\N	3
205	1807-05-14	\N	3
206	1807-05-15	\N	3
207	1807-05-16	\N	3
208	1807-05-17	\N	3
209	1807-05-18	\N	3
210	1807-05-19	\N	3
211	1807-05-20	\N	3
212	1807-05-21	\N	3
213	1807-05-22	\N	3
214	1807-05-23	\N	3
215	1807-05-24	\N	3
216	1807-05-25	\N	3
217	1807-05-26	\N	3
218	1807-05-27	\N	3
219	1807-05-28	\N	3
220	1807-05-29	\N	3
221	1807-05-30	\N	3
222	1807-05-31	\N	3
223	1807-06-01	\N	3
224	1807-06-02	\N	3
225	1807-06-03	\N	3
226	1807-06-04	\N	3
227	1807-06-05	\N	3
228	1807-06-06	\N	3
229	1807-06-07	\N	3
230	1807-06-08	\N	3
231	1807-06-09	\N	3
232	1807-06-10	\N	3
233	1807-06-11	\N	3
234	1807-06-12	\N	3
235	1807-06-13	\N	3
236	1807-06-14	\N	3
237	1807-06-15	\N	3
238	1807-06-16	\N	3
239	1807-06-17	\N	3
240	1807-06-18	\N	3
241	1807-06-19	\N	3
242	1807-06-20	\N	3
243	1807-06-21	\N	3
244	1812-09-30	\N	4
245	1812-10-01	\N	4
246	1812-10-02	\N	4
247	1812-10-03	\N	4
248	1812-10-04	\N	4
249	1812-10-05	\N	4
250	1812-10-06	\N	4
251	1812-10-07	\N	4
252	1812-10-08	\N	4
253	1812-10-09	\N	4
254	1812-10-10	\N	4
255	1812-10-11	\N	4
256	1812-10-12	\N	4
257	1812-10-13	\N	4
258	1812-10-14	\N	4
259	1812-10-15	\N	4
260	1812-10-16	\N	4
261	1812-10-17	\N	4
262	1812-10-18	\N	4
263	1812-10-19	\N	4
264	1812-10-20	\N	4
265	1812-10-21	\N	4
266	1812-10-22	\N	4
267	1812-10-23	\N	4
268	1812-10-24	\N	4
269	1812-10-25	\N	4
270	1812-10-26	\N	4
271	1812-10-27	\N	4
272	1812-10-28	\N	4
273	1812-10-29	\N	4
274	1812-10-30	\N	4
275	1812-10-31	\N	4
276	1812-11-01	\N	4
277	1812-11-02	\N	4
278	1812-11-03	\N	4
279	1812-11-04	\N	4
280	1812-11-05	\N	4
281	1812-11-06	\N	4
282	1812-11-07	\N	4
283	1812-11-08	\N	4
284	1812-11-09	\N	4
285	1812-11-10	\N	4
286	1812-11-11	\N	4
287	1812-11-12	\N	4
288	1812-11-13	\N	4
289	1812-11-14	\N	4
290	1812-11-15	\N	4
291	1812-11-16	\N	4
292	1812-11-17	\N	4
293	1812-11-18	\N	4
294	1812-11-19	\N	4
295	1812-11-20	\N	4
296	1812-11-21	\N	4
297	1812-11-22	\N	4
298	1812-11-23	\N	4
299	1818-06-11	\N	5
300	1818-06-12	\N	5
301	1818-06-13	\N	5
302	1818-06-14	\N	5
303	1818-06-15	\N	5
304	1818-06-16	\N	5
305	1818-06-17	\N	5
306	1818-06-18	\N	5
307	1818-06-19	\N	5
308	1818-06-20	\N	5
309	1818-06-21	\N	5
310	1818-06-22	\N	5
311	1818-06-23	\N	5
312	1818-06-24	\N	5
313	1818-06-25	\N	5
314	1818-06-26	\N	5
315	1818-06-27	\N	5
316	1818-06-28	\N	5
317	1818-06-29	\N	5
318	1818-06-30	\N	5
319	1818-07-01	\N	5
320	1818-07-02	\N	5
321	1818-07-03	\N	5
322	1818-07-04	\N	5
323	1818-07-05	\N	5
324	1818-07-06	\N	5
325	1818-07-07	\N	5
326	1818-07-08	\N	5
327	1818-07-09	\N	5
328	1818-07-10	\N	5
329	1818-07-11	\N	5
330	1818-07-12	\N	5
331	1818-07-13	\N	5
332	1818-07-14	\N	5
333	1818-07-15	\N	5
334	1818-07-16	\N	5
335	1818-07-17	\N	5
336	1818-07-18	\N	5
337	1818-07-19	\N	5
338	1818-07-20	\N	5
339	1818-07-21	\N	5
340	1818-07-22	\N	5
341	1818-07-23	\N	5
342	1818-07-24	\N	5
343	1818-07-25	\N	5
344	1818-07-26	\N	5
345	1818-07-27	\N	5
346	1818-07-28	\N	5
347	1818-07-29	\N	5
348	1818-07-30	\N	5
349	1818-07-31	\N	5
350	1818-08-01	\N	5
351	1818-08-02	\N	5
352	1818-08-03	\N	5
353	1818-08-04	\N	5
354	1818-08-05	\N	5
355	1818-08-06	\N	5
356	1818-08-07	\N	5
357	1818-08-08	\N	5
358	1818-08-09	\N	5
359	1818-08-10	\N	5
360	1818-08-11	\N	5
361	1818-08-12	\N	5
362	1818-08-13	\N	5
363	1818-08-14	\N	5
364	1818-08-15	\N	5
365	1818-08-16	\N	5
366	1818-08-17	\N	5
367	1818-08-18	\N	5
368	1818-08-19	\N	5
369	1818-08-20	\N	5
370	1818-08-21	\N	5
371	1818-08-22	\N	5
372	1818-08-23	\N	5
373	1818-08-24	\N	5
374	1818-08-25	\N	5
375	1818-08-26	\N	5
376	1818-08-27	\N	5
377	1818-08-28	\N	5
378	1818-08-29	\N	5
379	1818-08-30	\N	5
380	1818-08-31	\N	5
381	1818-09-01	\N	5
382	1818-09-02	\N	5
383	1818-09-03	\N	5
384	1818-09-04	\N	5
385	1818-09-05	\N	5
386	1818-09-06	\N	5
387	1818-09-07	\N	5
388	1818-09-08	\N	5
389	1818-09-09	\N	5
390	1818-09-10	\N	5
391	1818-09-11	\N	5
392	1818-09-12	\N	5
393	1818-09-13	\N	5
394	1818-09-14	\N	5
395	1818-09-15	\N	5
396	1818-09-16	\N	5
397	1818-09-17	\N	5
398	1818-09-18	\N	5
399	1818-09-19	\N	5
400	1818-09-20	\N	5
401	1818-09-21	\N	5
402	1818-09-22	\N	5
403	1818-09-23	\N	5
404	1818-09-24	\N	5
405	1818-09-25	\N	5
406	1818-09-26	\N	5
407	1818-09-27	\N	5
408	1818-09-28	\N	5
409	1818-09-29	\N	5
410	1818-09-30	\N	5
411	1818-10-01	\N	5
412	1818-10-02	\N	5
413	1818-10-03	\N	5
414	1818-10-04	\N	5
415	1818-10-05	\N	5
416	1818-10-06	\N	5
417	1818-10-07	\N	5
418	1818-10-08	\N	5
419	1818-10-09	\N	5
420	1818-10-10	\N	5
421	1818-10-11	\N	5
422	1818-10-12	\N	5
423	1818-10-13	\N	5
424	1818-10-14	\N	5
425	1818-10-15	\N	5
426	1818-10-16	\N	5
427	1818-10-17	\N	5
428	1818-10-18	\N	5
429	1818-10-19	\N	5
430	1818-10-20	\N	5
431	1818-10-21	\N	5
432	1818-10-22	\N	5
433	1818-10-23	\N	5
434	1818-10-24	\N	5
435	1818-10-25	\N	5
436	1818-10-26	\N	5
437	1818-10-27	\N	5
438	1818-10-28	\N	5
439	1818-10-29	\N	5
440	1818-10-30	\N	5
441	1818-10-31	\N	5
442	1818-11-01	\N	5
443	1818-11-02	\N	5
444	1818-11-03	\N	5
445	1818-11-04	\N	5
446	1818-11-05	\N	5
447	1818-11-06	\N	5
448	1818-11-07	\N	5
449	1818-11-08	\N	5
450	1818-11-09	\N	5
451	1818-11-10	\N	5
452	1818-11-11	\N	5
453	1818-11-12	\N	5
454	1818-11-13	\N	5
455	1818-11-14	\N	5
456	1818-11-15	\N	5
457	1818-11-16	\N	5
458	1818-11-17	\N	5
459	1818-11-18	\N	5
460	1818-11-19	\N	5
461	1818-11-20	\N	5
462	1818-11-21	\N	5
463	1818-11-22	\N	5
464	1818-11-23	\N	5
465	1818-11-24	\N	5
466	1818-11-25	\N	5
467	1818-11-26	\N	5
468	1818-11-27	\N	5
469	1818-11-28	\N	5
470	1818-11-29	\N	5
471	1818-11-30	\N	5
472	1818-12-01	\N	5
473	1818-12-02	\N	5
474	1818-12-03	\N	5
475	1818-12-04	\N	5
476	1818-12-05	\N	5
477	1818-12-06	\N	5
478	1818-12-07	\N	5
479	1818-12-08	\N	5
480	1818-12-09	\N	5
481	1818-12-10	\N	5
482	1818-12-11	\N	5
483	1818-12-12	\N	5
484	1818-12-13	\N	5
485	1818-12-14	\N	5
486	1818-12-15	\N	5
487	1818-12-16	\N	5
488	1818-12-17	\N	5
489	1818-12-18	\N	5
490	1818-12-19	\N	5
491	1818-12-20	\N	5
492	1818-12-21	\N	5
493	1818-12-22	\N	5
494	1818-12-23	\N	5
495	1818-12-24	\N	5
496	1818-12-25	\N	5
497	1818-12-26	\N	5
498	1818-12-27	\N	5
499	1818-12-28	\N	5
500	1818-12-29	\N	5
501	1818-12-30	\N	5
502	1818-12-31	\N	5
503	1819-01-01	\N	5
504	1819-01-02	\N	5
505	1819-01-03	\N	5
506	1819-01-04	\N	5
507	1819-01-05	\N	5
508	1819-01-06	\N	5
509	1819-01-07	\N	5
510	1819-01-08	\N	5
511	1819-01-09	\N	5
512	1819-01-10	\N	5
513	1819-01-11	\N	5
514	1819-01-12	\N	5
515	1819-01-13	\N	5
516	1820-03-01	\N	6
517	1820-03-02	\N	6
518	1820-03-03	\N	6
519	1820-03-04	\N	6
520	1820-03-05	\N	6
521	1820-03-06	\N	6
522	1820-03-07	\N	6
523	1820-03-08	\N	6
524	1820-03-09	\N	6
525	1820-03-10	\N	6
526	1820-03-11	\N	6
527	1820-03-12	\N	6
528	1820-03-13	\N	6
529	1820-03-14	\N	6
530	1820-03-15	\N	6
531	1820-03-16	\N	6
532	1820-03-17	\N	6
533	1820-03-18	\N	6
534	1820-03-19	\N	6
535	1820-03-20	\N	6
536	1820-03-21	\N	6
537	1820-03-22	\N	6
538	1820-03-23	\N	6
539	1820-03-24	\N	6
540	1820-03-25	\N	6
541	1820-03-26	\N	6
542	1820-03-27	\N	6
543	1820-03-28	\N	6
544	1820-03-29	\N	6
545	1820-03-30	\N	6
546	1820-03-31	\N	6
547	1820-04-01	\N	6
548	1820-04-02	\N	6
549	1820-04-03	\N	6
550	1820-04-04	\N	6
551	1820-04-05	\N	6
552	1820-04-06	\N	6
553	1820-04-07	\N	6
554	1820-04-08	\N	6
555	1820-04-09	\N	6
556	1820-04-10	\N	6
557	1820-04-11	\N	6
558	1820-04-12	\N	6
559	1820-04-13	\N	6
560	1820-04-14	\N	6
561	1820-04-15	\N	6
562	1820-04-16	\N	6
563	1820-04-17	\N	6
564	1820-04-18	\N	6
565	1820-04-19	\N	6
566	1820-04-20	\N	6
567	1826-06-03	\N	7
568	1826-06-04	\N	7
569	1826-06-05	\N	7
570	1826-06-06	\N	7
571	1826-06-07	\N	7
572	1826-06-08	\N	7
573	1826-06-09	\N	7
574	1826-06-10	\N	7
575	1826-06-11	\N	7
576	1826-06-12	\N	7
577	1826-06-13	\N	7
578	1826-06-14	\N	7
579	1826-06-15	\N	7
580	1826-06-16	\N	7
581	1826-06-17	\N	7
582	1826-06-18	\N	7
583	1826-06-19	\N	7
584	1826-06-20	\N	7
585	1826-06-21	\N	7
586	1826-06-22	\N	7
587	1826-06-23	\N	7
588	1826-06-24	\N	7
589	1826-06-25	\N	7
590	1826-06-26	\N	7
591	1826-06-27	\N	7
592	1826-06-28	\N	7
593	1826-06-29	\N	7
594	1826-06-30	\N	7
595	1826-07-01	\N	7
596	1826-07-02	\N	7
597	1826-07-03	\N	7
598	1826-07-04	\N	7
599	1826-07-05	\N	7
600	1826-07-06	\N	7
601	1826-07-07	\N	7
602	1826-07-08	\N	7
603	1826-07-09	\N	7
604	1826-07-10	\N	7
605	1826-07-11	\N	7
606	1826-07-12	\N	7
607	1826-07-13	\N	7
608	1826-07-14	\N	7
609	1826-07-15	\N	7
610	1826-07-16	\N	7
611	1826-07-17	\N	7
612	1826-07-18	\N	7
613	1826-07-19	\N	7
614	1826-07-20	\N	7
615	1826-07-21	\N	7
616	1826-07-22	\N	7
617	1826-07-23	\N	7
618	1826-07-24	\N	7
619	1826-07-25	\N	7
620	1826-07-26	\N	7
621	1826-07-27	\N	7
622	1826-07-28	\N	7
623	1826-07-29	\N	7
624	1826-07-30	\N	7
625	1826-07-31	\N	7
626	1826-08-01	\N	7
627	1826-08-02	\N	7
628	1826-08-03	\N	7
629	1826-08-04	\N	7
630	1826-08-05	\N	7
631	1826-08-06	\N	7
632	1826-08-07	\N	7
633	1826-08-08	\N	7
634	1826-08-09	\N	7
635	1826-08-10	\N	7
636	1826-08-11	\N	7
637	1826-08-12	\N	7
638	1826-08-13	\N	7
639	1826-08-14	\N	7
640	1826-08-15	\N	7
641	1826-08-16	\N	7
642	1826-08-17	\N	7
643	1826-08-18	\N	7
644	1826-08-19	\N	7
645	1826-08-20	\N	7
646	1826-08-21	\N	7
647	1826-08-22	\N	7
648	1826-08-23	\N	7
649	1826-08-24	\N	7
650	1826-08-25	\N	7
651	1826-08-26	\N	7
652	1826-08-27	\N	7
653	1826-08-28	\N	7
654	1826-08-29	\N	7
655	1826-08-30	\N	7
656	1826-08-31	\N	7
657	1826-09-01	\N	7
658	1826-09-02	\N	7
659	1826-09-03	\N	7
660	1826-09-04	\N	7
661	1826-09-05	\N	7
662	1826-09-06	\N	7
663	1826-09-07	\N	7
664	1826-09-08	\N	7
665	1826-09-09	\N	7
666	1826-09-10	\N	7
667	1826-09-11	\N	7
668	1826-09-12	\N	7
669	1826-09-13	\N	7
670	1826-09-14	\N	7
671	1826-09-15	\N	7
672	1826-09-16	\N	7
673	1826-09-17	\N	7
674	1826-09-18	\N	7
675	1826-09-19	\N	7
676	1826-09-20	\N	7
677	1826-09-21	\N	7
678	1826-09-22	\N	7
679	1826-09-23	\N	7
680	1826-09-24	\N	7
681	1826-09-25	\N	7
682	1826-09-26	\N	7
683	1826-09-27	\N	7
684	1826-09-28	\N	7
685	1826-09-29	\N	7
686	1826-09-30	\N	7
687	1826-10-01	\N	7
688	1826-10-02	\N	7
689	1826-10-03	\N	7
690	1826-10-04	\N	7
691	1826-10-05	\N	7
692	1826-10-06	\N	7
693	1826-10-07	\N	7
694	1826-10-08	\N	7
695	1826-10-09	\N	7
696	1826-10-10	\N	7
697	1826-10-11	\N	7
698	1826-10-12	\N	7
699	1826-10-13	\N	7
700	1826-10-14	\N	7
701	1826-10-15	\N	7
702	1826-10-16	\N	7
703	1826-10-17	\N	7
704	1826-10-18	\N	7
705	1826-10-19	\N	7
706	1826-10-20	\N	7
707	1826-10-21	\N	7
708	1826-10-22	\N	7
709	1826-10-23	\N	7
710	1826-10-24	\N	7
711	1826-10-25	\N	7
712	1826-10-26	\N	7
713	1826-10-27	\N	7
714	1826-10-28	\N	7
715	1826-10-29	\N	7
716	1826-10-30	\N	7
717	1826-10-31	\N	7
718	1826-11-01	\N	7
719	1826-11-02	\N	7
720	1826-11-03	\N	7
721	1826-11-04	\N	7
722	1826-11-05	\N	7
723	1826-11-06	\N	7
724	1826-11-07	\N	7
725	1826-11-08	\N	7
726	1826-11-09	\N	7
727	1826-11-10	\N	7
728	1826-11-11	\N	7
729	1826-11-12	\N	7
730	1826-11-13	\N	7
731	1830-07-25	\N	8
732	1830-07-26	\N	8
733	1830-07-27	\N	8
734	1830-07-28	\N	8
735	1830-07-29	\N	8
736	1830-07-30	\N	8
737	1830-07-31	\N	8
738	1830-08-01	\N	8
739	1830-08-02	\N	8
740	1830-08-03	\N	8
741	1830-08-04	\N	8
742	1830-08-05	\N	8
743	1830-08-06	\N	8
744	1830-08-07	\N	8
745	1830-08-08	\N	8
746	1830-08-09	\N	8
747	1830-08-10	\N	8
748	1830-08-11	\N	8
749	1830-08-12	\N	8
750	1830-08-13	\N	8
751	1830-08-14	\N	8
752	1830-08-15	\N	8
753	1830-08-16	\N	8
754	1830-08-17	\N	8
755	1830-08-18	\N	8
756	1830-08-19	\N	8
757	1830-08-20	\N	8
758	1830-08-21	\N	8
759	1830-08-22	\N	8
760	1830-08-23	\N	8
761	1830-08-24	\N	8
762	1830-08-25	\N	8
763	1830-08-26	\N	8
764	1830-08-27	\N	8
765	1830-08-28	\N	8
766	1830-08-29	\N	8
767	1830-08-30	\N	8
768	1830-08-31	\N	8
769	1830-09-01	\N	8
770	1830-09-02	\N	8
771	1830-09-03	\N	8
772	1830-09-04	\N	8
773	1830-09-05	\N	8
774	1830-09-06	\N	8
775	1830-09-07	\N	8
776	1830-09-08	\N	8
777	1830-09-09	\N	8
778	1830-09-10	\N	8
779	1830-09-11	\N	8
780	1830-09-12	\N	8
781	1830-09-13	\N	8
782	1830-09-14	\N	8
783	1830-09-15	\N	8
784	1830-09-16	\N	8
785	1830-09-17	\N	8
786	1830-09-18	\N	8
787	1830-09-19	\N	8
788	1830-09-20	\N	8
789	1830-09-21	\N	8
790	1830-09-22	\N	8
791	1830-09-23	\N	8
792	1830-09-24	\N	8
793	1830-09-25	\N	8
794	1830-09-26	\N	8
795	1830-09-27	\N	8
796	1830-09-28	\N	8
797	1830-09-29	\N	8
798	1830-09-30	\N	8
799	1830-10-01	\N	8
800	1830-10-02	\N	8
801	1830-10-03	\N	8
802	1830-10-04	\N	8
803	1830-10-05	\N	8
804	1830-10-06	\N	8
805	1830-10-07	\N	8
806	1830-10-08	\N	8
807	1830-10-09	\N	8
808	1830-10-10	\N	8
809	1830-10-11	\N	8
810	1830-10-12	\N	8
811	1830-10-13	\N	8
812	1830-10-14	\N	8
813	1830-10-15	\N	8
814	1830-10-16	\N	8
815	1830-10-17	\N	8
816	1830-10-18	\N	8
817	1830-10-19	\N	8
818	1830-10-20	\N	8
819	1830-10-21	\N	8
820	1830-10-22	\N	8
821	1830-10-23	\N	8
822	1830-10-24	\N	8
823	1830-10-25	\N	8
824	1831-04-24	\N	9
825	1831-04-25	\N	9
826	1831-04-26	\N	9
827	1831-04-27	\N	9
828	1831-04-28	\N	9
829	1831-04-29	\N	9
830	1831-04-30	\N	9
831	1831-05-01	\N	9
832	1831-05-02	\N	9
833	1831-05-03	\N	9
834	1831-05-04	\N	9
835	1831-05-05	\N	9
836	1831-05-06	\N	9
837	1831-05-07	\N	9
838	1831-05-08	\N	9
839	1831-05-09	\N	9
840	1831-05-10	\N	9
841	1831-05-11	\N	9
842	1831-05-12	\N	9
843	1831-05-13	\N	9
844	1831-05-14	\N	9
845	1831-05-15	\N	9
846	1831-05-16	\N	9
847	1831-05-17	\N	9
848	1831-05-18	\N	9
849	1831-05-19	\N	9
850	1831-05-20	\N	9
851	1831-05-21	\N	9
852	1831-05-22	\N	9
853	1831-05-23	\N	9
854	1831-05-24	\N	9
855	1831-05-25	\N	9
856	1831-05-26	\N	9
857	1831-05-27	\N	9
858	1831-05-28	\N	9
859	1831-05-29	\N	9
860	1831-05-30	\N	9
861	1831-05-31	\N	9
862	1831-06-01	\N	9
863	1831-06-02	\N	9
864	1831-06-03	\N	9
865	1831-06-04	\N	9
866	1831-06-05	\N	9
867	1831-06-06	\N	9
868	1831-06-07	\N	9
869	1831-06-08	\N	9
870	1831-06-09	\N	9
871	1831-06-10	\N	9
872	1831-06-11	\N	9
873	1831-06-12	\N	9
874	1831-06-13	\N	9
875	1832-12-04	\N	10
876	1832-12-05	\N	10
877	1832-12-06	\N	10
878	1832-12-07	\N	10
879	1832-12-08	\N	10
880	1832-12-09	\N	10
881	1832-12-10	\N	10
882	1832-12-11	\N	10
883	1832-12-12	\N	10
884	1832-12-13	\N	10
885	1832-12-14	\N	10
886	1832-12-15	\N	10
887	1832-12-16	\N	10
888	1832-12-17	\N	10
889	1832-12-18	\N	10
890	1832-12-19	\N	10
891	1832-12-20	\N	10
892	1832-12-21	\N	10
893	1832-12-22	\N	10
894	1832-12-23	\N	10
895	1832-12-24	\N	10
896	1832-12-25	\N	10
897	1832-12-26	\N	10
898	1832-12-27	\N	10
899	1832-12-28	\N	10
900	1832-12-29	\N	10
901	1832-12-30	\N	10
902	1832-12-31	\N	10
903	1833-01-01	\N	10
904	1833-01-02	\N	10
905	1833-01-03	\N	10
906	1833-01-04	\N	10
907	1833-01-05	\N	10
908	1833-01-06	\N	10
909	1833-01-07	\N	10
910	1833-01-08	\N	10
911	1833-01-09	\N	10
912	1833-01-10	\N	10
913	1833-01-11	\N	10
914	1833-01-12	\N	10
915	1833-01-13	\N	10
916	1833-01-14	\N	10
917	1833-01-15	\N	10
918	1833-01-16	\N	10
919	1833-01-17	\N	10
920	1833-01-18	\N	10
921	1833-01-19	\N	10
922	1833-01-20	\N	10
923	1833-01-21	\N	10
924	1833-01-22	\N	10
925	1833-01-23	\N	10
926	1833-01-24	\N	10
927	1833-01-25	\N	10
928	1833-01-26	\N	10
929	1833-01-27	\N	10
930	1833-01-28	\N	10
931	1834-12-30	\N	11
932	1834-12-31	\N	11
933	1835-01-01	\N	11
934	1835-01-02	\N	11
935	1835-01-03	\N	11
936	1835-01-04	\N	11
937	1835-01-05	\N	11
938	1835-01-06	\N	11
939	1835-01-07	\N	11
940	1835-01-08	\N	11
941	1835-01-09	\N	11
942	1835-01-10	\N	11
943	1835-01-11	\N	11
944	1835-01-12	\N	11
945	1835-01-13	\N	11
946	1835-01-14	\N	11
947	1835-01-15	\N	11
948	1835-01-16	\N	11
949	1835-01-17	\N	11
950	1835-01-18	\N	11
951	1835-01-19	\N	11
952	1835-01-20	\N	11
953	1835-01-21	\N	11
954	1835-01-22	\N	11
955	1835-01-23	\N	11
956	1835-01-24	\N	11
957	1835-01-25	\N	11
958	1835-01-26	\N	11
959	1835-01-27	\N	11
960	1835-01-28	\N	11
961	1835-01-29	\N	11
962	1835-01-30	\N	11
963	1835-01-31	\N	11
964	1835-02-01	\N	11
965	1835-02-02	\N	11
966	1835-02-03	\N	11
967	1835-02-04	\N	11
968	1835-02-05	\N	11
969	1835-02-06	\N	11
970	1835-02-07	\N	11
971	1835-02-08	\N	11
972	1835-02-09	\N	11
973	1835-02-10	\N	11
974	1835-02-11	\N	11
975	1835-02-12	\N	11
976	1835-02-13	\N	11
977	1835-02-14	\N	11
978	1835-02-15	\N	11
979	1835-02-16	\N	11
980	1835-02-17	\N	11
981	1835-02-18	\N	11
982	1837-07-18	\N	12
983	1837-07-19	\N	12
984	1837-07-20	\N	12
985	1837-07-21	\N	12
986	1837-07-22	\N	12
987	1837-07-23	\N	12
988	1837-07-24	\N	12
989	1837-07-25	\N	12
990	1837-07-26	\N	12
991	1837-07-27	\N	12
992	1837-07-28	\N	12
993	1837-07-29	\N	12
994	1837-07-30	\N	12
995	1837-07-31	\N	12
996	1837-08-01	\N	12
997	1837-08-02	\N	12
998	1837-08-03	\N	12
999	1837-08-04	\N	12
1000	1837-08-05	\N	12
1001	1837-08-06	\N	12
1002	1837-08-07	\N	12
1003	1837-08-08	\N	12
1004	1837-08-09	\N	12
1005	1837-08-10	\N	12
1006	1837-08-11	\N	12
1007	1837-08-12	\N	12
1008	1837-08-13	\N	12
1009	1837-08-14	\N	12
1010	1837-08-15	\N	12
1011	1837-08-16	\N	12
1012	1837-08-17	\N	12
1013	1837-08-18	\N	12
1014	1837-08-19	\N	12
1015	1837-08-20	\N	12
1016	1837-08-21	\N	12
1017	1837-08-22	\N	12
1018	1837-08-23	\N	12
1019	1837-08-24	\N	12
1020	1837-08-25	\N	12
1021	1837-08-26	\N	12
1022	1837-08-27	\N	12
1023	1837-08-28	\N	12
1024	1837-08-29	\N	12
1025	1837-08-30	\N	12
1026	1837-08-31	\N	12
1027	1837-09-01	\N	12
1028	1837-09-02	\N	12
1029	1837-09-03	\N	12
1030	1837-09-04	\N	12
1031	1837-09-05	\N	12
1032	1837-09-06	\N	12
1033	1837-09-07	\N	12
1034	1837-09-08	\N	12
1035	1837-09-09	\N	12
1036	1837-09-10	\N	12
1037	1837-09-11	\N	12
1038	1837-09-12	\N	12
1039	1837-09-13	\N	12
1040	1837-09-14	\N	12
1041	1837-09-15	\N	12
1042	1837-09-16	\N	12
1043	1837-09-17	\N	12
1044	1837-09-18	\N	12
1045	1837-09-19	\N	12
1046	1837-09-20	\N	12
1047	1837-09-21	\N	12
1048	1837-09-22	\N	12
1049	1837-09-23	\N	12
1050	1837-09-24	\N	12
1051	1837-09-25	\N	12
1052	1837-09-26	\N	12
1053	1837-09-27	\N	12
1054	1837-09-28	\N	12
1055	1837-09-29	\N	12
1056	1837-09-30	\N	12
1057	1837-10-01	\N	12
1058	1837-10-02	\N	12
1059	1837-10-03	\N	12
1060	1837-10-04	\N	12
1061	1837-10-05	\N	12
1062	1837-10-06	\N	12
1063	1837-10-07	\N	12
1064	1837-10-08	\N	12
1065	1837-10-09	\N	12
1066	1837-10-10	\N	12
1067	1837-10-11	\N	12
1068	1837-10-12	\N	12
1069	1837-10-13	\N	12
1070	1837-10-14	\N	12
1071	1837-10-15	\N	12
1072	1837-10-16	\N	12
1073	1837-10-17	\N	12
1074	1837-10-18	\N	12
1075	1837-10-19	\N	12
1076	1837-10-20	\N	12
1077	1837-10-21	\N	12
1078	1837-10-22	\N	12
1079	1837-10-23	\N	12
1080	1837-10-24	\N	12
1081	1837-10-25	\N	12
1082	1837-10-26	\N	12
1083	1837-10-27	\N	12
1084	1837-10-28	\N	12
1085	1837-10-29	\N	12
1086	1837-10-30	\N	12
1087	1837-10-31	\N	12
1088	1837-11-01	\N	12
1089	1837-11-02	\N	12
1090	1837-11-03	\N	12
1091	1837-11-04	\N	12
1092	1837-11-05	\N	12
1093	1837-11-06	\N	12
1094	1837-11-07	\N	12
1095	1837-11-08	\N	12
1096	1837-11-09	\N	12
1097	1837-11-10	\N	12
1098	1837-11-11	\N	12
1099	1837-11-12	\N	12
1100	1837-11-13	\N	12
1101	1837-11-14	\N	12
1102	1841-06-24	\N	13
1103	1841-06-25	\N	13
1104	1841-06-26	\N	13
1105	1841-06-27	\N	13
1106	1841-06-28	\N	13
1107	1841-06-29	\N	13
1108	1841-06-30	\N	13
1109	1841-07-01	\N	13
1110	1841-07-02	\N	13
1111	1841-07-03	\N	13
1112	1841-07-04	\N	13
1113	1841-07-05	\N	13
1114	1841-07-06	\N	13
1115	1841-07-07	\N	13
1116	1841-07-08	\N	13
1117	1841-07-09	\N	13
1118	1841-07-10	\N	13
1119	1841-07-11	\N	13
1120	1841-07-12	\N	13
1121	1841-07-13	\N	13
1122	1841-07-14	\N	13
1123	1841-07-15	\N	13
1124	1841-07-16	\N	13
1125	1841-07-17	\N	13
1126	1841-07-18	\N	13
1127	1841-07-19	\N	13
1128	1841-07-20	\N	13
1129	1841-07-21	\N	13
1130	1841-07-22	\N	13
1131	1841-07-23	\N	13
1132	1841-07-24	\N	13
1133	1841-07-25	\N	13
1134	1841-07-26	\N	13
1135	1841-07-27	\N	13
1136	1841-07-28	\N	13
1137	1841-07-29	\N	13
1138	1841-07-30	\N	13
1139	1841-07-31	\N	13
1140	1841-08-01	\N	13
1141	1841-08-02	\N	13
1142	1841-08-03	\N	13
1143	1841-08-04	\N	13
1144	1841-08-05	\N	13
1145	1841-08-06	\N	13
1146	1841-08-07	\N	13
1147	1841-08-08	\N	13
1148	1841-08-09	\N	13
1149	1841-08-10	\N	13
1150	1841-08-11	\N	13
1151	1841-08-12	\N	13
1152	1841-08-13	\N	13
1153	1841-08-14	\N	13
1154	1841-08-15	\N	13
1155	1841-08-16	\N	13
1156	1841-08-17	\N	13
1157	1841-08-18	\N	13
1158	1847-07-24	\N	14
1159	1847-07-25	\N	14
1160	1847-07-26	\N	14
1161	1847-07-27	\N	14
1162	1847-07-28	\N	14
1163	1847-07-29	\N	14
1164	1847-07-30	\N	14
1165	1847-07-31	\N	14
1166	1847-08-01	\N	14
1167	1847-08-02	\N	14
1168	1847-08-03	\N	14
1169	1847-08-04	\N	14
1170	1847-08-05	\N	14
1171	1847-08-06	\N	14
1172	1847-08-07	\N	14
1173	1847-08-08	\N	14
1174	1847-08-09	\N	14
1175	1847-08-10	\N	14
1176	1847-08-11	\N	14
1177	1847-08-12	\N	14
1178	1847-08-13	\N	14
1179	1847-08-14	\N	14
1180	1847-08-15	\N	14
1181	1847-08-16	\N	14
1182	1847-08-17	\N	14
1183	1847-08-18	\N	14
1184	1847-08-19	\N	14
1185	1847-08-20	\N	14
1186	1847-08-21	\N	14
1187	1847-08-22	\N	14
1188	1847-08-23	\N	14
1189	1847-08-24	\N	14
1190	1847-08-25	\N	14
1191	1847-08-26	\N	14
1192	1847-08-27	\N	14
1193	1847-08-28	\N	14
1194	1847-08-29	\N	14
1195	1847-08-30	\N	14
1196	1847-08-31	\N	14
1197	1847-09-01	\N	14
1198	1847-09-02	\N	14
1199	1847-09-03	\N	14
1200	1847-09-04	\N	14
1201	1847-09-05	\N	14
1202	1847-09-06	\N	14
1203	1847-09-07	\N	14
1204	1847-09-08	\N	14
1205	1847-09-09	\N	14
1206	1847-09-10	\N	14
1207	1847-09-11	\N	14
1208	1847-09-12	\N	14
1209	1847-09-13	\N	14
1210	1847-09-14	\N	14
1211	1847-09-15	\N	14
1212	1847-09-16	\N	14
1213	1847-09-17	\N	14
1214	1847-09-18	\N	14
1215	1847-09-19	\N	14
1216	1847-09-20	\N	14
1217	1847-09-21	\N	14
1218	1847-09-22	\N	14
1219	1847-09-23	\N	14
1220	1847-09-24	\N	14
1221	1847-09-25	\N	14
1222	1847-09-26	\N	14
1223	1847-09-27	\N	14
1224	1847-09-28	\N	14
1225	1847-09-29	\N	14
1226	1847-09-30	\N	14
1227	1847-10-01	\N	14
1228	1847-10-02	\N	14
1229	1847-10-03	\N	14
1230	1847-10-04	\N	14
1231	1847-10-05	\N	14
1232	1847-10-06	\N	14
1233	1847-10-07	\N	14
1234	1847-10-08	\N	14
1235	1847-10-09	\N	14
1236	1847-10-10	\N	14
1237	1847-10-11	\N	14
1238	1847-10-12	\N	14
1239	1847-10-13	\N	14
1240	1847-10-14	\N	14
1241	1847-10-15	\N	14
1242	1847-10-16	\N	14
1243	1847-10-17	\N	14
1244	1847-10-18	\N	14
1245	1847-10-19	\N	14
1246	1847-10-20	\N	14
1247	1847-10-21	\N	14
1248	1847-10-22	\N	14
1249	1847-10-23	\N	14
1250	1847-10-24	\N	14
1251	1847-10-25	\N	14
1252	1847-10-26	\N	14
1253	1847-10-27	\N	14
1254	1847-10-28	\N	14
1255	1847-10-29	\N	14
1256	1847-10-30	\N	14
1257	1847-10-31	\N	14
1258	1847-11-01	\N	14
1259	1847-11-02	\N	14
1260	1847-11-03	\N	14
1261	1847-11-04	\N	14
1262	1847-11-05	\N	14
1263	1847-11-06	\N	14
1264	1847-11-07	\N	14
1265	1847-11-08	\N	14
1266	1847-11-09	\N	14
1267	1847-11-10	\N	14
1268	1847-11-11	\N	14
1269	1847-11-12	\N	14
1270	1847-11-13	\N	14
1271	1847-11-14	\N	14
1272	1847-11-15	\N	14
1273	1847-11-16	\N	14
1274	1847-11-17	\N	14
1275	1852-07-02	\N	15
1276	1852-07-03	\N	15
1277	1852-07-04	\N	15
1278	1852-07-05	\N	15
1279	1852-07-06	\N	15
1280	1852-07-07	\N	15
1281	1852-07-08	\N	15
1282	1852-07-09	\N	15
1283	1852-07-10	\N	15
1284	1852-07-11	\N	15
1285	1852-07-12	\N	15
1286	1852-07-13	\N	15
1287	1852-07-14	\N	15
1288	1852-07-15	\N	15
1289	1852-07-16	\N	15
1290	1852-07-17	\N	15
1291	1852-07-18	\N	15
1292	1852-07-19	\N	15
1293	1852-07-20	\N	15
1294	1852-07-21	\N	15
1295	1852-07-22	\N	15
1296	1852-07-23	\N	15
1297	1852-07-24	\N	15
1298	1852-07-25	\N	15
1299	1852-07-26	\N	15
1300	1852-07-27	\N	15
1301	1852-07-28	\N	15
1302	1852-07-29	\N	15
1303	1852-07-30	\N	15
1304	1852-07-31	\N	15
1305	1852-08-01	\N	15
1306	1852-08-02	\N	15
1307	1852-08-03	\N	15
1308	1852-08-04	\N	15
1309	1852-08-05	\N	15
1310	1852-08-06	\N	15
1311	1852-08-07	\N	15
1312	1852-08-08	\N	15
1313	1852-08-09	\N	15
1314	1852-08-10	\N	15
1315	1852-08-11	\N	15
1316	1852-08-12	\N	15
1317	1852-08-13	\N	15
1318	1852-08-14	\N	15
1319	1852-08-15	\N	15
1320	1852-08-16	\N	15
1321	1852-08-17	\N	15
1322	1852-08-18	\N	15
1323	1852-08-19	\N	15
1324	1852-08-20	\N	15
1325	1852-08-21	\N	15
1326	1852-08-22	\N	15
1327	1852-08-23	\N	15
1328	1852-08-24	\N	15
1329	1852-08-25	\N	15
1330	1852-08-26	\N	15
1331	1852-08-27	\N	15
1332	1852-08-28	\N	15
1333	1852-08-29	\N	15
1334	1852-08-30	\N	15
1335	1852-08-31	\N	15
1336	1852-09-01	\N	15
1337	1852-09-02	\N	15
1338	1852-09-03	\N	15
1339	1852-09-04	\N	15
1340	1852-09-05	\N	15
1341	1852-09-06	\N	15
1342	1852-09-07	\N	15
1343	1852-09-08	\N	15
1344	1852-09-09	\N	15
1345	1852-09-10	\N	15
1346	1852-09-11	\N	15
1347	1852-09-12	\N	15
1348	1852-09-13	\N	15
1349	1852-09-14	\N	15
1350	1852-09-15	\N	15
1351	1852-09-16	\N	15
1352	1852-09-17	\N	15
1353	1852-09-18	\N	15
1354	1852-09-19	\N	15
1355	1852-09-20	\N	15
1356	1852-09-21	\N	15
1357	1852-09-22	\N	15
1358	1852-09-23	\N	15
1359	1852-09-24	\N	15
1360	1852-09-25	\N	15
1361	1852-09-26	\N	15
1362	1852-09-27	\N	15
1363	1852-09-28	\N	15
1364	1852-09-29	\N	15
1365	1852-09-30	\N	15
1366	1852-10-01	\N	15
1367	1852-10-02	\N	15
1368	1852-10-03	\N	15
1369	1852-10-04	\N	15
1370	1852-10-05	\N	15
1371	1852-10-06	\N	15
1372	1852-10-07	\N	15
1373	1852-10-08	\N	15
1374	1852-10-09	\N	15
1375	1852-10-10	\N	15
1376	1852-10-11	\N	15
1377	1852-10-12	\N	15
1378	1852-10-13	\N	15
1379	1852-10-14	\N	15
1380	1852-10-15	\N	15
1381	1852-10-16	\N	15
1382	1852-10-17	\N	15
1383	1852-10-18	\N	15
1384	1852-10-19	\N	15
1385	1852-10-20	\N	15
1386	1852-10-21	\N	15
1387	1852-10-22	\N	15
1388	1852-10-23	\N	15
1389	1852-10-24	\N	15
1390	1852-10-25	\N	15
1391	1852-10-26	\N	15
1392	1852-10-27	\N	15
1393	1852-10-28	\N	15
1394	1852-10-29	\N	15
1395	1852-10-30	\N	15
1396	1852-10-31	\N	15
1397	1852-11-01	\N	15
1398	1852-11-02	\N	15
1399	1852-11-03	\N	15
1400	1857-03-22	\N	16
1401	1857-03-23	\N	16
1402	1857-03-24	\N	16
1403	1857-03-25	\N	16
1404	1857-03-26	\N	16
1405	1857-03-27	\N	16
1406	1857-03-28	\N	16
1407	1857-03-29	\N	16
1408	1857-03-30	\N	16
1409	1857-03-31	\N	16
1410	1857-04-01	\N	16
1411	1857-04-02	\N	16
1412	1857-04-03	\N	16
1413	1857-04-04	\N	16
1414	1857-04-05	\N	16
1415	1857-04-06	\N	16
1416	1857-04-07	\N	16
1417	1857-04-08	\N	16
1418	1857-04-09	\N	16
1419	1857-04-10	\N	16
1420	1857-04-11	\N	16
1421	1857-04-12	\N	16
1422	1857-04-13	\N	16
1423	1857-04-14	\N	16
1424	1857-04-15	\N	16
1425	1857-04-16	\N	16
1426	1857-04-17	\N	16
1427	1857-04-18	\N	16
1428	1857-04-19	\N	16
1429	1857-04-20	\N	16
1430	1857-04-21	\N	16
1431	1857-04-22	\N	16
1432	1857-04-23	\N	16
1433	1857-04-24	\N	16
1434	1857-04-25	\N	16
1435	1857-04-26	\N	16
1436	1857-04-27	\N	16
1437	1857-04-28	\N	16
1438	1857-04-29	\N	16
1439	1859-04-24	\N	17
1440	1859-04-25	\N	17
1441	1859-04-26	\N	17
1442	1859-04-27	\N	17
1443	1859-04-28	\N	17
1444	1859-04-29	\N	17
1445	1859-04-30	\N	17
1446	1859-05-01	\N	17
1447	1859-05-02	\N	17
1448	1859-05-03	\N	17
1449	1859-05-04	\N	17
1450	1859-05-05	\N	17
1451	1859-05-06	\N	17
1452	1859-05-07	\N	17
1453	1859-05-08	\N	17
1454	1859-05-09	\N	17
1455	1859-05-10	\N	17
1456	1859-05-11	\N	17
1457	1859-05-12	\N	17
1458	1859-05-13	\N	17
1459	1859-05-14	\N	17
1460	1859-05-15	\N	17
1461	1859-05-16	\N	17
1462	1859-05-17	\N	17
1463	1859-05-18	\N	17
1464	1859-05-19	\N	17
1465	1859-05-20	\N	17
1466	1859-05-21	\N	17
1467	1859-05-22	\N	17
1468	1859-05-23	\N	17
1469	1859-05-24	\N	17
1470	1859-05-25	\N	17
1471	1859-05-26	\N	17
1472	1859-05-27	\N	17
1473	1859-05-28	\N	17
1474	1859-05-29	\N	17
1475	1859-05-30	\N	17
1476	1865-07-07	\N	18
1477	1865-07-08	\N	18
1478	1865-07-09	\N	18
1479	1865-07-10	\N	18
1480	1865-07-11	\N	18
1481	1865-07-12	\N	18
1482	1865-07-13	\N	18
1483	1865-07-14	\N	18
1484	1865-07-15	\N	18
1485	1865-07-16	\N	18
1486	1865-07-17	\N	18
1487	1865-07-18	\N	18
1488	1865-07-19	\N	18
1489	1865-07-20	\N	18
1490	1865-07-21	\N	18
1491	1865-07-22	\N	18
1492	1865-07-23	\N	18
1493	1865-07-24	\N	18
1494	1865-07-25	\N	18
1495	1865-07-26	\N	18
1496	1865-07-27	\N	18
1497	1865-07-28	\N	18
1498	1865-07-29	\N	18
1499	1865-07-30	\N	18
1500	1865-07-31	\N	18
1501	1865-08-01	\N	18
1502	1865-08-02	\N	18
1503	1865-08-03	\N	18
1504	1865-08-04	\N	18
1505	1865-08-05	\N	18
1506	1865-08-06	\N	18
1507	1865-08-07	\N	18
1508	1865-08-08	\N	18
1509	1865-08-09	\N	18
1510	1865-08-10	\N	18
1511	1865-08-11	\N	18
1512	1865-08-12	\N	18
1513	1865-08-13	\N	18
1514	1865-08-14	\N	18
1515	1865-08-15	\N	18
1516	1865-08-16	\N	18
1517	1865-08-17	\N	18
1518	1865-08-18	\N	18
1519	1865-08-19	\N	18
1520	1865-08-20	\N	18
1521	1865-08-21	\N	18
1522	1865-08-22	\N	18
1523	1865-08-23	\N	18
1524	1865-08-24	\N	18
1525	1865-08-25	\N	18
1526	1865-08-26	\N	18
1527	1865-08-27	\N	18
1528	1865-08-28	\N	18
1529	1865-08-29	\N	18
1530	1865-08-30	\N	18
1531	1865-08-31	\N	18
1532	1865-09-01	\N	18
1533	1865-09-02	\N	18
1534	1865-09-03	\N	18
1535	1865-09-04	\N	18
1536	1865-09-05	\N	18
1537	1865-09-06	\N	18
1538	1865-09-07	\N	18
1539	1865-09-08	\N	18
1540	1865-09-09	\N	18
1541	1865-09-10	\N	18
1542	1865-09-11	\N	18
1543	1865-09-12	\N	18
1544	1865-09-13	\N	18
1545	1865-09-14	\N	18
1546	1865-09-15	\N	18
1547	1865-09-16	\N	18
1548	1865-09-17	\N	18
1549	1865-09-18	\N	18
1550	1865-09-19	\N	18
1551	1865-09-20	\N	18
1552	1865-09-21	\N	18
1553	1865-09-22	\N	18
1554	1865-09-23	\N	18
1555	1865-09-24	\N	18
1556	1865-09-25	\N	18
1557	1865-09-26	\N	18
1558	1865-09-27	\N	18
1559	1865-09-28	\N	18
1560	1865-09-29	\N	18
1561	1865-09-30	\N	18
1562	1865-10-01	\N	18
1563	1865-10-02	\N	18
1564	1865-10-03	\N	18
1565	1865-10-04	\N	18
1566	1865-10-05	\N	18
1567	1865-10-06	\N	18
1568	1865-10-07	\N	18
1569	1865-10-08	\N	18
1570	1865-10-09	\N	18
1571	1865-10-10	\N	18
1572	1865-10-11	\N	18
1573	1865-10-12	\N	18
1574	1865-10-13	\N	18
1575	1865-10-14	\N	18
1576	1865-10-15	\N	18
1577	1865-10-16	\N	18
1578	1865-10-17	\N	18
1579	1865-10-18	\N	18
1580	1865-10-19	\N	18
1581	1865-10-20	\N	18
1582	1865-10-21	\N	18
1583	1865-10-22	\N	18
1584	1865-10-23	\N	18
1585	1865-10-24	\N	18
1586	1865-10-25	\N	18
1587	1865-10-26	\N	18
1588	1865-10-27	\N	18
1589	1865-10-28	\N	18
1590	1865-10-29	\N	18
1591	1865-10-30	\N	18
1592	1865-10-31	\N	18
1593	1865-11-01	\N	18
1594	1865-11-02	\N	18
1595	1865-11-03	\N	18
1596	1865-11-04	\N	18
1597	1865-11-05	\N	18
1598	1865-11-06	\N	18
1599	1865-11-07	\N	18
1600	1865-11-08	\N	18
1601	1865-11-09	\N	18
1602	1865-11-10	\N	18
1603	1865-11-11	\N	18
1604	1865-11-12	\N	18
1605	1865-11-13	\N	18
1606	1865-11-14	\N	18
1607	1865-11-15	\N	18
1608	1865-11-16	\N	18
1609	1865-11-17	\N	18
1610	1865-11-18	\N	18
1611	1865-11-19	\N	18
1612	1865-11-20	\N	18
1613	1865-11-21	\N	18
1614	1865-11-22	\N	18
1615	1865-11-23	\N	18
1616	1865-11-24	\N	18
1617	1865-11-25	\N	18
1618	1865-11-26	\N	18
1619	1865-11-27	\N	18
1620	1865-11-28	\N	18
1621	1865-11-29	\N	18
1622	1865-11-30	\N	18
1623	1865-12-01	\N	18
1624	1865-12-02	\N	18
1625	1865-12-03	\N	18
1626	1865-12-04	\N	18
1627	1865-12-05	\N	18
1628	1865-12-06	\N	18
1629	1865-12-07	\N	18
1630	1865-12-08	\N	18
1631	1865-12-09	\N	18
1632	1865-12-10	\N	18
1633	1865-12-11	\N	18
1634	1865-12-12	\N	18
1635	1865-12-13	\N	18
1636	1865-12-14	\N	18
1637	1865-12-15	\N	18
1638	1865-12-16	\N	18
1639	1865-12-17	\N	18
1640	1865-12-18	\N	18
1641	1865-12-19	\N	18
1642	1865-12-20	\N	18
1643	1865-12-21	\N	18
1644	1865-12-22	\N	18
1645	1865-12-23	\N	18
1646	1865-12-24	\N	18
1647	1865-12-25	\N	18
1648	1865-12-26	\N	18
1649	1865-12-27	\N	18
1650	1865-12-28	\N	18
1651	1865-12-29	\N	18
1652	1865-12-30	\N	18
1653	1865-12-31	\N	18
1654	1866-01-01	\N	18
1655	1866-01-02	\N	18
1656	1866-01-03	\N	18
1657	1866-01-04	\N	18
1658	1866-01-05	\N	18
1659	1866-01-06	\N	18
1660	1866-01-07	\N	18
1661	1866-01-08	\N	18
1662	1866-01-09	\N	18
1663	1866-01-10	\N	18
1664	1866-01-11	\N	18
1665	1866-01-12	\N	18
1666	1866-01-13	\N	18
1667	1866-01-14	\N	18
1668	1866-01-15	\N	18
1669	1866-01-16	\N	18
1670	1866-01-17	\N	18
1671	1866-01-18	\N	18
1672	1866-01-19	\N	18
1673	1866-01-20	\N	18
1674	1866-01-21	\N	18
1675	1866-01-22	\N	18
1676	1866-01-23	\N	18
1677	1866-01-24	\N	18
1678	1866-01-25	\N	18
1679	1866-01-26	\N	18
1680	1866-01-27	\N	18
1681	1866-01-28	\N	18
1682	1866-01-29	\N	18
1683	1866-01-30	\N	18
1684	1866-01-31	\N	18
1685	1868-11-12	\N	19
1686	1868-11-13	\N	19
1687	1868-11-14	\N	19
1688	1868-11-15	\N	19
1689	1868-11-16	\N	19
1690	1868-11-17	\N	19
1691	1868-11-18	\N	19
1692	1868-11-19	\N	19
1693	1868-11-20	\N	19
1694	1868-11-21	\N	19
1695	1868-11-22	\N	19
1696	1868-11-23	\N	19
1697	1868-11-24	\N	19
1698	1868-11-25	\N	19
1699	1868-11-26	\N	19
1700	1868-11-27	\N	19
1701	1868-11-28	\N	19
1702	1868-11-29	\N	19
1703	1868-11-30	\N	19
1704	1868-12-01	\N	19
1705	1868-12-02	\N	19
1706	1868-12-03	\N	19
1707	1868-12-04	\N	19
1708	1868-12-05	\N	19
1709	1868-12-06	\N	19
1710	1868-12-07	\N	19
1711	1868-12-08	\N	19
1712	1868-12-09	\N	19
1713	1874-01-27	\N	20
1714	1874-01-28	\N	20
1715	1874-01-29	\N	20
1716	1874-01-30	\N	20
1717	1874-01-31	\N	20
1718	1874-02-01	\N	20
1719	1874-02-02	\N	20
1720	1874-02-03	\N	20
1721	1874-02-04	\N	20
1722	1874-02-05	\N	20
1723	1874-02-06	\N	20
1724	1874-02-07	\N	20
1725	1874-02-08	\N	20
1726	1874-02-09	\N	20
1727	1874-02-10	\N	20
1728	1874-02-11	\N	20
1729	1874-02-12	\N	20
1730	1874-02-13	\N	20
1731	1874-02-14	\N	20
1732	1874-02-15	\N	20
1733	1874-02-16	\N	20
1734	1874-02-17	\N	20
1735	1874-02-18	\N	20
1736	1874-02-19	\N	20
1737	1874-02-20	\N	20
1738	1874-02-21	\N	20
1739	1874-02-22	\N	20
1740	1874-02-23	\N	20
1741	1874-02-24	\N	20
1742	1874-02-25	\N	20
1743	1874-02-26	\N	20
1744	1874-02-27	\N	20
1745	1874-02-28	\N	20
1746	1874-03-01	\N	20
1747	1874-03-02	\N	20
1748	1874-03-03	\N	20
1749	1874-03-04	\N	20
1750	1880-03-25	\N	21
1751	1880-03-26	\N	21
1752	1880-03-27	\N	21
1753	1880-03-28	\N	21
1754	1880-03-29	\N	21
1755	1880-03-30	\N	21
1756	1880-03-31	\N	21
1757	1880-04-01	\N	21
1758	1880-04-02	\N	21
1759	1880-04-03	\N	21
1760	1880-04-04	\N	21
1761	1880-04-05	\N	21
1762	1880-04-06	\N	21
1763	1880-04-07	\N	21
1764	1880-04-08	\N	21
1765	1880-04-09	\N	21
1766	1880-04-10	\N	21
1767	1880-04-11	\N	21
1768	1880-04-12	\N	21
1769	1880-04-13	\N	21
1770	1880-04-14	\N	21
1771	1880-04-15	\N	21
1772	1880-04-16	\N	21
1773	1880-04-17	\N	21
1774	1880-04-18	\N	21
1775	1880-04-19	\N	21
1776	1880-04-20	\N	21
1777	1880-04-21	\N	21
1778	1880-04-22	\N	21
1779	1880-04-23	\N	21
1780	1880-04-24	\N	21
1781	1880-04-25	\N	21
1782	1880-04-26	\N	21
1783	1880-04-27	\N	21
1784	1880-04-28	\N	21
1785	1885-11-19	\N	22
1786	1885-11-20	\N	22
1787	1885-11-21	\N	22
1788	1885-11-22	\N	22
1789	1885-11-23	\N	22
1790	1885-11-24	\N	22
1791	1885-11-25	\N	22
1792	1885-11-26	\N	22
1793	1885-11-27	\N	22
1794	1885-11-28	\N	22
1795	1885-11-29	\N	22
1796	1885-11-30	\N	22
1797	1885-12-01	\N	22
1798	1885-12-02	\N	22
1799	1885-12-03	\N	22
1800	1885-12-04	\N	22
1801	1885-12-05	\N	22
1802	1885-12-06	\N	22
1803	1885-12-07	\N	22
1804	1885-12-08	\N	22
1805	1885-12-09	\N	22
1806	1885-12-10	\N	22
1807	1885-12-11	\N	22
1808	1885-12-12	\N	22
1809	1885-12-13	\N	22
1810	1885-12-14	\N	22
1811	1885-12-15	\N	22
1812	1885-12-16	\N	22
1813	1885-12-17	\N	22
1814	1885-12-18	\N	22
1815	1885-12-19	\N	22
1816	1885-12-20	\N	22
1817	1885-12-21	\N	22
1818	1885-12-22	\N	22
1819	1885-12-23	\N	22
1820	1885-12-24	\N	22
1821	1885-12-25	\N	22
1822	1885-12-26	\N	22
1823	1885-12-27	\N	22
1824	1885-12-28	\N	22
1825	1885-12-29	\N	22
1826	1885-12-30	\N	22
1827	1885-12-31	\N	22
1828	1886-01-01	\N	22
1829	1886-01-02	\N	22
1830	1886-01-03	\N	22
1831	1886-01-04	\N	22
1832	1886-01-05	\N	22
1833	1886-01-06	\N	22
1834	1886-01-07	\N	22
1835	1886-01-08	\N	22
1836	1886-01-09	\N	22
1837	1886-01-10	\N	22
1838	1886-01-11	\N	22
1839	1886-06-27	\N	23
1840	1886-06-28	\N	23
1841	1886-06-29	\N	23
1842	1886-06-30	\N	23
1843	1886-07-01	\N	23
1844	1886-07-02	\N	23
1845	1886-07-03	\N	23
1846	1886-07-04	\N	23
1847	1886-07-05	\N	23
1848	1886-07-06	\N	23
1849	1886-07-07	\N	23
1850	1886-07-08	\N	23
1851	1886-07-09	\N	23
1852	1886-07-10	\N	23
1853	1886-07-11	\N	23
1854	1886-07-12	\N	23
1855	1886-07-13	\N	23
1856	1886-07-14	\N	23
1857	1886-07-15	\N	23
1858	1886-07-16	\N	23
1859	1886-07-17	\N	23
1860	1886-07-18	\N	23
1861	1886-07-19	\N	23
1862	1886-07-20	\N	23
1863	1886-07-21	\N	23
1864	1886-07-22	\N	23
1865	1886-07-23	\N	23
1866	1886-07-24	\N	23
1867	1886-07-25	\N	23
1868	1886-07-26	\N	23
1869	1886-07-27	\N	23
1870	1886-07-28	\N	23
1871	1886-07-29	\N	23
1872	1886-07-30	\N	23
1873	1886-07-31	\N	23
1874	1886-08-01	\N	23
1875	1886-08-02	\N	23
1876	1886-08-03	\N	23
1877	1886-08-04	\N	23
1878	1892-06-29	\N	24
1879	1892-06-30	\N	24
1880	1892-07-01	\N	24
1881	1892-07-02	\N	24
1882	1892-07-03	\N	24
1883	1892-07-04	\N	24
1884	1892-07-05	\N	24
1885	1892-07-06	\N	24
1886	1892-07-07	\N	24
1887	1892-07-08	\N	24
1888	1892-07-09	\N	24
1889	1892-07-10	\N	24
1890	1892-07-11	\N	24
1891	1892-07-12	\N	24
1892	1892-07-13	\N	24
1893	1892-07-14	\N	24
1894	1892-07-15	\N	24
1895	1892-07-16	\N	24
1896	1892-07-17	\N	24
1897	1892-07-18	\N	24
1898	1892-07-19	\N	24
1899	1892-07-20	\N	24
1900	1892-07-21	\N	24
1901	1892-07-22	\N	24
1902	1892-07-23	\N	24
1903	1892-07-24	\N	24
1904	1892-07-25	\N	24
1905	1892-07-26	\N	24
1906	1892-07-27	\N	24
1907	1892-07-28	\N	24
1908	1892-07-29	\N	24
1909	1892-07-30	\N	24
1910	1892-07-31	\N	24
1911	1892-08-01	\N	24
1912	1892-08-02	\N	24
1913	1892-08-03	\N	24
1914	1895-07-09	\N	25
1915	1895-07-10	\N	25
1916	1895-07-11	\N	25
1917	1895-07-12	\N	25
1918	1895-07-13	\N	25
1919	1895-07-14	\N	25
1920	1895-07-15	\N	25
1921	1895-07-16	\N	25
1922	1895-07-17	\N	25
1923	1895-07-18	\N	25
1924	1895-07-19	\N	25
1925	1895-07-20	\N	25
1926	1895-07-21	\N	25
1927	1895-07-22	\N	25
1928	1895-07-23	\N	25
1929	1895-07-24	\N	25
1930	1895-07-25	\N	25
1931	1895-07-26	\N	25
1932	1895-07-27	\N	25
1933	1895-07-28	\N	25
1934	1895-07-29	\N	25
1935	1895-07-30	\N	25
1936	1895-07-31	\N	25
1937	1895-08-01	\N	25
1938	1895-08-02	\N	25
1939	1895-08-03	\N	25
1940	1895-08-04	\N	25
1941	1895-08-05	\N	25
1942	1895-08-06	\N	25
1943	1895-08-07	\N	25
1944	1895-08-08	\N	25
1945	1895-08-09	\N	25
1946	1895-08-10	\N	25
1947	1895-08-11	\N	25
1948	1900-09-18	\N	26
1949	1900-09-19	\N	26
1950	1900-09-20	\N	26
1951	1900-09-21	\N	26
1952	1900-09-22	\N	26
1953	1900-09-23	\N	26
1954	1900-09-24	\N	26
1955	1900-09-25	\N	26
1956	1900-09-26	\N	26
1957	1900-09-27	\N	26
1958	1900-09-28	\N	26
1959	1900-09-29	\N	26
1960	1900-09-30	\N	26
1961	1900-10-01	\N	26
1962	1900-10-02	\N	26
1963	1900-10-03	\N	26
1964	1900-10-04	\N	26
1965	1900-10-05	\N	26
1966	1900-10-06	\N	26
1967	1900-10-07	\N	26
1968	1900-10-08	\N	26
1969	1900-10-09	\N	26
1970	1900-10-10	\N	26
1971	1900-10-11	\N	26
1972	1900-10-12	\N	26
1973	1900-10-13	\N	26
1974	1900-10-14	\N	26
1975	1900-10-15	\N	26
1976	1900-10-16	\N	26
1977	1900-10-17	\N	26
1978	1900-10-18	\N	26
1979	1900-10-19	\N	26
1980	1900-10-20	\N	26
1981	1900-10-21	\N	26
1982	1900-10-22	\N	26
1983	1900-10-23	\N	26
1984	1900-10-24	\N	26
1985	1900-10-25	\N	26
1986	1900-10-26	\N	26
1987	1900-10-27	\N	26
1988	1900-10-28	\N	26
1989	1900-10-29	\N	26
1990	1900-10-30	\N	26
1991	1900-10-31	\N	26
1992	1900-11-01	\N	26
1993	1900-11-02	\N	26
1994	1900-11-03	\N	26
1995	1900-11-04	\N	26
1996	1900-11-05	\N	26
1997	1900-11-06	\N	26
1998	1900-11-07	\N	26
1999	1900-11-08	\N	26
2000	1900-11-09	\N	26
2001	1900-11-10	\N	26
2002	1900-11-11	\N	26
2003	1900-11-12	\N	26
2004	1900-11-13	\N	26
2005	1900-11-14	\N	26
2006	1900-11-15	\N	26
2007	1900-11-16	\N	26
2008	1900-11-17	\N	26
2009	1900-11-18	\N	26
2010	1900-11-19	\N	26
2011	1900-11-20	\N	26
2012	1900-11-21	\N	26
2013	1900-11-22	\N	26
2014	1900-11-23	\N	26
2015	1900-11-24	\N	26
2016	1900-11-25	\N	26
2017	1900-11-26	\N	26
2018	1900-11-27	\N	26
2019	1900-11-28	\N	26
2020	1900-11-29	\N	26
2021	1900-11-30	\N	26
2022	1900-12-01	\N	26
2023	1900-12-02	\N	26
2024	1906-01-09	\N	27
2025	1906-01-10	\N	27
2026	1906-01-11	\N	27
2027	1906-01-12	\N	27
2028	1906-01-13	\N	27
2029	1906-01-14	\N	27
2030	1906-01-15	\N	27
2031	1906-01-16	\N	27
2032	1906-01-17	\N	27
2033	1906-01-18	\N	27
2034	1906-01-19	\N	27
2035	1906-01-20	\N	27
2036	1906-01-21	\N	27
2037	1906-01-22	\N	27
2038	1906-01-23	\N	27
2039	1906-01-24	\N	27
2040	1906-01-25	\N	27
2041	1906-01-26	\N	27
2042	1906-01-27	\N	27
2043	1906-01-28	\N	27
2044	1906-01-29	\N	27
2045	1906-01-30	\N	27
2046	1906-01-31	\N	27
2047	1906-02-01	\N	27
2048	1906-02-02	\N	27
2049	1906-02-03	\N	27
2050	1906-02-04	\N	27
2051	1906-02-05	\N	27
2052	1906-02-06	\N	27
2053	1906-02-07	\N	27
2054	1906-02-08	\N	27
2055	1906-02-09	\N	27
2056	1906-02-10	\N	27
2057	1906-02-11	\N	27
2058	1906-02-12	\N	27
2059	1910-01-11	\N	28
2060	1910-01-12	\N	28
2061	1910-01-13	\N	28
2062	1910-01-14	\N	28
2063	1910-01-15	\N	28
2064	1910-01-16	\N	28
2065	1910-01-17	\N	28
2066	1910-01-18	\N	28
2067	1910-01-19	\N	28
2068	1910-01-20	\N	28
2069	1910-01-21	\N	28
2070	1910-01-22	\N	28
2071	1910-01-23	\N	28
2072	1910-01-24	\N	28
2073	1910-01-25	\N	28
2074	1910-01-26	\N	28
2075	1910-01-27	\N	28
2076	1910-01-28	\N	28
2077	1910-01-29	\N	28
2078	1910-01-30	\N	28
2079	1910-01-31	\N	28
2080	1910-02-01	\N	28
2081	1910-02-02	\N	28
2082	1910-02-03	\N	28
2083	1910-02-04	\N	28
2084	1910-02-05	\N	28
2085	1910-02-06	\N	28
2086	1910-02-07	\N	28
2087	1910-02-08	\N	28
2088	1910-02-09	\N	28
2089	1910-02-10	\N	28
2090	1910-02-11	\N	28
2091	1910-02-12	\N	28
2092	1910-02-13	\N	28
2093	1910-02-14	\N	28
2094	1910-11-29	\N	29
2095	1910-11-30	\N	29
2096	1910-12-01	\N	29
2097	1910-12-02	\N	29
2098	1910-12-03	\N	29
2099	1910-12-04	\N	29
2100	1910-12-05	\N	29
2101	1910-12-06	\N	29
2102	1910-12-07	\N	29
2103	1910-12-08	\N	29
2104	1910-12-09	\N	29
2105	1910-12-10	\N	29
2106	1910-12-11	\N	29
2107	1910-12-12	\N	29
2108	1910-12-13	\N	29
2109	1910-12-14	\N	29
2110	1910-12-15	\N	29
2111	1910-12-16	\N	29
2112	1910-12-17	\N	29
2113	1910-12-18	\N	29
2114	1910-12-19	\N	29
2115	1910-12-20	\N	29
2116	1910-12-21	\N	29
2117	1910-12-22	\N	29
2118	1910-12-23	\N	29
2119	1910-12-24	\N	29
2120	1910-12-25	\N	29
2121	1910-12-26	\N	29
2122	1910-12-27	\N	29
2123	1910-12-28	\N	29
2124	1910-12-29	\N	29
2125	1910-12-30	\N	29
2126	1910-12-31	\N	29
2127	1911-01-01	\N	29
2128	1911-01-02	\N	29
2129	1911-01-03	\N	29
2130	1911-01-04	\N	29
2131	1911-01-05	\N	29
2132	1911-01-06	\N	29
2133	1911-01-07	\N	29
2134	1911-01-08	\N	29
2135	1911-01-09	\N	29
2136	1911-01-10	\N	29
2137	1911-01-11	\N	29
2138	1911-01-12	\N	29
2139	1911-01-13	\N	29
2140	1911-01-14	\N	29
2141	1911-01-15	\N	29
2142	1911-01-16	\N	29
2143	1911-01-17	\N	29
2144	1911-01-18	\N	29
2145	1911-01-19	\N	29
2146	1911-01-20	\N	29
2147	1911-01-21	\N	29
2148	1911-01-22	\N	29
2149	1911-01-23	\N	29
2150	1911-01-24	\N	29
2151	1911-01-25	\N	29
2152	1911-01-26	\N	29
2153	1911-01-27	\N	29
2154	1911-01-28	\N	29
2155	1911-01-29	\N	29
2156	1911-01-30	\N	29
2157	1918-11-26	\N	30
2158	1918-11-27	\N	30
2159	1918-11-28	\N	30
2160	1918-11-29	\N	30
2161	1918-11-30	\N	30
2162	1918-12-01	\N	30
2163	1918-12-02	\N	30
2164	1918-12-03	\N	30
2165	1918-12-04	\N	30
2166	1918-12-05	\N	30
2167	1918-12-06	\N	30
2168	1918-12-07	\N	30
2169	1918-12-08	\N	30
2170	1918-12-09	\N	30
2171	1918-12-10	\N	30
2172	1918-12-11	\N	30
2173	1918-12-12	\N	30
2174	1918-12-13	\N	30
2175	1918-12-14	\N	30
2176	1918-12-15	\N	30
2177	1918-12-16	\N	30
2178	1918-12-17	\N	30
2179	1918-12-18	\N	30
2180	1918-12-19	\N	30
2181	1918-12-20	\N	30
2182	1918-12-21	\N	30
2183	1918-12-22	\N	30
2184	1918-12-23	\N	30
2185	1918-12-24	\N	30
2186	1918-12-25	\N	30
2187	1918-12-26	\N	30
2188	1918-12-27	\N	30
2189	1918-12-28	\N	30
2190	1918-12-29	\N	30
2191	1918-12-30	\N	30
2192	1918-12-31	\N	30
2193	1919-01-01	\N	30
2194	1919-01-02	\N	30
2195	1919-01-03	\N	30
2196	1919-01-04	\N	30
2197	1919-01-05	\N	30
2198	1919-01-06	\N	30
2199	1919-01-07	\N	30
2200	1919-01-08	\N	30
2201	1919-01-09	\N	30
2202	1919-01-10	\N	30
2203	1919-01-11	\N	30
2204	1919-01-12	\N	30
2205	1919-01-13	\N	30
2206	1919-01-14	\N	30
2207	1919-01-15	\N	30
2208	1919-01-16	\N	30
2209	1919-01-17	\N	30
2210	1919-01-18	\N	30
2211	1919-01-19	\N	30
2212	1919-01-20	\N	30
2213	1919-01-21	\N	30
2214	1919-01-22	\N	30
2215	1919-01-23	\N	30
2216	1919-01-24	\N	30
2217	1919-01-25	\N	30
2218	1919-01-26	\N	30
2219	1919-01-27	\N	30
2220	1919-01-28	\N	30
2221	1919-01-29	\N	30
2222	1919-01-30	\N	30
2223	1919-01-31	\N	30
2224	1919-02-01	\N	30
2225	1919-02-02	\N	30
2226	1919-02-03	\N	30
2227	1922-10-27	\N	31
2228	1922-10-28	\N	31
2229	1922-10-29	\N	31
2230	1922-10-30	\N	31
2231	1922-10-31	\N	31
2232	1922-11-01	\N	31
2233	1922-11-02	\N	31
2234	1922-11-03	\N	31
2235	1922-11-04	\N	31
2236	1922-11-05	\N	31
2237	1922-11-06	\N	31
2238	1922-11-07	\N	31
2239	1922-11-08	\N	31
2240	1922-11-09	\N	31
2241	1922-11-10	\N	31
2242	1922-11-11	\N	31
2243	1922-11-12	\N	31
2244	1922-11-13	\N	31
2245	1922-11-14	\N	31
2246	1922-11-15	\N	31
2247	1922-11-16	\N	31
2248	1922-11-17	\N	31
2249	1922-11-18	\N	31
2250	1922-11-19	\N	31
2251	1923-11-17	\N	32
2252	1923-11-18	\N	32
2253	1923-11-19	\N	32
2254	1923-11-20	\N	32
2255	1923-11-21	\N	32
2256	1923-11-22	\N	32
2257	1923-11-23	\N	32
2258	1923-11-24	\N	32
2259	1923-11-25	\N	32
2260	1923-11-26	\N	32
2261	1923-11-27	\N	32
2262	1923-11-28	\N	32
2263	1923-11-29	\N	32
2264	1923-11-30	\N	32
2265	1923-12-01	\N	32
2266	1923-12-02	\N	32
2267	1923-12-03	\N	32
2268	1923-12-04	\N	32
2269	1923-12-05	\N	32
2270	1923-12-06	\N	32
2271	1923-12-07	\N	32
2272	1923-12-08	\N	32
2273	1923-12-09	\N	32
2274	1923-12-10	\N	32
2275	1923-12-11	\N	32
2276	1923-12-12	\N	32
2277	1923-12-13	\N	32
2278	1923-12-14	\N	32
2279	1923-12-15	\N	32
2280	1923-12-16	\N	32
2281	1923-12-17	\N	32
2282	1923-12-18	\N	32
2283	1923-12-19	\N	32
2284	1923-12-20	\N	32
2285	1923-12-21	\N	32
2286	1923-12-22	\N	32
2287	1923-12-23	\N	32
2288	1923-12-24	\N	32
2289	1923-12-25	\N	32
2290	1923-12-26	\N	32
2291	1923-12-27	\N	32
2292	1923-12-28	\N	32
2293	1923-12-29	\N	32
2294	1923-12-30	\N	32
2295	1923-12-31	\N	32
2296	1924-01-01	\N	32
2297	1924-01-02	\N	32
2298	1924-01-03	\N	32
2299	1924-01-04	\N	32
2300	1924-01-05	\N	32
2301	1924-01-06	\N	32
2302	1924-01-07	\N	32
2303	1924-10-10	\N	33
2304	1924-10-11	\N	33
2305	1924-10-12	\N	33
2306	1924-10-13	\N	33
2307	1924-10-14	\N	33
2308	1924-10-15	\N	33
2309	1924-10-16	\N	33
2310	1924-10-17	\N	33
2311	1924-10-18	\N	33
2312	1924-10-19	\N	33
2313	1924-10-20	\N	33
2314	1924-10-21	\N	33
2315	1924-10-22	\N	33
2316	1924-10-23	\N	33
2317	1924-10-24	\N	33
2318	1924-10-25	\N	33
2319	1924-10-26	\N	33
2320	1924-10-27	\N	33
2321	1924-10-28	\N	33
2322	1924-10-29	\N	33
2323	1924-10-30	\N	33
2324	1924-10-31	\N	33
2325	1924-11-01	\N	33
2326	1924-11-02	\N	33
2327	1924-11-03	\N	33
2328	1924-11-04	\N	33
2329	1924-11-05	\N	33
2330	1924-11-06	\N	33
2331	1924-11-07	\N	33
2332	1924-11-08	\N	33
2333	1924-11-09	\N	33
2334	1924-11-10	\N	33
2335	1924-11-11	\N	33
2336	1924-11-12	\N	33
2337	1924-11-13	\N	33
2338	1924-11-14	\N	33
2339	1924-11-15	\N	33
2340	1924-11-16	\N	33
2341	1924-11-17	\N	33
2342	1924-11-18	\N	33
2343	1924-11-19	\N	33
2344	1924-11-20	\N	33
2345	1924-11-21	\N	33
2346	1924-11-22	\N	33
2347	1924-11-23	\N	33
2348	1924-11-24	\N	33
2349	1924-11-25	\N	33
2350	1924-11-26	\N	33
2351	1924-11-27	\N	33
2352	1924-11-28	\N	33
2353	1924-11-29	\N	33
2354	1924-11-30	\N	33
2355	1924-12-01	\N	33
2356	1929-05-11	\N	34
2357	1929-05-12	\N	34
2358	1929-05-13	\N	34
2359	1929-05-14	\N	34
2360	1929-05-15	\N	34
2361	1929-05-16	\N	34
2362	1929-05-17	\N	34
2363	1929-05-18	\N	34
2364	1929-05-19	\N	34
2365	1929-05-20	\N	34
2366	1929-05-21	\N	34
2367	1929-05-22	\N	34
2368	1929-05-23	\N	34
2369	1929-05-24	\N	34
2370	1929-05-25	\N	34
2371	1929-05-26	\N	34
2372	1929-05-27	\N	34
2373	1929-05-28	\N	34
2374	1929-05-29	\N	34
2375	1929-05-30	\N	34
2376	1929-05-31	\N	34
2377	1929-06-01	\N	34
2378	1929-06-02	\N	34
2379	1929-06-03	\N	34
2380	1929-06-04	\N	34
2381	1929-06-05	\N	34
2382	1929-06-06	\N	34
2383	1929-06-07	\N	34
2384	1929-06-08	\N	34
2385	1929-06-09	\N	34
2386	1929-06-10	\N	34
2387	1929-06-11	\N	34
2388	1929-06-12	\N	34
2389	1929-06-13	\N	34
2390	1929-06-14	\N	34
2391	1929-06-15	\N	34
2392	1929-06-16	\N	34
2393	1929-06-17	\N	34
2394	1929-06-18	\N	34
2395	1929-06-19	\N	34
2396	1929-06-20	\N	34
2397	1929-06-21	\N	34
2398	1929-06-22	\N	34
2399	1929-06-23	\N	34
2400	1929-06-24	\N	34
2401	1931-10-08	\N	35
2402	1931-10-09	\N	35
2403	1931-10-10	\N	35
2404	1931-10-11	\N	35
2405	1931-10-12	\N	35
2406	1931-10-13	\N	35
2407	1931-10-14	\N	35
2408	1931-10-15	\N	35
2409	1931-10-16	\N	35
2410	1931-10-17	\N	35
2411	1931-10-18	\N	35
2412	1931-10-19	\N	35
2413	1931-10-20	\N	35
2414	1931-10-21	\N	35
2415	1931-10-22	\N	35
2416	1931-10-23	\N	35
2417	1931-10-24	\N	35
2418	1931-10-25	\N	35
2419	1931-10-26	\N	35
2420	1931-10-27	\N	35
2421	1931-10-28	\N	35
2422	1931-10-29	\N	35
2423	1931-10-30	\N	35
2424	1931-10-31	\N	35
2425	1931-11-01	\N	35
2426	1931-11-02	\N	35
2427	1935-10-26	\N	36
2428	1935-10-27	\N	36
2429	1935-10-28	\N	36
2430	1935-10-29	\N	36
2431	1935-10-30	\N	36
2432	1935-10-31	\N	36
2433	1935-11-01	\N	36
2434	1935-11-02	\N	36
2435	1935-11-03	\N	36
2436	1935-11-04	\N	36
2437	1935-11-05	\N	36
2438	1935-11-06	\N	36
2439	1935-11-07	\N	36
2440	1935-11-08	\N	36
2441	1935-11-09	\N	36
2442	1935-11-10	\N	36
2443	1935-11-11	\N	36
2444	1935-11-12	\N	36
2445	1935-11-13	\N	36
2446	1935-11-14	\N	36
2447	1935-11-15	\N	36
2448	1935-11-16	\N	36
2449	1935-11-17	\N	36
2450	1935-11-18	\N	36
2451	1935-11-19	\N	36
2452	1935-11-20	\N	36
2453	1935-11-21	\N	36
2454	1935-11-22	\N	36
2455	1935-11-23	\N	36
2456	1935-11-24	\N	36
2457	1935-11-25	\N	36
2458	1945-06-16	\N	37
2459	1945-06-17	\N	37
2460	1945-06-18	\N	37
2461	1945-06-19	\N	37
2462	1945-06-20	\N	37
2463	1945-06-21	\N	37
2464	1945-06-22	\N	37
2465	1945-06-23	\N	37
2466	1945-06-24	\N	37
2467	1945-06-25	\N	37
2468	1945-06-26	\N	37
2469	1945-06-27	\N	37
2470	1945-06-28	\N	37
2471	1945-06-29	\N	37
2472	1945-06-30	\N	37
2473	1945-07-01	\N	37
2474	1945-07-02	\N	37
2475	1945-07-03	\N	37
2476	1945-07-04	\N	37
2477	1945-07-05	\N	37
2478	1945-07-06	\N	37
2479	1945-07-07	\N	37
2480	1945-07-08	\N	37
2481	1945-07-09	\N	37
2482	1945-07-10	\N	37
2483	1945-07-11	\N	37
2484	1945-07-12	\N	37
2485	1945-07-13	\N	37
2486	1945-07-14	\N	37
2487	1945-07-15	\N	37
2488	1945-07-16	\N	37
2489	1945-07-17	\N	37
2490	1945-07-18	\N	37
2491	1945-07-19	\N	37
2492	1945-07-20	\N	37
2493	1945-07-21	\N	37
2494	1945-07-22	\N	37
2495	1945-07-23	\N	37
2496	1945-07-24	\N	37
2497	1945-07-25	\N	37
2498	1945-07-26	\N	37
2499	1945-07-27	\N	37
2500	1945-07-28	\N	37
2501	1945-07-29	\N	37
2502	1945-07-30	\N	37
2503	1945-07-31	\N	37
2504	1950-02-04	\N	38
2505	1950-02-05	\N	38
2506	1950-02-06	\N	38
2507	1950-02-07	\N	38
2508	1950-02-08	\N	38
2509	1950-02-09	\N	38
2510	1950-02-10	\N	38
2511	1950-02-11	\N	38
2512	1950-02-12	\N	38
2513	1950-02-13	\N	38
2514	1950-02-14	\N	38
2515	1950-02-15	\N	38
2516	1950-02-16	\N	38
2517	1950-02-17	\N	38
2518	1950-02-18	\N	38
2519	1950-02-19	\N	38
2520	1950-02-20	\N	38
2521	1950-02-21	\N	38
2522	1950-02-22	\N	38
2523	1950-02-23	\N	38
2524	1950-02-24	\N	38
2525	1950-02-25	\N	38
2526	1950-02-26	\N	38
2527	1950-02-27	\N	38
2528	1950-02-28	\N	38
2529	1951-10-06	\N	39
2530	1951-10-07	\N	39
2531	1951-10-08	\N	39
2532	1951-10-09	\N	39
2533	1951-10-10	\N	39
2534	1951-10-11	\N	39
2535	1951-10-12	\N	39
2536	1951-10-13	\N	39
2537	1951-10-14	\N	39
2538	1951-10-15	\N	39
2539	1951-10-16	\N	39
2540	1951-10-17	\N	39
2541	1951-10-18	\N	39
2542	1951-10-19	\N	39
2543	1951-10-20	\N	39
2544	1951-10-21	\N	39
2545	1951-10-22	\N	39
2546	1951-10-23	\N	39
2547	1951-10-24	\N	39
2548	1951-10-25	\N	39
2549	1951-10-26	\N	39
2550	1951-10-27	\N	39
2551	1951-10-28	\N	39
2552	1951-10-29	\N	39
2553	1951-10-30	\N	39
2554	1955-05-07	\N	40
2555	1955-05-08	\N	40
2556	1955-05-09	\N	40
2557	1955-05-10	\N	40
2558	1955-05-11	\N	40
2559	1955-05-12	\N	40
2560	1955-05-13	\N	40
2561	1955-05-14	\N	40
2562	1955-05-15	\N	40
2563	1955-05-16	\N	40
2564	1955-05-17	\N	40
2565	1955-05-18	\N	40
2566	1955-05-19	\N	40
2567	1955-05-20	\N	40
2568	1955-05-21	\N	40
2569	1955-05-22	\N	40
2570	1955-05-23	\N	40
2571	1955-05-24	\N	40
2572	1955-05-25	\N	40
2573	1955-05-26	\N	40
2574	1955-05-27	\N	40
2575	1955-05-28	\N	40
2576	1955-05-29	\N	40
2577	1955-05-30	\N	40
2578	1955-05-31	\N	40
2579	1955-06-01	\N	40
2580	1955-06-02	\N	40
2581	1955-06-03	\N	40
2582	1955-06-04	\N	40
2583	1955-06-05	\N	40
2584	1955-06-06	\N	40
2585	1959-09-19	\N	41
2586	1959-09-20	\N	41
2587	1959-09-21	\N	41
2588	1959-09-22	\N	41
2589	1959-09-23	\N	41
2590	1959-09-24	\N	41
2591	1959-09-25	\N	41
2592	1959-09-26	\N	41
2593	1959-09-27	\N	41
2594	1959-09-28	\N	41
2595	1959-09-29	\N	41
2596	1959-09-30	\N	41
2597	1959-10-01	\N	41
2598	1959-10-02	\N	41
2599	1959-10-03	\N	41
2600	1959-10-04	\N	41
2601	1959-10-05	\N	41
2602	1959-10-06	\N	41
2603	1959-10-07	\N	41
2604	1959-10-08	\N	41
2605	1959-10-09	\N	41
2606	1959-10-10	\N	41
2607	1959-10-11	\N	41
2608	1959-10-12	\N	41
2609	1959-10-13	\N	41
2610	1959-10-14	\N	41
2611	1959-10-15	\N	41
2612	1959-10-16	\N	41
2613	1959-10-17	\N	41
2614	1959-10-18	\N	41
2615	1959-10-19	\N	41
2616	1964-09-26	\N	42
2617	1964-09-27	\N	42
2618	1964-09-28	\N	42
2619	1964-09-29	\N	42
2620	1964-09-30	\N	42
2621	1964-10-01	\N	42
2622	1964-10-02	\N	42
2623	1964-10-03	\N	42
2624	1964-10-04	\N	42
2625	1964-10-05	\N	42
2626	1964-10-06	\N	42
2627	1964-10-07	\N	42
2628	1964-10-08	\N	42
2629	1964-10-09	\N	42
2630	1964-10-10	\N	42
2631	1964-10-11	\N	42
2632	1964-10-12	\N	42
2633	1964-10-13	\N	42
2634	1964-10-14	\N	42
2635	1964-10-15	\N	42
2636	1964-10-16	\N	42
2637	1964-10-17	\N	42
2638	1964-10-18	\N	42
2639	1964-10-19	\N	42
2640	1964-10-20	\N	42
2641	1964-10-21	\N	42
2642	1964-10-22	\N	42
2643	1964-10-23	\N	42
2644	1964-10-24	\N	42
2645	1964-10-25	\N	42
2646	1964-10-26	\N	42
2647	1966-03-11	\N	43
2648	1966-03-12	\N	43
2649	1966-03-13	\N	43
2650	1966-03-14	\N	43
2651	1966-03-15	\N	43
2652	1966-03-16	\N	43
2653	1966-03-17	\N	43
2654	1966-03-18	\N	43
2655	1966-03-19	\N	43
2656	1966-03-20	\N	43
2657	1966-03-21	\N	43
2658	1966-03-22	\N	43
2659	1966-03-23	\N	43
2660	1966-03-24	\N	43
2661	1966-03-25	\N	43
2662	1966-03-26	\N	43
2663	1966-03-27	\N	43
2664	1966-03-28	\N	43
2665	1966-03-29	\N	43
2666	1966-03-30	\N	43
2667	1966-03-31	\N	43
2668	1966-04-01	\N	43
2669	1966-04-02	\N	43
2670	1966-04-03	\N	43
2671	1966-04-04	\N	43
2672	1966-04-05	\N	43
2673	1966-04-06	\N	43
2674	1966-04-07	\N	43
2675	1966-04-08	\N	43
2676	1966-04-09	\N	43
2677	1966-04-10	\N	43
2678	1966-04-11	\N	43
2679	1966-04-12	\N	43
2680	1966-04-13	\N	43
2681	1966-04-14	\N	43
2682	1966-04-15	\N	43
2683	1966-04-16	\N	43
2684	1966-04-17	\N	43
2685	1970-05-30	\N	44
2686	1970-05-31	\N	44
2687	1970-06-01	\N	44
2688	1970-06-02	\N	44
2689	1970-06-03	\N	44
2690	1970-06-04	\N	44
2691	1970-06-05	\N	44
2692	1970-06-06	\N	44
2693	1970-06-07	\N	44
2694	1970-06-08	\N	44
2695	1970-06-09	\N	44
2696	1970-06-10	\N	44
2697	1970-06-11	\N	44
2698	1970-06-12	\N	44
2699	1970-06-13	\N	44
2700	1970-06-14	\N	44
2701	1970-06-15	\N	44
2702	1970-06-16	\N	44
2703	1970-06-17	\N	44
2704	1970-06-18	\N	44
2705	1970-06-19	\N	44
2706	1970-06-20	\N	44
2707	1970-06-21	\N	44
2708	1970-06-22	\N	44
2709	1970-06-23	\N	44
2710	1970-06-24	\N	44
2711	1970-06-25	\N	44
2712	1970-06-26	\N	44
2713	1970-06-27	\N	44
2714	1970-06-28	\N	44
2715	1974-02-09	\N	45
2716	1974-02-10	\N	45
2717	1974-02-11	\N	45
2718	1974-02-12	\N	45
2719	1974-02-13	\N	45
2720	1974-02-14	\N	45
2721	1974-02-15	\N	45
2722	1974-02-16	\N	45
2723	1974-02-17	\N	45
2724	1974-02-18	\N	45
2725	1974-02-19	\N	45
2726	1974-02-20	\N	45
2727	1974-02-21	\N	45
2728	1974-02-22	\N	45
2729	1974-02-23	\N	45
2730	1974-02-24	\N	45
2731	1974-02-25	\N	45
2732	1974-02-26	\N	45
2733	1974-02-27	\N	45
2734	1974-02-28	\N	45
2735	1974-03-01	\N	45
2736	1974-03-02	\N	45
2737	1974-03-03	\N	45
2738	1974-03-04	\N	45
2739	1974-03-05	\N	45
2740	1974-09-21	\N	46
2741	1974-09-22	\N	46
2742	1974-09-23	\N	46
2743	1974-09-24	\N	46
2744	1974-09-25	\N	46
2745	1974-09-26	\N	46
2746	1974-09-27	\N	46
2747	1974-09-28	\N	46
2748	1974-09-29	\N	46
2749	1974-09-30	\N	46
2750	1974-10-01	\N	46
2751	1974-10-02	\N	46
2752	1974-10-03	\N	46
2753	1974-10-04	\N	46
2754	1974-10-05	\N	46
2755	1974-10-06	\N	46
2756	1974-10-07	\N	46
2757	1974-10-08	\N	46
2758	1974-10-09	\N	46
2759	1974-10-10	\N	46
2760	1974-10-11	\N	46
2761	1974-10-12	\N	46
2762	1974-10-13	\N	46
2763	1974-10-14	\N	46
2764	1974-10-15	\N	46
2765	1974-10-16	\N	46
2766	1974-10-17	\N	46
2767	1974-10-18	\N	46
2768	1974-10-19	\N	46
2769	1974-10-20	\N	46
2770	1974-10-21	\N	46
2771	1979-04-08	\N	47
2772	1979-04-09	\N	47
2773	1979-04-10	\N	47
2774	1979-04-11	\N	47
2775	1979-04-12	\N	47
2776	1979-04-13	\N	47
2777	1979-04-14	\N	47
2778	1979-04-15	\N	47
2779	1979-04-16	\N	47
2780	1979-04-17	\N	47
2781	1979-04-18	\N	47
2782	1979-04-19	\N	47
2783	1979-04-20	\N	47
2784	1979-04-21	\N	47
2785	1979-04-22	\N	47
2786	1979-04-23	\N	47
2787	1979-04-24	\N	47
2788	1979-04-25	\N	47
2789	1979-04-26	\N	47
2790	1979-04-27	\N	47
2791	1979-04-28	\N	47
2792	1979-04-29	\N	47
2793	1979-04-30	\N	47
2794	1979-05-01	\N	47
2795	1979-05-02	\N	47
2796	1979-05-03	\N	47
2797	1979-05-04	\N	47
2798	1979-05-05	\N	47
2799	1979-05-06	\N	47
2800	1979-05-07	\N	47
2801	1979-05-08	\N	47
2802	1983-05-14	\N	48
2803	1983-05-15	\N	48
2804	1983-05-16	\N	48
2805	1983-05-17	\N	48
2806	1983-05-18	\N	48
2807	1983-05-19	\N	48
2808	1983-05-20	\N	48
2809	1983-05-21	\N	48
2810	1983-05-22	\N	48
2811	1983-05-23	\N	48
2812	1983-05-24	\N	48
2813	1983-05-25	\N	48
2814	1983-05-26	\N	48
2815	1983-05-27	\N	48
2816	1983-05-28	\N	48
2817	1983-05-29	\N	48
2818	1983-05-30	\N	48
2819	1983-05-31	\N	48
2820	1983-06-01	\N	48
2821	1983-06-02	\N	48
2822	1983-06-03	\N	48
2823	1983-06-04	\N	48
2824	1983-06-05	\N	48
2825	1983-06-06	\N	48
2826	1983-06-07	\N	48
2827	1983-06-08	\N	48
2828	1983-06-09	\N	48
2829	1983-06-10	\N	48
2830	1983-06-11	\N	48
2831	1983-06-12	\N	48
2832	1983-06-13	\N	48
2833	1983-06-14	\N	48
2834	1987-05-19	\N	49
2835	1987-05-20	\N	49
2836	1987-05-21	\N	49
2837	1987-05-22	\N	49
2838	1987-05-23	\N	49
2839	1987-05-24	\N	49
2840	1987-05-25	\N	49
2841	1987-05-26	\N	49
2842	1987-05-27	\N	49
2843	1987-05-28	\N	49
2844	1987-05-29	\N	49
2845	1987-05-30	\N	49
2846	1987-05-31	\N	49
2847	1987-06-01	\N	49
2848	1987-06-02	\N	49
2849	1987-06-03	\N	49
2850	1987-06-04	\N	49
2851	1987-06-05	\N	49
2852	1987-06-06	\N	49
2853	1987-06-07	\N	49
2854	1987-06-08	\N	49
2855	1987-06-09	\N	49
2856	1987-06-10	\N	49
2857	1987-06-11	\N	49
2858	1987-06-12	\N	49
2859	1987-06-13	\N	49
2860	1987-06-14	\N	49
2861	1987-06-15	\N	49
2862	1987-06-16	\N	49
2863	1992-03-17	\N	50
2864	1992-03-18	\N	50
2865	1992-03-19	\N	50
2866	1992-03-20	\N	50
2867	1992-03-21	\N	50
2868	1992-03-22	\N	50
2869	1992-03-23	\N	50
2870	1992-03-24	\N	50
2871	1992-03-25	\N	50
2872	1992-03-26	\N	50
2873	1992-03-27	\N	50
2874	1992-03-28	\N	50
2875	1992-03-29	\N	50
2876	1992-03-30	\N	50
2877	1992-03-31	\N	50
2878	1992-04-01	\N	50
2879	1992-04-02	\N	50
2880	1992-04-03	\N	50
2881	1992-04-04	\N	50
2882	1992-04-05	\N	50
2883	1992-04-06	\N	50
2884	1992-04-07	\N	50
2885	1992-04-08	\N	50
2886	1992-04-09	\N	50
2887	1992-04-10	\N	50
2888	1992-04-11	\N	50
2889	1992-04-12	\N	50
2890	1992-04-13	\N	50
2891	1992-04-14	\N	50
2892	1992-04-15	\N	50
2893	1992-04-16	\N	50
2894	1992-04-17	\N	50
2895	1992-04-18	\N	50
2896	1992-04-19	\N	50
2897	1992-04-20	\N	50
2898	1992-04-21	\N	50
2899	1992-04-22	\N	50
2900	1992-04-23	\N	50
2901	1992-04-24	\N	50
2902	1992-04-25	\N	50
2903	1992-04-26	\N	50
2904	1997-04-09	\N	51
2905	1997-04-10	\N	51
2906	1997-04-11	\N	51
2907	1997-04-12	\N	51
2908	1997-04-13	\N	51
2909	1997-04-14	\N	51
2910	1997-04-15	\N	51
2911	1997-04-16	\N	51
2912	1997-04-17	\N	51
2913	1997-04-18	\N	51
2914	1997-04-19	\N	51
2915	1997-04-20	\N	51
2916	1997-04-21	\N	51
2917	1997-04-22	\N	51
2918	1997-04-23	\N	51
2919	1997-04-24	\N	51
2920	1997-04-25	\N	51
2921	1997-04-26	\N	51
2922	1997-04-27	\N	51
2923	1997-04-28	\N	51
2924	1997-04-29	\N	51
2925	1997-04-30	\N	51
2926	1997-05-01	\N	51
2927	1997-05-02	\N	51
2928	1997-05-03	\N	51
2929	1997-05-04	\N	51
2930	1997-05-05	\N	51
2931	1997-05-06	\N	51
2932	2001-05-15	\N	52
2933	2001-05-16	\N	52
2934	2001-05-17	\N	52
2935	2001-05-18	\N	52
2936	2001-05-19	\N	52
2937	2001-05-20	\N	52
2938	2001-05-21	\N	52
2939	2001-05-22	\N	52
2940	2001-05-23	\N	52
2941	2001-05-24	\N	52
2942	2001-05-25	\N	52
2943	2001-05-26	\N	52
2944	2001-05-27	\N	52
2945	2001-05-28	\N	52
2946	2001-05-29	\N	52
2947	2001-05-30	\N	52
2948	2001-05-31	\N	52
2949	2001-06-01	\N	52
2950	2001-06-02	\N	52
2951	2001-06-03	\N	52
2952	2001-06-04	\N	52
2953	2001-06-05	\N	52
2954	2001-06-06	\N	52
2955	2001-06-07	\N	52
2956	2001-06-08	\N	52
2957	2001-06-09	\N	52
2958	2001-06-10	\N	52
2959	2001-06-11	\N	52
2960	2001-06-12	\N	52
2961	2005-04-12	\N	53
2962	2005-04-13	\N	53
2963	2005-04-14	\N	53
2964	2005-04-15	\N	53
2965	2005-04-16	\N	53
2966	2005-04-17	\N	53
2967	2005-04-18	\N	53
2968	2005-04-19	\N	53
2969	2005-04-20	\N	53
2970	2005-04-21	\N	53
2971	2005-04-22	\N	53
2972	2005-04-23	\N	53
2973	2005-04-24	\N	53
2974	2005-04-25	\N	53
2975	2005-04-26	\N	53
2976	2005-04-27	\N	53
2977	2005-04-28	\N	53
2978	2005-04-29	\N	53
2979	2005-04-30	\N	53
2980	2005-05-01	\N	53
2981	2005-05-02	\N	53
2982	2005-05-03	\N	53
2983	2005-05-04	\N	53
2984	2005-05-05	\N	53
2985	2005-05-06	\N	53
2986	2005-05-07	\N	53
2987	2005-05-08	\N	53
2988	2005-05-09	\N	53
2989	2005-05-10	\N	53
2990	2010-04-13	\N	54
2991	2010-04-14	\N	54
2992	2010-04-15	\N	54
2993	2010-04-16	\N	54
2994	2010-04-17	\N	54
2995	2010-04-18	\N	54
2996	2010-04-19	\N	54
2997	2010-04-20	\N	54
2998	2010-04-21	\N	54
2999	2010-04-22	\N	54
3000	2010-04-23	\N	54
3001	2010-04-24	\N	54
3002	2010-04-25	\N	54
3003	2010-04-26	\N	54
3004	2010-04-27	\N	54
3005	2010-04-28	\N	54
3006	2010-04-29	\N	54
3007	2010-04-30	\N	54
3008	2010-05-01	\N	54
3009	2010-05-02	\N	54
3010	2010-05-03	\N	54
3011	2010-05-04	\N	54
3012	2010-05-05	\N	54
3013	2010-05-06	\N	54
3014	2010-05-07	\N	54
3015	2010-05-08	\N	54
3016	2010-05-09	\N	54
3017	2010-05-10	\N	54
3018	2010-05-11	\N	54
3019	2010-05-12	\N	54
3020	2010-05-13	\N	54
3021	2010-05-14	\N	54
3022	2010-05-15	\N	54
3023	2010-05-16	\N	54
3024	2010-05-17	\N	54
3025	2015-03-31	\N	55
3026	2015-04-01	\N	55
3027	2015-04-02	\N	55
3028	2015-04-03	\N	55
3029	2015-04-04	\N	55
3030	2015-04-05	\N	55
3031	2015-04-06	\N	55
3032	2015-04-07	\N	55
3033	2015-04-08	\N	55
3034	2015-04-09	\N	55
3035	2015-04-10	\N	55
3036	2015-04-11	\N	55
3037	2015-04-12	\N	55
3038	2015-04-13	\N	55
3039	2015-04-14	\N	55
3040	2015-04-15	\N	55
3041	2015-04-16	\N	55
3042	2015-04-17	\N	55
3043	2015-04-18	\N	55
3044	2015-04-19	\N	55
3045	2015-04-20	\N	55
3046	2015-04-21	\N	55
3047	2015-04-22	\N	55
3048	2015-04-23	\N	55
3049	2015-04-24	\N	55
3050	2015-04-25	\N	55
3051	2015-04-26	\N	55
3052	2015-04-27	\N	55
3053	2015-04-28	\N	55
3054	2015-04-29	\N	55
3055	2015-04-30	\N	55
3056	2015-05-01	\N	55
3057	2015-05-02	\N	55
3058	2015-05-03	\N	55
3059	2015-05-04	\N	55
3060	2015-05-05	\N	55
3061	2015-05-06	\N	55
3062	2015-05-07	\N	55
3063	2015-05-08	\N	55
3064	2015-05-09	\N	55
3065	2015-05-10	\N	55
3066	2015-05-11	\N	55
3067	2015-05-12	\N	55
3068	2015-05-13	\N	55
3069	2015-05-14	\N	55
3070	2015-05-15	\N	55
3071	2015-05-16	\N	55
3072	2015-05-17	\N	55
3073	2017-05-04	\N	56
3074	2017-05-05	\N	56
3075	2017-05-06	\N	56
3076	2017-05-07	\N	56
3077	2017-05-08	\N	56
3078	2017-05-09	\N	56
3079	2017-05-10	\N	56
3080	2017-05-11	\N	56
3081	2017-05-12	\N	56
3082	2017-05-13	\N	56
3083	2017-05-14	\N	56
3084	2017-05-15	\N	56
3085	2017-05-16	\N	56
3086	2017-05-17	\N	56
3087	2017-05-18	\N	56
3088	2017-05-19	\N	56
3089	2017-05-20	\N	56
3090	2017-05-21	\N	56
3091	2017-05-22	\N	56
3092	2017-05-23	\N	56
3093	2017-05-24	\N	56
3094	2017-05-25	\N	56
3095	2017-05-26	\N	56
3096	2017-05-27	\N	56
3097	2017-05-28	\N	56
3098	2017-05-29	\N	56
3099	2017-05-30	\N	56
3100	2017-05-31	\N	56
3101	2017-06-01	\N	56
3102	2017-06-02	\N	56
3103	2017-06-03	\N	56
3104	2017-06-04	\N	56
3105	2017-06-05	\N	56
3106	2017-06-06	\N	56
3107	2017-06-07	\N	56
3108	2017-06-08	\N	56
3109	2017-06-09	\N	56
3110	2017-06-10	\N	56
3111	2017-06-11	\N	56
3112	2017-06-12	\N	56
3113	2019-11-06	\N	57
3114	2019-11-07	\N	57
3115	2019-11-08	\N	57
3116	2019-11-09	\N	57
3117	2019-11-10	\N	57
3118	2019-11-11	\N	57
3119	2019-11-12	\N	57
3120	2019-11-13	\N	57
3121	2019-11-14	\N	57
3122	2019-11-15	\N	57
3123	2019-11-16	\N	57
3124	2019-11-17	\N	57
3125	2019-11-18	\N	57
3126	2019-11-19	\N	57
3127	2019-11-20	\N	57
3128	2019-11-21	\N	57
3129	2019-11-22	\N	57
3130	2019-11-23	\N	57
3131	2019-11-24	\N	57
3132	2019-11-25	\N	57
3133	2019-11-26	\N	57
3134	2019-11-27	\N	57
3135	2019-11-28	\N	57
3136	2019-11-29	\N	57
3137	2019-11-30	\N	57
3138	2019-12-01	\N	57
3139	2019-12-02	\N	57
3140	2019-12-03	\N	57
3141	2019-12-04	\N	57
3142	2019-12-05	\N	57
3143	2019-12-06	\N	57
3144	2019-12-07	\N	57
3145	2019-12-08	\N	57
3146	2019-12-09	\N	57
3147	2019-12-10	\N	57
3148	2019-12-11	\N	57
3149	2019-12-12	\N	57
3150	2019-12-13	\N	57
3151	2019-12-14	\N	57
3152	2019-12-15	\N	57
3153	2019-12-16	\N	57
\.


--
-- Data for Name: dissolution_periods; Type: TABLE DATA; Schema: public; Owner: robert
--

COPY public.dissolution_periods (id, number, start_date, end_date) FROM stdin;
1	1	1802-06-30	1802-11-15
2	2	1806-10-25	1806-12-14
3	3	1807-04-30	1807-06-21
4	4	1812-09-30	1812-11-23
5	5	1818-06-11	1819-01-13
6	6	1820-03-01	1820-04-20
7	7	1826-06-03	1826-11-13
8	8	1830-07-25	1830-10-25
9	9	1831-04-24	1831-06-13
10	10	1832-12-04	1833-01-28
11	11	1834-12-30	1835-02-18
12	12	1837-07-18	1837-11-14
13	13	1841-06-24	1841-08-18
14	14	1847-07-24	1847-11-17
15	15	1852-07-02	1852-11-03
16	16	1857-03-22	1857-04-29
17	17	1859-04-24	1859-05-30
18	18	1865-07-07	1866-01-31
19	19	1868-11-12	1868-12-09
20	20	1874-01-27	1874-03-04
21	21	1880-03-25	1880-04-28
22	22	1885-11-19	1886-01-11
23	23	1886-06-27	1886-08-04
24	24	1892-06-29	1892-08-03
25	25	1895-07-09	1895-08-11
26	26	1900-09-18	1900-12-02
27	27	1906-01-09	1906-02-12
28	28	1910-01-11	1910-02-14
29	29	1910-11-29	1911-01-30
30	30	1918-11-26	1919-02-03
31	31	1922-10-27	1922-11-19
32	32	1923-11-17	1924-01-07
33	33	1924-10-10	1924-12-01
34	34	1929-05-11	1929-06-24
35	35	1931-10-08	1931-11-02
36	36	1935-10-26	1935-11-25
37	37	1945-06-16	1945-07-31
38	38	1950-02-04	1950-02-28
39	39	1951-10-06	1951-10-30
40	40	1955-05-07	1955-06-06
41	41	1959-09-19	1959-10-19
42	42	1964-09-26	1964-10-26
43	43	1966-03-11	1966-04-17
44	44	1970-05-30	1970-06-28
45	45	1974-02-09	1974-03-05
46	46	1974-09-21	1974-10-21
47	47	1979-04-08	1979-05-08
48	48	1983-05-14	1983-06-14
49	49	1987-05-19	1987-06-16
50	50	1992-03-17	1992-04-26
51	51	1997-04-09	1997-05-06
52	52	2001-05-15	2001-06-12
53	53	2005-04-12	2005-05-10
54	54	2010-04-13	2010-05-17
55	55	2015-03-31	2015-05-17
56	56	2017-05-04	2017-06-12
57	57	2019-11-06	2019-12-16
\.


--
-- Data for Name: houses; Type: TABLE DATA; Schema: public; Owner: robert
--

COPY public.houses (id, name) FROM stdin;
1	House of Commons
2	House of Lords
\.


--
-- Data for Name: parliament_periods; Type: TABLE DATA; Schema: public; Owner: robert
--

COPY public.parliament_periods (id, number, start_date, end_date) FROM stdin;
1	1	1801-01-22	1802-06-29
2	2	1802-11-16	1806-10-24
3	3	1806-12-15	1807-04-29
4	4	1807-06-22	1812-09-29
5	5	1812-11-24	1818-06-10
6	6	1819-01-14	1820-02-29
7	7	1820-04-21	1826-06-02
8	8	1826-11-14	1830-07-24
9	9	1830-10-26	1831-04-23
10	10	1831-06-14	1832-12-03
11	11	1833-01-29	1834-12-29
12	12	1835-02-19	1837-07-17
13	13	1837-11-15	1841-06-23
14	14	1841-08-19	1847-07-23
15	15	1847-11-18	1852-07-01
16	16	1852-11-04	1857-03-21
17	17	1857-04-30	1859-04-23
18	18	1859-05-31	1865-07-06
19	19	1866-02-01	1868-11-11
20	20	1868-12-10	1874-01-26
21	21	1874-03-05	1880-03-24
22	22	1880-04-29	1885-11-18
23	23	1886-01-12	1886-06-26
24	24	1886-08-05	1892-06-28
25	25	1892-08-04	1895-07-08
26	26	1895-08-12	1900-09-17
27	27	1900-12-03	1906-01-08
28	28	1906-02-13	1910-01-10
29	29	1910-02-15	1910-11-28
30	30	1911-01-31	1918-11-25
31	31	1919-02-04	1922-10-26
32	32	1922-11-20	1923-11-16
33	33	1924-01-08	1924-10-09
34	34	1924-12-02	1929-05-10
35	35	1929-06-25	1931-10-07
36	36	1931-11-03	1935-10-25
37	37	1935-11-26	1945-06-15
38	38	1945-08-01	1950-02-03
39	39	1950-03-01	1951-10-05
40	40	1951-10-31	1955-05-06
41	41	1955-06-07	1959-09-18
42	42	1959-10-20	1964-09-25
43	43	1964-10-27	1966-03-10
44	44	1966-04-18	1970-05-29
45	45	1970-06-29	1974-02-08
46	46	1974-03-06	1974-09-20
47	47	1974-10-22	1979-04-07
48	48	1979-05-09	1983-05-13
49	49	1983-06-15	1987-05-18
50	50	1987-06-17	1992-03-16
51	51	1992-04-27	1997-04-08
52	52	1997-05-07	2001-05-14
53	53	2001-06-13	2005-04-11
54	54	2005-05-11	2010-04-12
55	55	2010-05-18	2015-03-30
56	56	2015-05-18	2017-05-03
57	57	2017-06-13	2019-11-05
58	58	2019-12-17	\N
\.


--
-- Data for Name: procedures; Type: TABLE DATA; Schema: public; Owner: robert
--

COPY public.procedures (id, display_order, name, active) FROM stdin;
1	1	Legislative Reform Order approval period	t
2	2	Localism Order approval period	t
3	3	Proposed Negative Statutory Instrument committee sifting period	t
5	5	Statutory Instrument praying period (Commons only)	t
6	6	Statutory Instrument praying period (Commons and Lords)	t
7	7	Statutory Instrument approval period (Commons only)	t
8	8	Statutory Instrument approval period (Commons and Lords, both Houses sitting)	t
9	9	Statutory Instrument approval period (Commons and Lords, either House sitting)	t
10	10	Treaty objection period A	t
11	11	Treaty objection period B	t
4	4	Public Bodies Order approval period	f
\.


--
-- Data for Name: prorogation_days; Type: TABLE DATA; Schema: public; Owner: robert
--

COPY public.prorogation_days (id, date, google_event_id, prorogation_period_id) FROM stdin;
1	1980-11-14	\N	1
2	1980-11-15	\N	1
3	1980-11-16	\N	1
4	1980-11-17	\N	1
5	1980-11-18	\N	1
6	1980-11-19	\N	1
7	1981-10-31	\N	2
8	1981-11-01	\N	2
9	1981-11-02	\N	2
10	1981-11-03	\N	2
11	1982-10-29	\N	3
12	1982-10-30	\N	3
13	1982-10-31	\N	3
14	1982-11-01	\N	3
15	1982-11-02	\N	3
16	1984-11-01	\N	4
17	1984-11-02	\N	4
18	1984-11-03	\N	4
19	1984-11-04	\N	4
20	1984-11-05	\N	4
21	1985-10-31	\N	5
22	1985-11-01	\N	5
23	1985-11-02	\N	5
24	1985-11-03	\N	5
25	1985-11-04	\N	5
26	1985-11-05	\N	5
27	1986-11-08	\N	6
28	1986-11-09	\N	6
29	1986-11-10	\N	6
30	1986-11-11	\N	6
31	1988-11-16	\N	7
32	1988-11-17	\N	7
33	1988-11-18	\N	7
34	1988-11-19	\N	7
35	1988-11-20	\N	7
36	1988-11-21	\N	7
37	1989-11-17	\N	8
38	1989-11-18	\N	8
39	1989-11-19	\N	8
40	1989-11-20	\N	8
41	1990-11-02	\N	9
42	1990-11-03	\N	9
43	1990-11-04	\N	9
44	1990-11-05	\N	9
45	1990-11-06	\N	9
46	1991-10-23	\N	10
47	1991-10-24	\N	10
48	1991-10-25	\N	10
49	1991-10-26	\N	10
50	1991-10-27	\N	10
51	1991-10-28	\N	10
52	1991-10-29	\N	10
53	1991-10-30	\N	10
54	1993-11-06	\N	11
55	1993-11-07	\N	11
56	1993-11-08	\N	11
57	1993-11-09	\N	11
58	1993-11-10	\N	11
59	1993-11-11	\N	11
60	1993-11-12	\N	11
61	1993-11-13	\N	11
62	1993-11-14	\N	11
63	1993-11-15	\N	11
64	1993-11-16	\N	11
65	1993-11-17	\N	11
66	1994-11-04	\N	12
67	1994-11-05	\N	12
68	1994-11-06	\N	12
69	1994-11-07	\N	12
70	1994-11-08	\N	12
71	1994-11-09	\N	12
72	1994-11-10	\N	12
73	1994-11-11	\N	12
74	1994-11-12	\N	12
75	1994-11-13	\N	12
76	1994-11-14	\N	12
77	1994-11-15	\N	12
78	1995-11-09	\N	13
79	1995-11-10	\N	13
80	1995-11-11	\N	13
81	1995-11-12	\N	13
82	1995-11-13	\N	13
83	1995-11-14	\N	13
84	1996-10-18	\N	14
85	1996-10-19	\N	14
86	1996-10-20	\N	14
87	1996-10-21	\N	14
88	1996-10-22	\N	14
89	1998-11-20	\N	15
90	1998-11-21	\N	15
91	1998-11-22	\N	15
92	1998-11-23	\N	15
93	1999-11-12	\N	16
94	1999-11-13	\N	16
95	1999-11-14	\N	16
96	1999-11-15	\N	16
97	1999-11-16	\N	16
98	2000-12-01	\N	17
99	2000-12-02	\N	17
100	2000-12-03	\N	17
101	2000-12-04	\N	17
102	2002-11-08	\N	18
103	2002-11-09	\N	18
104	2002-11-10	\N	18
105	2002-11-11	\N	18
106	2002-11-12	\N	18
107	2003-11-21	\N	19
108	2003-11-22	\N	19
109	2003-11-23	\N	19
110	2003-11-24	\N	19
111	2003-11-25	\N	19
112	2004-11-19	\N	20
113	2004-11-20	\N	20
114	2004-11-21	\N	20
115	2004-11-22	\N	20
116	2006-11-09	\N	21
117	2006-11-10	\N	21
118	2006-11-11	\N	21
119	2006-11-12	\N	21
120	2006-11-13	\N	21
121	2006-11-14	\N	21
122	2007-10-31	\N	22
123	2007-11-01	\N	22
124	2007-11-02	\N	22
125	2007-11-03	\N	22
126	2007-11-04	\N	22
127	2007-11-05	\N	22
128	2008-11-27	\N	23
129	2008-11-28	\N	23
130	2008-11-29	\N	23
131	2008-11-30	\N	23
132	2008-12-01	\N	23
133	2008-12-02	\N	23
134	2009-11-13	\N	24
135	2009-11-14	\N	24
136	2009-11-15	\N	24
137	2009-11-16	\N	24
138	2009-11-17	\N	24
139	2012-05-02	\N	25
140	2012-05-03	\N	25
141	2012-05-04	\N	25
142	2012-05-05	\N	25
143	2012-05-06	\N	25
144	2012-05-07	\N	25
145	2012-05-08	\N	25
146	2013-04-26	\N	26
147	2013-04-27	\N	26
148	2013-04-28	\N	26
149	2013-04-29	\N	26
150	2013-04-30	\N	26
151	2013-05-01	\N	26
152	2013-05-02	\N	26
153	2013-05-03	\N	26
154	2013-05-04	\N	26
155	2013-05-05	\N	26
156	2013-05-06	\N	26
157	2013-05-07	\N	26
158	2014-05-15	\N	27
159	2014-05-16	\N	27
160	2014-05-17	\N	27
161	2014-05-18	\N	27
162	2014-05-19	\N	27
163	2014-05-20	\N	27
164	2014-05-21	\N	27
165	2014-05-22	\N	27
166	2014-05-23	\N	27
167	2014-05-24	\N	27
168	2014-05-25	\N	27
169	2014-05-26	\N	27
170	2014-05-27	\N	27
171	2014-05-28	\N	27
172	2014-05-29	\N	27
173	2014-05-30	\N	27
174	2014-05-31	\N	27
175	2014-06-01	\N	27
176	2014-06-02	\N	27
177	2014-06-03	\N	27
178	2016-05-13	\N	28
179	2016-05-14	\N	28
180	2016-05-15	\N	28
181	2016-05-16	\N	28
182	2016-05-17	\N	28
183	2019-10-09	\N	29
184	2019-10-10	\N	29
185	2019-10-11	\N	29
186	2019-10-12	\N	29
187	2019-10-13	\N	29
\.


--
-- Data for Name: prorogation_periods; Type: TABLE DATA; Schema: public; Owner: robert
--

COPY public.prorogation_periods (id, number, start_date, end_date, parliament_period_id) FROM stdin;
1	1	1980-11-14	1980-11-19	48
2	2	1981-10-31	1981-11-03	48
3	3	1982-10-29	1982-11-02	48
4	1	1984-11-01	1984-11-05	49
5	2	1985-10-31	1985-11-05	49
6	3	1986-11-08	1986-11-11	49
7	1	1988-11-16	1988-11-21	50
8	2	1989-11-17	1989-11-20	50
9	3	1990-11-02	1990-11-06	50
10	4	1991-10-23	1991-10-30	50
11	1	1993-11-06	1993-11-17	51
12	2	1994-11-04	1994-11-15	51
13	3	1995-11-09	1995-11-14	51
14	4	1996-10-18	1996-10-22	51
15	1	1998-11-20	1998-11-23	52
16	2	1999-11-12	1999-11-16	52
17	3	2000-12-01	2000-12-04	52
18	1	2002-11-08	2002-11-12	53
19	2	2003-11-21	2003-11-25	53
20	3	2004-11-19	2004-11-22	53
21	1	2006-11-09	2006-11-14	54
22	2	2007-10-31	2007-11-05	54
23	3	2008-11-27	2008-12-02	54
24	4	2009-11-13	2009-11-17	54
25	1	2012-05-02	2012-05-08	55
26	2	2013-04-26	2013-05-07	55
27	3	2014-05-15	2014-06-03	55
28	1	2016-05-13	2016-05-17	56
29	1	2019-10-09	2019-10-13	57
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: robert
--

COPY public.sessions (id, number, start_date, end_date, parliament_period_id) FROM stdin;
1	1	2019-12-17	\N	58
2	2	2019-10-14	2019-11-05	57
3	1	2017-06-13	2019-10-08	57
4	2	2016-05-18	2017-05-03	56
5	1	2015-05-18	2016-05-12	56
6	4	2014-06-04	2015-03-30	55
7	3	2013-05-08	2014-05-14	55
8	2	2012-05-09	2013-04-25	55
9	1	2010-05-18	2012-05-01	55
10	5	2009-11-18	2010-04-12	54
11	4	2008-12-03	2009-11-12	54
12	3	2007-11-06	2008-11-26	54
13	2	2006-11-15	2007-10-30	54
14	1	2005-05-11	2006-11-08	54
15	4	2004-11-23	2005-04-11	53
16	3	2003-11-26	2004-11-18	53
17	2	2002-11-13	2003-11-20	53
18	1	2001-06-13	2002-11-07	53
19	4	2000-12-05	2001-05-14	52
20	3	1999-11-17	2000-11-30	52
21	2	1998-11-24	1999-11-11	52
22	1	1997-05-07	1998-11-19	52
23	5	1996-10-23	1997-04-08	51
24	4	1995-11-15	1996-10-17	51
25	3	1994-11-16	1995-11-08	51
26	2	1993-11-18	1994-11-03	51
27	1	1992-04-27	1993-11-05	51
28	5	1991-10-31	1992-03-16	50
29	4	1990-11-07	1991-10-22	50
30	3	1989-11-21	1990-11-01	50
31	2	1988-11-22	1989-11-16	50
32	1	1987-06-17	1988-11-15	50
33	4	1986-11-12	1987-05-18	49
34	3	1985-11-06	1986-11-07	49
35	2	1984-11-06	1985-10-30	49
36	1	1983-06-15	1984-10-31	49
37	4	1982-11-03	1983-05-13	48
38	3	1981-11-04	1982-10-28	48
39	2	1980-11-20	1981-10-30	48
40	1	1979-05-09	1980-11-13	48
\.


--
-- Data for Name: sitting_days; Type: TABLE DATA; Schema: public; Owner: robert
--

COPY public.sitting_days (id, start_date, end_date, google_event_id, session_id, house_id) FROM stdin;
1	2019-12-17	2019-12-17	1l315ap1009i5hbkgr0v1cehsv	1	1
2	2019-12-18	2019-12-18	449nhv54qdlpb0mp8rlvsda3iv	1	1
3	2019-12-19	2019-12-19	56srt31t6vb25dmdbbr4ptcid9	1	1
4	2019-12-20	2019-12-20	6l0ag6t5e064sb4f7egr62qs2r	1	1
5	2020-01-07	2020-01-07	4pm65lfmjke2fvsi2fasqsd1lu	1	1
6	2020-01-08	2020-01-08	20fbor74k2ht7pi1s6jaccv4c7	1	1
7	2020-01-09	2020-01-09	78asadqiddoa5p1183mlrphj30	1	1
8	2020-01-13	2020-01-13	6ivea4t3dfhn7ffvtdcitrri0e	1	1
9	2020-01-14	2020-01-14	1ljar3ivthta447hsl34r38vj5	1	1
10	2020-01-15	2020-01-15	3uuqq30koapn9hc9u07gkqbpob	1	1
11	2020-01-16	2020-01-16	3ofeersq7ntqrqg74ic2pt2tlk	1	1
12	2020-01-20	2020-01-20	7sdcjvn1i0upjp3c8f3qiurbkf	1	1
13	2020-01-21	2020-01-21	0qgt7q6uqdvifec9a04n3vtbli	1	1
14	2020-01-22	2020-01-22	289v4btsibeue29rkabnputulr	1	1
15	2020-01-23	2020-01-23	4vtve01q988fqakkj4k76dgf4k	1	1
16	2020-01-27	2020-01-27	3pql9584vlkm9drgt3pieivkce	1	1
17	2020-01-28	2020-01-28	1kol989r5hpb4gv35675s77vd8	1	1
18	2020-01-29	2020-01-29	5fjt6ploo5tn41nt8o7nhnf10a	1	1
19	2020-01-30	2020-01-30	5c37oje02a0gvlogt2qd4rq921	1	1
20	2020-02-03	2020-02-03	60gt316tmqg7jnfc5tu33decc3	1	1
21	2020-02-04	2020-02-04	63jcneg465bu4du4slpd10hvps	1	1
22	2020-02-05	2020-02-05	65tgfh7cig018kukhcgs66dog5	1	1
23	2020-02-06	2020-02-06	66jnp51gtsl6mkr44s8fhcsgvo	1	1
24	2020-02-10	2020-02-10	0gqj9oi2kfomae5bgs2iavvmfb	1	1
25	2020-02-11	2020-02-11	3s19t7sca7d70iv6p9f6citftg	1	1
26	2020-02-12	2020-02-12	42gvse4f0nbacurakh4anvkpb5	1	1
27	2020-02-13	2020-02-13	0i33uud8m8evciruq0pom6dot0	1	1
28	2020-02-24	2020-02-24	1bshgditlvmomc02hrdpfethu8	1	1
29	2020-02-25	2020-02-25	4km6h3gk5qk46fctrahhj0rass	1	1
30	2020-02-26	2020-02-26	4b4k7rsqcn9ppetj6don7hhpa8	1	1
31	2020-02-27	2020-02-27	1dsj00jgjcrj44jvs231hos1n1	1	1
32	2020-03-02	2020-03-02	672ga23re6bc3n6n1akm264pmm	1	1
33	2020-03-03	2020-03-03	6s1qd35oits76fgjchd77r3387	1	1
34	2020-03-04	2020-03-04	6aclf8432rd303ruh0t763u11h	1	1
35	2020-03-05	2020-03-05	7edmb4b7v6sbj81v6rnmcffcnd	1	1
36	2020-03-09	2020-03-09	5lfle6tk3efoe7ohi4c39mv17t	1	1
37	2020-03-10	2020-03-10	055n74l65tnipgoiua22pspsqp	1	1
38	2020-03-11	2020-03-11	3bgqn6vhftqkl9ntol0c329qg6	1	1
39	2020-03-12	2020-03-12	73biau21pb5h95jefkd63s5d7f	1	1
40	2020-03-13	2020-03-13	1kfa0v3cm2evjifaikg9eapqli	1	1
41	2020-03-16	2020-03-16	1m67lecn7patait7qb9k43tntk	1	1
42	2020-03-17	2020-03-17	2ijktaggqrsreidnmgi7579s4u	1	1
43	2020-03-18	2020-03-18	15g374scbgq0fnbr8r5jccvcdi	1	1
44	2020-03-19	2020-03-19	6sjc6n6aqbti7o37k28vbv9elo	1	1
45	2020-03-23	2020-03-23	31vb6ho5ro9esrru20mq4dpij9	1	1
46	2020-03-24	2020-03-24	3kplb2vknrvbd5s1ieelilk1pu	1	1
47	2020-03-25	2020-03-25	239k3uvsp17si79pl1r2v2gmsl	1	1
48	2020-04-21	2020-04-21	2r54ln8o7jukmu19eum0nh7tj1	1	1
49	2020-04-22	2020-04-22	33c62jcr08fs5lf73c9vqrh773	1	1
50	2020-04-27	2020-04-27	0s8vkh4pr6r3b6843l69qs6tpp	1	1
51	2020-04-28	2020-04-28	6df0s75gtb95b8978okrn97s77	1	1
52	2020-04-29	2020-04-29	2sq2c5evg43tdfk6ietccu1g78	1	1
53	2020-05-04	2020-05-04	50erjjbtkn19iks0e6p0i6lk0c	1	1
54	2020-05-05	2020-05-05	2a2r7rj48jjcalpubfq6hqeb3d	1	1
55	2020-05-06	2020-05-06	1eveo7vuv5edb70hjs55ad5eq3	1	1
56	2020-05-11	2020-05-11	2177a053av4ubcqsgr85r1mvvs	1	1
57	2020-05-12	2020-05-12	78pm04skplqen1m6n23lpipnv0	1	1
58	2020-05-13	2020-05-13	2d16rfi2uatec8m1a2n1cp0596	1	1
59	2020-05-18	2020-05-18	7mjtcsd4t7g4rdbl95ktb25ve2	1	1
60	2020-05-19	2020-05-19	5eusk302oi8p0emqjbc3q0kkrc	1	1
61	2020-05-20	2020-05-20	57r94u5ln2vr1t7bmbihjgdah0	1	1
62	2020-06-02	2020-06-02	0r78tr5m81k4iem6ckpslioogm	1	1
63	2020-06-03	2020-06-03	72csbrmf09rdsdmbp2kl9jg0ee	1	1
64	2020-06-04	2020-06-04	29mqhb5g784idogrl14t7opdlp	1	1
65	2020-06-08	2020-06-08	4f5of7vsdkc3p8s6n9dic5cnmr	1	1
66	2020-06-09	2020-06-09	7jap32hj5f9g17d5qpp8hcds8t	1	1
67	2020-06-10	2020-06-10	6d1hh95qhbs1mviumau4ncb29c	1	1
68	2020-06-11	2020-06-11	2f4put9kauhfiam2tfue34o75o	1	1
69	2020-06-15	2020-06-15	7b4pp73mv90vqrcrrme3248ai8	1	1
70	2020-06-16	2020-06-16	6dgl8evr0jivjadfb7mhnufjet	1	1
79	2020-07-15	2020-07-15	3q00q0o3fhrcf2i9gfaav3dd37	1	1
80	2020-07-16	2020-07-16	3ooqng6samonj507e6aev07aj4	1	1
81	2020-07-20	2020-07-20	5lon02kkbcmk7124fodquufqhb	1	1
82	2020-07-21	2020-07-21	5hb2vhrpt2hmkn7o8c89o038cm	1	1
83	2020-09-08	2020-09-08	1p50u82grljlrs1ditq48tkapj	1	1
84	2020-09-09	2020-09-09	0cn1i1030u2lpgm022iq261vfo	1	1
85	2020-09-10	2020-09-10	276r4qsb4saurl93bvph3m1hs9	1	1
86	2020-09-14	2020-09-14	3rd3pvmpcsi9gsttb288mk1633	1	1
87	2020-09-15	2020-09-15	3fbsl1or36r0g5hvcp285j53an	1	1
88	2020-09-16	2020-09-16	62r0c49vckhvudslk4eita1n1f	1	1
89	2020-09-17	2020-09-17	7gu3a3s70uodhhmdp6s1m37ukf	1	1
90	2017-06-21	2017-06-21	04fkh76vncif24blpcgn9t3rs1	3	1
91	2017-06-22	2017-06-22	4m77nkejv5m3vdg7t4hp50vaql	3	1
92	2017-06-26	2017-06-26	55ug0pds2e9gtcunlkjv7qc77e	3	1
93	2017-06-27	2017-06-27	6r5pdc5m5s8fuibrjt7art2ce0	3	1
94	2017-06-28	2017-06-28	55f1se0nbrbcfgec3tablb980j	3	1
95	2017-06-29	2017-06-29	4pepj6qf5f5bo87mr2tt65mdn4	3	1
96	2017-06-13	2017-06-13	69k6381tmrqdlaglrscd0ci84t	3	1
97	2017-06-14	2017-06-14	0kmdnveoeqolbppk64v1ei8k0b	3	1
98	2017-06-15	2017-06-15	55t936pdnaagt90et5ubs9jje2	3	1
99	2020-06-17	2020-06-17	0gdirr0mbfru0b9f4s9vvgcsut	1	1
100	2017-07-03	2017-07-03	2mi83oo3m17s0rhg08lkb47ris	3	1
101	2017-07-04	2017-07-04	2qnr2a4rlgj8nb8nkvrot2nd95	3	1
102	2017-07-05	2017-07-05	42dou2haqgd778r535k44b6nru	3	1
103	2017-07-06	2017-07-06	66g1fdeg1rf8aojdmf1ulsefpg	3	1
104	2017-07-10	2017-07-10	7fm2le555517op90hb5iu2f8en	3	1
105	2017-07-11	2017-07-11	422oukcs3ctsv3t22ervfs0pr8	3	1
106	2017-07-12	2017-07-12	00c0t1gc10nube0ddblrpb7dji	3	1
107	2017-07-13	2017-07-13	4rni8kabuub9g6k54947rdh458	3	1
108	2017-07-17	2017-07-17	7lqqdvg6pvo4iiign5o01bc84a	3	1
109	2017-07-18	2017-07-18	67reteh217qunr3hobr625uk0n	3	1
110	2017-07-19	2017-07-19	7vascbt4h7e5ulm9mj4thbag3l	3	1
111	2017-07-20	2017-07-20	4u2ha4557b7v7vlrl1ei9no8qp	3	1
112	2017-09-05	2017-09-05	360ed5vt126s2l8f822jsrv37q	3	1
113	2017-09-06	2017-09-06	7h6c7oltap8colnak5k6f3toh8	3	1
114	2017-09-07	2017-09-07	0h1g88bq1onljidg3o58ef5cbh	3	1
115	2017-09-11	2017-09-11	6g07l9uqtc5velntd3fbhsuspn	3	1
116	2017-09-12	2017-09-12	1fe68okfh6g6i9fq421pfi0l49	3	1
117	2017-09-13	2017-09-13	72k3mekok8fv1ufnvc59nr83vm	3	1
118	2017-09-14	2017-09-14	165qghanof2ibr0ljcejhcto0b	3	1
119	2017-10-09	2017-10-09	0dkd7o7dvo9ni2ujrm7uuei166	3	1
120	2017-10-10	2017-10-10	7uhd0msbi28prorhu3b65oa1fj	3	1
121	2017-10-11	2017-10-11	41n186rv62hf5eaa1am1s3etgq	3	1
122	2017-10-12	2017-10-12	2ort18ppvijk8g8atcrg7fops6	3	1
123	2017-10-16	2017-10-16	1l5161mujmnlifov75an77p5je	3	1
124	2017-10-17	2017-10-17	3pp6oro17h3k34tf8tvcbn6u5i	3	1
125	2017-10-18	2017-10-18	7mojtpqeuq8cdidnlj15novimk	3	1
126	2017-10-19	2017-10-19	02knske3s0kdj7ds4fvav2jpf1	3	1
127	2017-10-20	2017-10-20	0ipeh91dfj6l2l1152fd4qrq35	3	1
128	2017-10-23	2017-10-23	7p54jc5p26hfk898g0rqjf04p1	3	1
129	2017-10-24	2017-10-24	5k19rj2mg682quisohannku4il	3	1
130	2017-10-25	2017-10-25	036qodi6h3cts2fefp07fkrkcl	3	1
131	2017-10-26	2017-10-26	0c2bohnonr7jjfusov016srijv	3	1
132	2017-10-30	2017-10-30	3nff1gjahjqqk0u9coqmpph220	3	1
133	2017-10-31	2017-10-31	14elvaktp70k2hc88q8ngsi3ma	3	1
134	2017-11-01	2017-11-01	777hadvc48e8gvbg3nrqst50le	3	1
135	2017-11-02	2017-11-02	4i15ece02icviflru881p4p0t9	3	1
136	2017-11-03	2017-11-03	534hvboc3en42m6m9nnog44u9m	3	1
137	2017-11-06	2017-11-06	6v0fkbfgqkldog2shf984lloci	3	1
138	2017-11-07	2017-11-07	2phrr447beu0iu1lmtg2oqin9m	3	1
139	2017-11-13	2017-11-13	0u2aj4pevjh67bos3c39va9vu3	3	1
140	2017-11-14	2017-11-14	32lrqec7lma2au5p7le9v61d69	3	1
141	2017-11-15	2017-11-15	5c3n9outihb5hi153uailj7rto	3	1
142	2017-11-16	2017-11-16	5ld8d8bgaoijak77q00c0kv4c4	3	1
143	2017-11-20	2017-11-20	08g4bac0li4ufbahic8l7k90k2	3	1
144	2017-11-21	2017-11-21	62ckgeokqskurt5tqll30j2gbb	3	1
145	2017-11-22	2017-11-22	3ueb897bl8sp8o9r3qfsl7jf2s	3	1
146	2017-11-23	2017-11-23	0ctf6vh8glnfd7t5pdmotqms48	3	1
147	2017-11-27	2017-11-27	6qs6tbb58qe2fs7uk3qqtfkg47	3	1
148	2017-11-28	2017-11-28	082l3ei9kon7e9ljgd46vi6dtp	3	1
149	2017-11-29	2017-11-29	625s9vogh0fvph8il1hl9fcfc5	3	1
150	2017-11-30	2017-11-30	3a4vvu4klh3v5bakqpenlml9vh	3	1
151	2017-12-01	2017-12-01	4pi1qu5jlh2k062fvplvlfdrbj	3	1
152	2017-12-04	2017-12-04	1sls0orrd1ivm2gh1edh820cl7	3	1
153	2017-12-05	2017-12-05	6ivqqvaj8arsfk58smb6qlvkb9	3	1
154	2017-12-06	2017-12-06	368rgfs5dmqt81fq93rjgdiegd	3	1
155	2017-12-07	2017-12-07	358u6tafk8gbq7lgc8mso6fpu1	3	1
156	2017-12-11	2017-12-11	202laoqdd0pri3itra401h8f6q	3	1
157	2017-12-12	2017-12-12	2t5n3q24ld5ejr3e9dum9gq6v4	3	1
158	2017-12-13	2017-12-13	66v032t774b1psjpegs8juqrmh	3	1
159	2017-12-14	2017-12-14	2srrd14lqsm0rsqkols3omcopd	3	1
160	2017-12-18	2017-12-18	1hii066s259u35ukl94sl622iu	3	1
161	2017-12-19	2017-12-19	4j2udlma4qhhuc65r8emg12ts0	3	1
162	2017-12-20	2017-12-20	5s48qaftdbjup2geijqoc90b65	3	1
163	2017-12-21	2017-12-21	2p38cbphr6m8fog48vg9pd64p1	3	1
164	2020-06-18	2020-06-18	0degas5dspcgiejumkaqe0ba42	1	1
165	2018-01-08	2018-01-08	7c36srdei0m68836unm7ekmmcf	3	1
166	2018-01-09	2018-01-09	210noaocc62g38e2aqgkf9s7t0	3	1
167	2018-01-10	2018-01-10	3a076ca5mrpgig9ikfviujtgnd	3	1
168	2018-01-11	2018-01-11	50qbm58n8evpgnhkgoi3j9afn3	3	1
169	2018-01-15	2018-01-15	6k90p6ehq0ruq3pajljo0a7c5f	3	1
170	2018-01-16	2018-01-16	7g0467kkmf0158udukigln8cle	3	1
171	2018-01-17	2018-01-17	1pvmgaufrkp6h9bl888jp83g9c	3	1
172	2018-01-18	2018-01-18	0lhtkmns3mum7os4j67dphg8p6	3	1
173	2018-01-19	2018-01-19	21dg2isfp6mtls9oirfp44it1c	3	1
174	2018-01-22	2018-01-22	77b0gkg9oo2jv4bu82t5o7l7bk	3	1
175	2018-01-23	2018-01-23	4sleoo31o41o27vkbn7f0l0dht	3	1
176	2018-01-24	2018-01-24	3ualt499the5719o1jsake80p6	3	1
177	2018-01-25	2018-01-25	1phig67j8a8b1020te3b3qd0g6	3	1
178	2018-01-29	2018-01-29	39q6th33mkbcdiocmh4trmbblu	3	1
179	2018-01-30	2018-01-30	5p4gmcuupjvbjt6g52epmtvv87	3	1
180	2018-01-31	2018-01-31	0vgmo9q71avfdqu8tichv2vk79	3	1
181	2018-02-01	2018-02-01	05vt7g8mv0kgr6sdo6g98k7e35	3	1
182	2018-02-02	2018-02-02	7gg9c6cqnsvhb8oue4qcdl0kjc	3	1
183	2018-02-05	2018-02-05	450jnnou0vbs730a1dqm1tp8dr	3	1
184	2018-02-06	2018-02-06	30g4bbdhqrp74o81sv5tekd3f4	3	1
185	2018-02-07	2018-02-07	0s063ar2qcrb1o3jj4qogdsq5b	3	1
186	2018-02-08	2018-02-08	15dmutlr4got5tdb0gskcv4ism	3	1
187	2018-02-20	2018-02-20	4tirv18clt7hbbn42ba1rj1oim	3	1
188	2018-02-21	2018-02-21	767tfd8dd5q52vmpkia0i7i4rc	3	1
189	2018-02-22	2018-02-22	1oc12cftgf4dpavs13r1sa9qd5	3	1
190	2018-02-23	2018-02-23	58p4ce29ugkhmg381ggk05qbp0	3	1
191	2018-02-26	2018-02-26	2l92blsaulaqkav8se66hfdrt6	3	1
192	2018-02-27	2018-02-27	2kdhqr32oqf432vbf36b0i6ntc	3	1
193	2018-02-28	2018-02-28	4dqo3doptf1j3546eqpcu39fbr	3	1
194	2018-03-01	2018-03-01	2jl4k96a4aul8nemfq9f28p5m2	3	1
195	2018-03-05	2018-03-05	7g6pfoof4k4ntktl12rp50tamf	3	1
196	2018-03-06	2018-03-06	3oeiaue8bl7vpo7n0re93uvim6	3	1
197	2018-03-07	2018-03-07	798lg6lbnj6597b6huhijnhg94	3	1
198	2018-03-08	2018-03-08	2qkf73m6448v3plvjm8dglclru	3	1
199	2018-03-12	2018-03-12	65cdumed3b3s4o0os1ttifml33	3	1
200	2018-03-13	2018-03-13	4ks7t26ctf026j8h87l2p2akua	3	1
201	2018-03-14	2018-03-14	6m8a9k8qok9lqe7l7q1lcoh9ji	3	1
202	2018-03-15	2018-03-15	4idpg85ium35khsdkfks6pdvmo	3	1
203	2018-03-16	2018-03-16	52b80b9l8vr0mv3snc006sp165	3	1
204	2018-03-19	2018-03-19	1163q0ocibqp1mvita7btdb36f	3	1
205	2018-03-20	2018-03-20	32lknshpn58batk9a819fghpne	3	1
206	2018-03-21	2018-03-21	12v0ekt576t1gq3efd0mdghjfj	3	1
207	2018-03-22	2018-03-22	1oacjo83vbn6eonr4si9rmgeel	3	1
208	2018-03-26	2018-03-26	2r05q8noat87ecjn739g9r1kh7	3	1
209	2018-03-27	2018-03-27	63sfr2omf4sagdbme0v7dktoa0	3	1
210	2018-03-28	2018-03-28	3d5n0gvrffgeqf62sbtfcf7121	3	1
211	2018-03-29	2018-03-29	68vt5d696gs3g0c939nrdnpo88	3	1
212	2018-04-16	2018-04-16	52gdephe9ahuqego9jdfdfhgj5	3	1
213	2018-04-17	2018-04-17	6vj1fenndgvhav64mgctaisch7	3	1
214	2018-04-18	2018-04-18	37rbikudegrjof6k73mf7crhpl	3	1
215	2018-04-19	2018-04-19	6bdtiqnp63rup52i5b807764na	3	1
216	2018-04-23	2018-04-23	6atnenhamukqnrnmsm5ukfguq2	3	1
217	2018-04-24	2018-04-24	5pila3gerrr9adabouh6gjc23q	3	1
218	2018-04-25	2018-04-25	392tpm60a5n9iadh4juulkcprs	3	1
219	2018-04-26	2018-04-26	2vnrq74vj3lonbqmqnj1q3bevu	3	1
220	2018-04-27	2018-04-27	4kkrc1a46ico0103eil6d7hp4v	3	1
221	2018-04-30	2018-04-30	6fvclpuu5qvo5u9lif8ut71o8t	3	1
222	2018-05-01	2018-05-01	10umhqggbg2h1f38d9v2c2d22p	3	1
223	2018-05-02	2018-05-02	6d7ka0q77peieqa6kbp44rg2mp	3	1
224	2018-05-03	2018-05-03	1kac5lcm3a7k3119923bk0vdtn	3	1
225	2018-05-08	2018-05-08	542b15jib1ojqn5e73fbg5vvtd	3	1
226	2018-05-09	2018-05-09	2lb3no90qo07l6hr1pb042tpgd	3	1
227	2018-05-10	2018-05-10	0q2604r02a2mh0q4ar3mfa177h	3	1
228	2018-05-11	2018-05-11	6fq9aruhv3f33fg5dl2rj4ndr0	3	1
229	2018-05-14	2018-05-14	7v8m2u577b48k2m83gdestulk1	3	1
230	2018-05-15	2018-05-15	7q28vcefg9bctr3518p437j2ks	3	1
231	2018-05-16	2018-05-16	6gic32t4irirca3v0icimij06s	3	1
232	2018-05-17	2018-05-17	0vduhhgkm3ueddbf2tk808u22j	3	1
233	2018-05-21	2018-05-21	10lqnvprmos19blffrhnprtd15	3	1
234	2018-05-22	2018-05-22	1otil6f009co20prm4r1ajqvme	3	1
235	2018-05-23	2018-05-23	1cauvdsqdu8tqma8obapr19f33	3	1
236	2018-05-24	2018-05-24	2a88gr47diu5rvulv32t8ih91d	3	1
237	2018-06-04	2018-06-04	6hqt79093lfnl09qf995pcbhvr	3	1
238	2018-06-05	2018-06-05	4pu628s8pe5p61eqrkc8cgcps1	3	1
239	2018-06-06	2018-06-06	7bpm88hggirr3vo286jo46tdtq	3	1
240	2018-06-07	2018-06-07	41og8k4qe2t7fk9jc0dfgchkfm	3	1
241	2018-06-11	2018-06-11	6uottvc4klvnnm8qo2vv369oma	3	1
242	2018-06-12	2018-06-12	6uoomol57lfrc4a4etmfjmq0bn	3	1
243	2018-06-13	2018-06-13	0hkp0peed01alejgfjc4sjv3u2	3	1
244	2018-06-14	2018-06-14	4irvlfmg1cppg2piql06gkr3th	3	1
245	2018-06-15	2018-06-15	04u5vq144vc820becfiatv4hcj	3	1
246	2018-06-18	2018-06-18	22763dmtvfm49ucv0b3d9gjt0c	3	1
247	2018-06-19	2018-06-19	5bpa856s1geq7i9r419m1u7fhl	3	1
248	2018-06-20	2018-06-20	49si13fmdjou5nssniuomr11av	3	1
249	2018-06-21	2018-06-21	6afekhn685ia0se4cpfr6pri4u	3	1
250	2018-06-25	2018-06-25	29d79of9kjamhknqbnbpnrdelk	3	1
251	2018-06-26	2018-06-26	2rg5f4ch67j2f6nbh6k9son6sj	3	1
252	2018-06-27	2018-06-27	61se8c0n0u3ahsmopngjhbqq9v	3	1
253	2018-06-28	2018-06-28	5dkod3erk71vlkct1ha2phc497	3	1
254	2018-07-02	2018-07-02	6uojc0hk6kojprsj53qn82lfhc	3	1
255	2018-07-03	2018-07-03	1v9j48pgjv4qge0plml6karu6p	3	1
256	2018-07-04	2018-07-04	2jl1i0tb77r586ng0igdgvb000	3	1
257	2018-07-05	2018-07-05	4oub0e4g6kujjlvbsbkr9qr57s	3	1
258	2018-07-06	2018-07-06	5suenpldcg908bm8goo4992joo	3	1
259	2018-07-09	2018-07-09	0altg5ajdqqcrcfoc9rftp0rkv	3	1
260	2018-07-10	2018-07-10	117ninkv413i0mdhaj9drjf4fo	3	1
261	2018-07-11	2018-07-11	0l8m5in766k37sst15hp1ochog	3	1
262	2018-07-12	2018-07-12	6nd35bd84l287s6fkp7qq17lvk	3	1
263	2018-07-16	2018-07-16	58k0ntff3ltj1fj2oq1jnkf4ds	3	1
264	2018-07-17	2018-07-17	05pookt5nrn8kpmneiermq2qog	3	1
265	2018-07-18	2018-07-18	5sj7kmcscbjoefdsqftbsfv1sa	3	1
266	2018-07-19	2018-07-19	43sn2lp9fbc2k3bvfjkneraqur	3	1
267	2018-07-23	2018-07-23	75f7055t75q1rloru0uq06v0hr	3	1
268	2018-07-24	2018-07-24	58tsj45l1tlfkqukcotl8uh56g	3	1
269	2018-09-04	2018-09-04	33s33absvu6lfp7pcphtc7jgn9	3	1
270	2018-09-05	2018-09-05	4keaj0jlq912scn7fp6lteij8p	3	1
271	2020-06-22	2020-06-22	63uatqf2gm9dq2sttdstdm0bst	1	1
272	2020-06-23	2020-06-23	70n3ipt8srpm475s274lapi2jn	1	1
273	2018-09-06	2018-09-06	1oihj72tnc3efu90vik3etfqr0	3	1
274	2018-09-10	2018-09-10	3dnu4augjk0k6tatc5g398op5b	3	1
275	2018-09-11	2018-09-11	6hj3sq8p1gp3rhh9cilr5uelte	3	1
276	2018-09-12	2018-09-12	2s9trij7mrm88gd6qba6etq33r	3	1
277	2018-09-13	2018-09-13	65uovkojsgjetm9p2ff4nujh3g	3	1
278	2018-10-09	2018-10-09	059lpr2bk2ol3ut6p07h237gb9	3	1
279	2018-10-10	2018-10-10	6hqlb15d2f9kcmti0ld2erbl6l	3	1
280	2018-10-11	2018-10-11	5dmj2mikt0mddouj1eedco3o6o	3	1
281	2018-10-15	2018-10-15	42dnvft48qs11gkignaa9bsf9s	3	1
282	2018-10-16	2018-10-16	38eegkmfmm5oihg11v8g275nuj	3	1
283	2018-10-17	2018-10-17	4kr9e584rdgmuf35vhv00de76r	3	1
284	2018-10-18	2018-10-18	2moba3mor08d7g8gqrr42g436v	3	1
285	2018-10-22	2018-10-22	5ntc82erfd40hbb1t4mnreh04c	3	1
286	2018-10-23	2018-10-23	3t1nmohm0qhn445opv5rd2frt8	3	1
287	2018-10-24	2018-10-24	1815nabcnna2586mqo283upalj	3	1
288	2018-10-25	2018-10-25	47spd7ckslar25bpge3v2m19ql	3	1
289	2018-10-26	2018-10-26	0sl7rp32r024k3ahrrk4ldvouq	3	1
290	2018-10-29	2018-10-29	693mp630tj26ldul966h0at01t	3	1
291	2018-10-30	2018-10-30	722iprhesqk0mbd4dtaha5pmhs	3	1
292	2018-10-31	2018-10-31	7oqvbs238i5rmfa0hk4q9shnra	3	1
293	2018-11-01	2018-11-01	20v3dbp96va5iq8uc61lcm5kkh	3	1
294	2018-11-05	2018-11-05	7l6lva8f2mil602eu4417891et	3	1
295	2018-11-06	2018-11-06	7bh0i5f3rpdi8ton81qcupn4hb	3	1
296	2018-11-12	2018-11-12	4j13c9e4gagvllr0std6lsbdc0	3	1
297	2018-11-13	2018-11-13	5s1rflhufslcutgc95der7cruu	3	1
298	2018-11-14	2018-11-14	09kn27lmukbiv3d8iqpj4vqmsv	3	1
299	2018-11-15	2018-11-15	3aqbu0kqu3n0cpoc6vbeou6ffq	3	1
300	2018-11-19	2018-11-19	36ftntkmg9cgl2p4teirivl0bg	3	1
301	2018-11-20	2018-11-20	6ugp870b4r718f6lpk8hs29r4j	3	1
302	2018-11-21	2018-11-21	67tjc3bddodei7gab1f1cu3698	3	1
303	2018-11-22	2018-11-22	3gi3m921cfgktcjfmamk0u6dqh	3	1
304	2018-11-23	2018-11-23	2r5g8o531paipgjsfjnamcc95p	3	1
305	2018-11-26	2018-11-26	05mhgjfqbe9u8mejkps0qcu107	3	1
306	2018-11-27	2018-11-27	1fmgper03j0n54jf03taqhjjmf	3	1
307	2018-11-28	2018-11-28	2m1ep8sfv6hslcaskshme9cknb	3	1
308	2018-11-29	2018-11-29	4qp947tvdg70j10s7pec4tgh8v	3	1
309	2018-12-03	2018-12-03	7kqvhuu50dm1hajaqrd5id041s	3	1
310	2018-12-04	2018-12-04	5gk9q66vmc6bj1bgl1ll02akm7	3	1
311	2018-12-05	2018-12-05	5cutiuajbfikig4j10k4n3vvq2	3	1
312	2018-12-06	2018-12-06	1jrj64vr73vt186bl10v5bt92a	3	1
313	2018-12-10	2018-12-10	2s4aoj1rbbmtpk759sfb3mf7mo	3	1
314	2018-12-11	2018-12-11	5v3u3ompkc5hitd662bt5u25o4	3	1
315	2018-12-12	2018-12-12	4gr5s03rvf3pfk8odvl5v0rodp	3	1
316	2018-12-13	2018-12-13	0drq4755thn947429ctq9ca7sl	3	1
317	2018-12-17	2018-12-17	0s8sq03jd8rs90aj4bl7eei6br	3	1
318	2018-12-18	2018-12-18	4j2td8brnr8sav0j18rnn2glrt	3	1
319	2018-12-19	2018-12-19	71ea08mrgt2dlne71pn5lajd4o	3	1
320	2018-12-20	2018-12-20	64tull2f6n4kto4q9eq9suig9g	3	1
321	2019-01-07	2019-01-07	5m2147g8ll62b7lvd2m21mpora	3	1
322	2019-01-08	2019-01-08	6ht9o4j00l42d8jd4jvauc5jo5	3	1
323	2019-01-09	2019-01-09	0t9smt4cqehlu2ar4rmdc3tgt0	3	1
324	2019-01-10	2019-01-10	3nr6i6v8dgevto40jao36092gl	3	1
325	2019-01-11	2019-01-11	2dai61jpm9ls76hb8r48i5gn46	3	1
326	2019-01-14	2019-01-14	0ctcqk4ss5cv6o4pf9g37kctqu	3	1
327	2019-01-15	2019-01-15	5bdspkscf8a8kfq8eqcmld1f8l	3	1
328	2019-01-16	2019-01-16	12jahg4i2ct08bk60ak9iqsuh8	3	1
329	2019-01-17	2019-01-17	7l3jlqmcq3tldjlj5hbosupvgf	3	1
330	2019-01-21	2019-01-21	16eaou5gd0b8a71bn82aa06eir	3	1
331	2019-01-22	2019-01-22	5uaus2a6ub73rgi7c67o5msvk9	3	1
332	2019-01-23	2019-01-23	5qffgss63nut7ko052prjt824j	3	1
333	2019-01-24	2019-01-24	5r2u1iva2fkutpph5mfcfbau11	3	1
334	2019-01-28	2019-01-28	7115k3hm1f17p1vsspdv0aobbr	3	1
335	2019-01-29	2019-01-29	34qvmdi0gtv6hg35c03qqlnvmm	3	1
336	2019-01-30	2019-01-30	1rn4ppiunkv16fjbirchp423be	3	1
337	2019-01-31	2019-01-31	0l44khkak8oftlms87m10ie2pd	3	1
338	2019-02-04	2019-02-04	17bdru896b20l7iq8dopb4elan	3	1
339	2019-02-05	2019-02-05	1bvivh2lg798iqcacgcuqas6ju	3	1
340	2019-02-06	2019-02-06	3l48rh00cl6v29fqulr052d387	3	1
341	2019-02-07	2019-02-07	1dr4l2vi2077u59fqeut8t6egv	3	1
342	2019-02-08	2019-02-08	47mu8rh787396ao9aoj5205q1o	3	1
343	2019-02-11	2019-02-11	4dj9b80p7jmvofasjheoj8ejak	3	1
344	2019-02-12	2019-02-12	6vq1uilb0eeuspq9okq3ga31pf	3	1
345	2019-02-13	2019-02-13	2ipku22hotrsdrj1ts37v414hc	3	1
346	2019-02-14	2019-02-14	4pbfg8jos21logfnrmjc2ft6qn	3	1
347	2019-02-18	2019-02-18	0d8s5icjp8aeriiejrpnpo4jjc	3	1
348	2019-02-19	2019-02-19	1cn50490c7obdk0efigi2d2ndc	3	1
349	2019-02-20	2019-02-20	2rmms5sl2mkq9ol6cj5oecvkl9	3	1
350	2019-02-21	2019-02-21	2bt978eagv1uorfmaj080e03qp	3	1
351	2019-02-25	2019-02-25	20rm4ujcr0g8i7jgrue7l4msea	3	1
352	2019-02-26	2019-02-26	7rldktl062lurpcrd404lo9v9v	3	1
353	2019-02-27	2019-02-27	2sc2a3k4v7fgaj67odpdgfhmff	3	1
354	2019-02-28	2019-02-28	1hrdon5b8sjl8p6cm94lmluj3r	3	1
355	2019-03-04	2019-03-04	5um0v7f0jk96a7akgv3ttr6q2c	3	1
356	2019-03-05	2019-03-05	3ge6i3bgn0ucihka1t09jttjo8	3	1
357	2019-03-06	2019-03-06	5kn4di1aqa3evmb58u6h9bdhv7	3	1
358	2019-03-07	2019-03-07	2ivqq3g2g2esjhalt17g4vi417	3	1
359	2019-03-11	2019-03-11	6dk1dqfgqrio24c8apvlcjp8rq	3	1
360	2019-03-12	2019-03-12	70obo4cd14lmjt6j0kgfv6jegi	3	1
361	2019-03-13	2019-03-13	6r6t5ulrlppnsiv09e6t8e650t	3	1
362	2019-03-14	2019-03-14	00b80i0l2i1dv0s12k2hcftok6	3	1
363	2019-03-15	2019-03-15	4nik7vu56b8t8fuhfjplumb8po	3	1
364	2019-03-18	2019-03-18	0h69kiflqe26c0m75l3ku6ogbj	3	1
365	2019-03-19	2019-03-19	4c54r77d48a6apndv834rcj0ph	3	1
366	2019-03-20	2019-03-20	2h66p2a0kt4b1rl9efublt0qd3	3	1
367	2019-03-21	2019-03-21	1f6obm2jh938emj8210h74tcft	3	1
368	2019-03-22	2019-03-22	1l95pudt01iccj5pprllimj24q	3	1
369	2019-03-25	2019-03-25	5pvuvh9irt9pcuo6trnbkpig0b	3	1
370	2019-03-26	2019-03-26	74qd9tq796bmfm8rmo04htoc30	3	1
371	2019-03-27	2019-03-27	2k6cn5mq5fbggaaqlukrq3f2j5	3	1
372	2019-03-28	2019-03-28	23k57j2c949a1icfbif624cb7c	3	1
373	2019-03-29	2019-03-29	6omq5qqbq816lcuq1cfl6j5674	3	1
374	2019-04-01	2019-04-01	6ojksvv9vdg4g162pa936hmor3	3	1
375	2019-04-02	2019-04-02	5sbnvtaonmrvt1simjl74d7n4t	3	1
376	2019-04-03	2019-04-03	39bgghsn23n2c1ln2jeco3kntn	3	1
377	2019-04-04	2019-04-04	1o9qf19rlftm74et3h7jlarhkp	3	1
378	2019-04-08	2019-04-08	3kg5nqevopjjvl50l519paegs1	3	1
379	2019-04-09	2019-04-09	78ipfa3bpdlo51i5nn1k84nier	3	1
380	2019-04-10	2019-04-10	1m4j03dqhlcf3nhjp0goeudhnj	3	1
381	2019-04-11	2019-04-11	1bilu4mdpsp7lhpjdj0svnn2an	3	1
382	2019-04-23	2019-04-23	5oh76c0du476390oum5hm7vo4i	3	1
383	2019-04-24	2019-04-24	5g0muqbtglq23k9q9nv8tv6ff0	3	1
384	2019-04-25	2019-04-25	19rqs37vo75urlfpsaufas3eo7	3	1
385	2019-04-29	2019-04-29	6tj0lm14f9d76u1kh8l402ifc7	3	1
386	2019-04-30	2019-04-30	49v808qgf2akidjg9g5ildqpp7	3	1
387	2019-05-01	2019-05-01	724g25p9vr8i1bh20lhqi5k74f	3	1
388	2019-05-02	2019-05-02	1a9ronte42eejaidnoauum4gd9	3	1
389	2019-05-07	2019-05-07	62ii2t7vv3pr8ldvum11vstp9p	3	1
390	2019-05-08	2019-05-08	6g8b4j5hdleskv9p9et3h59mip	3	1
391	2019-05-09	2019-05-09	3d9pjqgcb3oshp5b9jjm8t91gm	3	1
392	2019-05-13	2019-05-13	417q5cr1b1hc9tt6n7pef6vna8	3	1
393	2019-05-14	2019-05-14	30ol9cvoc75m18hgfug8bme73g	3	1
394	2019-05-15	2019-05-15	6e2ch5764bf611t6db0rucm0ra	3	1
395	2019-05-16	2019-05-16	522ko1g4nf81v7j12a4u1crpjq	3	1
396	2019-05-20	2019-05-20	603kav2ase7kuvq8e08hicdvqg	3	1
397	2019-05-21	2019-05-21	3hhjnb0errc74g7a2hq88d7s26	3	1
398	2019-05-22	2019-05-22	543n84bt6i67eg6qhm6jshs27n	3	1
399	2019-05-23	2019-05-23	1heu30k2gkv9dhvh027r1td902	3	1
400	2019-06-04	2019-06-04	7li7gmc7lt4ejibfkffcjgtch5	3	1
401	2019-06-05	2019-06-05	7f95rg2rlrp7tcjl2p6jb4s44b	3	1
402	2019-06-06	2019-06-06	1skios9bfpm4lsctcbh2cnrr4s	3	1
403	2019-06-10	2019-06-10	6qhuam5vv6hcsfcsggrkfjv6lq	3	1
404	2019-06-11	2019-06-11	1rkdshtudb5q8hind29c7s829v	3	1
405	2019-06-12	2019-06-12	7n0sgu7kl6vj7dbk09sarge9q5	3	1
406	2019-06-13	2019-06-13	6bkq35c6faajs98l7ktlrg2bs8	3	1
407	2019-06-17	2019-06-17	3ckj47m2rc63i9aqcaftij0r2h	3	1
408	2019-06-18	2019-06-18	5hhgaiiov4m1gs7519ghpf68bg	3	1
409	2019-06-19	2019-06-19	316l4j6kv50rt0t9pnlsd9eilp	3	1
410	2019-06-20	2019-06-20	1vd38u5qs7hfgc589lkovbj1e3	3	1
411	2019-06-24	2019-06-24	5vv8jgstumoot3vim7c4a50ov6	3	1
412	2019-06-25	2019-06-25	57t802iajos20p1r0je3v1qcj4	3	1
413	2019-06-26	2019-06-26	7iqs6s2gtc09d62j47v0m6o995	3	1
414	2019-06-27	2019-06-27	2t7ckdqtphv00rd5k60f3m5vgi	3	1
415	2019-07-01	2019-07-01	7s6rqinkdl2q4pn9p709m6mh2v	3	1
416	2019-07-02	2019-07-02	5vtu8c1go8s7enasv3b96of3ef	3	1
417	2019-07-03	2019-07-03	4qrbj0teo50pc0cp3b0adf612m	3	1
418	2019-07-04	2019-07-04	5p3bgge06q4ojjb4bc1hj9i0es	3	1
419	2019-07-08	2019-07-08	1fnva8e5sstg0n4ui3ma0ranjr	3	1
420	2019-07-09	2019-07-09	14grnmmrrffqp12f6b8gdjd7lv	3	1
421	2019-07-10	2019-07-10	4sltshhgflll74um2301r1gsur	3	1
422	2019-07-11	2019-07-11	0je2qppam04c84bd5tm04234ji	3	1
423	2019-07-15	2019-07-15	5litqce9hqfd8guk60iogu7a5b	3	1
424	2019-07-16	2019-07-16	4ar5qtq6fjoo9o6etmbth0i6o7	3	1
425	2019-07-17	2019-07-17	4734sc85llokn697jr9ape9iq9	3	1
426	2019-07-18	2019-07-18	444i3a2cgu16bjgka84qeso680	3	1
427	2019-07-22	2019-07-22	54de77bvivr9h0qebfdqvltev7	3	1
428	2019-07-23	2019-07-23	6reablk4c277m3dd2v163nf8pv	3	1
429	2019-07-24	2019-07-24	76e9jip5622kj75213qceli875	3	1
430	2019-07-25	2019-07-25	2hcro50c30i4o5h4afv6vfit6t	3	1
431	2019-09-03	2019-09-03	3mhaa32hm9ur7ii78sbvfggs7v	3	1
432	2019-09-04	2019-09-04	5f39ntr2e0u6a92p0nr239k57t	3	1
433	2019-09-05	2019-09-05	31rc05huo2g0phs35ob4qm8trt	3	1
434	2019-09-09	2019-09-09	24oumj9j8p4erk70921b3r9p6p	3	1
435	2019-09-25	2019-09-25	6jfmbv7h8rnrqssufb1ngm269q	3	1
436	2019-09-26	2019-09-26	2ehsassf7botjsl7f38f9fj3dp	3	1
437	2019-09-30	2019-09-30	7a4vb9jkaiejutli5t8f6ke37j	3	1
438	2019-10-01	2019-10-01	4ghqbuc6mbt3qkubbull8mpdtp	3	1
439	2019-10-02	2019-10-02	27j8bvi4a6mm1766uoois6jof7	3	1
440	2019-10-03	2019-10-03	09cbib0sud3etk8bt41utthml8	3	1
441	2019-10-07	2019-10-07	23uvi575vdvvmcncuuj45cv6ro	3	1
442	2019-10-08	2019-10-08	79hfuoj7764r9bpc3k8vq53a1k	3	1
443	2019-10-14	2019-10-14	2sgo8je2mkqkt70m4eb74necq0	2	1
444	2019-10-15	2019-10-15	1cd64ti8lbfjhqlip1o9ho91kn	2	1
445	2019-10-16	2019-10-16	3jjnnv0qdbvru1f4de4g7r1ui7	2	1
446	2019-10-17	2019-10-17	3ht875a2fh5md6lmsnmkeeskir	2	1
447	2019-10-19	2019-10-19	5thi4nhb2m89nk072sjffb0p2o	2	1
448	2019-10-21	2019-10-21	4cj7ili90onpqg9pt07t1ruj53	2	1
449	2019-10-22	2019-10-22	773qjsnt9sgmju6s31hnr0h4cq	2	1
450	2019-10-23	2019-10-23	0h7e254v046e81k5gosjnavp6q	2	1
451	2019-10-24	2019-10-24	3djj6ck1u2e7kgug9g1v5gqjvv	2	1
452	2019-10-28	2019-10-28	20b9venfmnb5metqv0i9vkares	2	1
453	2019-10-29	2019-10-29	6971i0cnrnkajgn4dg8179mc7k	2	1
454	2019-10-30	2019-10-30	4qqnjedvna7kbpr9vrhg8njt8f	2	1
455	2019-10-31	2019-10-31	60o7qhqmu0k62t14lbn5d02aqa	2	1
456	2019-11-04	2019-11-04	0iuk34n1055rg33q3uu5ql1kns	2	1
457	2019-11-05	2019-11-05	2n8vq2ob1lmpb7ir92c0fog2vb	2	1
458	2020-06-24	2020-06-24	0p5hlcphpeepcas0q2j2l9tsec	1	1
459	2020-06-25	2020-06-25	13n8cmlkvg0cijhd07egmsqe74	1	1
460	2020-10-13	2020-10-13	2m6600ao3k7sft13bbvga1mrqj	1	1
461	2020-10-14	2020-10-14	4uaa8c552upvf9a7vpu5drkdb1	1	1
462	2020-10-15	2020-10-15	45lc5brc8preuj1cbpfqulg406	1	1
463	2020-10-19	2020-10-19	22nf3tkaimo34e3pi07q3bn9f6	1	1
464	2020-10-20	2020-10-20	3r5tlfu87p9v9h32jhpc1m4ptu	1	1
465	2020-10-21	2020-10-21	4soa5nqste1qg0josc6ngug237	1	1
466	2020-10-22	2020-10-22	3as4tgj27uoclr4omul933paj4	1	1
467	2020-10-26	2020-10-26	3fhgftog4lohebltbfa8o5ohf0	1	1
468	2020-10-27	2020-10-27	7m0ji5g9b9s3u7u9ganbssivln	1	1
469	2020-10-28	2020-10-28	3gqicpl1hsvupkatj8o4cjkhge	1	1
470	2020-10-29	2020-10-29	2aokphdkpubr1uo1fu3tsg1k0e	1	1
471	2020-06-29	2020-06-29	2r3sam6cjrohl69b0efnh28jo7	1	1
472	2020-06-30	2020-06-30	23hiqvua1a77h74ptedbv1v6ei	1	1
473	2020-07-01	2020-07-01	3444btfjcfvq3lbou49egvnsmh	1	1
474	2019-12-17	2019-12-17	1n9juvpgdr8tiqaabs4gume9fi	1	2
475	2019-12-18	2019-12-18	1qhu7ojr9mnpqqohimagpk28m2	1	2
476	2019-12-19	2019-12-19	0bkumk9k1hq1qoucb6nk69npl6	1	2
477	2020-01-07	2020-01-07	79chq2hr0oq2qbghgn2erag6bk	1	2
478	2020-01-08	2020-01-08	70jir26j91qfk9pr2avj9s1jvm	1	2
479	2020-01-09	2020-01-09	45h5t4fmmu6g4igdkvgvihlpkr	1	2
480	2020-01-13	2020-01-13	73r40gj6t647ov4rujjcho3vqq	1	2
481	2020-01-14	2020-01-14	39emcck41q761vo6q2mnjvlrdq	1	2
482	2020-01-15	2020-01-15	69qg5clh10nhe51iq0ti7tnj68	1	2
483	2020-01-16	2020-01-16	51ebdttf47540bg12s0lfca4ob	1	2
484	2020-01-20	2020-01-20	4nt02rrt82du3rpoofmjk3gucc	1	2
485	2020-01-21	2020-01-21	3lviohtvgjdep0eahtukafk83g	1	2
486	2020-01-22	2020-01-22	037anr420b5c1ks50co48qteth	1	2
487	2020-01-23	2020-01-23	4pbjcisgpmqjpko7rtkhv7hlhh	1	2
488	2020-01-27	2020-01-27	4vhqi5v733a828l4f515v3vec6	1	2
489	2020-01-28	2020-01-28	23jcrpdpnqjikn395ek24o2np5	1	2
490	2020-01-29	2020-01-29	1lk5jkjnb1m05ukc6o6c4h1vav	1	2
491	2020-01-30	2020-01-30	7v3ddbt862rc2b2pb870rdmcj5	1	2
492	2020-02-03	2020-02-03	27e5fh6malhqosa39bi582v46u	1	2
493	2020-02-04	2020-02-04	11qfjkkl5sc41511o62lbapoo6	1	2
494	2020-02-05	2020-02-05	52cuesq1t48mhp4v8d6h96c2r5	1	2
495	2020-02-06	2020-02-06	5o9aqdr9i7l4lnuf923gfi9pme	1	2
496	2020-02-07	2020-02-07	6q8qv358gcudmsgc7g449u966f	1	2
497	2020-02-10	2020-02-10	7gktdv81rh5k8iq5ojv3jddapk	1	2
498	2020-02-11	2020-02-11	6v9um6lasoon18n1gufmjmtfij	1	2
499	2020-02-12	2020-02-12	635gteimm37tru0qa9isomm37i	1	2
500	2020-02-13	2020-02-13	48j69sn8g7srum7dqenbq18t2j	1	2
501	2020-02-24	2020-02-24	5dq8t9r1mdpr2ghn14822f5dnn	1	2
502	2020-02-25	2020-02-25	3vdvtdbgh000bppije2f0peb8i	1	2
503	2020-02-26	2020-02-26	6tepid13vrlohadhca0avmffhf	1	2
504	2020-02-27	2020-02-27	6m4nri63j3ql4lj1flbottohvp	1	2
505	2020-03-02	2020-03-02	20pnvfues3lv7q2413adnj1s34	1	2
506	2020-03-03	2020-03-03	4g0d7vtfhnbodq0jq1d1jlkqhi	1	2
507	2020-03-04	2020-03-04	305corjlc6opjqeealdmgtvs0c	1	2
508	2020-03-05	2020-03-05	6h4s1jdnqk2p6cri7068po7ump	1	2
509	2020-03-09	2020-03-09	4abhqs8651k3qpfklnti7fps30	1	2
510	2020-03-10	2020-03-10	62hgh7vbl5119skv1ldqfhk1sv	1	2
511	2020-03-11	2020-03-11	7tt4kqs0doil3ja4rn6pqa673p	1	2
512	2020-03-12	2020-03-12	59li1et0b8722sevfst4ipvu44	1	2
513	2020-03-13	2020-03-13	7t155c3glht183aktgum7feurr	1	2
514	2020-03-16	2020-03-16	5uekvv6ggda3e5kvmvpodm2iko	1	2
515	2020-03-17	2020-03-17	3scl48nmu3gpa5ni9didgdrmli	1	2
516	2020-03-18	2020-03-18	5ckch22kom6duesovpp5506r9v	1	2
517	2020-03-19	2020-03-19	67mt2o5bb0ipknpsucer1h1m1h	1	2
518	2020-03-23	2020-03-23	2kin3itfc9k61pvu6um922mf2b	1	2
519	2020-03-24	2020-03-24	69kamcr26it30rhj39lu0air8n	1	2
520	2020-03-25	2020-03-25	3pa7kflcmbnq68qkjlcg5jpd08	1	2
521	2020-05-06	2020-05-06	05kkh2fqa5ihtmmf3rqeo9skc6	1	2
522	2020-05-14	2020-05-14	7bmrierohdgp1f3ns994vt0cjo	1	2
523	2020-05-19	2020-05-19	3d2n8n2gsvlglih3mnqch9j69t	1	2
524	2020-06-04	2020-06-04	2nojfdbo5jrao60a6bu1n5keba	1	2
525	2020-06-08	2020-06-08	7iii5t656h5pnr6ekr4r2fg0kv	1	2
526	2020-06-09	2020-06-09	6c4308q6en0ppr8bjj02udh8h7	1	2
527	2020-06-10	2020-06-10	1l9nqmr1r8oe62t8k6di18oghn	1	2
528	2020-06-11	2020-06-11	6vifm1veshv64uql7lbnaaboab	1	2
529	2020-06-15	2020-06-15	1u4g3ftdm4cs0enbm3l5igub6k	1	2
530	2020-06-16	2020-06-16	5kmj2osegl28g06bbst0n49epo	1	2
538	2020-07-15	2020-07-15	1o2nnmj8r6hbksjacsdjvog5k5	1	2
539	2020-07-16	2020-07-16	4otms6jvtmhe5c07ol2iofd61r	1	2
540	2020-07-20	2020-07-20	2qhgimap3mu5bldobcqijh3r21	1	2
541	2020-07-21	2020-07-21	6segf95da9fehmv6tm79m16r6u	1	2
542	2020-07-22	2020-07-22	55d4m3nt7ldisajam0poa83d1i	1	2
543	2020-07-23	2020-07-23	1i9m2g5td4l9apb8hof5avkrer	1	2
544	2020-07-27	2020-07-27	78qml48pc0a9cb845n28cc90j3	1	2
545	2020-07-28	2020-07-28	6cts0eeh0ind861mm2tlbd0ml5	1	2
546	2020-07-29	2020-07-29	6r2khmqhktrlibccbov2l2t29p	1	2
547	2020-09-02	2020-09-02	28uomuk08cd7k5ab91jk9la5dj	1	2
548	2020-09-03	2020-09-03	4qd1he9dntakhhvmdg7enq8p7q	1	2
549	2020-09-07	2020-09-07	3jbsd18k6jir5vq4sp1uijp3eb	1	2
550	2020-09-08	2020-09-08	6h7mqftfi8jl174mqgvr1kv3i6	1	2
551	2020-09-09	2020-09-09	732sha9nokvd6och3vn4auaud5	1	2
552	2020-09-10	2020-09-10	4nkuj1lq6p36vdn1e3nno4j7cn	1	2
553	2020-09-14	2020-09-14	446po0qlek5ria8j0roucu6m3b	1	2
554	2020-09-15	2020-09-15	6vpm7qf81of7n8pt072a494a90	1	2
555	2020-09-16	2020-09-16	07lmlptrgjfvp7b3us6fdjbpl2	1	2
556	2020-09-17	2020-09-17	6ifjg7ms9on3od7mnnppcd8n32	1	2
557	2020-09-21	2020-09-21	190fovpp5clds8fo9nn5shmbj5	1	2
558	2020-09-22	2020-09-22	6vtuad9dhd84kosnr8nhne6e42	1	2
559	2020-09-23	2020-09-23	1189mhf99m28tkeu8neiilbbtd	1	2
560	2020-09-24	2020-09-24	4oq7mt4ge39if74ge9sn4gek65	1	2
561	2020-09-28	2020-09-28	2rcige8h6bpeghrf7kn3oi6voc	1	2
562	2020-09-29	2020-09-29	3u7ctjfkfboslvb22gko3oogv4	1	2
563	2020-09-30	2020-09-30	04rupokd15bobd4u5e1o7vuv13	1	2
564	2020-10-01	2020-10-01	5b8knsglsn9vkgp9pb0n24t5ev	1	2
565	2020-10-05	2020-10-05	3307roaki0r8mi649ei8lacl4l	1	2
566	2020-10-06	2020-10-06	40ckisuqotc91kjb68nhp3cn36	1	2
567	2020-10-07	2020-10-07	1ab8nid467u6p358r2fvug1go1	1	2
568	2020-10-08	2020-10-08	7bpbgk9d5dr1g5bqui4lf182a2	1	2
569	2020-10-12	2020-10-12	3408m6aq05pmhac61hk5dluivd	1	2
570	2020-10-13	2020-10-13	5m6unatr75l0dscvl80lh6bfdj	1	2
571	2020-10-14	2020-10-14	014ovlr2hof3u1u434qoe532tm	1	2
572	2020-10-15	2020-10-15	36ipm8061uirs0l166pgvut5lg	1	2
573	2020-10-19	2020-10-19	362sv7ms8i6apij9b008vhn8p1	1	2
574	2020-10-20	2020-10-20	74ie7v70qtbnain4e1ldno2fsh	1	2
575	2020-10-21	2020-10-21	57nbs6arbl177dv48qp2fv7qjt	1	2
576	2020-10-22	2020-10-22	5c6jjq0pn9hfukea5e5ela7ppb	1	2
577	2020-10-26	2020-10-26	5r7kpvumh2gijptf3ccs5h3dqh	1	2
578	2020-10-27	2020-10-27	50ejo1ud4ugunsmcroa3og25qa	1	2
579	2020-10-28	2020-10-28	2uqs4c97u3lo7ut20is7aajqeq	1	2
580	2020-10-29	2020-10-29	5oso591k368o6nvrs1qgp87vv3	1	2
581	2017-06-21	2017-06-21	67uaqvvj9su43ba81tdgqgu5j6	3	2
582	2017-06-22	2017-06-22	50asmp3bg44asvtdbg9fpfa5b9	3	2
583	2017-06-26	2017-06-26	3ldmq7sfi8l3haj2hvjjj8grot	3	2
584	2017-06-27	2017-06-27	07tnnkuurqhnre9hsvcis8pch5	3	2
585	2017-06-28	2017-06-28	154l4j542ig17c48vciefgrqlg	3	2
586	2017-06-29	2017-06-29	1nrdrlml4vlg8arjd0v0q3sh0m	3	2
587	2017-06-13	2017-06-13	5be7kh4m86bsf49d50douj7pjq	3	2
588	2017-06-14	2017-06-14	2ln301cdmj7jlmucpr02tc272u	3	2
589	2020-06-17	2020-06-17	09ait3279cakvb9uplr56g3pmp	1	2
590	2017-07-03	2017-07-03	78i73jnqkqjj1mr4a0msth32c8	3	2
591	2017-07-04	2017-07-04	44cmgmpnt5uv6rofq1g9a6v6mv	3	2
592	2017-07-05	2017-07-05	1bbgekb2etbi52mnv9dv7de937	3	2
593	2017-07-06	2017-07-06	02ts08fa35r69mkdmc4sa2gh9m	3	2
594	2017-07-10	2017-07-10	4ei4jgs1ugg14k00kj62v7jgln	3	2
595	2017-07-11	2017-07-11	18q9q8ao67tjsrsr4lt2n14jr8	3	2
596	2017-07-12	2017-07-12	1atok5t41bakht2p6ps0st4qne	3	2
597	2017-07-13	2017-07-13	2nmcmae8qifbepoq6jrr94jgbg	3	2
598	2017-07-17	2017-07-17	05p2bk1le43g3dn3lcto2jis67	3	2
599	2017-07-18	2017-07-18	6ck124mlq6i1vjfdkqpg01034p	3	2
600	2017-07-19	2017-07-19	1ljia0ji6jk3a5lmcdhs1b6mdb	3	2
601	2017-07-20	2017-07-20	3dfuhg60149m88c3chjd73509m	3	2
602	2017-09-05	2017-09-05	22gf8l0hh16o4g0v5ou061pd2d	3	2
603	2017-09-06	2017-09-06	2duual4qitujbrqc616r120gls	3	2
604	2017-09-07	2017-09-07	46viukp8t8td7btva0v0enu7s9	3	2
605	2017-09-08	2017-09-08	0894h2ab6b1latp3dd0ibiear8	3	2
606	2017-09-11	2017-09-11	2ge859hgjfoh73qqb7f25gvsl7	3	2
607	2017-09-12	2017-09-12	0d3l1o1cg469kdbacpv35tj13n	3	2
608	2017-09-13	2017-09-13	33mfqtdu4pqlr25it9ei7hifad	3	2
609	2017-09-14	2017-09-14	245qp2hhgkjtogump51cus8q8n	3	2
610	2017-10-09	2017-10-09	1dcsc5sl5hf8s6ge60to2al5ij	3	2
611	2017-10-10	2017-10-10	4al9aalb3h0o4qcjl4evosd7ms	3	2
612	2017-10-11	2017-10-11	52jc94cgq0v90jsvvptp09t0dq	3	2
613	2017-10-12	2017-10-12	37li0rj6bhmp13ospvbj9lsuf4	3	2
614	2017-10-16	2017-10-16	3k5mpt4bivvchg2fu3fien1p8d	3	2
615	2017-10-17	2017-10-17	0l8q82q77mqgfkbbgjr0tggab3	3	2
616	2017-10-18	2017-10-18	6gtr5rofjbp2mmcl4pdd3qq1ta	3	2
617	2017-10-19	2017-10-19	319d0bilod2tc2c79hamqju55c	3	2
618	2017-10-23	2017-10-23	4gmiu0o2v98hmhojhndevk8ktq	3	2
619	2017-10-24	2017-10-24	34fj6a231nauf7u4eq7i9r0076	3	2
620	2017-10-25	2017-10-25	69n36adhmqndijh0j5n2sca09a	3	2
621	2017-10-26	2017-10-26	7gi2l87fip2fef1nvv5prbmnrj	3	2
622	2017-10-27	2017-10-27	4mc3ss135k50n2vgqrqkiq2drp	3	2
623	2017-10-30	2017-10-30	3o80ltjqeglltha2e8dfulb82k	3	2
624	2017-10-31	2017-10-31	47ak28jit2d35h89b6bkvklh0b	3	2
625	2017-11-01	2017-11-01	4jsdmbvkube9virtg862seih1g	3	2
626	2017-11-02	2017-11-02	1ki1g3243a7cqgsqsmlg9levdh	3	2
627	2017-11-06	2017-11-06	6gahr6pjk2ua432ffs7uhap5kg	3	2
628	2017-11-07	2017-11-07	7jc599akr019fp4m1n0caulb2g	3	2
629	2017-11-13	2017-11-13	4c776d5pf26j2un54c42g6fv7b	3	2
630	2017-11-14	2017-11-14	5gs7adomtqc0gidaal4392s3e2	3	2
631	2017-11-15	2017-11-15	0p2uvea1i99n172ll1j9dakfck	3	2
632	2017-11-16	2017-11-16	3f7tbnoq7ci5r6664fth0q53o0	3	2
633	2017-11-20	2017-11-20	6eg3f0qlfpefv8ptr43h5nk1c7	3	2
634	2017-11-21	2017-11-21	33l7m8nrc2ac6t02vs2812k4hc	3	2
635	2017-11-22	2017-11-22	27v2h4omtfadhtlmtqb8vbv18b	3	2
636	2017-11-23	2017-11-23	3fpu4npllhj6s21p0sjo30ljb4	3	2
637	2017-11-24	2017-11-24	4ht69lesq0vvls76k6h2m19joa	3	2
638	2017-11-27	2017-11-27	698cjp8aokfcbks5dd5gnckpg6	3	2
639	2017-11-28	2017-11-28	2b42mf3j1gkd4nlb7eusotdt2i	3	2
640	2017-11-29	2017-11-29	6j65ke1372ar3kgeah9nhd2o4c	3	2
641	2017-11-30	2017-11-30	4n6hh7g0hapm2m16r4sjmae3cl	3	2
642	2017-12-04	2017-12-04	23hono76lntofe5on1fj13l9pc	3	2
643	2017-12-05	2017-12-05	25k3cf9mbpnq07pdppp3udh4is	3	2
644	2017-12-06	2017-12-06	5dcuihq39emng56sqqrfql10a3	3	2
645	2017-12-07	2017-12-07	0iiks67mapg8mvuc58qlh51bak	3	2
646	2017-12-08	2017-12-08	05nv12elotspsqpggh4rcb4r0c	3	2
647	2017-12-11	2017-12-11	785ce6234vpuh3tlqqurmirh4a	3	2
648	2017-12-12	2017-12-12	6h9ij65bpst9se6m0rvaf75di3	3	2
649	2017-12-13	2017-12-13	1graaf6kpitj5d41g0i0aqob5i	3	2
650	2017-12-14	2017-12-14	2upshurmtf0qlbvqqqdkvefihn	3	2
651	2017-12-15	2017-12-15	34fal7ecodsvgf2t7vg7eharjs	3	2
652	2017-12-18	2017-12-18	17rn24mqtpc1j39e1n8v1u5as4	3	2
653	2017-12-19	2017-12-19	2f34ed7k4nkjvt8d6nnqsmr9lt	3	2
654	2017-12-20	2017-12-20	3u17d8gc1geds8i0ls302ojebi	3	2
655	2017-12-21	2017-12-21	5utrgbkcjd6v074m3jjff0gfkm	3	2
656	2020-06-18	2020-06-18	4p6npqdj76gn6780romgjjbfd2	1	2
657	2018-01-08	2018-01-08	1r34hlin2su8i9bid8389r8i2o	3	2
658	2018-01-09	2018-01-09	2vnfm9mripkvjeonovqisbv382	3	2
659	2018-01-10	2018-01-10	6tgumg34qvullv12dfq2meclva	3	2
660	2018-01-11	2018-01-11	3pgqrh8c7v38i3rj35h0kmmnpv	3	2
661	2018-01-15	2018-01-15	13861nnrj3qeatg7g1i6lla4ir	3	2
662	2018-01-16	2018-01-16	5rlt7qcj1fikb5fqsdrm575jma	3	2
663	2018-01-17	2018-01-17	5u4rsuq1dh4hfonmh5slgn8r2e	3	2
664	2018-01-18	2018-01-18	1bp2p4jqf9boitimkebd8jl2u2	3	2
665	2018-01-22	2018-01-22	0u4sd0ptfukpcnsaghuhark5mv	3	2
666	2018-01-23	2018-01-23	6hrnbb5sf6d5b5aauegqp3ap6j	3	2
667	2018-01-24	2018-01-24	6r5cu425s312glqt4aq40cn1pv	3	2
668	2018-01-25	2018-01-25	35rghvchrqvhvrt608t32abr7n	3	2
669	2018-01-26	2018-01-26	3h0m6l8p216h3sl7mg2tovgo4v	3	2
670	2018-01-29	2018-01-29	3fv2jre9iv8v5edqhua1lr2v4v	3	2
671	2018-01-30	2018-01-30	3rlb26vd4ek90hvrfeccbfs5i9	3	2
672	2018-01-31	2018-01-31	1clas8anu8floht1oqukm8qmbf	3	2
673	2018-02-01	2018-02-01	6r3oqnpndfmnbtlvl3pubo1fms	3	2
674	2018-02-05	2018-02-05	49npq8jj9ql27cavfkfj357qo4	3	2
675	2018-02-06	2018-02-06	7r91rvlkue08bi2pjdtjj7suqu	3	2
676	2018-02-07	2018-02-07	24g9ulcf8lp0jbq6lfdoi811ms	3	2
677	2018-02-08	2018-02-08	3kg5gslrd6ga4g9uqnmfs10t2m	3	2
678	2018-02-20	2018-02-20	721c65gj2veqjht88blaokgd1s	3	2
679	2018-02-21	2018-02-21	52pfdab66uh627eshbe5aqj06k	3	2
680	2018-02-22	2018-02-22	7bffb9hvegnmmvnqbm2m0c7kn7	3	2
681	2018-02-23	2018-02-23	389mrnr46b2pk5qiicnr6mitqh	3	2
682	2018-02-26	2018-02-26	1307516guj9ltunsjma0540er3	3	2
683	2018-02-27	2018-02-27	6j26tmq9fthb6pvglih314m4gt	3	2
684	2018-02-28	2018-02-28	2un9e4mfalakq4a8u796jdo1ug	3	2
685	2018-03-01	2018-03-01	7oft96paej02qts0erl4v5mqpi	3	2
686	2018-03-05	2018-03-05	2sqir877ati29o9ocgq0bve2k7	3	2
687	2018-03-06	2018-03-06	6vt0l0rtdcio9rgu0jo49bjk6h	3	2
688	2018-03-07	2018-03-07	721bsdb5kfnshb9oehv72k2ah6	3	2
689	2018-03-08	2018-03-08	1pqs3p249r8r8k4fit076tnhln	3	2
690	2018-03-12	2018-03-12	6q9kelhk0leqidgh96jufv0kho	3	2
691	2018-03-13	2018-03-13	5tamn96re8pq7rqd7goagafshq	3	2
692	2018-03-14	2018-03-14	1lpuba718ao4c6pn9dk731v9uv	3	2
693	2018-03-15	2018-03-15	0b0sj7erib383v0v53o9r3sk9p	3	2
694	2018-03-19	2018-03-19	351aa72oof96tdp9cg69qp654a	3	2
695	2018-03-20	2018-03-20	0h95vdgbvoljtdqp1cis023s1v	3	2
696	2018-03-21	2018-03-21	52vi990nq740c4itdsoqsi4759	3	2
697	2018-03-22	2018-03-22	0dve1lojaqfmckn2e7jppg43mv	3	2
698	2018-03-23	2018-03-23	5trph5aioi7acgre96bl1foghq	3	2
699	2018-03-26	2018-03-26	4328r7kj9n19k6130r9fej6d94	3	2
700	2018-03-27	2018-03-27	52b3a5p9jqq3j0og7nmu0o0pfj	3	2
701	2018-03-28	2018-03-28	4ibcgi206h38r2lgi8n9mqv98v	3	2
702	2018-03-29	2018-03-29	1q1n4orh4jl3tmiiq7ljfj02u1	3	2
703	2018-04-16	2018-04-16	5rktg62oa9p6fst4gm8hmikshi	3	2
704	2018-04-17	2018-04-17	18sus6cnopdth7rsahhtcemgio	3	2
705	2018-04-18	2018-04-18	13d4ac7erejh0r2vraf59eru1b	3	2
706	2018-04-19	2018-04-19	0hlol9mc17o43ffdmtbgd50upp	3	2
707	2018-04-23	2018-04-23	4fknjrgbhf5kkneogcavje9edo	3	2
708	2018-04-24	2018-04-24	3d3clvvpk5n4jhomhkdfbhbg2v	3	2
709	2018-04-25	2018-04-25	4ft9bvuq0fe2sio8i0jqmgf9v7	3	2
710	2018-04-26	2018-04-26	3k8ape4v3896mj4g944i5hs2m9	3	2
711	2018-04-27	2018-04-27	16chinh1406i4lphlgbhmc0ci0	3	2
712	2018-04-30	2018-04-30	2ns46rkj7q05kikqgkangmt9g3	3	2
713	2018-05-01	2018-05-01	55k01mfbgaacf39h3e9knf449f	3	2
714	2018-05-02	2018-05-02	31eo8rjk9ctcr0atcdsaauk8hp	3	2
715	2018-05-03	2018-05-03	2cplagk1atjo5bungtp73jstn2	3	2
716	2018-05-08	2018-05-08	2nq5ckb75o5v9ih2km3fvfc9v3	3	2
717	2018-05-09	2018-05-09	53l1g957jp9dmhj3q3g2kt35ep	3	2
718	2018-05-10	2018-05-10	22n8oiqubdia3gpb5p4nis1vm9	3	2
719	2018-05-11	2018-05-11	230mm26t6qrls7reejpjrrl2b6	3	2
720	2018-05-14	2018-05-14	3o8q265b7lrhoissqubvj15lqj	3	2
721	2018-05-15	2018-05-15	0lfk5sd3bkeiu3pfnpfdsrd3pc	3	2
722	2018-05-16	2018-05-16	5svfgjvu0p9nbs842i7keomqvf	3	2
723	2018-05-17	2018-05-17	1d0tvj7hp2it38g17ettn06moj	3	2
724	2018-05-21	2018-05-21	66a4qt41n69thr1pdsldrofq7g	3	2
725	2018-05-22	2018-05-22	0fst8kdfao9960spj23ln67351	3	2
726	2018-05-23	2018-05-23	5esv4ok586vqj88c7h5j0qt3lb	3	2
727	2018-05-24	2018-05-24	3bfqvh794r8q97d1v3sh384jfe	3	2
728	2018-06-04	2018-06-04	05ol9ihh3vd7pnr8d7cnhr7ovt	3	2
729	2018-06-05	2018-06-05	1qsp1qi4uefp5ibf7pi2cjl55b	3	2
730	2018-06-06	2018-06-06	04ee7ars3ds720mn53qn2764oa	3	2
731	2018-06-07	2018-06-07	7gkprvqs5c52rr87bp5i6hqqf3	3	2
732	2018-06-11	2018-06-11	5coq3p6i9mgpnhkjvskks8301u	3	2
733	2018-06-12	2018-06-12	4jf5gilstb89jsjrh3o4q5t6i3	3	2
734	2018-06-13	2018-06-13	3s9vnui5eu0authfcc3c84giig	3	2
735	2018-06-14	2018-06-14	4g94l14a93mei0vmpc857g0iv2	3	2
736	2018-06-18	2018-06-18	5cmm5bkfgj6gftdl8ddt4p6nl5	3	2
737	2018-06-19	2018-06-19	3dmskvv5jg6stfc49i2huih7uh	3	2
738	2018-06-20	2018-06-20	1al552d5totpe0sifem1bv7bid	3	2
739	2018-06-21	2018-06-21	273vjrbup97hc7cevtg6bsch7l	3	2
740	2018-06-25	2018-06-25	3ai9069pe6au3pfhrpkpoh4ah6	3	2
741	2018-06-26	2018-06-26	3iltrtqmig5g02ekiqmhggncac	3	2
742	2018-06-27	2018-06-27	5iiudijcoh4qb6enoodugpdvns	3	2
743	2018-06-28	2018-06-28	7m0kud5f19l04429b20v2cdcps	3	2
744	2018-06-29	2018-06-29	03fq082oa60js3cfvepsash6tn	3	2
745	2018-07-02	2018-07-02	0pdlmd6qpmrpk2pqav1gca79oq	3	2
746	2018-07-03	2018-07-03	5jk795kusiij7qngic4g5f5ha3	3	2
747	2018-07-04	2018-07-04	475dn3j3r6enfuactf90cma805	3	2
748	2018-07-05	2018-07-05	0eoo56k4eua5igcenntbdj3lgu	3	2
749	2018-07-09	2018-07-09	30lhggrb1ho2726c70te6b9ecj	3	2
750	2018-07-10	2018-07-10	6qh45l1mlppu94i7shoqlj0cpk	3	2
751	2018-07-11	2018-07-11	431d6r0m23glstmk9vv13u26q5	3	2
752	2018-07-12	2018-07-12	1a4u9bjm489i5htt7m5ikh3cg6	3	2
753	2018-07-16	2018-07-16	5h5a115karefcifuetosri0ih6	3	2
754	2018-07-17	2018-07-17	5qv2ke3m84ccur21iqt5s1cikj	3	2
755	2018-07-18	2018-07-18	01ej5vst1vgpb4jjemrr59bcrt	3	2
756	2018-07-19	2018-07-19	61l8k0a5i0h45oeto7a26rp2a6	3	2
757	2018-07-20	2018-07-20	08igif5fgnp53m45c935jqpff6	3	2
758	2018-07-23	2018-07-23	2gm14tmnukaqtav6kisnjtaavu	3	2
759	2018-07-24	2018-07-24	05b9o7vpgdr67kf2shuk9umf77	3	2
760	2018-09-04	2018-09-04	2vp0vqq3q3d9qv5vshqs5eljvq	3	2
761	2018-09-05	2018-09-05	7k8254us1bcn0cka33a1jugfur	3	2
762	2020-06-22	2020-06-22	4od5gq9eb84el6e2pt01bk9r3c	1	2
763	2020-06-23	2020-06-23	760pggmmcvmlodk1473ngn7eko	1	2
764	2018-09-06	2018-09-06	4v2f8iuherfbsvjfj84glorpqq	3	2
765	2018-09-07	2018-09-07	3pgkkdgmb8srnat7d4kpk9kf2r	3	2
766	2018-09-10	2018-09-10	56hjqj1a8vf5plbj8bgn4m0ne5	3	2
767	2018-09-11	2018-09-11	7ajlkkcrk0fcebsvqgdo1ubepe	3	2
768	2018-09-12	2018-09-12	490foeca2ol2h3jspcqo325enq	3	2
769	2018-09-13	2018-09-13	61cesm4dainrfg3pjv88ltkdil	3	2
770	2018-10-09	2018-10-09	57g0fc55n4nf8mo7oion0vbbe1	3	2
771	2018-10-10	2018-10-10	17dqcmb9ighc47r9av1tass29g	3	2
772	2018-10-11	2018-10-11	064r1dillmifbpkhq9jr7tj91m	3	2
773	2018-10-15	2018-10-15	3uclss2i2sj2etcarg7ot810hv	3	2
774	2018-10-16	2018-10-16	48i1cg8q5548hbch49kosb562o	3	2
775	2018-10-17	2018-10-17	1ek6pa2k2rki0l6jf713r0b41i	3	2
776	2018-10-18	2018-10-18	72ieic38e26keaca2j0c5kmi1e	3	2
777	2018-10-22	2018-10-22	1lckmut02qfjkq44otgj2vnsfp	3	2
778	2018-10-23	2018-10-23	1vp09pgd8q927np31j43inlbau	3	2
779	2018-10-24	2018-10-24	4d1o9hkdcqpu07pe8vj7e0g5p7	3	2
780	2018-10-25	2018-10-25	0996fq3rbtudso6d2o4c0dtfp2	3	2
781	2018-10-26	2018-10-26	0bpjh27soo0ulo9nui3piqd28o	3	2
782	2018-10-29	2018-10-29	0f6r54vkj6ge10o10h92rttrqc	3	2
783	2018-10-30	2018-10-30	0rehhlp1bqkuotqi2s4e9gaoaf	3	2
784	2018-10-31	2018-10-31	66i3sqdjth60sl4a3fenohk7jl	3	2
785	2018-11-01	2018-11-01	46ugrpnt899mp5j4t1ue4dg0hb	3	2
786	2018-11-05	2018-11-05	68sojlcehll9m127m3vdlgieur	3	2
787	2018-11-06	2018-11-06	6t7tfvpj0n8ko55pi4e3tlsnnl	3	2
788	2018-11-12	2018-11-12	15ppbsf8bjk1kc781f18cfmakj	3	2
789	2018-11-13	2018-11-13	4vlel41gkeakapvr6opjnc966g	3	2
790	2018-11-14	2018-11-14	4qr1770jiuv50fv4ebmfisio88	3	2
791	2018-11-15	2018-11-15	1fe47sjqobec5d43bs845rf7ml	3	2
792	2018-11-20	2018-11-20	0fd0uc8dkss512b86ro9sro9c2	3	2
793	2018-11-19	2018-11-19	5dqsq6j26k64pg7th2f79evia3	3	2
794	2018-11-21	2018-11-21	0rp2ur6itmqnt5s42uo1ah0hq7	3	2
795	2018-11-22	2018-11-22	7f7g0qgo7mf7io83tgd7h92vg0	3	2
796	2018-11-23	2018-11-23	4dru06vp4jbks5vs40kcqtdao9	3	2
797	2018-11-26	2018-11-26	3mkltn31k3l58f6g5u3d69legm	3	2
798	2018-11-27	2018-11-27	5475q2c5jpmbmck8coggmgdvb2	3	2
799	2018-11-28	2018-11-28	7a1gdgts56q1clpj3agelj6cmo	3	2
800	2018-11-29	2018-11-29	0kcnull1pfsin7djk7iq2199nv	3	2
801	2018-12-03	2018-12-03	466qbi64nmachcj6j99cus1ath	3	2
802	2018-12-04	2018-12-04	2pko7cpjbv98vak09kujrd7qlq	3	2
803	2018-12-05	2018-12-05	3gplssnot0vn1aue61eask54sb	3	2
804	2018-12-06	2018-12-06	2s3637h9qhf9qdtpcs1sfunkt3	3	2
805	2018-12-10	2018-12-10	1dmgjm6k4hse9c1ciqs7bjlhfg	3	2
806	2018-12-11	2018-12-11	70l1m2cp3go4ptu65s23o2j7ha	3	2
807	2018-12-12	2018-12-12	5iiji5e15t5h896n2laoe7usd5	3	2
808	2018-12-13	2018-12-13	67bsri7va1b6lg5aiqkfm5kn4e	3	2
809	2018-12-14	2018-12-14	3k09v1vrimrl2hoshn3d6rqlug	3	2
810	2018-12-17	2018-12-17	5rvmh0nu18rgq9fo3icf86aae0	3	2
811	2018-12-18	2018-12-18	0aitk17una7msne5h5a1dfv6q7	3	2
812	2018-12-19	2018-12-19	1oic89cer0r8habtnfv3b01e4e	3	2
813	2018-12-20	2018-12-20	2nrmqtunetaof2kor3p1dtt0qk	3	2
814	2019-01-07	2019-01-07	4l7kaggcf6ta1f227paqqrr6gp	3	2
815	2019-01-08	2019-01-08	2qh2t2fh2vm5auji6vpk9lcriq	3	2
816	2019-01-09	2019-01-09	78rvum1p9l3v3arlalltail591	3	2
817	2019-01-10	2019-01-10	7ms18ag4q4qnp78mrrhkg4ldg9	3	2
818	2019-01-14	2019-01-14	4uahjscsgt7v0hr9brnnl8u0sj	3	2
819	2019-01-15	2019-01-15	16uj36tcujhnp6v2ov0nhhrf01	3	2
820	2019-01-16	2019-01-16	3ujrbrilrgs3l103odpaq4mrkj	3	2
821	2019-01-17	2019-01-17	2c9977can41uk1vreclu26ekhf	3	2
822	2019-01-18	2019-01-18	56c2rps7ohjpla7n3bha9s7lo9	3	2
823	2019-01-21	2019-01-21	4o3pvpq1aqrqaqn384vcrpj02p	3	2
824	2019-01-22	2019-01-22	1ctn30e4alveed9f79k1uobi94	3	2
825	2019-01-23	2019-01-23	3sg85196h42ua3k56f7qbgeqej	3	2
826	2019-01-24	2019-01-24	1563gg6ujpk70q6b365voh1pt3	3	2
827	2019-01-28	2019-01-28	6o8jbs677eni0lg3bd0vvvvh4d	3	2
828	2019-01-29	2019-01-29	67rhct3hnk745mefkiedh5knjg	3	2
829	2019-01-30	2019-01-30	4r695lhn8d4do6u4shvjgbr1pg	3	2
830	2019-01-31	2019-01-31	5d6u4jmomca5mu070l317u4fo1	3	2
831	2019-02-01	2019-02-01	12qjhphmgnfej4i8pka5gr5n3k	3	2
832	2019-02-04	2019-02-04	7o5t6nvn3li79doa8ppihub3i8	3	2
833	2019-02-05	2019-02-05	6kjl363s4iftekq4fdouutc8t5	3	2
834	2019-02-06	2019-02-06	5rntlunn1c79lc22461cdlrqv9	3	2
835	2019-02-07	2019-02-07	01q1pqufh7g25aj282q6bqapaf	3	2
836	2019-02-11	2019-02-11	3eir5jm872ssi61c4invls41fd	3	2
837	2019-02-12	2019-02-12	2kqhpmg1mnkbh9a7kingmm3nmn	3	2
838	2019-02-13	2019-02-13	1tpj5lhuv5rfgb166c805g5sb4	3	2
839	2019-02-14	2019-02-14	0h7iipav1bmk2dfgssup5s2jm4	3	2
840	2019-02-18	2019-02-18	6865mb6u6ftsq5s4hpor2ek6hs	3	2
841	2019-02-19	2019-02-19	7jokhpatcqbtrj2rr7patjr94n	3	2
842	2019-02-20	2019-02-20	1tsmdqqhrgipadkqarihj7kvit	3	2
843	2019-02-21	2019-02-21	6svrse0f9cbv0m3ag4utp21deb	3	2
844	2019-02-25	2019-02-25	42nk3k0fvmor0v0vmdb8uiuejc	3	2
845	2019-02-26	2019-02-26	5u7bu3sgnfftkhtuole5tv3t4l	3	2
846	2019-02-27	2019-02-27	1qo1hrg37qm6clsia1nhb3sch9	3	2
847	2019-02-28	2019-02-28	0422jcpte0jn4rbnclu0bh67nb	3	2
848	2019-03-01	2019-03-01	4jbfu7jdtga40v39b3tac09ctt	3	2
849	2019-03-04	2019-03-04	7m7bf8mn7goadoba6nir3c9ml8	3	2
850	2019-03-05	2019-03-05	7cq7a1vf6n0s1r0ltug12nslc4	3	2
851	2019-03-06	2019-03-06	2tpo70eee3467tdbkp2e762vq3	3	2
852	2019-03-07	2019-03-07	3gnkaa725h34v6orbq96vu31uf	3	2
853	2019-03-11	2019-03-11	2sfq0qds8k3elptq39ttmdso8d	3	2
854	2019-03-12	2019-03-12	4c25q3el9fc8nt38o5tnd11moo	3	2
855	2019-03-13	2019-03-13	3h8f4l5c49h48btqmfneu5n1og	3	2
856	2019-03-14	2019-03-14	3gkpkssg21kohlo1hnkjo806dv	3	2
857	2019-03-15	2019-03-15	63poijk3rqpcgeuq7mo5hepeti	3	2
858	2019-03-18	2019-03-18	493uq7dh5q5fgbfobb2c5lf5bo	3	2
859	2019-03-19	2019-03-19	7vqt8quthaju56dl1u229qajgi	3	2
860	2019-03-20	2019-03-20	7svqs2n7jnd2an1b6dbkd875v3	3	2
861	2019-03-21	2019-03-21	4ebm7e6sc7o8sgkfucldm42f3u	3	2
862	2019-03-25	2019-03-25	5a13ufgdhuscb20ki69d0bdgqj	3	2
863	2019-03-26	2019-03-26	2vp1mb7ebskid3e13ntk1sai6m	3	2
864	2019-03-27	2019-03-27	6cfpke2lju2i3hh1k1raodukma	3	2
865	2019-03-28	2019-03-28	2j88ih095b3175kg96knvu5ump	3	2
866	2019-04-01	2019-04-01	5ohtdha3v19jt705adgsnsu91c	3	2
867	2019-04-02	2019-04-02	3go4vk68ejac476q0ponirl9d6	3	2
868	2019-04-03	2019-04-03	3j7e4bg41enia5dbvsb73tavam	3	2
869	2019-04-04	2019-04-04	2mf9f7hlb6c73rsjhp6r15on6d	3	2
870	2019-04-08	2019-04-08	6eb2dst6atcuoh0e3a3auh937v	3	2
871	2019-04-09	2019-04-09	7u7frvbeeftudk92kk5h82d5uj	3	2
872	2019-04-10	2019-04-10	24malal1mk66sng35bi4c0sloj	3	2
873	2019-04-11	2019-04-11	320k5c8ocpuopp2sjje6abjtgr	3	2
874	2019-04-24	2019-04-24	5c8f4livqufsva7j1g1lns9rg3	3	2
875	2019-04-25	2019-04-25	7m91nctr4pt95m6ufoamkr76f3	3	2
876	2019-04-29	2019-04-29	5prss7aghdc5hdi218ospbteti	3	2
877	2019-04-30	2019-04-30	78v9fdg9l4d7me7rlppsek7tf2	3	2
878	2019-05-01	2019-05-01	0qd6vmj6k6aclndq6n1hvtggct	3	2
879	2019-05-02	2019-05-02	76beig6l24dq8jj5976k5dgtpd	3	2
880	2019-05-07	2019-05-07	5u0p3ha0j2tga5sr9k5u6pvphj	3	2
881	2019-05-08	2019-05-08	5fk48gae4a9i634d2d39l1cb39	3	2
882	2019-05-09	2019-05-09	260qdnc24gp77m2c7ljjkgj7fr	3	2
883	2019-05-13	2019-05-13	1bqqn091tf8cdk7i54op52h10j	3	2
884	2019-05-14	2019-05-14	2u6c5sd4kmg7m0b32oslekpmbd	3	2
885	2019-05-15	2019-05-15	4ia682d1cgs094aqfigpk2n7a0	3	2
886	2019-05-16	2019-05-16	5qg5u7ib5topjjl76auog21n5s	3	2
887	2019-05-20	2019-05-20	0ig26u523ds644jepbbe8k6o6e	3	2
888	2019-05-21	2019-05-21	33lnjdkfp7penl9iqvfquiu5pg	3	2
889	2019-05-22	2019-05-22	33igq2u4chq27jajdvh4ma6huk	3	2
890	2019-05-23	2019-05-23	2543uoobs9lrotr3bsa8folokp	3	2
891	2019-06-04	2019-06-04	11fb8f7hjnm6c0pa8d14sgeqgq	3	2
892	2019-06-05	2019-06-05	5sthkhk0rb78g3jq9elfdi0meo	3	2
893	2019-06-06	2019-06-06	0mq94setk2tnm3ncf0unfhneat	3	2
894	2019-06-10	2019-06-10	51bpceftdc7khf1ppdicbgblg6	3	2
895	2019-06-11	2019-06-11	341snq5ks8u2n1q2errq2f7vus	3	2
896	2019-06-12	2019-06-12	154dmburtbbh7rllagdgnvc1l3	3	2
897	2019-06-13	2019-06-13	50pfq6s8od1s2vc3j7i8epehtv	3	2
898	2019-06-14	2019-06-14	6kmb2qevel5ephbt0k5egsbuhm	3	2
899	2019-06-17	2019-06-17	11q4tfco9lk74vhqdjgcehdrrs	3	2
900	2019-06-18	2019-06-18	7tk4gj3tft9kfi267vqmcl2571	3	2
901	2019-06-19	2019-06-19	0g40fu0d5r5ab72qd04ccncnhm	3	2
902	2019-06-20	2019-06-20	3uaiqb4nl0s3u3iscobe1hlgel	3	2
903	2019-06-24	2019-06-24	45ah416mctdg407v9l9dslbvem	3	2
904	2019-06-25	2019-06-25	625f9afvtu009v8ftktb0788l4	3	2
905	2019-06-26	2019-06-26	5d63i1f8i9ggpsfopfbr1pmmgr	3	2
906	2019-06-27	2019-06-27	7t8uivaca75cresoapaccin9ic	3	2
907	2019-07-01	2019-07-01	70s4f4lkkgq0b4tbf6l2siq493	3	2
908	2019-07-02	2019-07-02	1folqhumvipeokkhpf80t3luaa	3	2
909	2019-07-03	2019-07-03	4sfqdi2ar2l1b2ocdrqsc2a82a	3	2
910	2019-07-04	2019-07-04	7i965q1me41r2hub70mlkbgl4g	3	2
911	2019-07-08	2019-07-08	4tdm9nugjooadcnt931c1r6t8o	3	2
912	2019-07-09	2019-07-09	07geuh7m7aot9uflg9s63dadck	3	2
913	2019-07-10	2019-07-10	2ttg6a0qmp0f3lumhnhfm1e3cq	3	2
914	2019-07-11	2019-07-11	6ku1g1stsdnljrt3d4pk8rcp74	3	2
915	2019-07-15	2019-07-15	4dmi4q8h02rtcj1cck5nmvf9ns	3	2
916	2019-07-16	2019-07-16	6sm6qabsdupikdgr6a9k1cdhbs	3	2
917	2019-07-17	2019-07-17	7eungebund92kmafe16aalit4q	3	2
918	2019-07-18	2019-07-18	6r0338l135p5ki6287drlgrda0	3	2
919	2019-07-19	2019-07-19	7cnobknr1o83cljq977ij7qlp6	3	2
920	2019-07-22	2019-07-22	5buj6qjhpu3gpu2coo11ca9ujs	3	2
921	2019-07-23	2019-07-23	664jhh6up7l3haqqvqu1lcias5	3	2
922	2019-07-24	2019-07-24	0e195tt9jnle8g2u6ihiqdlfe1	3	2
923	2019-07-25	2019-07-25	2v9sho5scj2inrafufkge37dcn	3	2
924	2019-09-03	2019-09-03	5ccvj2psd91tkd1357no7jjq8u	3	2
925	2019-09-04	2019-09-04	79r7rd18psainf5b98ndhv5i80	3	2
926	2019-09-05	2019-09-05	49aidugnck3abr6p97asigu48r	3	2
927	2019-09-06	2019-09-06	5k01f7ubvfjh6f89361a0v46ae	3	2
928	2019-09-09	2019-09-09	4sei84otumgug8c0dhv40l39cf	3	2
929	2019-09-25	2019-09-25	3l9o7j529mlsfekhr7ph9j67kc	3	2
930	2019-09-26	2019-09-26	64i7q4v9jrv352ipi4q36rid40	3	2
931	2019-09-30	2019-09-30	70iv00eb9rr3mjholan0f8ge6f	3	2
932	2019-10-01	2019-10-01	7ltq7ks7uk2tnfobcpescrhbdv	3	2
933	2019-10-02	2019-10-02	6vt5mtd203jc7kcq8rpluscosc	3	2
934	2019-10-03	2019-10-03	5ik2b02uokldmo2rir60sj05v4	3	2
935	2019-10-07	2019-10-07	4cpb9cinnbk2n90j50duve4l6q	3	2
936	2019-10-08	2019-10-08	37m9gj2app9vo8746ghme29e9f	3	2
937	2019-10-14	2019-10-14	24bgc1mn6pjqb8dccrce2plmc2	2	2
938	2019-10-15	2019-10-15	2k32va3fh9qfn4563105cuq7j6	2	2
939	2019-10-16	2019-10-16	1510o9kjglgncprj3mufcc23di	2	2
940	2019-10-17	2019-10-17	6uo0omgsdq2r1qahq6jv3mhiag	2	2
941	2019-10-19	2019-10-19	5mi5j64ilqknukt12uba86j723	2	2
942	2019-10-21	2019-10-21	0skenj0eokbfinlod83m01j5bt	2	2
943	2019-10-22	2019-10-22	2u80jsqnl585dmk8dmc6lpgink	2	2
944	2019-10-23	2019-10-23	2koio98l28sv9d0ig5gkckfqar	2	2
945	2019-10-24	2019-10-24	7dieimog06d3rcp6466l5u9si8	2	2
946	2019-10-28	2019-10-28	39lctfea6om6fng1blhd60lnt7	2	2
947	2019-10-29	2019-10-29	7s916ajpts8av4p4qid3tomu75	2	2
948	2019-10-30	2019-10-30	3rp1dn8ljens4kev04kannc3n0	2	2
949	2019-10-31	2019-10-31	1a7vqtnrtmok12c11gakp1q9vl	2	2
950	2019-11-04	2019-11-04	1ppe5i6nfd8fmr3v04jg54b58b	2	2
951	2019-11-05	2019-11-05	2ip123nr2visq3qpvdortjnhdt	2	2
952	2020-06-24	2020-06-24	0f7fbn28vkq7ri5etk7k38tgvq	1	2
953	2020-06-25	2020-06-25	0g2kh8ragvss3a7smnn9hb7o5h	1	2
954	2020-06-29	2020-06-29	0eflrcd7oe45obhl2pdovqcupu	1	2
955	2020-06-30	2020-06-30	45rfmutiact46n0t4nv8bvgorb	1	2
956	2020-04-21	2020-04-21	07i55k25omj71v2u2lr3uu393g	1	2
957	2020-04-22	2020-04-22	785tormnf4g642ahco75hfjo4a	1	2
958	2020-04-28	2020-04-28	2rhtndg5v6vo09eaqp6f1f20r4	1	2
959	2020-07-01	2020-07-01	62qade4qjj5vu2k4ptrckeirv2	1	2
960	2020-09-11	2020-09-11	7ukc5bcngven3bpboli5l0usfp	1	1
961	2020-10-16	2020-10-16	25ajek8g781vf3vq8u62q68kh3	1	1
962	2020-10-23	2020-10-23	1mqq8iqiasm7hgi3uj7b7rj5tv	1	1
963	2020-10-30	2020-10-30	14pj811u9ihovmpo5hqbpvkkgm	1	1
964	2020-07-02	2020-07-02	4rttl3k6ckfibce7djjnbl3aol	1	1
965	2020-07-02	2020-07-02	5e7fo7l5lkvgo49k090lm3j5lh	1	2
968	2020-07-24	2020-07-24	59n6e69dev8827hgeichf75hfn	1	2
969	2020-09-02	2020-09-02	73i91t6olama9h6gk98vo2bf9r	1	1
970	2020-09-03	2020-09-03	1k9hvavo8ach0o6jqukkb2ssaa	1	1
972	2020-09-07	2020-09-07	7ihmbh41unq573fvqgpkg0t0qr	1	1
974	2020-07-22	2020-07-22	48fhc9rkdakpnbnjpb7pu5t0n1	1	1
975	2020-09-01	2020-09-01	0dq8sjqj8v35jkej0ujtr8or8l	1	1
976	2020-09-21	2020-09-21	25p87jtkfhds3ktql0o5vgleid	1	1
977	2020-09-22	2020-09-22	01e0d8rp56islf5h2v92kdqnee	1	1
978	2020-09-23	2020-09-23	6q567i8am1e92bvm6t3j0gnit9	1	1
979	2020-09-24	2020-09-24	73uj3aol18jh20lrj8r0flgrd8	1	1
980	2020-09-25	2020-09-25	7tlk6jddpeq9v0q2h2r8p3uod7	1	1
981	2020-09-28	2020-09-28	58h6f391obdnvl8u0a99qikbif	1	1
982	2020-09-29	2020-09-29	7dqc1q0deocqu1o8olr2eoe22c	1	1
983	2020-09-30	2020-09-30	27nejr8p7bks4htqqfbuqqjm2a	1	1
984	2020-10-01	2020-10-01	05nnuukuovh2al53lsfhn9lap7	1	1
985	2020-10-05	2020-10-05	50nskbru6ng5ba9fkc32qe0ku1	1	1
986	2020-10-06	2020-10-06	6smff3qm155ei6qrlcfst9en97	1	1
987	2020-10-07	2020-10-07	65qj61inkvb5irbitka9on7b9h	1	1
988	2020-10-08	2020-10-08	20mq7961rq496a3vqt46f8okpn	1	1
989	2020-10-12	2020-10-12	2447k2k2vplmol9rppsqjno5lm	1	1
990	2020-11-02	2020-11-02	4vd553aejl48kn8oh7vc24s6mi	1	1
991	2020-11-03	2020-11-03	3fveevc6fo9hish479hvg3hepd	1	1
992	2020-11-04	2020-11-04	5htc60o91i263l8ccvntua0jr9	1	1
993	2020-11-05	2020-11-05	0ermi27avlrpj87k08h177epij	1	1
994	2020-11-02	2020-11-02	4nsnr2s32l3hnidmnn4gug5kj5	1	2
995	2020-11-03	2020-11-03	5qdi1ls0ea257u1e3ho02tqlr7	1	2
996	2020-11-04	2020-11-04	0ig59ph3501h3gvgqig30dpcrv	1	2
997	2020-11-05	2020-11-05	7erjm0cohq6cd5k1g3i821o8qo	1	2
998	2020-07-06	2020-07-06	2194imvbj855lejvmsln27qn3p	1	1
999	2020-07-06	2020-07-06	7rs9j7dml5rm4p9u8co64actu5	1	2
1000	2020-07-07	2020-07-07	4cch8pc7aoq7j6rj9mrr6rfm4f	1	1
1001	2020-07-07	2020-07-07	2ct4654nlo9c1upe74nggip452	1	2
1002	2020-07-08	2020-07-08	0a0tica4us2f8siu23q438esa6	1	1
1003	2020-07-08	2020-07-08	42dm7l8mcnj8fbbg3llunhe0pd	1	2
1004	2020-07-09	2020-07-09	4fg2f6a377e64382s5j5vfluie	1	1
1005	2020-07-09	2020-07-09	4s3nflmq2a9p1k12b3eq8e9iqo	1	2
1006	2020-07-17	2020-07-17	5u2p6i84g0ah4skqu9sra20jfo	1	2
1007	2020-07-10	2020-07-10	7g6s00bhbb0q15iubvcqtvib8j	1	2
1008	2020-07-13	2020-07-13	6e0m3sahdpvooi7lhcqoq78r0d	1	1
1009	2020-07-13	2020-07-13	7esimfege59qorfgf5r4dpg0r4	1	2
1010	2020-07-14	2020-07-14	309le81rnsa8v19l0pfhige9af	1	1
1011	2020-07-14	2020-07-14	0eetf3st34leatks9jt3i0uq3m	1	2
\.


--
-- Data for Name: sync_tokens; Type: TABLE DATA; Schema: public; Owner: robert
--

COPY public.sync_tokens (id, google_calendar_id, token) FROM stdin;
3	p1lfs3elv1fk0lqdigs3jngop8@group.calendar.google.com	CMjFktbHqeoCEMjFktbHqeoCGAE=
4	ikdqq0rcg07bbs64g7aeqqlkt4@group.calendar.google.com	CIicveWpwuoCEIicveWpwuoCGAE=
5	ibbc1cen1mdm6rsf6kkno17i0c@group.calendar.google.com	CLiC6uWpwuoCELiC6uWpwuoCGAE=
1	20n14bks46tvd2k5rse3jmsfb4@group.calendar.google.com	CMiO9MD1yeoCEMiO9MD1yeoCGAE=
2	o26tfi8b5o78cborja7utgpcb8@group.calendar.google.com	CMiAz8D1yeoCEMiAz8D1yeoCGAE=
\.


--
-- Data for Name: virtual_sitting_days; Type: TABLE DATA; Schema: public; Owner: robert
--

COPY public.virtual_sitting_days (id, start_date, end_date, google_event_id, session_id, house_id) FROM stdin;
1	2020-04-23	2020-04-23	6sg8ulfpj7o7rteh1foj6q6pne	1	2
2	2020-04-29	2020-04-29	089gkjmao56anjhjh3qk7paukq	1	2
3	2020-04-30	2020-04-30	3jbqfs1u2a04011f4k8acjm3di	1	2
4	2020-05-05	2020-05-05	594qt6gh12j6gb81mgp9c02vqg	1	2
5	2020-05-12	2020-05-12	7g452f5cs3cmfaq276vdck92e4	1	2
6	2020-05-13	2020-05-13	1ke0jd0k6nnaptka6ttl4b501a	1	2
7	2020-05-18	2020-05-18	4b2h7fau4js29nhvh5b8hau16f	1	2
8	2020-05-20	2020-05-20	66pngpltlie78v5s3rjt9j285n	1	2
9	2020-05-21	2020-05-21	51d1vo7tb9mptgok0qcl27n74k	1	2
10	2020-06-02	2020-06-02	18u77htnkv2k7qf9ho9sfll266	1	2
11	2020-06-03	2020-06-03	116g4n3akb0499e530bon8ms1b	1	2
\.


--
-- Name: adjournment_days_id_seq; Type: SEQUENCE SET; Schema: public; Owner: robert
--

SELECT pg_catalog.setval('public.adjournment_days_id_seq', 1618, true);


--
-- Name: dissolution_days_id_seq; Type: SEQUENCE SET; Schema: public; Owner: robert
--

SELECT pg_catalog.setval('public.dissolution_days_id_seq', 3153, true);


--
-- Name: dissolution_periods_id_seq; Type: SEQUENCE SET; Schema: public; Owner: robert
--

SELECT pg_catalog.setval('public.dissolution_periods_id_seq', 57, true);


--
-- Name: houses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: robert
--

SELECT pg_catalog.setval('public.houses_id_seq', 2, true);


--
-- Name: parliament_periods_id_seq; Type: SEQUENCE SET; Schema: public; Owner: robert
--

SELECT pg_catalog.setval('public.parliament_periods_id_seq', 58, true);


--
-- Name: procedures_id_seq; Type: SEQUENCE SET; Schema: public; Owner: robert
--

SELECT pg_catalog.setval('public.procedures_id_seq', 11, true);


--
-- Name: prorogation_days_id_seq; Type: SEQUENCE SET; Schema: public; Owner: robert
--

SELECT pg_catalog.setval('public.prorogation_days_id_seq', 187, true);


--
-- Name: prorogation_periods_id_seq; Type: SEQUENCE SET; Schema: public; Owner: robert
--

SELECT pg_catalog.setval('public.prorogation_periods_id_seq', 29, true);


--
-- Name: sessions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: robert
--

SELECT pg_catalog.setval('public.sessions_id_seq', 40, true);


--
-- Name: sitting_days_id_seq; Type: SEQUENCE SET; Schema: public; Owner: robert
--

SELECT pg_catalog.setval('public.sitting_days_id_seq', 1011, true);


--
-- Name: sync_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: robert
--

SELECT pg_catalog.setval('public.sync_tokens_id_seq', 5, true);


--
-- Name: virtual_sitting_days_id_seq; Type: SEQUENCE SET; Schema: public; Owner: robert
--

SELECT pg_catalog.setval('public.virtual_sitting_days_id_seq', 11, true);


--
-- Name: adjournment_days adjournment_days_pkey; Type: CONSTRAINT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.adjournment_days
    ADD CONSTRAINT adjournment_days_pkey PRIMARY KEY (id);


--
-- Name: dissolution_days dissolution_days_pkey; Type: CONSTRAINT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.dissolution_days
    ADD CONSTRAINT dissolution_days_pkey PRIMARY KEY (id);


--
-- Name: dissolution_periods dissolution_periods_pkey; Type: CONSTRAINT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.dissolution_periods
    ADD CONSTRAINT dissolution_periods_pkey PRIMARY KEY (id);


--
-- Name: houses houses_pkey; Type: CONSTRAINT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.houses
    ADD CONSTRAINT houses_pkey PRIMARY KEY (id);


--
-- Name: parliament_periods parliament_periods_pkey; Type: CONSTRAINT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.parliament_periods
    ADD CONSTRAINT parliament_periods_pkey PRIMARY KEY (id);


--
-- Name: procedures procedures_pkey; Type: CONSTRAINT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.procedures
    ADD CONSTRAINT procedures_pkey PRIMARY KEY (id);


--
-- Name: prorogation_days prorogation_days_pkey; Type: CONSTRAINT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.prorogation_days
    ADD CONSTRAINT prorogation_days_pkey PRIMARY KEY (id);


--
-- Name: prorogation_periods prorogation_periods_pkey; Type: CONSTRAINT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.prorogation_periods
    ADD CONSTRAINT prorogation_periods_pkey PRIMARY KEY (id);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: sitting_days sitting_days_pkey; Type: CONSTRAINT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.sitting_days
    ADD CONSTRAINT sitting_days_pkey PRIMARY KEY (id);


--
-- Name: sync_tokens sync_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.sync_tokens
    ADD CONSTRAINT sync_tokens_pkey PRIMARY KEY (id);


--
-- Name: virtual_sitting_days virtual_sitting_days_pkey; Type: CONSTRAINT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.virtual_sitting_days
    ADD CONSTRAINT virtual_sitting_days_pkey PRIMARY KEY (id);


--
-- Name: dissolution_days fk_dissolution_period; Type: FK CONSTRAINT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.dissolution_days
    ADD CONSTRAINT fk_dissolution_period FOREIGN KEY (dissolution_period_id) REFERENCES public.dissolution_periods(id);


--
-- Name: sitting_days fk_house; Type: FK CONSTRAINT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.sitting_days
    ADD CONSTRAINT fk_house FOREIGN KEY (house_id) REFERENCES public.houses(id);


--
-- Name: virtual_sitting_days fk_house; Type: FK CONSTRAINT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.virtual_sitting_days
    ADD CONSTRAINT fk_house FOREIGN KEY (house_id) REFERENCES public.houses(id);


--
-- Name: adjournment_days fk_house; Type: FK CONSTRAINT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.adjournment_days
    ADD CONSTRAINT fk_house FOREIGN KEY (house_id) REFERENCES public.houses(id);


--
-- Name: prorogation_periods fk_parliament_period; Type: FK CONSTRAINT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.prorogation_periods
    ADD CONSTRAINT fk_parliament_period FOREIGN KEY (parliament_period_id) REFERENCES public.parliament_periods(id);


--
-- Name: sessions fk_parliament_period; Type: FK CONSTRAINT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT fk_parliament_period FOREIGN KEY (parliament_period_id) REFERENCES public.parliament_periods(id);


--
-- Name: prorogation_days fk_prorogation_period; Type: FK CONSTRAINT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.prorogation_days
    ADD CONSTRAINT fk_prorogation_period FOREIGN KEY (prorogation_period_id) REFERENCES public.prorogation_periods(id);


--
-- Name: sitting_days fk_session; Type: FK CONSTRAINT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.sitting_days
    ADD CONSTRAINT fk_session FOREIGN KEY (session_id) REFERENCES public.sessions(id);


--
-- Name: virtual_sitting_days fk_session; Type: FK CONSTRAINT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.virtual_sitting_days
    ADD CONSTRAINT fk_session FOREIGN KEY (session_id) REFERENCES public.sessions(id);


--
-- Name: adjournment_days fk_session; Type: FK CONSTRAINT; Schema: public; Owner: robert
--

ALTER TABLE ONLY public.adjournment_days
    ADD CONSTRAINT fk_session FOREIGN KEY (session_id) REFERENCES public.sessions(id);


--
-- PostgreSQL database dump complete
--

