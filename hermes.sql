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
-- Name: SequelizeMeta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."SequelizeMeta" (
    name character varying(255) NOT NULL
);


ALTER TABLE public."SequelizeMeta" OWNER TO postgres;

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
    deadline character varying,
    packagelocation character varying,
    packagestatus character varying,
    packageassigned character varying,
    packagespeed character varying,
    packagetype character varying,
    packagesize character varying,
    packageweight character varying,
    packagesource character varying,
    packagedestination character varying,
    userid integer,
    adminid integer,
    review character varying,
    price double precision,
    trackingid character varying,
    lat decimal,
    long decimal
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
    pspeed text,
    ptype text,
    psize text,
    pweight text,
    price numeric NOT NULL
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
    zipcode character varying,
    googlelink character varying,
    lat decimal,
    long decimal
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
-- Data for Name: SequelizeMeta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."SequelizeMeta" (name) FROM stdin;
20201104041414-create-url.js
\.


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
\.


--
-- Data for Name: deliveryadmin; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.deliveryadmin (adminid, userid, companyname, spkg, mpkg, lpkg, electronic, delicate, heavy, doc, other, express, normal) FROM stdin;
7	61	FedEx	t	t	t	t	t	t	t	t	t	t
8	62	UPS	t	t	t	t	t	f	t	f	t	t
9	63	FedEx	t	t	t	t	t	f	t	f	t	t
10	64	USPS	t	t	t	t	t	f	t	f	t	t
11	65	FedEx	t	t	t	t	t	t	t	t	t	t
12	66	UPS	t	t	t	t	t	t	t	t	t	t
13	71	FedEx	t	t	t	t	t	t	t	t	t	t
\.


--
-- Name: deliveryadmin_adminid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.deliveryadmin_adminid_seq', 13, true);


--
-- Data for Name: deliverydriver; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.deliverydriver (driverid, userid, companyname, licenseno) FROM stdin;
5	67	FedEx	1245785
6	68	FedEx	784519
7	69	FedEx	562359
8	70	UPS	Ad4579
\.


--
-- Name: deliverydriver_driverid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.deliverydriver_driverid_seq', 9, true);


--
-- Data for Name: package; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.package (packageid, deadline, packagelocation, packagestatus, packageassigned, packagespeed, packagetype, packagesize, packageweight, packagesource, packagedestination, userid, adminid, review, price, trackingid, lat, long) FROM stdin;
13	12/17/2020	https://maps.google.com/?q=4511+3rd+Ave.,+The+Bronx,+NY+10457,+USA&ftid=0x89c2f47db1da1731:0xd35b3a18ce33b746	Delivered	limitax114	Regular	Regular	Small	Light	521 North Washington Street	747 Manhattan Beach Boulevard	78	7	5 stars	10	6c3187a6eb4c288c97c001e9e37de19c	-118.4042906	33.8871918
14	12/17/2020	https://maps.google.com/?q=4511+3rd+Ave.,+The+Bronx,+NY+10457,+USA&ftid=0x89c2f47db1da1731:0xd35b3a18ce33b746	Delivered	limitax114	Regular	Regular	Small	Light	521 North Washington Street	7211 Interstate 35	78	7	ok	10	fe7f8255ec93559f68e1f4bba7642112	-97.7018542	30.3325467
12	12/03/2020	https://maps.google.com/?q=5441+N+East+River+Rd,+Chicago,+IL+60656,+USA&ftid=0x880fca1d7a5b8631:0x7bd1524bc944b4f	Recieved	xologic282	Regular	Electronic	Small	Light	721 S College Mall Rd	5441 North East River Road	78	8	Not satisfying service, received package after estimated time.	75	a12b2cb38bad9b45b5caf08d6773e7e4	-87.8432723	41.9782801
15	12/03/2020	https://maps.google.com/?q=4540+Center+Blvd,+Queens,+NY+11109,+USA&ftid=0x89c25921a251e7c7:0xae4955bac345fdbc	Recieved	\N	Regular	Electronic	Small	Light	721 S College Mall Rd	4540 Center Boulevard	78	8	\N	75	2f67217c5c12004ce3ae002a26af0d1b	-73.9569018	40.7478908
\.


