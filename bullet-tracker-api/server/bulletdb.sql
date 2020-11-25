--
-- PostgreSQL database dump
--

-- Dumped from database version 12.5
-- Dumped by pg_dump version 12.5

-- Started on 2020-11-25 10:52:53

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
-- TOC entry 203 (class 1259 OID 16625)
-- Name: categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.categories (
    categoryid integer NOT NULL,
    category_name character varying(20) DEFAULT 'Unknown'::character varying
);


--
-- TOC entry 204 (class 1259 OID 16628)
-- Name: Categories_CategoryId_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."Categories_CategoryId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2856 (class 0 OID 0)
-- Dependencies: 204
-- Name: Categories_CategoryId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."Categories_CategoryId_seq" OWNED BY public.categories.categoryid;


--
-- TOC entry 202 (class 1259 OID 16619)
-- Name: bullets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.bullets (
    creation_date date NOT NULL,
    start_date date NOT NULL,
    end_date date,
    category_id integer NOT NULL,
    strength integer,
    summary character varying(120),
    narrative text,
    user_id integer NOT NULL,
    bullet_format character varying(120),
    bullet_action character varying(120),
    bullet_impact character varying(120),
    bullet_result character varying(120),
    bulletid integer NOT NULL
);


--
-- TOC entry 205 (class 1259 OID 16652)
-- Name: bullets_bulletid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.bullets_bulletid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2857 (class 0 OID 0)
-- Dependencies: 205
-- Name: bullets_bulletid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.bullets_bulletid_seq OWNED BY public.bullets.bulletid;


--
-- TOC entry 209 (class 1259 OID 16671)
-- Name: bullets_categories_join; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.bullets_categories_join (
    relationshipid integer NOT NULL,
    category_id integer NOT NULL,
    bullet_id integer NOT NULL
);


--
-- TOC entry 208 (class 1259 OID 16669)
-- Name: bullets_categories_join_bullet_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.bullets_categories_join_bullet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2858 (class 0 OID 0)
-- Dependencies: 208
-- Name: bullets_categories_join_bullet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.bullets_categories_join_bullet_id_seq OWNED BY public.bullets_categories_join.bullet_id;


--
-- TOC entry 207 (class 1259 OID 16667)
-- Name: bullets_categories_join_category_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.bullets_categories_join_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2859 (class 0 OID 0)
-- Dependencies: 207
-- Name: bullets_categories_join_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.bullets_categories_join_category_id_seq OWNED BY public.bullets_categories_join.category_id;


--
-- TOC entry 206 (class 1259 OID 16665)
-- Name: bullets_categories_join_relationshipid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.bullets_categories_join_relationshipid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2860 (class 0 OID 0)
-- Dependencies: 206
-- Name: bullets_categories_join_relationshipid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.bullets_categories_join_relationshipid_seq OWNED BY public.bullets_categories_join.relationshipid;


--
-- TOC entry 2704 (class 2604 OID 16654)
-- Name: bullets bulletid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bullets ALTER COLUMN bulletid SET DEFAULT nextval('public.bullets_bulletid_seq'::regclass);


--
-- TOC entry 2707 (class 2604 OID 16674)
-- Name: bullets_categories_join relationshipid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bullets_categories_join ALTER COLUMN relationshipid SET DEFAULT nextval('public.bullets_categories_join_relationshipid_seq'::regclass);


--
-- TOC entry 2705 (class 2604 OID 16630)
-- Name: categories categoryid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories ALTER COLUMN categoryid SET DEFAULT nextval('public."Categories_CategoryId_seq"'::regclass);


--
-- TOC entry 2843 (class 0 OID 16619)
-- Dependencies: 202
-- Data for Name: bullets; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.bullets (creation_date, start_date, end_date, category_id, strength, summary, narrative, user_id, bullet_format, bullet_action, bullet_impact, bullet_result, bulletid) FROM stdin;
2020-11-23	2019-09-07	2020-08-29	1	3	Earned CCAF	Earned my CCAF in Aircraft Maintenance Tech. Completed 18 credit hours between Sep 2019 and August 2020. Completed degree plan five months ahead of schedule. 3.4 GPA.	1	- Awarded CCAF Aircraft Maintenance Tech degree; completed 18 credit hrs--exceeded degree plan by 5 mths	Awarded CCAF Aircraft Maintenance Tech degree	completed 18 credit hrs	exceeded degree plan by 5 mths	1
2020-11-23	2019-05-13	2020-10-05	1	2	Completed some certification course	Earned certification in some field. Sentence about time spent, outstanding performance, and how it will assist in the performance of my primary duties.	1	- Earned XYZ certification via 5 mo. course; [something something impact] -- [something something result]				11
\.


--
-- TOC entry 2850 (class 0 OID 16671)
-- Dependencies: 209
-- Data for Name: bullets_categories_join; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.bullets_categories_join (relationshipid, category_id, bullet_id) FROM stdin;
1	1	1
2	1	11
\.


--
-- TOC entry 2844 (class 0 OID 16625)
-- Dependencies: 203
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.categories (categoryid, category_name) FROM stdin;
1	Education
2	Primary Duties
3	Volunteer
4	Leadership
\.


--
-- TOC entry 2861 (class 0 OID 0)
-- Dependencies: 204
-- Name: Categories_CategoryId_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."Categories_CategoryId_seq"', 4, true);


--
-- TOC entry 2862 (class 0 OID 0)
-- Dependencies: 205
-- Name: bullets_bulletid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.bullets_bulletid_seq', 11, true);


--
-- TOC entry 2863 (class 0 OID 0)
-- Dependencies: 208
-- Name: bullets_categories_join_bullet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.bullets_categories_join_bullet_id_seq', 1, false);


--
-- TOC entry 2864 (class 0 OID 0)
-- Dependencies: 207
-- Name: bullets_categories_join_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.bullets_categories_join_category_id_seq', 1, false);


--
-- TOC entry 2865 (class 0 OID 0)
-- Dependencies: 206
-- Name: bullets_categories_join_relationshipid_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.bullets_categories_join_relationshipid_seq', 2, true);


--
-- TOC entry 2711 (class 2606 OID 16635)
-- Name: categories Categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT "Categories_pkey" PRIMARY KEY (categoryid);


--
-- TOC entry 2713 (class 2606 OID 16678)
-- Name: bullets_categories_join bullets_categories_join_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bullets_categories_join
    ADD CONSTRAINT bullets_categories_join_pkey PRIMARY KEY (relationshipid);


--
-- TOC entry 2709 (class 2606 OID 16662)
-- Name: bullets bullets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bullets
    ADD CONSTRAINT bullets_pkey PRIMARY KEY (bulletid);


--
-- TOC entry 2716 (class 2606 OID 16689)
-- Name: bullets_categories_join bulletid; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bullets_categories_join
    ADD CONSTRAINT bulletid FOREIGN KEY (bullet_id) REFERENCES public.bullets(bulletid) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 2714 (class 2606 OID 16642)
-- Name: bullets bullets_CategoryId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bullets
    ADD CONSTRAINT "bullets_CategoryId_fkey" FOREIGN KEY (category_id) REFERENCES public.categories(categoryid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2715 (class 2606 OID 16679)
-- Name: bullets_categories_join categoryid; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bullets_categories_join
    ADD CONSTRAINT categoryid FOREIGN KEY (category_id) REFERENCES public.categories(categoryid) ON UPDATE CASCADE ON DELETE SET NULL;


-- Completed on 2020-11-25 10:52:53

--
-- PostgreSQL database dump complete
--

