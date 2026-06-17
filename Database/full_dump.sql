--
-- PostgreSQL database dump
--

\restrict XwSVEarexhQtFdjN1sKxkb0R5tG467UFm7cXpk5ho0Qg1yVMDYYU4ekPvPrjZcG

-- Dumped from database version 18.1
-- Dumped by pg_dump version 18.0

-- Started on 2026-05-17 15:12:43 MSK

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 874 (class 1247 OID 17352)
-- Name: address_type_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.address_type_enum AS ENUM (
    'HOME',
    'OFFICE',
    'EVENT_VENUE',
    'OTHER'
);


ALTER TYPE public.address_type_enum OWNER TO postgres;

--
-- TOC entry 898 (class 1247 OID 17446)
-- Name: changed_by_type_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.changed_by_type_enum AS ENUM (
    'CLIENT',
    'MANAGER',
    'SYSTEM',
    'KITCHEN',
    'COURIER',
    'PSP_WEBHOOK'
);


ALTER TYPE public.changed_by_type_enum OWNER TO postgres;

--
-- TOC entry 871 (class 1247 OID 17347)
-- Name: client_type_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.client_type_enum AS ENUM (
    'INDIVIDUAL',
    'CORPORATE'
);


ALTER TYPE public.client_type_enum OWNER TO postgres;

--
-- TOC entry 880 (class 1247 OID 17368)
-- Name: customer_type_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.customer_type_enum AS ENUM (
    'INDIVIDUAL',
    'CORPORATE',
    'ALL'
);


ALTER TYPE public.customer_type_enum OWNER TO postgres;

--
-- TOC entry 877 (class 1247 OID 17362)
-- Name: discount_type_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.discount_type_enum AS ENUM (
    'PERCENT',
    'FIXED_AMOUNT'
);


ALTER TYPE public.discount_type_enum OWNER TO postgres;

--
-- TOC entry 889 (class 1247 OID 17412)
-- Name: dish_category_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.dish_category_enum AS ENUM (
    'SALAD',
    'MAIN',
    'DESSERT',
    'DRINK',
    'SNACK',
    'OTHER'
);


ALTER TYPE public.dish_category_enum OWNER TO postgres;

--
-- TOC entry 886 (class 1247 OID 17388)
-- Name: order_status_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.order_status_enum AS ENUM (
    'CREATED',
    'AWAITING_PAYMENT',
    'PAID',
    'PAYMENT_FAILED',
    'IN_PREPARATION',
    'PREPARATION_FAILED',
    'READY',
    'IN_DELIVERY',
    'DELIVERY_FAILED',
    'DELIVERED',
    'CANCELLED'
);


ALTER TYPE public.order_status_enum OWNER TO postgres;

--
-- TOC entry 892 (class 1247 OID 17426)
-- Name: payment_method_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.payment_method_enum AS ENUM (
    'CARD',
    'SBP',
    'CASH'
);


ALTER TYPE public.payment_method_enum OWNER TO postgres;

--
-- TOC entry 895 (class 1247 OID 17434)
-- Name: payment_status_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.payment_status_enum AS ENUM (
    'PENDING',
    'SUCCEEDED',
    'FAILED',
    'CANCELLED',
    'EXPIRED'
);


ALTER TYPE public.payment_status_enum OWNER TO postgres;

--
-- TOC entry 883 (class 1247 OID 17376)
-- Name: season_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.season_enum AS ENUM (
    'SPRING',
    'SUMMER',
    'AUTUMN',
    'WINTER',
    'ALL'
);


ALTER TYPE public.season_enum OWNER TO postgres;

--
-- TOC entry 901 (class 1247 OID 17460)
-- Name: status_change_source_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.status_change_source_enum AS ENUM (
    'COMMAND',
    'WEBHOOK',
    'TTL',
    'MANUAL'
);


