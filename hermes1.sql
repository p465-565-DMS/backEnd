--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.23
-- Dumped by pg_dump version 9.5.23

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: company; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.company (
    compid integer NOT NULL,
    compname text,
    creatorid integer,
    logo text,
    description text,
    address text
);


ALTER TABLE public.company OWNER TO postgres;

--
-- Name: company_compid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.company_compid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.company_compid_seq OWNER TO postgres;

--
-- Name: company_compid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.company_compid_seq OWNED BY public.company.compid;


--
-- Name: companyrelations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.companyrelations (
    compid integer,
    userid integer
);


ALTER TABLE public.companyrelations OWNER TO postgres;

--
-- Name: customertopackage; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customertopackage (
    userid integer,
    packageid integer
);


ALTER TABLE public.customertopackage OWNER TO postgres;

--
-- Name: deliveryadmin; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.deliveryadmin (
    adminid integer NOT NULL,
    userid integer,
    companyname character varying(255) NOT NULL,
    spkg boolean,
    mpkg boolean,
    lpkg boolean,
    electronic boolean,
    delicate boolean,
    heavy boolean,
    doc boolean,
    other boolean,
    express boolean,
    normal boolean
);


ALTER TABLE public.deliveryadmin OWNER TO postgres;

--
-- Name: deliveryadmin_adminid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.deliveryadmin_adminid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.deliveryadmin_adminid_seq OWNER TO postgres;

--
-- Name: deliveryadmin_adminid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.deliveryadmin_adminid_seq OWNED BY public.deliveryadmin.adminid;


--
-- Name: deliverydriver; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.deliverydriver (
    driverid integer NOT NULL,
    userid integer,
    companyname character varying(255) NOT NULL,
    licenseno character varying(15)
);


ALTER TABLE public.deliverydriver OWNER TO postgres;

--
-- Name: deliverydriver_driverid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.deliverydriver_driverid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.deliverydriver_driverid_seq OWNER TO postgres;

--
-- Name: deliverydriver_driverid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.deliverydriver_driverid_seq OWNED BY public.deliverydriver.driverid;


--
-- Name: package; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.package (
    packageid integer NOT NULL,
    packagetitle text,
    packagedescription text,
    packageslocation text,
    deadline text,
    packageelocation text,
    packagedeliverystatus text
);


ALTER TABLE public.package OWNER TO postgres;

--
-- Name: package_packageid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.package_packageid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.package_packageid_seq OWNER TO postgres;

--
-- Name: package_packageid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.package_packageid_seq OWNED BY public.package.packageid;


--
-- Name: packagerelations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.packagerelations (
    userid integer,
    packageid text
);


ALTER TABLE public.packagerelations OWNER TO postgres;

--
-- Name: servicedetails; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.servicedetails (
    id integer NOT NULL,
    adminid integer,
    spkg numeric,
    mpkg numeric,
    lpkg numeric,
    electronic numeric,
    delicate numeric,
    heavy numeric,
    doc numeric,
    other numeric,
    express numeric,
    normal numeric
);


ALTER TABLE public.servicedetails OWNER TO postgres;

--
-- Name: servicedetails_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.servicedetails_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.servicedetails_id_seq OWNER TO postgres;

--
-- Name: servicedetails_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.servicedetails_id_seq OWNED BY public.servicedetails.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    userid integer NOT NULL,
    fname text NOT NULL,
    lname text NOT NULL,
    username text NOT NULL,
    role text NOT NULL,
    address text,
    phone character varying,
    email character varying,
    state text,
    city text,
    zipcode character varying
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_userid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_userid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_userid_seq OWNER TO postgres;

--
-- Name: users_userid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_userid_seq OWNED BY public.users.userid;


--
-- Name: compid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.company ALTER COLUMN compid SET DEFAULT nextval('public.company_compid_seq'::regclass);


--
-- Name: adminid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deliveryadmin ALTER COLUMN adminid SET DEFAULT nextval('public.deliveryadmin_adminid_seq'::regclass);