--
-- Name: package_packageid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.package_packageid_seq', 8, true);


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

COPY public.servicedetails (id, adminid, pspeed, ptype, psize, pweight, price) FROM stdin;
3	8	Regular	Electronic	Small	Light	75.00
4	9	Regular	Electronic	Small	Light	95.00
5	10	Regular	Electronic	Small	Light	77.00
14	7	Regular	Regular	Small	Light	10.00
15	7	Regular	Regular	Medium	Light	15.00
16	7	Regular	Regular	Large	Light	20.00
17	7	Express	Regular	Small	Light	15.00
18	7	Express	Regular	Medium	Light	20.00
19	7	Express	Regular	Large	Light	25.00
20	7	Regular	Regular	Medium	Medium	25.00
21	7	Regular	Regular	Large	Heavy	50.00
22	7	Express	Regular	Medium	Medium	50.00
23	7	Express	Regular	Large	Heavy	75.00
24	7	Regular	Electronics	Small	Light	30.00
25	7	Regular	Electronics	Medium	Medium	40.00
26	7	Regular	Electronics	Large	Heavy	60.00
27	7	Express	Electronics	Small	Light	35.00
28	7	Express	Electronics	Medium	Medium	45.00
29	7	Express	Electronics	Large	Heavy	75.00
30	7	Regular	Food	Small	Light	15.00
31	7	Regular	Food	Medium	Medium	25.00
32	7	Express	Food	Small	Light	35.00
33	7	Express	Food	Medium	Medium	45.00
34	7	Regular	Documents	Small	Light	5.00
35	7	Regular	Documents	Medium	Light	7.00
36	7	Regular	Documents	Medium	Medium	12.00
37	7	Regular	Documents	Large	Heavy	20.00
38	7	Express	Documents	Small	Light	10.00
39	7	Express	Documents	Medium	Medium	15.00
40	7	Regular	Others	Small	Light	15.00
41	7	Regular	Others	Medium	Medium	25.00
42	7	Regular	Others	Large	Heavy	35.00
43	7	Regular	Others	Large	Medium	25.00
44	7	Regular	Others	Small	Medium	25.00
45	7	Express	Others	Small	Light	25.00
46	7	Express	Others	Medium	Medium	35.00
47	7	Express	Others	Large	Medium	45.00
48	7	Express	Others	Large	Heavy	55.00
49	7	Express	Others	Small	Medium	30.00
\.