ALTER TYPE public.status_change_source_enum OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 222 (class 1259 OID 17486)
-- Name: client_address; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_address (
    client_address_id integer NOT NULL,
    client_id integer NOT NULL,
    address_type public.address_type_enum,
    street character varying(255) NOT NULL,
    city character varying(100) NOT NULL,
    postal_code character varying(20),
    is_default boolean DEFAULT false,
    notes text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.client_address OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 17485)
-- Name: client_address_client_address_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.client_address_client_address_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.client_address_client_address_id_seq OWNER TO postgres;

--
-- TOC entry 3986 (class 0 OID 0)
-- Dependencies: 221
-- Name: client_address_client_address_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.client_address_client_address_id_seq OWNED BY public.client_address.client_address_id;


--
-- TOC entry 220 (class 1259 OID 17470)
-- Name: clients; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clients (
    client_id integer NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    middle_name character varying(100),
    phone_number character varying(20),
    email character varying(255),
    type_client public.client_type_enum NOT NULL,
    company_name character varying(255),
    tax_id character varying(20),
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.clients OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 17469)
-- Name: clients_client_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.clients_client_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.clients_client_id_seq OWNER TO postgres;

--
-- TOC entry 3987 (class 0 OID 0)
-- Dependencies: 219
-- Name: clients_client_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.clients_client_id_seq OWNED BY public.clients.client_id;


--
-- TOC entry 230 (class 1259 OID 17564)
-- Name: dishes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dishes (
    dish_id integer NOT NULL,
    dish_category public.dish_category_enum NOT NULL,
    dish_name character varying(50) NOT NULL,
    description text,
    portion_weight numeric(10,2),
    portion_pers_order smallint,
    cooking_time smallint,
    price numeric(10,2) NOT NULL,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.dishes OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 17563)
-- Name: dishes_dish_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dishes_dish_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dishes_dish_id_seq OWNER TO postgres;

--
-- TOC entry 3988 (class 0 OID 0)
-- Dependencies: 229
-- Name: dishes_dish_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dishes_dish_id_seq OWNED BY public.dishes.dish_id;


--
-- TOC entry 234 (class 1259 OID 17602)
-- Name: events; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.events (
    event_id integer NOT NULL,
    order_id integer NOT NULL,
    event_name character varying(255) NOT NULL,
    event_datetime timestamp without time zone NOT NULL,
    guest_count integer NOT NULL,
    venue_address character varying(500) NOT NULL,
    venue_city character varying(100),
    contact_person character varying(255),
    contact_phone character varying(20),
    notes text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.events OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 17601)
-- Name: events_event_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.events_event_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.events_event_id_seq OWNER TO postgres;

--
-- TOC entry 3989 (class 0 OID 0)
-- Dependencies: 233
-- Name: events_event_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.events_event_id_seq OWNED BY public.events.event_id;


--
-- TOC entry 226 (class 1259 OID 17518)
-- Name: order_discounts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_discounts (
    order_discount_id integer NOT NULL,
    order_id integer NOT NULL,
    discount_rule_id integer,
    discount_name character varying(255),
    discount_amount numeric(10,2),
    is_selected boolean DEFAULT true,
    applied_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.order_discounts OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 17517)
-- Name: order_discounts_order_discount_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_discounts_order_discount_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.order_discounts_order_discount_id_seq OWNER TO postgres;

--
-- TOC entry 3990 (class 0 OID 0)
-- Dependencies: 225
-- Name: order_discounts_order_discount_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_discounts_order_discount_id_seq OWNED BY public.order_discounts.order_discount_id;


--
-- TOC entry 232 (class 1259 OID 17579)
-- Name: order_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_items (
    order_item_id integer NOT NULL,
    dish_id integer NOT NULL,
    order_id integer NOT NULL,
    quantity integer NOT NULL,
    unit_price numeric(10,2) NOT NULL,
    line_amount numeric(10,2) NOT NULL,
    dish_name_snapshot character varying(50) NOT NULL,
    dish_category_snapshot public.dish_category_enum NOT NULL,
    portion_weight_snapshot numeric(10,2)
);


