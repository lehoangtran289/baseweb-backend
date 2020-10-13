--
-- PostgreSQL database dump
--

-- Dumped from database version 12.2
-- Dumped by pg_dump version 12.2

-- Started on 2020-10-13 22:31:52

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
-- TOC entry 6 (class 2615 OID 28394)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 224 (class 1255 OID 28396)
-- Name: set_last_updated_stamp(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.set_last_updated_stamp() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW.last_updated_stamp := now();
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.set_last_updated_stamp() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 212 (class 1259 OID 28542)
-- Name: application; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.application (
    application_id character varying(255) NOT NULL,
    application_type_id character varying(255) NOT NULL,
    module_id character varying(255),
    permission_id character varying(255),
    description text,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.application OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 28533)
-- Name: application_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.application_type (
    application_type_id character varying(60) NOT NULL,
    description text,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.application_type OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 28566)
-- Name: author; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.author (
    author_id integer NOT NULL,
    author_name character varying(200)
);


ALTER TABLE public.author OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 28571)
-- Name: book; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.book (
    book_id integer NOT NULL,
    title character varying(200)
);


ALTER TABLE public.book OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 28576)
-- Name: book_author; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.book_author (
    book_id integer,
    author_id integer
);


ALTER TABLE public.book_author OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 28457)
-- Name: party; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.party (
    party_id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    party_type_id character varying(60),
    external_id character varying(60),
    description text,
    status_id character varying(60),
    created_date timestamp without time zone,
    created_by_user_login character varying(255),
    last_modified_date timestamp without time zone,
    last_modified_by_user_login character varying(255),
    is_unread boolean,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    party_code character varying(255)
);


ALTER TABLE public.party OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 28443)
-- Name: party_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.party_type (
    party_type_id character varying(60) NOT NULL,
    parent_type_id character varying(60),
    has_table boolean,
    description text,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.party_type OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 28477)
-- Name: person; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.person (
    party_id uuid NOT NULL,
    first_name character varying(100),
    middle_name character varying(100),
    last_name character varying(100),
    gender character(1),
    birth_date date,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.person OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 28488)
-- Name: security_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.security_group (
    group_id character varying(60) NOT NULL,
    description text,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.security_group OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 28506)
-- Name: security_group_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.security_group_permission (
    group_id character varying(60) NOT NULL,
    permission_id character varying(100) NOT NULL,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.security_group_permission OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 28497)
-- Name: security_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.security_permission (
    permission_id character varying(100) NOT NULL,
    description text,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.security_permission OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 28422)
-- Name: status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.status (
    status_id character varying(60) NOT NULL,
    status_type_id character varying(60),
    status_code character varying(60),
    sequence_id character varying(60),
    description text,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.status OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 28652)
-- Name: status_item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.status_item (
    status_id character varying(60) NOT NULL,
    status_type_id character varying(60),
    status_code character varying(60),
    description text,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.status_item OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 28408)
-- Name: status_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.status_type (
    status_type_id character varying(60) NOT NULL,
    parent_type_id character varying(60),
    description text,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.status_type OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 28700)
-- Name: user_login; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_login (
    user_login_id character varying(255) NOT NULL,
    current_password character varying(60),
    otp_secret character varying(60),
    client_token character varying(512),
    password_hint text,
    is_system boolean,
    enabled boolean,
    has_logged_out boolean,
    require_password_change boolean,
    disabled_date_time timestamp without time zone,
    successive_failed_logins integer,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    otp_resend_number integer DEFAULT 0,
    party_id uuid,
    email character varying(255)
);


ALTER TABLE public.user_login OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 28738)
-- Name: user_login_security_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_login_security_group (
    user_login_id character varying(255) NOT NULL,
    group_id character varying(60) NOT NULL,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.user_login_security_group OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 28677)