--
-- Name: driverid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deliverydriver ALTER COLUMN driverid SET DEFAULT nextval('public.deliverydriver_driverid_seq'::regclass);


--
-- Name: packageid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.package ALTER COLUMN packageid SET DEFAULT nextval('public.package_packageid_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.servicedetails ALTER COLUMN id SET DEFAULT nextval('public.servicedetails_id_seq'::regclass);


--
-- Name: userid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN userid SET DEFAULT nextval('public.users_userid_seq'::regclass);


--
-- Data for Name: company; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.company (compid, compname, creatorid, logo, description, address) FROM stdin;
1	Presidential Shark Industries	1	image.jpg	WE SHIP. BY SHARK.	107 S Indiana Ave, Bloomington, IN 47405
2	Iniatoyo Shippers	2	image.jpg	You shipped my father, prepare to ship services.	107 S Indiana Ave, Bloomington, IN 47405
3	Vees Viral Shippers	3	image.jpg	Contagiously good.	107 S Indiana Ave, Bloomington, IN 47405
4	Presidential Shark Industries	1	image.jpg	WE SHIP. BY SHARK.	107 S Indiana Ave, Bloomington, IN 47405
5	Iniatoyo Shippers	2	image.jpg	You shipped my father, prepare to ship services.	107 S Indiana Ave, Bloomington, IN 47405
6	Vees Viral Shippers	3	image.jpg	Contagiously good.	107 S Indiana Ave, Bloomington, IN 47405
\.


--
-- Name: company_compid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.company_compid_seq', 6, true);


--
-- Data for Name: companyrelations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.companyrelations (compid, userid) FROM stdin;
1	1
1	4
1	5
2	2
2	6
2	7
3	3
3	8
3	9
1	1
1	4
1	5
2	2
2	6
2	7
3	3
3	8
3	9
\.


--
-- Data for Name: customertopackage; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customertopackage (userid, packageid) FROM stdin;
10	1
11	2
10	3
11	4
10	5
11	6
10	1
11	2
10	3
11	4
10	5
11	6
\.


--
-- Data for Name: deliveryadmin; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.deliveryadmin (adminid, userid, companyname, spkg, mpkg, lpkg, electronic, delicate, heavy, doc, other, express, normal) FROM stdin;
5	46	FedX	t	t	t	t	t	f	t	t	t	t
\.


--
-- Name: deliveryadmin_adminid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.deliveryadmin_adminid_seq', 5, true);


--
-- Data for Name: deliverydriver; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.deliverydriver (driverid, userid, companyname, licenseno) FROM stdin;
1	49	FedX	2546879
\.


--
-- Name: deliverydriver_driverid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.deliverydriver_driverid_seq', 1, true);


--
-- Data for Name: package; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.package (packageid, packagetitle, packagedescription, packageslocation, deadline, packageelocation, packagedeliverystatus) FROM stdin;
1	Shark Fin Soup	These shark fins are grown from premium shark fin trees, and is 100% humane	\r\n                      502 E Kirkwood Ave	10/11/2021	430 E Kirkwood Ave # 18, Bloomington, IN 47408	UNSHIPPED
2	Ghost Grenades	These grenades are 100% effective against ghosts, guarenteed.	\r\n                      502 E Kirkwood Ave	10/11/2021	430 E Kirkwood Ave # 18, Bloomington, IN 47408	UNSHIPPED
3	Excalibur	Can only be delivered by the king.	\r\n                      502 E Kirkwood Ave	10/11/2021	430 E Kirkwood Ave # 18, Bloomington, IN 47408	IN TRANSIT
4	Gun	Get rid of your competition with this convienent weapon. Usable in almost any scenario!	\r\n                      502 E Kirkwood Ave	10/11/2021	430 E Kirkwood Ave # 18, Bloomington, IN 47408	IN TRANSIT
5	Magic Karate Belt	Wear this belt and magically gain karate powers rivaling any Bruce Lee baddie.	\r\n                      502 E Kirkwood Ave	10/11/2021	430 E Kirkwood Ave # 18, Bloomington, IN 47408	DELIVERED
6	Shark Fin Soup	These shark fins are grown from premium shark fin trees, and is 100% humane	\r\n                      502 E Kirkwood Ave	10/11/2021	430 E Kirkwood Ave # 18, Bloomington, IN 47408	DELIVERED
\.


--
-- Name: package_packageid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.package_packageid_seq', 6, true);


--
-- Data for Name: packagerelations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.packagerelations (userid, packageid) FROM stdin;
4	00001
5	00002
6	00003
7	00004
8	00005
9	00006
4	1
5	2
6	3
7	4
8	5
9	6
4	1
5	4
6	3
4	1
5	2
6	3
7	4
8	5
9	6
4	1
5	4
\.


--
-- Data for Name: servicedetails; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.servicedetails (id, adminid, spkg, mpkg, lpkg, electronic, delicate, heavy, doc, other, express, normal) FROM stdin;
\.


--
-- Name: servicedetails_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.servicedetails_id_seq', 1, false);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (userid, fname, lname, username, role, address, phone, email, state, city, zipcode) FROM stdin;
33	Viral	Prajapati	viralprajapati07	admin	720 S College Mall Rd	123456789	viralprajapati07@gmail.com	IN	Bloomington	47401
34	John	johnson	jjson	user	555 S College Mall Rd	456789123	jjson@gmail.com	IN	Bloomington	47401
35	Luke	Martin	lmartin	ddriver	721 S College Mall Rd	582146397	lmartin@gmail.com	IN	Bloomington	47401
39	Viral	Prajapati	vkprajap	user	502 S Park Ridge Rd	123456789	vkprajap@iu.edu	IN	Bloomington	47401
46	Viral	Prajapati	vkp	admin	502 S Park Ridge Rd	123456789	vkp@iu.edu	IN	Bloomington	47401
49	Anshul	Vohra	ansvohra	driver	502 S Park Ridge Rd	123456789	ansvohrap@iu.edu	IN	Bloomington	47401
\.


--
-- Name: users_userid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_userid_seq', 49, true);


--
-- Name: company_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.company
    ADD CONSTRAINT company_pkey PRIMARY KEY (compid);


--
-- Name: deliveryadmin_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deliveryadmin
    ADD CONSTRAINT deliveryadmin_pkey PRIMARY KEY (adminid);


--
-- Name: deliverydriver_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deliverydriver
    ADD CONSTRAINT deliverydriver_pkey PRIMARY KEY (driverid);


--
-- Name: package_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.package
    ADD CONSTRAINT package_pkey PRIMARY KEY (packageid);


--
-- Name: servicedetails_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.servicedetails
    ADD CONSTRAINT servicedetails_pkey PRIMARY KEY (id);


--
-- Name: unique_username; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT unique_username UNIQUE (username);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (userid);


--
-- Name: companyrelations_compid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.companyrelations
    ADD CONSTRAINT companyrelations_compid_fkey FOREIGN KEY (compid) REFERENCES public.company(compid);


--
-- Name: customertopackage_packageid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customertopackage
    ADD CONSTRAINT customertopackage_packageid_fkey FOREIGN KEY (packageid) REFERENCES public.package(packageid);


--
-- Name: fk_dadmin; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deliveryadmin
    ADD CONSTRAINT fk_dadmin FOREIGN KEY (userid) REFERENCES public.users(userid);


--
-- Name: fk_ddriver; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deliverydriver
    ADD CONSTRAINT fk_ddriver FOREIGN KEY (userid) REFERENCES public.users(userid);


--
-- Name: fk_service; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.servicedetails
    ADD CONSTRAINT fk_service FOREIGN KEY (adminid) REFERENCES public.deliveryadmin(adminid);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