ALTER TABLE public.order_items OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 17578)
-- Name: order_items_order_item_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_items_order_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.order_items_order_item_id_seq OWNER TO postgres;

--
-- TOC entry 3991 (class 0 OID 0)
-- Dependencies: 231
-- Name: order_items_order_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_items_order_item_id_seq OWNED BY public.order_items.order_item_id;


--
-- TOC entry 238 (class 1259 OID 17645)
-- Name: order_status_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_status_history (
    history_id integer NOT NULL,
    order_id integer NOT NULL,
    from_status public.order_status_enum,
    to_status public.order_status_enum NOT NULL,
    changed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    changed_by_type public.changed_by_type_enum NOT NULL,
    changed_by_id integer,
    reason_code character varying(50),
    comment character varying(500),
    source public.status_change_source_enum NOT NULL
);


ALTER TABLE public.order_status_history OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 17644)
-- Name: order_status_history_history_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_status_history_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.order_status_history_history_id_seq OWNER TO postgres;

--
-- TOC entry 3992 (class 0 OID 0)
-- Dependencies: 237
-- Name: order_status_history_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_status_history_history_id_seq OWNED BY public.order_status_history.history_id;


--
-- TOC entry 228 (class 1259 OID 17533)
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    order_id integer NOT NULL,
    order_discount_id integer,
    client_id integer NOT NULL,
    order_number character varying(20) NOT NULL,
    order_status public.order_status_enum NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    confirmed_at timestamp without time zone,
    ready_at timestamp without time zone,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    applied_discount_code character varying(50),
    applied_discount_type public.discount_type_enum,
    applied_discount_value numeric(10,2),
    subtotal_amount numeric(10,2) NOT NULL,
    discount_total numeric(10,2) DEFAULT 0,
    tax_amount numeric(10,2) DEFAULT 0,
    total_amount numeric(10,2) NOT NULL,
    notes text
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 17532)
-- Name: orders_order_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_order_id_seq OWNER TO postgres;

--
-- TOC entry 3993 (class 0 OID 0)
-- Dependencies: 227
-- Name: orders_order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_order_id_seq OWNED BY public.orders.order_id;


--
-- TOC entry 236 (class 1259 OID 17623)
-- Name: payments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payments (
    payment_id integer NOT NULL,
    order_id integer NOT NULL,
    payment_amount numeric(10,2) NOT NULL,
    payment_method public.payment_method_enum NOT NULL,
    payment_status public.payment_status_enum NOT NULL,
    transaction_id character varying(100),
    paid_at timestamp without time zone,
    notes text,
    provider_payment_id character varying(100),
    provider_event_id character varying(100),
    currency character varying(3) NOT NULL,
    payment_url text,
    idempotency_key uuid,
    webhook_received_at timestamp without time zone,
    expires_at timestamp without time zone,
    signature_valid boolean
);


ALTER TABLE public.payments OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 17622)
-- Name: payments_payment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payments_payment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payments_payment_id_seq OWNER TO postgres;

--
-- TOC entry 3994 (class 0 OID 0)
-- Dependencies: 235
-- Name: payments_payment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payments_payment_id_seq OWNED BY public.payments.payment_id;


--
-- TOC entry 224 (class 1259 OID 17506)
-- Name: rule_discounts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rule_discounts (
    discount_rule_id integer NOT NULL,
    name character varying(255) NOT NULL,
    discount_type public.discount_type_enum NOT NULL,
    discount_value numeric(10,2) NOT NULL,
    customer_type public.customer_type_enum,
    min_order_amount numeric(10,2),
    season public.season_enum,
    valid_from date,
    valid_to date,
    is_active boolean DEFAULT true,
    priority smallint
);


ALTER TABLE public.rule_discounts OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 17505)
-- Name: rule_discounts_discount_rule_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rule_discounts_discount_rule_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.rule_discounts_discount_rule_id_seq OWNER TO postgres;