-- Name: user_register; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_register (
    user_login_id character varying(60) NOT NULL,
    password character varying(100),
    email character varying(100),
    first_name character varying(100),
    middle_name character varying(100),
    last_name character varying(100),
    status_id character varying(60),
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.user_register OWNER TO postgres;

--
-- TOC entry 2987 (class 0 OID 28542)
-- Dependencies: 212
-- Data for Name: application; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.application VALUES ('MENU_USER', 'MENU', NULL, NULL, 'Menu user management', '2019-12-26 08:00:39.953', '2019-12-26 08:00:39.953');
INSERT INTO public.application VALUES ('MENU_USER_CREATE', 'MENU', 'MENU_USER', 'USER_CREATE', 'Menu user create', '2019-12-26 08:00:39.953', '2019-12-26 08:00:39.953');
INSERT INTO public.application VALUES ('MENU_USER_LIST', 'MENU', 'MENU_USER', 'USER_VIEW', 'Menu user list', '2019-12-26 08:00:39.953', '2019-12-26 08:00:39.953');
INSERT INTO public.application VALUES ('MENU_ORDER', 'MENU', NULL, NULL, 'Menu order management', '2019-12-26 08:00:39.953', '2019-12-26 08:00:39.953');
INSERT INTO public.application VALUES ('MENU_ORDER_LIST', 'MENU', 'MENU_ORDER', 'ORDER_VIEW', 'Menu order list', '2019-12-26 08:00:39.953', '2019-12-26 08:00:39.953');
INSERT INTO public.application VALUES ('MENU_ORDER_CREATE', 'MENU', 'MENU_ORDER', 'ORDER_CREATE', 'Menu order create', '2019-12-26 08:00:39.953', '2019-12-26 08:00:39.953');
INSERT INTO public.application VALUES ('MENU_INVOICE', 'MENU', NULL, NULL, 'Menu invoice management', '2019-12-26 08:00:39.953', '2019-12-26 08:00:39.953');
INSERT INTO public.application VALUES ('MENU_INVOICE_CREATE', 'MENU', 'MENU_INVOICE', 'INVOICE_CREATE', 'Menu invoice create', '2019-12-26 08:00:39.953', '2019-12-26 08:00:39.953');
INSERT INTO public.application VALUES ('MENU_INVOICE_LIST', 'MENU', 'MENU_INVOICE', 'INVOICE_VIEW', 'Menu invoice list', '2019-12-26 08:00:39.953', '2019-12-26 08:00:39.953');
INSERT INTO public.application VALUES ('MENU_TMS', 'MENU', NULL, NULL, 'Menu TMS', '2020-03-01 18:46:31.727', '2020-03-01 18:40:20.478');
INSERT INTO public.application VALUES ('MENU_SALES_ROUTE', 'MENU', NULL, NULL, 'Menu Sales Route', NULL, '2020-03-01 18:54:50.488');
INSERT INTO public.application VALUES ('MENU_SALES_ROUTE_PLAN_CREATE', 'MENU', 'MENU_SALES_ROUTE', 'SALES_ROUTE_PLAN_CREATE', 'Menu Sales Route', NULL, '2020-03-01 18:54:50.488');
INSERT INTO public.application VALUES ('MENU_GEO_ADDRESS', 'MENU', NULL, 'GEO_ADDRESS_ADMIN', 'Menu Geo and Address', '2020-03-23 11:14:44.243', '2020-03-01 18:54:50.488');
INSERT INTO public.application VALUES ('MENU_SALES_REPORT', 'MENU', NULL, 'SALES_ADMIN_VIEW_REPORT', 'Menu sales report', NULL, '2020-03-01 18:54:50.488');
INSERT INTO public.application VALUES ('MENU_SALES_REPORT_CHART', 'MENU', 'MENU_SALES_REPORT', 'SALES_ADMIN_VIEW_REPORT', 'Chart report', NULL, '2020-03-01 18:54:50.488');
INSERT INTO public.application VALUES ('MENU_SALES_REPORT_TABLE', 'MENU', 'MENU_SALES_REPORT', 'SALES_ADMIN_VIEW_REPORT', 'Table report', NULL, '2020-03-01 18:54:50.488');
INSERT INTO public.application VALUES ('MENU_SALES_REPORT_CUSTOMER', 'MENU', 'MENU_SALES_REPORT', 'SALES_ADMIN_VIEW_REPORT', 'Customer based Revenue', NULL, '2020-03-01 18:54:50.488');
INSERT INTO public.application VALUES ('MENU_SALES_REPORT_SALESMAN', 'MENU', 'MENU_SALES_REPORT', 'SALES_ADMIN_VIEW_REPORT', 'Salesman based Revenue', NULL, '2020-03-01 18:54:50.488');
INSERT INTO public.application VALUES ('MENU_SALES_REPORT_DISTRIBUTOR', 'MENU', 'MENU_SALES_REPORT', 'SALES_ADMIN_VIEW_REPORT', 'Distributor based Revenue', NULL, '2020-03-01 18:54:50.488');
INSERT INTO public.application VALUES ('MENU_SALES_REPORT_PRODUCT', 'MENU', 'MENU_SALES_REPORT', 'SALES_ADMIN_VIEW_REPORT', 'Product based Revenue', NULL, '2020-03-01 18:54:50.488');
INSERT INTO public.application VALUES ('MENU_FACILITY_REPORT', 'MENU', NULL, 'FACILITY_ADMIN_VIEW_REPORT', 'Menu sales report', NULL, '2020-03-01 18:54:50.488');
INSERT INTO public.application VALUES ('MENU_FACILITY_REPORT_INVENTORY_ITEM_ON_HAND', 'MENU', 'MENU_FACILITY_REPORT', 'FACILITY_ADMIN_VIEW_REPORT', 'Ton kho', NULL, '2020-03-01 18:54:50.488');
INSERT INTO public.application VALUES ('MENU_SALES_REPORT_IMPORT', 'MENU', 'MENU_FACILITY_REPORT', 'FACILITY_ADMIN_VIEW_REPORT', 'Nhap kho', NULL, '2020-03-01 18:54:50.488');
INSERT INTO public.application VALUES ('MENU_SALES_REPORT_EXPORT', 'MENU', 'MENU_FACILITY_REPORT', 'FACILITY_ADMIN_VIEW_REPORT', 'Xuat kho', NULL, '2020-03-01 18:54:50.488');
INSERT INTO public.application VALUES ('MENU_TMS_REPORT', 'MENU', NULL, 'TMS_ADMIN_VIEW_REPORT', 'Menu sales report', NULL, '2020-03-01 18:54:50.488');
INSERT INTO public.application VALUES ('MENU_TMS_REPORT_DRIVER', 'MENU', 'MENU_TMS_REPORT', 'TMS_ADMIN_VIEW_REPORT', 'Driver based report', NULL, '2020-03-01 18:54:50.488');
INSERT INTO public.application VALUES ('MENU_TMS_REPORT_CUSTOMER', 'MENU', 'MENU_TMS_REPORT', 'TMS_ADMIN_VIEW_REPORT', 'Customer based report', NULL, '2020-03-01 18:54:50.488');
INSERT INTO public.application VALUES ('MENU_TMS_REPORT_FACILITY', 'MENU', 'MENU_TMS_REPORT', 'TMS_ADMIN_VIEW_REPORT', 'Facility based', NULL, '2020-03-01 18:54:50.488');
INSERT INTO public.application VALUES ('MENU_TMS_CONTAINER', 'MENU', NULL, 'TMS_CONTAINER_ADMIN', 'Menu sales report', NULL, '2020-03-01 18:54:50.488');
INSERT INTO public.application VALUES ('MENU_DEPARTMENT', 'MENU', NULL, NULL, 'Menu user management', NULL, '2020-05-09 22:28:24.558581');
INSERT INTO public.application VALUES ('MENU_DEPARTMENT_CREATE', 'MENU', 'MENU_DEPARTMENT', 'PERM_DEPARTMENT_CREATE', 'Menu department create', NULL, '2020-05-09 22:28:24.561581');
INSERT INTO public.application VALUES ('MENU_DEPARTMENT_LIST', 'MENU', 'MENU_DEPARTMENT', 'PERM_DEPARTMENT_VIEW', 'Menu department list', NULL, '2020-05-09 22:28:24.563581');
INSERT INTO public.application VALUES ('MENU_TMS_CREATE_DELIVERY_PLAN', 'MENU', 'MENU_TMS', 'DELIVERY_PLAN_CREATE', 'Menu Create Delivery Plan', NULL, '2020-03-01 18:41:10.706');
INSERT INTO public.application VALUES ('MENU_CUSTOMER', 'MENU', NULL, NULL, 'Menu customer management', NULL, '2020-05-09 22:28:56.563412');
INSERT INTO public.application VALUES ('MENU_CUSTOMER_CREATE', 'MENU', 'MENU_CUSTOMER', 'CUSTOMER_CREATE', 'Menu create customer management', NULL, '2020-05-09 22:28:56.574412');
INSERT INTO public.application VALUES ('MENU_CUSTOMER_VIEW', 'MENU', 'MENU_CUSTOMER', 'CUSTOMER_VIEW', 'Menu customer management', NULL, '2020-05-09 22:28:56.576412');
INSERT INTO public.application VALUES ('MENU_PRODUCT', 'MENU', NULL, NULL, 'Menu product management', NULL, '2020-05-09 22:30:07.329459');
INSERT INTO public.application VALUES ('MENU_PRODUCT_CREATE', 'MENU', 'MENU_PRODUCT', 'PRODUCT_CREATE', 'Menu create product', NULL, '2020-05-09 22:30:07.331459');
INSERT INTO public.application VALUES ('MENU_PRODUCT_VIEW', 'MENU', 'MENU_PRODUCT', 'PRODUCT_VIEW', 'Menu view product', NULL, '2020-05-09 22:30:07.333459');
INSERT INTO public.application VALUES ('MENU_PRODUCT_PRICE_CREATE', 'MENU', 'MENU_PRODUCT', 'PRODUCT_PRICE_CREATE', 'Menu create product price', NULL, '2020-05-09 22:30:07.33546');
INSERT INTO public.application VALUES ('MENU_PRODUCT_PRICE_VIEW', 'MENU', 'MENU_PRODUCT', 'PRODUCT_PRICE_VIEW', 'Menu view product price', NULL, '2020-05-09 22:30:07.33746');
INSERT INTO public.application VALUES ('MENU_WAREHOUSE', 'MENU', NULL, NULL, 'Menu warehouse management', NULL, '2020-05-09 22:31:16.456413');
INSERT INTO public.application VALUES ('MENU_WAREHOUSE_CREATE', 'MENU', 'MENU_WAREHOUSE', 'WAREHOUSE_CREATE', 'Menu create warehouse', NULL, '2020-05-09 22:31:16.460413');
INSERT INTO public.application VALUES ('MENU_WAREHOUSE_VIEW', 'MENU', 'MENU_WAREHOUSE', 'WAREHOUSE_VIEW', 'Menu view warehouse', NULL, '2020-05-09 22:31:16.462413');
INSERT INTO public.application VALUES ('MENU_WAREHOUSE_IMPORT', 'MENU', 'MENU_WAREHOUSE', 'WAREHOUSE_IMPORT', 'Menu import warehouse', NULL, '2020-05-09 22:31:16.464414');
INSERT INTO public.application VALUES ('MENU_WAREHOUSE_EXPORT', 'MENU', 'MENU_WAREHOUSE', 'WAREHOUSE_EXPORT', 'Menu export warehouse', NULL, '2020-05-09 22:31:16.465414');
INSERT INTO public.application VALUES ('MENU_WAREHOUSE_INVENTORY_ITEM', 'MENU', 'MENU_WAREHOUSE', 'WAREHOUSE_INVENTORY_ITEM', 'Menu inventory item warehouse', NULL, '2020-05-09 22:31:16.468414');
INSERT INTO public.application VALUES ('MENU_RETAIL_OUTLET', 'MENU', NULL, NULL, 'Menu  about retail outlets', NULL, '2020-05-09 22:31:34.073421');
INSERT INTO public.application VALUES ('MENU_CREATE_RETAIL_OUTLET', 'MENU', 'MENU_RETAIL_OUTLET', 'PERM_RETAILOUTLET_CREATE', 'Menu  create retail outlets', NULL, '2020-05-09 22:31:34.076421');
INSERT INTO public.application VALUES ('MENU_VIEW_RETAIL_OUTLET', 'MENU', 'MENU_RETAIL_OUTLET', 'PERM_RETAILOUTLET_VIEW', 'Menu  view list retail outlets', NULL, '2020-05-09 22:31:34.078421');
INSERT INTO public.application VALUES ('MENU_VIEW_ALL_RETAIL_OUTLET', 'MENU', 'MENU_RETAIL_OUTLET', 'PERM_RETAILOUTLET_VIEW_ALL', 'Menu  view list of all retail outlets', NULL, '2020-05-09 22:31:34.079421');
INSERT INTO public.application VALUES ('MENU_DISTRIBUTOR', 'MENU', NULL, NULL, 'Menu  about distributors', NULL, '2020-05-09 22:31:34.081421');
INSERT INTO public.application VALUES ('MENU_CREATE_DISTRIBUTOR', 'MENU', 'MENU_DISTRIBUTOR', 'PERM_DISTRIBUTOR_CREATE', 'Menu  create distributors', NULL, '2020-05-09 22:31:34.082421');
INSERT INTO public.application VALUES ('MENU_VIEW_DISTRIBUTOR', 'MENU', 'MENU_DISTRIBUTOR', 'PERM_DISTRIBUTOR_VIEW', 'Menu  view list distributors', NULL, '2020-05-09 22:31:34.084421');
INSERT INTO public.application VALUES ('MENU_VIEW_ALL_DISTRIBUTOR', 'MENU', 'MENU_DISTRIBUTOR', 'PERM_DISTRIBUTOR_VIEW_ALL', 'Menu  view list of all distributors', NULL, '2020-05-09 22:31:34.085421');


--
-- TOC entry 2986 (class 0 OID 28533)
-- Dependencies: 211
-- Data for Name: application_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.application_type VALUES ('MENU', 'Menu application type', '2020-05-09 22:27:45.03032', '2020-05-09 22:27:45.03032');
INSERT INTO public.application_type VALUES ('SCREEN', 'Screen application type', '2020-05-09 22:27:45.03132', '2020-05-09 22:27:45.03132');
INSERT INTO public.application_type VALUES ('MODULE', 'Module application type', '2020-05-09 22:27:45.03332', '2020-05-09 22:27:45.03332');
INSERT INTO public.application_type VALUES ('SERVICE', 'Service application type', '2020-05-09 22:27:45.03432', '2020-05-09 22:27:45.03432');
INSERT INTO public.application_type VALUES ('ENTITY', 'Entity application type', '2020-05-09 22:27:45.035321', '2020-05-09 22:27:45.035321');


--
-- TOC entry 2988 (class 0 OID 28566)
-- Dependencies: 213
-- Data for Name: author; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.author VALUES (1, 'authorA');
INSERT INTO public.author VALUES (2, 'Bthor C');
INSERT INTO public.author VALUES (3, 'Cthen D');
INSERT INTO public.author VALUES (11, 'David Messi');


--
-- TOC entry 2989 (class 0 OID 28571)
-- Dependencies: 214
-- Data for Name: book; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.book VALUES (1, 'this is book1');
INSERT INTO public.book VALUES (2, 'this is the book2');
INSERT INTO public.book VALUES (3, 'this is cat book3');


--
-- TOC entry 2990 (class 0 OID 28576)
-- Dependencies: 215
-- Data for Name: book_author; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.book_author VALUES (1, 1);
INSERT INTO public.book_author VALUES (1, 2);
INSERT INTO public.book_author VALUES (2, 2);
INSERT INTO public.book_author VALUES (1, 3);
INSERT INTO public.book_author VALUES (3, 1);
INSERT INTO public.book_author VALUES (3, 2);
INSERT INTO public.book_author VALUES (3, 3);
INSERT INTO public.book_author VALUES (1, 1);
INSERT INTO public.book_author VALUES (1, 2);
INSERT INTO public.book_author VALUES (2, 2);
INSERT INTO public.book_author VALUES (1, 3);
INSERT INTO public.book_author VALUES (3, 1);
INSERT INTO public.book_author VALUES (3, 2);
INSERT INTO public.book_author VALUES (3, 3);
INSERT INTO public.book_author VALUES (1, 1);
INSERT INTO public.book_author VALUES (1, 2);
INSERT INTO public.book_author VALUES (2, 2);
INSERT INTO public.book_author VALUES (1, 3);
INSERT INTO public.book_author VALUES (3, 1);
INSERT INTO public.book_author VALUES (3, 2);
INSERT INTO public.book_author VALUES (3, 3);
INSERT INTO public.book_author VALUES (1, 1);
INSERT INTO public.book_author VALUES (1, 2);
INSERT INTO public.book_author VALUES (2, 2);
INSERT INTO public.book_author VALUES (1, 3);
INSERT INTO public.book_author VALUES (3, 1);
INSERT INTO public.book_author VALUES (3, 2);
INSERT INTO public.book_author VALUES (3, 3);


--
-- TOC entry 2981 (class 0 OID 28457)
-- Dependencies: 206
-- Data for Name: party; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.party VALUES ('bd6322f2-2121-11ea-81a8-979e2f76b5a4', 'PERSON', NULL, NULL, 'PARTY_ENABLED', NULL, NULL, NULL, NULL, false, '2020-05-09 22:27:47.48146', '2020-05-09 22:27:47.48146', 'admin');
INSERT INTO public.party VALUES ('3ad64675-24b9-42ca-823a-9f2e70af960c', 'PERSON', NULL, '', 'PARTY_ENABLED', '2020-05-10 22:52:01.372', 'admin', '2020-05-10 22:52:01.372', 'admin', false, NULL, '2020-05-10 22:52:01.335224', '1');
INSERT INTO public.party VALUES ('e9e1781e-b939-429f-b23b-cb9a67ab49ea', 'PERSON', NULL, '', 'PARTY_DISABLED', '2020-05-11 09:07:50.866', 'hoangtl', '2020-05-11 09:08:37.931', 'hoangtl', false, NULL, '2020-05-11 09:07:50.764087', 'temp');
INSERT INTO public.party VALUES ('3ab6176c-e6a1-4d69-9980-aee597a62ac6', 'PERSON', NULL, '', 'PARTY_ENABLED', '2020-05-10 21:24:20.195', 'admin', '2020-05-11 09:19:44.998', 'a', false, NULL, '2020-05-10 21:24:20.151301', 'admin');
INSERT INTO public.party VALUES ('3a637e5f-ea23-4217-b92b-aaf7e06b4656', 'PERSON', NULL, '', 'PARTY_ENABLED', '2020-05-11 10:31:19.541', 'admin', '2020-05-11 10:31:19.541', 'admin', false, NULL, '2020-05-11 10:31:19.536573', 'admin');
INSERT INTO public.party VALUES ('feca4e1f-d77f-4c59-8571-1efeae252015', 'PERSON', NULL, '', 'PARTY_ENABLED', '2020-05-11 11:17:51.25', 'hoangtl1', '2020-05-11 11:17:51.25', 'hoangtl1', false, NULL, '2020-05-11 11:17:51.208247', 'admin');
INSERT INTO public.party VALUES ('9dd7ce54-94b6-4bfa-b765-66db5691679e', 'PERSON', NULL, '', 'PARTY_DISABLED', '2020-05-10 23:06:54.394', 'hoangtl', '2020-05-11 11:18:25.13', 'hoangtl2', false, NULL, '2020-05-10 23:06:54.308299', '222');
INSERT INTO public.party VALUES ('7735cbb1-ee6d-412c-85a0-ca787f93cc79', 'PERSON', NULL, '', 'PARTY_DISABLED', '2020-05-11 16:10:39.303', 'admin', '2020-05-11 16:11:04.675', 'hoangtl3', false, NULL, '2020-05-11 16:10:38.943745', 'admin');
INSERT INTO public.party VALUES ('6d28fa9b-5528-466f-802f-21815bceb8e8', 'PERSON', NULL, '', 'PARTY_ENABLED', '2020-05-11 20:40:18.579', 'hoangtl', '2020-05-11 20:40:18.579', 'hoangtl', false, NULL, '2020-05-11 20:40:18.575937', 'hoangtl4');
INSERT INTO public.party VALUES ('7e8b6ed2-265c-11ea-aca9-f77013972e0d', 'PERSON', NULL, NULL, 'PARTY_ENABLED', '2020-08-15 20:27:42.719018', 'admin', NULL, NULL, false, NULL, '2020-08-15 20:27:42.719018', NULL);
INSERT INTO public.party VALUES ('9a8e40d2-265c-11ea-acaa-eb83ca2329f6', 'PERSON', NULL, NULL, 'PARTY_ENABLED', '2020-08-15 20:28:41.118359', 'admin', NULL, NULL, false, NULL, '2020-08-15 20:28:41.118359', NULL);
INSERT INTO public.party VALUES ('8161d37e-4026-11ea-9be3-54bf64436441', 'PARTY_DISTRIBUTOR', NULL, NULL, NULL, NULL, NULL, NULL, NULL, false, '2020-01-26 17:27:51.182', '2020-01-26 17:27:51.182', NULL);
INSERT INTO public.party VALUES ('875704ac-4026-11ea-9be4-54bf64436441', 'PARTY_DISTRIBUTOR', NULL, NULL, NULL, NULL, NULL, NULL, NULL, false, '2020-01-26 17:28:01.179', '2020-01-26 17:28:01.179', NULL);
INSERT INTO public.party VALUES ('a2fc6dfc-9209-11ea-8788-8bce451a0940', 'COMPANY', NULL, NULL, 'PARTY_ENABLED', NULL, NULL, NULL, NULL, false, '2020-09-01 11:29:35.83743', '2020-05-09 22:27:47.496461', NULL);
INSERT INTO public.party VALUES ('a535012e-9209-11ea-8789-474edece084f', 'COMPANY', NULL, NULL, 'PARTY_ENABLED', NULL, NULL, NULL, NULL, false, '2020-09-01 11:29:35.84143', '2020-05-09 22:27:51.229675', NULL);
INSERT INTO public.party VALUES ('a9c60c1a-9209-11ea-878a-6f96690f8ac3', 'COMPANY', NULL, NULL, 'PARTY_ENABLED', NULL, NULL, NULL, NULL, false, '2020-09-01 11:29:35.84343', '2020-05-09 22:27:58.891113', NULL);
INSERT INTO public.party VALUES ('5ae20c48-4d6c-11ea-967e-54bf64436441', 'PARTY_RETAIL_OUTLET', NULL, NULL, 'PARTY_ENABLED', NULL, 'admin', NULL, NULL, false, '2020-09-01 11:29:35.84443', '2020-02-12 14:50:36.479', NULL);
INSERT INTO public.party VALUES ('d8d8fb18-4d6f-11ea-9681-54bf64436441', 'PARTY_RETAIL_OUTLET', NULL, NULL, 'PARTY_ENABLED', NULL, 'admin', NULL, NULL, false, '2020-09-01 11:29:35.84643', '2020-02-12 15:15:36.302', NULL);
INSERT INTO public.party VALUES ('5b63a1ea-4d71-11ea-9684-54bf64436441', 'PARTY_RETAIL_OUTLET', NULL, NULL, 'PARTY_ENABLED', NULL, 'admin', NULL, NULL, false, '2020-09-01 11:29:35.84943', '2020-02-12 15:26:24.812', NULL);
INSERT INTO public.party VALUES ('68b9cef2-defb-11ea-b306-8795e5f6fd94', 'COMPANY', NULL, NULL, 'PARTY_ENABLED', NULL, NULL, NULL, NULL, false, '2020-09-01 11:29:35.85143', '2020-08-15 20:29:56.333661', NULL);
INSERT INTO public.party VALUES ('38e2f0c2-e938-11ea-937b-97d72a8a4aba', 'COMPANY', NULL, NULL, 'PARTY_ENABLED', NULL, NULL, NULL, NULL, false, '2020-09-01 11:29:35.85343', '2020-08-28 21:10:26.990869', NULL);
INSERT INTO public.party VALUES ('67199a90-e938-11ea-8239-6ba8a6dd76a9', 'COMPANY', NULL, NULL, 'PARTY_ENABLED', NULL, NULL, NULL, NULL, false, '2020-09-01 11:29:35.85443', '2020-08-28 21:11:44.535304', NULL);


--
-- TOC entry 2980 (class 0 OID 28443)
-- Dependencies: 205
-- Data for Name: party_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.party_type VALUES ('AUTOMATED_AGENT', NULL, false, 'Automated Agent', '2020-05-09 22:27:44.902313', '2020-05-09 22:27:44.902313');
INSERT INTO public.party_type VALUES ('PERSON', NULL, true, 'Person', '2020-05-09 22:27:44.905313', '2020-05-09 22:27:44.905313');
INSERT INTO public.party_type VALUES ('PARTY_GROUP', NULL, true, 'Party Group', '2020-05-09 22:27:44.908313', '2020-05-09 22:27:44.908313');
INSERT INTO public.party_type VALUES ('BANK', 'PARTY_GROUP', true, 'Bank', '2020-05-09 22:27:44.909313', '2020-05-09 22:27:44.909313');
INSERT INTO public.party_type VALUES ('LEGAL_ORGANIZATION', 'PARTY_GROUP', false, 'Legal Organization', '2017-01-03 10:11:27.885', '2017-01-03 10:11:27.608');
INSERT INTO public.party_type VALUES ('CORPORATION', 'LEGAL_ORGANIZATION', false, 'Corporation', '2020-05-09 22:27:44.918314', '2020-05-09 22:27:44.918314');
INSERT INTO public.party_type VALUES ('CUSTOMER_GROUP', 'PARTY_GROUP', false, 'Customer Group', '2020-05-09 22:27:44.920314', '2020-05-09 22:27:44.920314');
INSERT INTO public.party_type VALUES ('PARTY_DISTRIBUTOR', NULL, false, 'Distributor', '2020-05-09 22:27:44.925314', '2020-05-09 22:27:44.925314');
INSERT INTO public.party_type VALUES ('PARTY_RETAIL_OUTLET', NULL, false, 'Distributor', '2020-05-09 22:27:44.927314', '2020-05-09 22:27:44.927314');
INSERT INTO public.party_type VALUES ('COMPANY', NULL, NULL, 'Company', NULL, '2020-05-09 22:27:44.928314');
INSERT INTO public.party_type VALUES ('PARTY_SUPPLIER', NULL, false, 'Supplier', '2020-08-28 21:10:26.67085', '2020-08-28 21:10:26.67085');


--
-- TOC entry 2982 (class 0 OID 28477)
-- Dependencies: 207
-- Data for Name: person; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.person VALUES ('bd6322f2-2121-11ea-81a8-979e2f76b5a4', 'admin', ',', ',', 'M', '2020-05-09', NULL, '2020-05-09 22:27:47.485461');
INSERT INTO public.person VALUES ('3ab6176c-e6a1-4d69-9980-aee597a62ac6', 'Tran', 'Le', 'Hoang', 'M', '2020-05-10', NULL, '2020-05-10 21:24:20.151301');
INSERT INTO public.person VALUES ('9dd7ce54-94b6-4bfa-b765-66db5691679e', '21', '22', '23', 'M', '2020-05-10', NULL, '2020-05-10 23:06:54.308299');
INSERT INTO public.person VALUES ('e9e1781e-b939-429f-b23b-cb9a67ab49ea', 'a', 'b', 'c', 'M', '2020-05-11', NULL, '2020-05-11 09:07:50.764087');
INSERT INTO public.person VALUES ('3ad64675-24b9-42ca-823a-9f2e70af960c', '11', '1', '2345', 'M', '2020-05-10', NULL, '2020-05-10 22:52:01.335224');
INSERT INTO public.person VALUES ('3a637e5f-ea23-4217-b92b-aaf7e06b4656', 'tran', 'le ', 'Hoang', 'M', '2020-05-11', NULL, '2020-05-11 10:31:19.536573');
INSERT INTO public.person VALUES ('feca4e1f-d77f-4c59-8571-1efeae252015', 'Tran', 'le', 'Hoang', 'M', '2020-05-03', NULL, '2020-05-11 11:17:51.208247');
INSERT INTO public.person VALUES ('6d28fa9b-5528-466f-802f-21815bceb8e8', 'Tran', 'Le', 'Hoang', 'M', '2020-05-11', NULL, '2020-05-11 20:40:18.575937');
INSERT INTO public.person VALUES ('7e8b6ed2-265c-11ea-aca9-f77013972e0d', 'Nguyễn', 'Văn', 'Sêu', 'M', '2020-08-15', NULL, '2020-08-15 20:27:42.730019');
INSERT INTO public.person VALUES ('9a8e40d2-265c-11ea-acaa-eb83ca2329f6', 'Trần', 'Thị', 'Toán', 'M', '2020-08-15', NULL, '2020-08-15 20:28:41.121359');


--
-- TOC entry 2983 (class 0 OID 28488)
-- Dependencies: 208
-- Data for Name: security_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.security_group VALUES ('ROLE_SALE_MANAGER', 'Sale manager account owner access security group', '2017-01-03 10:12:23.879', '2017-01-03 10:12:23.878');
INSERT INTO public.security_group VALUES ('ROLE_ACCOUNTANT', 'Accountant account owner access security group', '2017-01-03 10:12:42.531', '2017-01-03 10:12:42.507');
INSERT INTO public.security_group VALUES ('ROLE_FULL_ADMIN', 'Full Admin group, has all general functional permissions.', '2017-01-03 10:12:23.994', '2017-01-03 10:12:23.993');
INSERT INTO public.security_group VALUES ('ROLE_TMS_MANAGER', 'Management of Transportation System', NULL, '2020-03-01 18:39:19.097');
INSERT INTO public.security_group VALUES ('ROLE_SALES_ROUTE_MANAGER', 'Management of Sales Route', NULL, '2020-03-01 18:54:50.488');
INSERT INTO public.security_group VALUES ('ROLE_TMS_CONTAINER_ADMIN', 'Quản trị vận chuyển container', NULL, '2020-04-10 23:35:36.604');
INSERT INTO public.security_group VALUES ('ROLE_HR_ADMIN', 'human resources group', NULL, '2020-05-09 22:28:23.1385');
INSERT INTO public.security_group VALUES ('ROLE_DISTRIBUTOR', 'distributor group', NULL, '2020-05-09 22:28:50.580069');
INSERT INTO public.security_group VALUES ('ROLE_CUSTOMER_ADMIN', 'customer admin group', NULL, '2020-05-09 22:28:56.556411');
INSERT INTO public.security_group VALUES ('ROLE_PRODUCT_ADMIN', 'product management group', NULL, '2020-05-09 22:30:07.291457');
INSERT INTO public.security_group VALUES ('ROLE_DRIVER', 'driver group', NULL, '2020-05-09 22:31:11.407124');
INSERT INTO public.security_group VALUES ('ROLE_WAREHOUSE_ADMIN', 'warehouse group', NULL, '2020-05-09 22:31:16.443412');
INSERT INTO public.security_group VALUES ('ROLE_SALESMAN', 'salesman group', NULL, '2020-05-09 22:31:34.05642');
INSERT INTO public.security_group VALUES ('ROLE_SALESSUP', 'sales supervisor group', NULL, '2020-05-09 22:31:34.06542');
INSERT INTO public.security_group VALUES ('ROLE_SALES_ADMIN', 'sales admin', NULL, '2020-05-09 22:31:34.06642');
INSERT INTO public.security_group VALUES ('ROLE_RETAIL_OUTLET', 'retail outlet group', NULL, '2020-05-09 22:31:42.136882');


--
-- TOC entry 2985 (class 0 OID 28506)
-- Dependencies: 210
-- Data for Name: security_group_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.security_group_permission VALUES ('ROLE_FULL_ADMIN', 'ORDER_VIEW', '2019-12-26 08:00:35.749', '2019-12-26 08:00:35.749');
INSERT INTO public.security_group_permission VALUES ('ROLE_FULL_ADMIN', 'ORDER_CREATE', '2019-12-26 08:00:35.749', '2019-12-26 08:00:35.749');
INSERT INTO public.security_group_permission VALUES ('ROLE_FULL_ADMIN', 'USER_CREATE', '2019-12-26 08:00:35.749', '2019-12-26 08:00:35.749');
INSERT INTO public.security_group_permission VALUES ('ROLE_FULL_ADMIN', 'USER_VIEW', '2019-12-26 08:00:35.749', '2019-12-26 08:00:35.749');
INSERT INTO public.security_group_permission VALUES ('ROLE_FULL_ADMIN', 'INVOICE_CREATE', '2019-12-26 08:00:35.749', '2019-12-26 08:00:35.749');
INSERT INTO public.security_group_permission VALUES ('ROLE_FULL_ADMIN', 'INVOICE_VIEW', '2019-12-26 08:00:35.749', '2019-12-26 08:00:35.749');
INSERT INTO public.security_group_permission VALUES ('ROLE_SALE_MANAGER', 'ORDER_CREATE', '2019-12-26 08:00:35.749', '2019-12-26 08:00:35.749');
INSERT INTO public.security_group_permission VALUES ('ROLE_SALE_MANAGER', 'ORDER_VIEW', '2019-12-26 08:00:35.749', '2019-12-26 08:00:35.749');
INSERT INTO public.security_group_permission VALUES ('ROLE_ACCOUNTANT', 'ORDER_VIEW', '2019-12-26 08:00:35.749', '2019-12-26 08:00:35.749');
INSERT INTO public.security_group_permission VALUES ('ROLE_ACCOUNTANT', 'INVOICE_CREATE', '2019-12-26 08:00:35.749', '2019-12-26 08:00:35.749');
INSERT INTO public.security_group_permission VALUES ('ROLE_ACCOUNTANT', 'INVOICE_VIEW', '2019-12-26 08:00:35.749', '2019-12-26 08:00:35.749');
INSERT INTO public.security_group_permission VALUES ('ROLE_TMS_MANAGER', 'DELIVERY_PLAN_CREATE', NULL, '2020-03-01 18:39:24.741');
INSERT INTO public.security_group_permission VALUES ('ROLE_FULL_ADMIN', 'DELIVERY_PLAN_CREATE', NULL, '2020-03-01 18:49:58.969');
INSERT INTO public.security_group_permission VALUES ('ROLE_SALES_ROUTE_MANAGER', 'SALES_ROUTE_PLAN_CREATE', NULL, '2020-03-01 18:54:50.488');
INSERT INTO public.security_group_permission VALUES ('ROLE_FULL_ADMIN', 'SALES_ROUTE_PLAN_CREATE', NULL, '2020-03-01 18:54:50.488');
INSERT INTO public.security_group_permission VALUES ('ROLE_FULL_ADMIN', 'GEO_ADDRESS_ADMIN', NULL, '2020-03-01 18:54:50.488');
INSERT INTO public.security_group_permission VALUES ('ROLE_FULL_ADMIN', 'SALES_ADMIN_VIEW_REPORT', NULL, '2020-03-01 18:54:50.488');
INSERT INTO public.security_group_permission VALUES ('ROLE_FULL_ADMIN', 'FACILITY_ADMIN_VIEW_REPORT', NULL, '2020-03-01 18:54:50.488');
INSERT INTO public.security_group_permission VALUES ('ROLE_FULL_ADMIN', 'TMS_ADMIN_VIEW_REPORT', NULL, '2020-03-01 18:54:50.488');
INSERT INTO public.security_group_permission VALUES ('ROLE_FULL_ADMIN', 'TMS_CONTAINER_ADMIN', NULL, '2020-03-01 18:54:50.488');
INSERT INTO public.security_group_permission VALUES ('ROLE_TMS_CONTAINER_ADMIN', 'TMS_CONTAINER_ADMIN', NULL, '2020-03-01 18:54:50.488');
INSERT INTO public.security_group_permission VALUES ('ROLE_PRODUCT_ADMIN', 'PRODUCT_CREATE', NULL, '2020-05-09 22:30:07.33846');
INSERT INTO public.security_group_permission VALUES ('ROLE_PRODUCT_ADMIN', 'PRODUCT_VIEW', NULL, '2020-05-09 22:30:07.34046');
INSERT INTO public.security_group_permission VALUES ('ROLE_PRODUCT_ADMIN', 'PRODUCT_PRICE_CREATE', NULL, '2020-05-09 22:30:07.34246');
INSERT INTO public.security_group_permission VALUES ('ROLE_PRODUCT_ADMIN', 'PRODUCT_PRICE_VIEW', NULL, '2020-05-09 22:30:07.34346');
INSERT INTO public.security_group_permission VALUES ('ROLE_WAREHOUSE_ADMIN', 'WAREHOUSE_CREATE', NULL, '2020-05-09 22:31:16.477414');
INSERT INTO public.security_group_permission VALUES ('ROLE_WAREHOUSE_ADMIN', 'WAREHOUSE_VIEW', NULL, '2020-05-09 22:31:16.479414');
INSERT INTO public.security_group_permission VALUES ('ROLE_WAREHOUSE_ADMIN', 'WAREHOUSE_IMPORT', NULL, '2020-05-09 22:31:16.481415');
INSERT INTO public.security_group_permission VALUES ('ROLE_WAREHOUSE_ADMIN', 'WAREHOUSE_EXPORT', NULL, '2020-05-09 22:31:16.484415');
INSERT INTO public.security_group_permission VALUES ('ROLE_WAREHOUSE_ADMIN', 'WAREHOUSE_INVENTORY_ITEM', NULL, '2020-05-09 22:31:16.486415');
INSERT INTO public.security_group_permission VALUES ('ROLE_SALESMAN', 'PERM_RETAILOUTLET_CREATE', NULL, '2020-05-09 22:31:34.086421');
INSERT INTO public.security_group_permission VALUES ('ROLE_SALESMAN', 'PERM_RETAILOUTLET_VIEW', NULL, '2020-05-09 22:31:34.088422');
INSERT INTO public.security_group_permission VALUES ('ROLE_SALESSUP', 'PERM_RETAILOUTLET_CREATE', NULL, '2020-05-09 22:31:34.089422');
INSERT INTO public.security_group_permission VALUES ('ROLE_SALESSUP', 'PERM_RETAILOUTLET_VIEW', NULL, '2020-05-09 22:31:34.090422');
INSERT INTO public.security_group_permission VALUES ('ROLE_SALES_ADMIN', 'PERM_RETAILOUTLET_CREATE', NULL, '2020-05-09 22:31:34.092422');
INSERT INTO public.security_group_permission VALUES ('ROLE_SALES_ADMIN', 'PERM_RETAILOUTLET_VIEW', NULL, '2020-05-09 22:31:34.093422');
INSERT INTO public.security_group_permission VALUES ('ROLE_SALES_ADMIN', 'PERM_RETAILOUTLET_VIEW_ALL', NULL, '2020-05-09 22:31:34.094422');
INSERT INTO public.security_group_permission VALUES ('ROLE_SALES_ADMIN', 'PERM_DISTRIBUTOR_CREATE', NULL, '2020-05-09 22:31:34.095422');
INSERT INTO public.security_group_permission VALUES ('ROLE_SALES_ADMIN', 'PERM_DISTRIBUTOR_VIEW', NULL, '2020-05-09 22:31:34.096422');
INSERT INTO public.security_group_permission VALUES ('ROLE_SALES_ADMIN', 'PERM_DISTRIBUTOR_VIEW_ALL', NULL, '2020-05-09 22:31:34.097422');
INSERT INTO public.security_group_permission VALUES ('ROLE_FULL_ADMIN', 'PERM_RETAILOUTLET_CREATE', NULL, '2020-05-09 22:31:34.098422');
INSERT INTO public.security_group_permission VALUES ('ROLE_FULL_ADMIN', 'PERM_RETAILOUTLET_VIEW', NULL, '2020-05-09 22:31:34.100422');
INSERT INTO public.security_group_permission VALUES ('ROLE_FULL_ADMIN', 'PERM_RETAILOUTLET_VIEW_ALL', NULL, '2020-05-09 22:31:34.101422');
INSERT INTO public.security_group_permission VALUES ('ROLE_FULL_ADMIN', 'PERM_DISTRIBUTOR_CREATE', NULL, '2020-05-09 22:31:34.102422');
INSERT INTO public.security_group_permission VALUES ('ROLE_FULL_ADMIN', 'PERM_DISTRIBUTOR_VIEW', NULL, '2020-05-09 22:31:34.103422');
INSERT INTO public.security_group_permission VALUES ('ROLE_FULL_ADMIN', 'PERM_DISTRIBUTOR_VIEW_ALL', NULL, '2020-05-09 22:31:34.104423');
INSERT INTO public.security_group_permission VALUES ('ROLE_HR_ADMIN', 'USER_CREATE', NULL, '2020-05-09 22:28:24.564581');
INSERT INTO public.security_group_permission VALUES ('ROLE_HR_ADMIN', 'USER_VIEW', NULL, '2020-05-09 22:28:24.566582');
INSERT INTO public.security_group_permission VALUES ('ROLE_HR_ADMIN', 'PERM_DEPARTMENT_CREATE', NULL, '2020-05-09 22:28:24.567582');
INSERT INTO public.security_group_permission VALUES ('ROLE_HR_ADMIN', 'PERM_DEPARTMENT_VIEW', NULL, '2020-05-09 22:28:24.569582');
INSERT INTO public.security_group_permission VALUES ('ROLE_CUSTOMER_ADMIN', 'CUSTOMER_CREATE', NULL, '2020-05-09 22:28:56.578413');
INSERT INTO public.security_group_permission VALUES ('ROLE_CUSTOMER_ADMIN', 'CUSTOMER_VIEW', NULL, '2020-05-09 22:28:56.581413');


--
-- TOC entry 2984 (class 0 OID 28497)
-- Dependencies: 209
-- Data for Name: security_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.security_permission VALUES ('USER_CREATE', 'Create user permission', '2019-12-26 08:00:31.803', '2019-12-26 08:00:31.803');
INSERT INTO public.security_permission VALUES ('USER_VIEW', 'View user permission', '2019-12-26 08:00:31.803', '2019-12-26 08:00:31.803');
INSERT INTO public.security_permission VALUES ('ORDER_CREATE', 'Create order permission', '2019-12-26 08:00:31.803', '2019-12-26 08:00:31.803');
INSERT INTO public.security_permission VALUES ('ORDER_VIEW', 'View order permission', '2019-12-26 08:00:31.803', '2019-12-26 08:00:31.803');
INSERT INTO public.security_permission VALUES ('INVOICE_CREATE', 'Create order permission', '2019-12-26 08:00:31.803', '2019-12-26 08:00:31.803');
INSERT INTO public.security_permission VALUES ('INVOICE_VIEW', 'View order permission', '2019-12-26 08:00:31.803', '2019-12-26 08:00:31.803');
INSERT INTO public.security_permission VALUES ('DELIVERY_PLAN_CREATE', 'Creation of delivery plan and trips', NULL, '2020-03-01 18:39:22.008');
INSERT INTO public.security_permission VALUES ('SALES_ROUTE_PLAN_CREATE', 'Creation of Sales Route', NULL, '2020-03-01 18:54:50.488');
INSERT INTO public.security_permission VALUES ('GEO_ADDRESS_ADMIN', 'Creation of Sales Route', NULL, '2020-03-01 18:54:50.488');
INSERT INTO public.security_permission VALUES ('SALES_ADMIN_VIEW_REPORT', 'Administrator of sales', NULL, '2020-03-01 18:54:50.488');
INSERT INTO public.security_permission VALUES ('FACILITY_ADMIN_VIEW_REPORT', 'Administrator of facility', NULL, '2020-03-01 18:54:50.488');
INSERT INTO public.security_permission VALUES ('TMS_ADMIN_VIEW_REPORT', 'Administrator of facility', NULL, '2020-03-01 18:54:50.488');
INSERT INTO public.security_permission VALUES ('TMS_CONTAINER_ADMIN', 'Administrator of container transportation', NULL, '2020-03-01 18:54:50.488');
INSERT INTO public.security_permission VALUES ('SALES_ADMIN', 'Administrator of sales', NULL, '2020-03-01 18:54:50.488');
INSERT INTO public.security_permission VALUES ('PERM_DEPARTMENT_CREATE', 'Create department', NULL, '2020-05-09 22:28:24.53558');
INSERT INTO public.security_permission VALUES ('PERM_DEPARTMENT_VIEW', 'Create department', NULL, '2020-05-09 22:28:24.53858');
INSERT INTO public.security_permission VALUES ('CUSTOMER_CREATE', 'Create customers', NULL, '2020-05-09 22:28:56.559411');
INSERT INTO public.security_permission VALUES ('CUSTOMER_VIEW', 'View customers', NULL, '2020-05-09 22:28:56.560412');
INSERT INTO public.security_permission VALUES ('PRODUCT_CREATE', 'Create products', NULL, '2020-05-09 22:30:07.296457');
INSERT INTO public.security_permission VALUES ('PRODUCT_VIEW', 'View products', NULL, '2020-05-09 22:30:07.298457');
INSERT INTO public.security_permission VALUES ('PRODUCT_PRICE_CREATE', 'Create product price', NULL, '2020-05-09 22:30:07.299458');
INSERT INTO public.security_permission VALUES ('PRODUCT_PRICE_VIEW', 'View product price', NULL, '2020-05-09 22:30:07.300458');
INSERT INTO public.security_permission VALUES ('WAREHOUSE_CREATE', 'Create warehouse', NULL, '2020-05-09 22:31:16.448413');
INSERT INTO public.security_permission VALUES ('WAREHOUSE_VIEW', 'View warehouse', NULL, '2020-05-09 22:31:16.450413');
INSERT INTO public.security_permission VALUES ('WAREHOUSE_IMPORT', 'Import to warehouse management', NULL, '2020-05-09 22:31:16.451413');
INSERT INTO public.security_permission VALUES ('WAREHOUSE_EXPORT', 'Export from warehouse management', NULL, '2020-05-09 22:31:16.453413');
INSERT INTO public.security_permission VALUES ('WAREHOUSE_INVENTORY_ITEM', 'Inventory item', NULL, '2020-05-09 22:31:16.454413');
INSERT INTO public.security_permission VALUES ('PERM_RETAILOUTLET_CREATE', 'Create retail outlets', NULL, '2020-05-09 22:31:34.06842');
INSERT INTO public.security_permission VALUES ('PERM_RETAILOUTLET_VIEW', 'View retail outlets', NULL, '2020-05-09 22:31:34.069421');
INSERT INTO public.security_permission VALUES ('PERM_RETAILOUTLET_VIEW_ALL', 'View retail outlets', NULL, '2020-05-09 22:31:34.070421');
INSERT INTO public.security_permission VALUES ('PERM_DISTRIBUTOR_CREATE', 'Create retail outlets', NULL, '2020-05-09 22:31:34.071421');
INSERT INTO public.security_permission VALUES ('PERM_DISTRIBUTOR_VIEW', 'View retail outlets', NULL, '2020-05-09 22:31:34.071421');
INSERT INTO public.security_permission VALUES ('PERM_DISTRIBUTOR_VIEW_ALL', 'View retail outlets', NULL, '2020-05-09 22:31:34.072421');


--
-- TOC entry 2979 (class 0 OID 28422)
-- Dependencies: 204
-- Data for Name: status; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.status VALUES ('SINGLE', 'MARRY_STATUS', 'SINGLE', '0', 'Độc thân', '2020-05-09 22:27:44.944315', '2020-05-09 22:27:44.944315');
INSERT INTO public.status VALUES ('MARRIED', 'MARRY_STATUS', 'MARRIED', '0', 'Đã kết hôn', '2020-05-09 22:27:44.950316', '2020-05-09 22:27:44.950316');
INSERT INTO public.status VALUES ('DIVORCED', 'MARRY_STATUS', 'DIVORCED', '0', 'Đã ly dị', '2020-05-09 22:27:44.953316', '2020-05-09 22:27:44.953316');
INSERT INTO public.status VALUES ('PARTY_ENABLED', 'PARTY_STATUS', 'ENABLED', '0', 'Đã kích hoạt', '2020-05-09 22:27:44.956316', '2020-05-09 22:27:44.956316');
INSERT INTO public.status VALUES ('PARTY_DISABLED', 'PARTY_STATUS', 'DISABLED', '0', 'Đã bị vô hiệu hóa', '2020-05-09 22:27:44.959316', '2020-05-09 22:27:44.959316');


--
-- TOC entry 2991 (class 0 OID 28652)
-- Dependencies: 216
-- Data for Name: status_item; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.status_item VALUES ('USER_REGISTERED', 'USER_STATUS', 'REGISTERED', 'Đã đăng ký', NULL, '2020-10-13 20:14:38.11117');
INSERT INTO public.status_item VALUES ('USER_APPROVED', 'USER_STATUS', 'APPROVED', 'Đã phê duyệt', NULL, '2020-10-13 20:14:38.11117');
INSERT INTO public.status_item VALUES ('ORDER_CREATED', 'ORDER_STATUS', 'CREATED', 'tạo mới', NULL, '2020-05-09 22:27:04.446999');
INSERT INTO public.status_item VALUES ('ORDER_CANCELLED', 'ORDER_STATUS', 'CANCELLED', 'đã hủy', NULL, '2020-05-09 22:27:04.446999');
INSERT INTO public.status_item VALUES ('SHIPMENT_ITEM_CREATED', 'DELIVERY_STATUS', NULL, 'Tạo mới', NULL, '2020-05-09 22:27:04.454999');
INSERT INTO public.status_item VALUES ('DELIVERY_TRIP_CREATED', 'DELIVERY_STATUS', NULL, 'Tạo mới', NULL, '2020-05-09 22:27:04.454999');
INSERT INTO public.status_item VALUES ('SHIPMENT_ITEM_SCHEDULED_TRIP', 'DELIVERY_STATUS', NULL, 'Đang xếp chuyến', NULL, '2020-05-09 22:27:04.454999');
INSERT INTO public.status_item VALUES ('DELIVERY_TRIP_DETAIL_SCHEDULED_TRIP', 'DELIVERY_STATUS', NULL, 'Đang xếp chuyến', NULL, '2020-05-09 22:27:04.454999');
INSERT INTO public.status_item VALUES ('DELIVERY_TRIP_APPROVED_TRIP', 'DELIVERY_STATUS', NULL, 'Đã phê duyệt chuyến', NULL, '2020-05-09 22:27:04.454999');
INSERT INTO public.status_item VALUES ('DELIVERY_TRIP_DETAIL_APPROVED_TRIP', 'DELIVERY_STATUS', NULL, 'Đã phê duyệt chi tiết chuyến', NULL, '2020-05-09 22:27:04.454999');
INSERT INTO public.status_item VALUES ('DELIVERY_TRIP_DETAIL_ON_TRIP', 'DELIVERY_STATUS', NULL, 'Đang thực hiện chuyến', NULL, '2020-05-09 22:27:04.454999');
INSERT INTO public.status_item VALUES ('DELIVERY_TRIP_EXECUTED', 'DELIVERY_STATUS', NULL, 'Đang thực hiện chuyến', NULL, '2020-05-09 22:27:04.454999');
INSERT INTO public.status_item VALUES ('DELIVERY_TRIP_DETAIL_COMPLETED', 'DELIVERY_STATUS', NULL, 'Hoàn thành giao chi tiết chuyến', NULL, '2020-05-09 22:27:04.454999');
INSERT INTO public.status_item VALUES ('SHIPMENT_ITEM_COMPLETED', 'DELIVERY_STATUS', NULL, 'Hoàn thành giao đơn vận chuyển', NULL, '2020-05-09 22:27:04.454999');
INSERT INTO public.status_item VALUES ('DELIVERY_TRIP_COMPLETED', 'DELIVERY_STATUS', NULL, 'Hoàn thành giao chuyến', NULL, '2020-05-09 22:27:04.454999');
INSERT INTO public.status_item VALUES ('SHIPMENT_TRIP_CREATED', 'DELIVERY_STATUS', NULL, 'Tạo mới', NULL, '2020-03-08 08:47:16.775');
INSERT INTO public.status_item VALUES ('SHIPMENT_TRIP_CANCELLED', 'DELIVERY_STATUS', NULL, 'Hủy', NULL, '2020-03-08 08:47:16.775');
INSERT INTO public.status_item VALUES ('SHIPMENT_TRIP_COMPLETED', 'DELIVERY_STATUS', NULL, 'Hoàn thành', NULL, '2020-03-08 08:47:16.775');
INSERT INTO public.status_item VALUES ('SHIPMENT_ITEM_ON_TRIP', 'DELIVERY_STATUS', NULL, 'Hàng xếp chuyến', NULL, '2020-03-08 08:47:16.775');
INSERT INTO public.status_item VALUES ('SHIPMENT_ITEM_DELIVERED', 'DELIVERY_STATUS', NULL, 'Đã giao xong', NULL, '2020-03-08 08:47:16.775');
INSERT INTO public.status_item VALUES ('SHIPMENT_ITEM_NOT_DELIVERED', 'DELIVERY_STATUS', NULL, 'Hàng không được giao', NULL, '2020-03-08 08:47:16.775');
INSERT INTO public.status_item VALUES ('SHIPMENT_ITEM_CANCELLED', 'DELIVERY_STATUS', NULL, 'Hủy', NULL, '2020-03-08 08:47:16.775');
INSERT INTO public.status_item VALUES ('CREATED', 'DELIVERY_STATUS', NULL, 'Hủy', NULL, '2020-03-08 08:47:16.775');
INSERT INTO public.status_item VALUES ('SCHEDULED_TRIP', 'DELIVERY_STATUS', NULL, 'Hủy', NULL, '2020-03-08 08:47:16.775');
INSERT INTO public.status_item VALUES ('APPROVED_TRIP', 'DELIVERY_STATUS', NULL, 'Hủy', NULL, '2020-03-08 08:47:16.775');
INSERT INTO public.status_item VALUES ('COMPLETED', 'DELIVERY_STATUS', NULL, 'Hủy', NULL, '2020-03-08 08:47:16.775');
INSERT INTO public.status_item VALUES ('INVOICE_CREATED', 'INVOICE_STATUS', NULL, 'Tạo mới hóa đơn', NULL, '2020-08-15 20:29:50.870348');
INSERT INTO public.status_item VALUES ('INVOICE_APPROVED', 'INVOICE_STATUS', NULL, 'Đã phê duyệt hóa đơn', NULL, '2020-08-15 20:29:50.870348');
INSERT INTO public.status_item VALUES ('INVOICE_CANCELED', 'INVOICE_STATUS', NULL, 'Hóa đơn đã bị hủy', NULL, '2020-08-15 20:29:50.870348');
INSERT INTO public.status_item VALUES ('INVOICE_COMPLETED', 'INVOICE_STATUS', NULL, 'Hóa đơn hoàn thành', NULL, '2020-08-15 20:29:50.870348');


--
-- TOC entry 2978 (class 0 OID 28408)
-- Dependencies: 203
-- Data for Name: status_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.status_type VALUES ('USER_STATUS', NULL, 'users status', NULL, '2020-10-13 20:14:38.10667');
INSERT INTO public.status_type VALUES ('ORDER_STATUS', NULL, 'Order Status', NULL, '2020-02-01 21:35:10.048');
INSERT INTO public.status_type VALUES ('DELIVERY_STATUS', NULL, 'Delivery status', NULL, '2020-03-08 08:43:46.697');
INSERT INTO public.status_type VALUES ('PARTY_STATUS', NULL, 'Party status', '2020-05-09 22:27:44.930314', '2020-05-09 22:27:44.930314');
INSERT INTO public.status_type VALUES ('MARRY_STATUS', NULL, 'Marry status', '2020-05-09 22:27:44.934315', '2020-05-09 22:27:44.934315');
INSERT INTO public.status_type VALUES ('SERVICE_STATUS', NULL, 'Service status', '2020-05-09 22:27:44.936315', '2020-05-09 22:27:44.936315');
INSERT INTO public.status_type VALUES ('INVOICE_STATUS', NULL, 'invoice Status', '2020-05-09 22:27:44.938315', '2020-05-09 22:27:44.938315');


--
-- TOC entry 2993 (class 0 OID 28700)
-- Dependencies: 218
-- Data for Name: user_login; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.user_login VALUES ('hoangtl', '$2a$10$DnFnON27fzbHXrMKXOSaH.mQwU3zcvdXVgKc1KWcLyUycBOu3xNBC', NULL, NULL, NULL, false, true, false, false, NULL, NULL, NULL, '2020-05-10 21:24:20.151301', 0, '3ab6176c-e6a1-4d69-9980-aee597a62ac6', 'hoangtl@gmail.com');
INSERT INTO public.user_login VALUES ('test', '$2a$10$SKNMpjtfDDOle06TdKml0ur4jwK1JVAKabXtYzjHWb3dOzbYxbPxG', NULL, NULL, NULL, false, true, false, false, NULL, NULL, NULL, '2020-05-10 22:52:01.335224', 0, '3ad64675-24b9-42ca-823a-9f2e70af960c', '123@gmail.com');
INSERT INTO public.user_login VALUES ('222', '$2a$10$9UQk07xDnY0Pm51rbS3l7uVq38vf7m2U4aYvJ63Nn0rWs152CwG6a', NULL, NULL, NULL, false, true, false, false, NULL, NULL, NULL, '2020-05-10 23:06:54.308299', 0, '9dd7ce54-94b6-4bfa-b765-66db5691679e', '222@gmail.com');
INSERT INTO public.user_login VALUES ('a', '$2a$10$mlILzTUg.Pa18/skslxOd.4YrEdyewaJJp8t1b.dbzvFGRKQ24wra', NULL, NULL, NULL, false, true, false, false, NULL, NULL, NULL, '2020-05-11 09:07:50.764087', 0, 'e9e1781e-b939-429f-b23b-cb9a67ab49ea', 'a@gmail.com');
INSERT INTO public.user_login VALUES ('hoangtl1', '$2a$10$TE9vjKt7Nt5L5W2W2V9GiODAFBfH9YEXXjgf.OKGSpHb.yD5VLNr6', NULL, NULL, NULL, false, true, false, false, NULL, NULL, NULL, '2020-05-11 10:31:19.536573', 0, '3a637e5f-ea23-4217-b92b-aaf7e06b4656', 'hoangtl123@gmail.com');
INSERT INTO public.user_login VALUES ('hoangtl2', '$2a$10$t3vK/JjzTzcNyXAwDz9WBe6QUsHP1kezTWGU.U/cMCFK389q7VT4q', NULL, NULL, NULL, false, true, false, false, NULL, NULL, NULL, '2020-05-11 11:17:51.208247', 0, 'feca4e1f-d77f-4c59-8571-1efeae252015', 'hoangtl21@gmail.com');
INSERT INTO public.user_login VALUES ('hoangtl3', '$2a$10$HG.ABHn0GYhrU2bugsJvBeXSsK56ycZezx2opkYfwkCzDwGtwGM.q', NULL, NULL, NULL, false, false, false, false, NULL, NULL, NULL, '2020-05-11 16:10:38.943745', 0, '7735cbb1-ee6d-412c-85a0-ca787f93cc79', 'lehoang@gmail.com');
INSERT INTO public.user_login VALUES ('hoangtl4', '$2a$10$aqEQpTtEpxiCsLvHGbgJ/OGQ.Ab/qaB9W.sUpGqncgw16VhG2ppmC', NULL, NULL, NULL, false, true, false, false, NULL, NULL, NULL, '2020-05-11 20:40:18.575937', 0, '6d28fa9b-5528-466f-802f-21815bceb8e8', 'hoangtl4@gmail.com');
INSERT INTO public.user_login VALUES ('nguyenvanseu', '$2a$04$cqFXgdkB.8u2HwT3QUTVZuePtHdzi.rWFCjdgNbVB7l6vn/yAU7F6', NULL, NULL, NULL, false, true, false, false, NULL, NULL, '2020-08-15 20:28:41.098357', '2020-08-15 20:28:41.098357', 0, '7e8b6ed2-265c-11ea-aca9-f77013972e0d', NULL);
INSERT INTO public.user_login VALUES ('tranthitoan', '$2a$04$cqFXgdkB.8u2HwT3QUTVZuePtHdzi.rWFCjdgNbVB7l6vn/yAU7F6', NULL, NULL, NULL, false, true, false, false, NULL, NULL, '2020-08-15 20:28:41.124359', '2020-08-15 20:28:41.124359', 0, '9a8e40d2-265c-11ea-acaa-eb83ca2329f6', NULL);
INSERT INTO public.user_login VALUES ('admin', '$2a$10$Y4FXX6TalapgQ3rJoe.QHe9.RutM4l81pAm2S1XzDuUR83qLvDxyO', NULL, NULL, NULL, false, true, false, false, NULL, NULL, '2020-08-28 21:11:44.522303', '2020-05-09 22:27:47.489461', 0, 'bd6322f2-2121-11ea-81a8-979e2f76b5a4', 'admin@gmail.com');


--
-- TOC entry 2994 (class 0 OID 28738)
-- Dependencies: 219
-- Data for Name: user_login_security_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.user_login_security_group VALUES ('admin', 'ROLE_FULL_ADMIN', '2020-05-09 22:27:47.492461', '2020-05-09 22:27:47.492461');
INSERT INTO public.user_login_security_group VALUES ('admin', 'ROLE_HR_ADMIN', '2020-05-09 22:28:24.570582', '2020-05-09 22:28:24.570582');
INSERT INTO public.user_login_security_group VALUES ('admin', 'ROLE_CUSTOMER_ADMIN', '2020-05-09 22:28:56.583413', '2020-05-09 22:28:56.583413');
INSERT INTO public.user_login_security_group VALUES ('admin', 'ROLE_PRODUCT_ADMIN', '2020-05-09 22:30:07.34546', '2020-05-09 22:30:07.34546');
INSERT INTO public.user_login_security_group VALUES ('admin', 'ROLE_WAREHOUSE_ADMIN', '2020-05-09 22:31:16.487415', '2020-05-09 22:31:16.487415');
INSERT INTO public.user_login_security_group VALUES ('222', 'ROLE_FULL_ADMIN', NULL, '2020-05-10 23:06:54.308299');
INSERT INTO public.user_login_security_group VALUES ('a', 'ROLE_FULL_ADMIN', NULL, '2020-05-11 09:07:50.764087');
INSERT INTO public.user_login_security_group VALUES ('hoangtl', 'ROLE_FULL_ADMIN', NULL, '2020-05-11 09:19:45.01694');
INSERT INTO public.user_login_security_group VALUES ('test', 'ROLE_FULL_ADMIN', NULL, '2020-05-11 09:23:06.621471');
INSERT INTO public.user_login_security_group VALUES ('hoangtl1', 'ROLE_FULL_ADMIN', NULL, '2020-05-11 11:14:16.433963');
INSERT INTO public.user_login_security_group VALUES ('hoangtl2', 'ROLE_FULL_ADMIN', NULL, '2020-05-11 20:37:29.351258');
INSERT INTO public.user_login_security_group VALUES ('hoangtl4', 'ROLE_FULL_ADMIN', NULL, '2020-05-11 20:40:18.575937');
INSERT INTO public.user_login_security_group VALUES ('nguyenvanseu', 'ROLE_SALE_MANAGER', '2020-08-15 20:28:41.109358', '2020-08-15 20:28:41.109358');
INSERT INTO public.user_login_security_group VALUES ('tranthitoan', 'ROLE_ACCOUNTANT', '2020-08-15 20:28:41.127359', '2020-08-15 20:28:41.127359');


--
-- TOC entry 2992 (class 0 OID 28677)
-- Dependencies: 217
-- Data for Name: user_register; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2809 (class 2606 OID 28570)
-- Name: author author_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.author
    ADD CONSTRAINT author_pkey PRIMARY KEY (author_id);


--
-- TOC entry 2811 (class 2606 OID 28575)
-- Name: book book_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book
    ADD CONSTRAINT book_pkey PRIMARY KEY (book_id);


--
-- TOC entry 2807 (class 2606 OID 28550)
-- Name: application pk_application; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.application
    ADD CONSTRAINT pk_application PRIMARY KEY (application_id);


--
-- TOC entry 2805 (class 2606 OID 28541)
-- Name: application_type pk_application_type; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.application_type
    ADD CONSTRAINT pk_application_type PRIMARY KEY (application_type_id);


--
-- TOC entry 2795 (class 2606 OID 28466)
-- Name: party pk_party; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party
    ADD CONSTRAINT pk_party PRIMARY KEY (party_id);


--
-- TOC entry 2793 (class 2606 OID 28451)
-- Name: party_type pk_party_type; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party_type
    ADD CONSTRAINT pk_party_type PRIMARY KEY (party_type_id);


--
-- TOC entry 2797 (class 2606 OID 28482)
-- Name: person pk_person; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT pk_person PRIMARY KEY (party_id);


--
-- TOC entry 2799 (class 2606 OID 28496)
-- Name: security_group pk_security_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.security_group
    ADD CONSTRAINT pk_security_group PRIMARY KEY (group_id);


--
-- TOC entry 2803 (class 2606 OID 28511)
-- Name: security_group_permission pk_security_group_permission; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.security_group_permission
    ADD CONSTRAINT pk_security_group_permission PRIMARY KEY (group_id, permission_id);


--
-- TOC entry 2801 (class 2606 OID 28505)
-- Name: security_permission pk_security_permission; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.security_permission
    ADD CONSTRAINT pk_security_permission PRIMARY KEY (permission_id);


--
-- TOC entry 2791 (class 2606 OID 28430)
-- Name: status pk_status; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.status
    ADD CONSTRAINT pk_status PRIMARY KEY (status_id);


--
-- TOC entry 2813 (class 2606 OID 28660)
-- Name: status_item pk_status_item; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.status_item
    ADD CONSTRAINT pk_status_item PRIMARY KEY (status_id);


--
-- TOC entry 2789 (class 2606 OID 28416)
-- Name: status_type pk_status_type; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.status_type
    ADD CONSTRAINT pk_status_type PRIMARY KEY (status_type_id);


--
-- TOC entry 2817 (class 2606 OID 28709)
-- Name: user_login pk_user_login; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_login
    ADD CONSTRAINT pk_user_login PRIMARY KEY (user_login_id);


--
-- TOC entry 2821 (class 2606 OID 28743)
-- Name: user_login_security_group pk_user_login_security_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_login_security_group
    ADD CONSTRAINT pk_user_login_security_group PRIMARY KEY (user_login_id, group_id);


--
-- TOC entry 2815 (class 2606 OID 28685)
-- Name: user_register pk_user_register_user_login_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_register
    ADD CONSTRAINT pk_user_register_user_login_id PRIMARY KEY (user_login_id);


--
-- TOC entry 2819 (class 2606 OID 28711)
-- Name: user_login user_login_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_login
    ADD CONSTRAINT user_login_email_key UNIQUE (email);


--
-- TOC entry 2850 (class 2620 OID 28699)
-- Name: application application_last_updated_stamp; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER application_last_updated_stamp BEFORE UPDATE ON public.application FOR EACH ROW EXECUTE FUNCTION public.set_last_updated_stamp();


--
-- TOC entry 2849 (class 2620 OID 28698)
-- Name: application_type application_type_last_updated_stamp; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER application_type_last_updated_stamp BEFORE UPDATE ON public.application_type FOR EACH ROW EXECUTE FUNCTION public.set_last_updated_stamp();


--
-- TOC entry 2844 (class 2620 OID 28693)
-- Name: party party_last_updated_stamp; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER party_last_updated_stamp BEFORE UPDATE ON public.party FOR EACH ROW EXECUTE FUNCTION public.set_last_updated_stamp();


--
-- TOC entry 2843 (class 2620 OID 28692)
-- Name: party_type party_type_last_updated_stamp; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER party_type_last_updated_stamp BEFORE UPDATE ON public.party_type FOR EACH ROW EXECUTE FUNCTION public.set_last_updated_stamp();


--
-- TOC entry 2845 (class 2620 OID 28694)
-- Name: person person_last_updated_stamp; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER person_last_updated_stamp BEFORE UPDATE ON public.person FOR EACH ROW EXECUTE FUNCTION public.set_last_updated_stamp();


--
-- TOC entry 2846 (class 2620 OID 28695)
-- Name: security_group security_group_last_updated_stamp; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER security_group_last_updated_stamp BEFORE UPDATE ON public.security_group FOR EACH ROW EXECUTE FUNCTION public.set_last_updated_stamp();


--
-- TOC entry 2848 (class 2620 OID 28697)
-- Name: security_group_permission security_group_permission_last_updated_stamp; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER security_group_permission_last_updated_stamp BEFORE UPDATE ON public.security_group_permission FOR EACH ROW EXECUTE FUNCTION public.set_last_updated_stamp();


--
-- TOC entry 2847 (class 2620 OID 28696)
-- Name: security_permission security_permission_last_updated_stamp; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER security_permission_last_updated_stamp BEFORE UPDATE ON public.security_permission FOR EACH ROW EXECUTE FUNCTION public.set_last_updated_stamp();


--
-- TOC entry 2842 (class 2620 OID 28691)
-- Name: status status_last_updated_stamp; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER status_last_updated_stamp BEFORE UPDATE ON public.status FOR EACH ROW EXECUTE FUNCTION public.set_last_updated_stamp();


--
-- TOC entry 2851 (class 2620 OID 28721)
-- Name: user_login user_login_last_updated_stamp; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER user_login_last_updated_stamp BEFORE UPDATE ON public.user_login FOR EACH ROW EXECUTE FUNCTION public.set_last_updated_stamp();


--
-- TOC entry 2833 (class 2606 OID 28556)
-- Name: application application_application_module; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.application
    ADD CONSTRAINT application_application_module FOREIGN KEY (module_id) REFERENCES public.application(application_id);


--
-- TOC entry 2832 (class 2606 OID 28551)
-- Name: application application_application_type; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.application
    ADD CONSTRAINT application_application_type FOREIGN KEY (application_type_id) REFERENCES public.application_type(application_type_id);


--
-- TOC entry 2834 (class 2606 OID 28561)
-- Name: application application_permission; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.application
    ADD CONSTRAINT application_permission FOREIGN KEY (permission_id) REFERENCES public.security_permission(permission_id);


--
-- TOC entry 2836 (class 2606 OID 28584)
-- Name: book_author book_author_author_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_author
    ADD CONSTRAINT book_author_author_id_fkey FOREIGN KEY (author_id) REFERENCES public.author(author_id);


--
-- TOC entry 2835 (class 2606 OID 28579)
-- Name: book_author book_author_book_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_author
    ADD CONSTRAINT book_author_book_id_fkey FOREIGN KEY (book_id) REFERENCES public.book(book_id);


--
-- TOC entry 2838 (class 2606 OID 28686)
-- Name: user_register fk_user_register_status_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_register
    ADD CONSTRAINT fk_user_register_status_id FOREIGN KEY (status_id) REFERENCES public.status_item(status_id);


--
-- TOC entry 2828 (class 2606 OID 28759)
-- Name: party party_c_user_login; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party
    ADD CONSTRAINT party_c_user_login FOREIGN KEY (created_by_user_login) REFERENCES public.user_login(user_login_id);


--
-- TOC entry 2827 (class 2606 OID 28754)
-- Name: party party_m_user_login; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party
    ADD CONSTRAINT party_m_user_login FOREIGN KEY (last_modified_by_user_login) REFERENCES public.user_login(user_login_id);


--
-- TOC entry 2826 (class 2606 OID 28472)
-- Name: party party_pty_typ; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party
    ADD CONSTRAINT party_pty_typ FOREIGN KEY (party_type_id) REFERENCES public.party_type(party_type_id);


--
-- TOC entry 2825 (class 2606 OID 28467)
-- Name: party party_status_item; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party
    ADD CONSTRAINT party_status_item FOREIGN KEY (status_id) REFERENCES public.status(status_id);


--
-- TOC entry 2824 (class 2606 OID 28452)
-- Name: party_type party_type_par; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party_type
    ADD CONSTRAINT party_type_par FOREIGN KEY (parent_type_id) REFERENCES public.party_type(party_type_id);


--
-- TOC entry 2829 (class 2606 OID 28483)
-- Name: person person_party; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT person_party FOREIGN KEY (party_id) REFERENCES public.party(party_id);


--
-- TOC entry 2830 (class 2606 OID 28512)
-- Name: security_group_permission sec_grp_perm_grp; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.security_group_permission
    ADD CONSTRAINT sec_grp_perm_grp FOREIGN KEY (group_id) REFERENCES public.security_group(group_id);


--
-- TOC entry 2831 (class 2606 OID 28517)
-- Name: security_group_permission sec_grp_perm_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.security_group_permission
    ADD CONSTRAINT sec_grp_perm_perm FOREIGN KEY (permission_id) REFERENCES public.security_permission(permission_id);


--
-- TOC entry 2837 (class 2606 OID 28661)
-- Name: status_item status_item_to_type; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.status_item
    ADD CONSTRAINT status_item_to_type FOREIGN KEY (status_type_id) REFERENCES public.status_type(status_type_id);


--
-- TOC entry 2823 (class 2606 OID 28431)
-- Name: status status_to_type; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.status
    ADD CONSTRAINT status_to_type FOREIGN KEY (status_type_id) REFERENCES public.status_type(status_type_id);


--
-- TOC entry 2822 (class 2606 OID 28417)
-- Name: status_type status_type_parent; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.status_type
    ADD CONSTRAINT status_type_parent FOREIGN KEY (parent_type_id) REFERENCES public.status_type(status_type_id);


--
-- TOC entry 2839 (class 2606 OID 28712)
-- Name: user_login user_party; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_login
    ADD CONSTRAINT user_party FOREIGN KEY (party_id) REFERENCES public.party(party_id);


--
-- TOC entry 2840 (class 2606 OID 28744)
-- Name: user_login_security_group user_secgrp_grp; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_login_security_group
    ADD CONSTRAINT user_secgrp_grp FOREIGN KEY (group_id) REFERENCES public.security_group(group_id);


--
-- TOC entry 2841 (class 2606 OID 28749)
-- Name: user_login_security_group user_secgrp_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_login_security_group
    ADD CONSTRAINT user_secgrp_user FOREIGN KEY (user_login_id) REFERENCES public.user_login(user_login_id);


--
-- TOC entry 3000 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2020-10-13 22:31:53

--
-- PostgreSQL database dump complete
--