--
-- Name: servicedetails_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.servicedetails_id_seq', 49, true);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (userid, fname, lname, username, role, address, phone, email, state, city, zipcode, googlelink, lat, long) FROM stdin;
69	daxe	laf	daxelaf572	driver	2307 East 2nd Street	741258963	daxelaf572@mojzur.com	Indiana	Bloomington	47454	https://maps.google.com/?q=2307+E+2nd+St,+Bloomington,+IN+47401,+USA&ftid=0x886c66993c6b0b17:0xdab438e92530cd5a	39.161536	-86.505240
70	xo	logic	xologic282	driver	4569 South Rockport Road	456789123	xologic282@mojzur.com	Indiana	Bloomington	74748	https://maps.google.com/?q=4569+S+Rockport+Rd,+Bloomington,+IN+47403,+USA&ftid=0x886c67fab212aa33:0xac5e3a58068eaa31	39.114050	-86.570598
61	Viral	Praj	vkprajap	dadmin	521 North Washington Street	14578623	vkprajap@iu.edu	Indiana	Bloomington	54878	https://maps.google.com/?q=521+N+Washington+St,+Bloomington,+IN+47408,+USA&ftid=0x886c66db8324466d:0x3b8991617ea53741	39.171324	-86.532675
62	Luke	Martin	lmartin	dadmin	721 S College Mall Rd	582146397	lmartin@gmail.com	IN	Bloomington	47401	https://maps.google.com/?q=521+N+Washington+St,+Bloomington,+IN+47408,+USA&ftid=0x886c66db8324466d:0x3b8991617ea53741	39.171341	-86.532611
63	John	Oliver	joliver	dadmin	721 S College Mall Rd	582146397	jol@gmail.com	IN	Bloomington	47401	https://maps.google.com/?q=521+N+Washington+St,+Bloomington,+IN+47408,+USA&ftid=0x886c66db8324466d:0x3b8991617ea53741	39.171341	-86.532611
64	Neville	Potter	npoter	dadmin	721 S College Mall Rd	582146397	npoter@gmail.com	IN	Bloomington	47401	https://maps.google.com/?q=521+N+Washington+St,+Bloomington,+IN+47408,+USA&ftid=0x886c66db8324466d:0x3b8991617ea53741	39.171341	-86.532611
71	recim	john	recimo4040	dadmin	455 North College Avenue	8126508528	recimo4040@x1post.com	Indiana	Bloomington	789748	https://maps.google.com/?q=455+N+College+Ave,+Bloomington,+IN+47404,+USA&ftid=0x886c66dc02df13d5:0xbe6d4b1f843e60c	39.170151	-86.535223
65	Viral	Prajapati	viralprajapati07	dadmin	789 East Sherwood Hills Drive	8126508528	viralprajapati07@gmail.com	Indiana	Bloomington	78975	https://maps.google.com/?q=789+E+Sherwood+Hills+Dr,+Bloomington,+IN+47401,+USA&ftid=0x886c6643552c306b:0xabcb5aeecb78c622	39.133983	-86.524782
66	fijo	tal	fijota1940	dadmin	541 North Woodlawn Avenue	123456789	fijota1940@ezeca.com	Indiana	Bloomington	47401	https://maps.google.com/?q=541+N+Woodlawn+Ave,+Bloomington,+IN+47406,+USA&ftid=0x886c66c6c7b4edd5:0x10bedf59e9c9d74d	39.170927	-86.523723
67	limi	tax	limitax114	driver	694 South Landmark Avenue	78946133	limitax114@adeata.com	Indiana	Bloomington	52526	https://maps.google.com/?q=694+S+Landmark+Ave,+Bloomington,+IN+47403,+USA&ftid=0x886c6711138040d1:0x3766bedc9edf6521	39.170902	-86.524008
68	sigeh	llubed	sigeh58579	driver	1425 North Dunn Street	963258741	sigeh58579@llubed.com	Indiana	Bloomington	968574	https://maps.google.com/?q=1425+N+Dunn+St,+Bloomington,+IN+47408,+USA&ftid=0x886c66ce696aca37:0x8cf32b9df0547ad2	39.180093	-86.529273
78	James	Austin	xileko1321	user	4500 68th Street Southeast	147852369	xileko1321@tjuln.com	Michigan	Caledonia	565422	https://maps.google.com/?q=4500+68th+St+SE,+Caledonia,+MI+49316,+USA&ftid=0x88184b99848d5027:0x97f542f15ebd506a	42.841014	-85.553134
87	Ive	Giy	giyive8495	driver	East University Street Bloomington	8123631235	giyive8495@dkt1.com	United States	Perry Township	47404	https://maps.google.com/?q=E+University+St,+Bloomington,+IN+47401,+USA&ftid=0x886c66eb7bba297b:0xf69ee3eecc0021a8	39.1601935	-86.52204809999999
\.


--
-- Name: users_userid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_userid_seq', 79, true);


--
-- Name: SequelizeMeta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."SequelizeMeta"
    ADD CONSTRAINT "SequelizeMeta_pkey" PRIMARY KEY (name);


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
-- Name: fk_admin; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.package
    ADD CONSTRAINT fk_admin FOREIGN KEY (adminid) REFERENCES public.deliveryadmin(adminid) ON DELETE CASCADE;


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
-- Name: fk_package; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.package
    ADD CONSTRAINT fk_package FOREIGN KEY (userid) REFERENCES public.users(userid) ON DELETE CASCADE;


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