--
-- TOC entry 3995 (class 0 OID 0)
-- Dependencies: 223
-- Name: rule_discounts_discount_rule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rule_discounts_discount_rule_id_seq OWNED BY public.rule_discounts.discount_rule_id;


--
-- TOC entry 3752 (class 2604 OID 17489)
-- Name: client_address client_address_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_address ALTER COLUMN client_address_id SET DEFAULT nextval('public.client_address_client_address_id_seq'::regclass);


--
-- TOC entry 3748 (class 2604 OID 17473)
-- Name: clients client_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clients ALTER COLUMN client_id SET DEFAULT nextval('public.clients_client_id_seq'::regclass);


--
-- TOC entry 3765 (class 2604 OID 17567)
-- Name: dishes dish_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dishes ALTER COLUMN dish_id SET DEFAULT nextval('public.dishes_dish_id_seq'::regclass);


--
-- TOC entry 3769 (class 2604 OID 17605)
-- Name: events event_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.events ALTER COLUMN event_id SET DEFAULT nextval('public.events_event_id_seq'::regclass);


--
-- TOC entry 3757 (class 2604 OID 17521)
-- Name: order_discounts order_discount_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_discounts ALTER COLUMN order_discount_id SET DEFAULT nextval('public.order_discounts_order_discount_id_seq'::regclass);


--
-- TOC entry 3768 (class 2604 OID 17582)
-- Name: order_items order_item_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items ALTER COLUMN order_item_id SET DEFAULT nextval('public.order_items_order_item_id_seq'::regclass);


--
-- TOC entry 3772 (class 2604 OID 17648)
-- Name: order_status_history history_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_status_history ALTER COLUMN history_id SET DEFAULT nextval('public.order_status_history_history_id_seq'::regclass);


--
-- TOC entry 3760 (class 2604 OID 17536)
-- Name: orders order_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders ALTER COLUMN order_id SET DEFAULT nextval('public.orders_order_id_seq'::regclass);


--
-- TOC entry 3771 (class 2604 OID 17626)
-- Name: payments payment_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments ALTER COLUMN payment_id SET DEFAULT nextval('public.payments_payment_id_seq'::regclass);


--
-- TOC entry 3755 (class 2604 OID 17509)
-- Name: rule_discounts discount_rule_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rule_discounts ALTER COLUMN discount_rule_id SET DEFAULT nextval('public.rule_discounts_discount_rule_id_seq'::regclass);


--
-- TOC entry 3964 (class 0 OID 17486)
-- Dependencies: 222
-- Data for Name: client_address; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_address (client_address_id, client_id, address_type, street, city, postal_code, is_default, notes, created_at) FROM stdin;
1	1	HOME	Lenina 10	Moscow	\N	t	\N	2026-04-28 19:00:50.963483
2	2	OFFICE	Tverskaya 15	Moscow	\N	t	\N	2026-04-28 19:00:50.963483
\.


--
-- TOC entry 3962 (class 0 OID 17470)
-- Dependencies: 220
-- Data for Name: clients; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.clients (client_id, first_name, last_name, middle_name, phone_number, email, type_client, company_name, tax_id, is_active, created_at, updated_at) FROM stdin;
1	Ivan	Petrov	\N	+79990000001	ivan@mail.com	INDIVIDUAL	\N	\N	t	2026-04-28 19:00:36.780875	2026-04-28 19:00:36.780875
2	Anna	Smirnova	\N	+79990000002	anna@corp.com	CORPORATE	\N	\N	t	2026-04-28 19:00:36.780875	2026-04-28 19:00:36.780875
\.


--
-- TOC entry 3972 (class 0 OID 17564)
-- Dependencies: 230
-- Data for Name: dishes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dishes (dish_id, dish_category, dish_name, description, portion_weight, portion_pers_order, cooking_time, price, is_active, created_at) FROM stdin;
1	SALAD	Caesar Salad	\N	\N	\N	\N	500.00	t	2026-04-28 19:01:25.148864
2	MAIN	Chicken Steak	\N	\N	\N	\N	900.00	t	2026-04-28 19:01:25.148864
3	DESSERT	Cheesecake	\N	\N	\N	\N	400.00	t	2026-04-28 19:01:25.148864
\.


--
-- TOC entry 3976 (class 0 OID 17602)
-- Dependencies: 234
-- Data for Name: events; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.events (event_id, order_id, event_name, event_datetime, guest_count, venue_address, venue_city, contact_person, contact_phone, notes, created_at) FROM stdin;
1	1	Birthday	2026-04-28 19:01:45.447361	10	Lenina 10	\N	\N	\N	\N	2026-04-28 19:01:45.447361
2	2	Corporate Lunch	2026-04-28 19:01:45.447361	25	Office	\N	\N	\N	\N	2026-04-28 19:01:45.447361
\.


--
-- TOC entry 3968 (class 0 OID 17518)
-- Dependencies: 226
-- Data for Name: order_discounts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_discounts (order_discount_id, order_id, discount_rule_id, discount_name, discount_amount, is_selected, applied_at) FROM stdin;
1	2	1	Corporate 10%	1500.00	t	2026-04-28 19:01:08.178848
\.


--
-- TOC entry 3974 (class 0 OID 17579)
-- Dependencies: 232
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_items (order_item_id, dish_id, order_id, quantity, unit_price, line_amount, dish_name_snapshot, dish_category_snapshot, portion_weight_snapshot) FROM stdin;
1	1	1	5	500.00	2500.00	Caesar Salad	SALAD	\N
2	2	1	3	900.00	2700.00	Chicken Steak	MAIN	\N
3	3	2	10	400.00	4000.00	Cheesecake	DESSERT	\N
\.


--
-- TOC entry 3980 (class 0 OID 17645)
-- Dependencies: 238
-- Data for Name: order_status_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_status_history (history_id, order_id, from_status, to_status, changed_at, changed_by_type, changed_by_id, reason_code, comment, source) FROM stdin;
1	1	\N	CREATED	2026-04-28 19:01:59.857322	CLIENT	\N	\N	\N	COMMAND
2	1	CREATED	AWAITING_PAYMENT	2026-04-28 19:01:59.857322	CLIENT	\N	\N	\N	COMMAND
3	2	\N	CREATED	2026-04-28 19:01:59.857322	CLIENT	\N	\N	\N	COMMAND
4	2	CREATED	AWAITING_PAYMENT	2026-04-28 19:01:59.857322	CLIENT	\N	\N	\N	COMMAND
5	2	AWAITING_PAYMENT	PAID	2026-04-28 19:01:59.857322	PSP_WEBHOOK	\N	\N	\N	WEBHOOK
\.


--
-- TOC entry 3970 (class 0 OID 17533)
-- Dependencies: 228
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (order_id, order_discount_id, client_id, order_number, order_status, created_at, confirmed_at, ready_at, updated_at, applied_discount_code, applied_discount_type, applied_discount_value, subtotal_amount, discount_total, tax_amount, total_amount, notes) FROM stdin;
1	\N	1	ORD-001	AWAITING_PAYMENT	2026-04-28 19:01:30.714581	\N	\N	2026-04-28 19:01:30.714581	\N	\N	\N	5000.00	0.00	0.00	5000.00	\N
2	1	2	ORD-002	PAID	2026-04-28 19:01:30.714581	\N	\N	2026-04-28 19:01:30.714581	Corporate 10%	PERCENT	10.00	15000.00	1500.00	0.00	13500.00	\N
\.


--
-- TOC entry 3978 (class 0 OID 17623)
-- Dependencies: 236
-- Data for Name: payments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payments (payment_id, order_id, payment_amount, payment_method, payment_status, transaction_id, paid_at, notes, provider_payment_id, provider_event_id, currency, payment_url, idempotency_key, webhook_received_at, expires_at, signature_valid) FROM stdin;
1	1	5000.00	CARD	PENDING	\N	\N	\N	\N	\N	RUB	\N	\N	\N	\N	\N
2	2	13500.00	CARD	SUCCEEDED	\N	\N	\N	\N	\N	RUB	\N	\N	\N	\N	\N
\.


--
-- TOC entry 3966 (class 0 OID 17506)
-- Dependencies: 224
-- Data for Name: rule_discounts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rule_discounts (discount_rule_id, name, discount_type, discount_value, customer_type, min_order_amount, season, valid_from, valid_to, is_active, priority) FROM stdin;
1	Corporate 10%	PERCENT	10.00	CORPORATE	\N	\N	\N	\N	t	\N
\.


--
-- TOC entry 3996 (class 0 OID 0)
-- Dependencies: 221
-- Name: client_address_client_address_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.client_address_client_address_id_seq', 2, true);


--
-- TOC entry 3997 (class 0 OID 0)
-- Dependencies: 219
-- Name: clients_client_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.clients_client_id_seq', 2, true);


--
-- TOC entry 3998 (class 0 OID 0)
-- Dependencies: 229
-- Name: dishes_dish_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dishes_dish_id_seq', 3, true);


--
-- TOC entry 3999 (class 0 OID 0)
-- Dependencies: 233
-- Name: events_event_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.events_event_id_seq', 2, true);


--
-- TOC entry 4000 (class 0 OID 0)
-- Dependencies: 225
-- Name: order_discounts_order_discount_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_discounts_order_discount_id_seq', 1, true);


--
-- TOC entry 4001 (class 0 OID 0)
-- Dependencies: 231
-- Name: order_items_order_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_items_order_item_id_seq', 3, true);


--
-- TOC entry 4002 (class 0 OID 0)
-- Dependencies: 237
-- Name: order_status_history_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_status_history_history_id_seq', 5, true);


--
-- TOC entry 4003 (class 0 OID 0)
-- Dependencies: 227
-- Name: orders_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_order_id_seq', 2, true);


--
-- TOC entry 4004 (class 0 OID 0)
-- Dependencies: 235
-- Name: payments_payment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payments_payment_id_seq', 2, true);


--
-- TOC entry 4005 (class 0 OID 0)
-- Dependencies: 223
-- Name: rule_discounts_discount_rule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rule_discounts_discount_rule_id_seq', 1, true);


--
-- TOC entry 3777 (class 2606 OID 17499)
-- Name: client_address client_address_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_address
    ADD CONSTRAINT client_address_pkey PRIMARY KEY (client_address_id);


--
-- TOC entry 3775 (class 2606 OID 17484)
-- Name: clients clients_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (client_id);


--
-- TOC entry 3789 (class 2606 OID 17577)
-- Name: dishes dishes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dishes
    ADD CONSTRAINT dishes_pkey PRIMARY KEY (dish_id);


--
-- TOC entry 3794 (class 2606 OID 17616)
-- Name: events events_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_pkey PRIMARY KEY (event_id);


--
-- TOC entry 3781 (class 2606 OID 17526)
-- Name: order_discounts order_discounts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_discounts
    ADD CONSTRAINT order_discounts_pkey PRIMARY KEY (order_discount_id);


--
-- TOC entry 3792 (class 2606 OID 17590)
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (order_item_id);


--
-- TOC entry 3804 (class 2606 OID 17658)
-- Name: order_status_history order_status_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_status_history
    ADD CONSTRAINT order_status_history_pkey PRIMARY KEY (history_id);


--
-- TOC entry 3785 (class 2606 OID 17552)
-- Name: orders orders_order_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_order_number_key UNIQUE (order_number);


--
-- TOC entry 3787 (class 2606 OID 17550)
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_id);


--
-- TOC entry 3798 (class 2606 OID 17638)
-- Name: payments payments_idempotency_key_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_idempotency_key_key UNIQUE (idempotency_key);


--
-- TOC entry 3800 (class 2606 OID 17636)
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (payment_id);


--
-- TOC entry 3779 (class 2606 OID 17516)
-- Name: rule_discounts rule_discounts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rule_discounts
    ADD CONSTRAINT rule_discounts_pkey PRIMARY KEY (discount_rule_id);


--
-- TOC entry 3795 (class 1259 OID 17668)
-- Name: idx_events_order_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_events_order_id ON public.events USING btree (order_id);


--
-- TOC entry 3790 (class 1259 OID 17666)
-- Name: idx_order_items_order_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_order_items_order_id ON public.order_items USING btree (order_id);


--
-- Name: idx_order_discounts_order_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_order_discounts_order_id ON public.order_discounts USING btree (order_id);


--
-- TOC entry 3801 (class 1259 OID 17670)
-- Name: idx_order_status_history_changed_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_order_status_history_changed_at ON public.order_status_history USING btree (order_id, changed_at DESC);


--
-- TOC entry 3802 (class 1259 OID 17669)
-- Name: idx_order_status_history_order_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_order_status_history_order_id ON public.order_status_history USING btree (order_id);


--
-- TOC entry 3782 (class 1259 OID 17664)
-- Name: idx_orders_client_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_orders_client_id ON public.orders USING btree (client_id);


--
-- TOC entry 3783 (class 1259 OID 17665)
-- Name: idx_orders_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_orders_status ON public.orders USING btree (order_status);


--
-- TOC entry 3796 (class 1259 OID 17667)
-- Name: idx_payments_order_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_payments_order_id ON public.payments USING btree (order_id);


--
-- TOC entry 3805 (class 2606 OID 17500)
-- Name: client_address client_address_client_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_address
    ADD CONSTRAINT client_address_client_id_fkey FOREIGN KEY (client_id) REFERENCES public.clients(client_id);


--
-- TOC entry 3811 (class 2606 OID 17617)
-- Name: events events_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(order_id);


--
-- TOC entry 3806 (class 2606 OID 17527)
-- Name: order_discounts order_discounts_discount_rule_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_discounts
    ADD CONSTRAINT order_discounts_discount_rule_id_fkey FOREIGN KEY (discount_rule_id) REFERENCES public.rule_discounts(discount_rule_id);


ALTER TABLE ONLY public.order_discounts
    ADD CONSTRAINT order_discounts_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(order_id);


--
-- TOC entry 3809 (class 2606 OID 17591)
-- Name: order_items order_items_dish_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_dish_id_fkey FOREIGN KEY (dish_id) REFERENCES public.dishes(dish_id);


--
-- TOC entry 3810 (class 2606 OID 17596)
-- Name: order_items order_items_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(order_id);


--
-- TOC entry 3813 (class 2606 OID 17659)
-- Name: order_status_history order_status_history_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_status_history
    ADD CONSTRAINT order_status_history_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(order_id);


--
-- TOC entry 3807 (class 2606 OID 17558)
-- Name: orders orders_client_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_client_id_fkey FOREIGN KEY (client_id) REFERENCES public.clients(client_id);


--
-- TOC entry 3808 (class 2606 OID 17553)
-- Name: orders orders_order_discount_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_order_discount_id_fkey FOREIGN KEY (order_discount_id) REFERENCES public.order_discounts(order_discount_id);


--
-- TOC entry 3812 (class 2606 OID 17639)
-- Name: payments payments_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(order_id);


-- Completed on 2026-05-17 15:12:44 MSK

--
-- PostgreSQL database dump complete
--

\unrestrict XwSVEarexhQtFdjN1sKxkb0R5tG467UFm7cXpk5ho0Qg1yVMDYYU4ekPvPrjZcG

