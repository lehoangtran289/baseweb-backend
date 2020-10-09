--
-- PostgreSQL database dump
--

-- Dumped from database version 12.2
-- Dumped by pg_dump version 12.2

-- Started on 2020-09-04 21:07:32

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
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 4391 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- TOC entry 362 (class 1255 OID 25431)
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
-- TOC entry 214 (class 1259 OID 23194)
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
-- TOC entry 213 (class 1259 OID 23185)
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
-- TOC entry 348 (class 1259 OID 28129)
-- Name: author; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.author (
    author_id integer NOT NULL,
    author_name character varying(200)
);


ALTER TABLE public.author OWNER TO postgres;

--
-- TOC entry 309 (class 1259 OID 24924)
-- Name: backlog_project; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.backlog_project (
    backlog_project_id character varying(60) NOT NULL,
    backlog_project_name character varying(200),
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone
);


ALTER TABLE public.backlog_project OWNER TO postgres;

--
-- TOC entry 311 (class 1259 OID 24934)
-- Name: backlog_task; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.backlog_task (
    backlog_task_id character varying(60) NOT NULL,
    backlog_task_name character varying(200),
    backlog_task_category_id character varying(60),
    backlog_description text,
    backlog_project_id character varying(60),
    created_date timestamp without time zone,
    created_by_user_login_id character varying(60),
    due_date timestamp without time zone,
    status_id character varying(60),
    priority_id character varying(10),
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone
);


ALTER TABLE public.backlog_task OWNER TO postgres;

--
-- TOC entry 312 (class 1259 OID 24947)
-- Name: backlog_task_assignment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.backlog_task_assignment (
    backlog_task_assignment_id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    backlog_task_id character varying(60),
    assigned_to_party_id uuid NOT NULL,
    start_date timestamp without time zone,
    finished_date timestamp without time zone,
    status_id character varying(60),
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone
);


ALTER TABLE public.backlog_task_assignment OWNER TO postgres;

--
-- TOC entry 310 (class 1259 OID 24929)
-- Name: backlog_task_category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.backlog_task_category (
    backlog_task_category_id character varying(60) NOT NULL,
    backlog_task_category_name character varying(200),
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone
);


ALTER TABLE public.backlog_task_category OWNER TO postgres;

--
-- TOC entry 349 (class 1259 OID 28134)
-- Name: book; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.book (
    book_id integer NOT NULL,
    title character varying(200)
);


ALTER TABLE public.book OWNER TO postgres;

--
-- TOC entry 350 (class 1259 OID 28139)
-- Name: book_author; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.book_author (
    book_id integer,
    author_id integer
);


ALTER TABLE public.book_author OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 23411)
-- Name: commune; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.commune (
    commune_id character varying(60) NOT NULL,
    commune_name character varying(200),
    district_id character varying(60),
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.commune OWNER TO postgres;

--
-- TOC entry 333 (class 1259 OID 25246)
-- Name: cont_container; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cont_container (
    container_id character varying(60) NOT NULL,
    container_type_id character varying(60),
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    container_name character varying(60)
);


ALTER TABLE public.cont_container OWNER TO postgres;

--
-- TOC entry 332 (class 1259 OID 25240)
-- Name: cont_container_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cont_container_type (
    container_type_id character varying(60) NOT NULL,
    description character varying(200),
    unit integer,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.cont_container_type OWNER TO postgres;

--
-- TOC entry 338 (class 1259 OID 25296)
-- Name: cont_depot_container; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cont_depot_container (
    depot_container_id character varying(60) NOT NULL,
    depot_container_name character varying(200),
    contact_mech_id uuid NOT NULL,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.cont_depot_container OWNER TO postgres;

--
-- TOC entry 337 (class 1259 OID 25285)
-- Name: cont_depot_trailer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cont_depot_trailer (
    depot_trailer_id character varying(60) NOT NULL,
    depot_trailer_name character varying(200),
    contact_mech_id uuid NOT NULL,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.cont_depot_trailer OWNER TO postgres;

--
-- TOC entry 336 (class 1259 OID 25274)
-- Name: cont_depot_truck; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cont_depot_truck (
    depot_truck_id character varying(60) NOT NULL,
    depot_truck_name character varying(200),
    contact_mech_id uuid NOT NULL,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.cont_depot_truck OWNER TO postgres;

--
-- TOC entry 335 (class 1259 OID 25263)
-- Name: cont_port; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cont_port (
    port_id character varying(60) NOT NULL,
    port_name character varying(60),
    contact_mech_id uuid NOT NULL,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.cont_port OWNER TO postgres;

--
-- TOC entry 343 (class 1259 OID 25385)
-- Name: cont_request_between_warehouse; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cont_request_between_warehouse (
    request_between_warehouse_id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    container_type_id character varying(60),
    number_containers integer,
    from_facility_id character varying(60),
    early_date_time_expected_from_facility timestamp without time zone,
    late_date_time_expected_from_facility timestamp without time zone,
    has_trailer character varying(1),
    to_facility_id character varying(60),
    early_date_time_expected_to_facility timestamp without time zone,
    late_date_time_expected_to_facility timestamp without time zone,
    leave_trailer character varying(1),
    request_date_time timestamp without time zone,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.cont_request_between_warehouse OWNER TO postgres;

--
-- TOC entry 341 (class 1259 OID 25346)
-- Name: cont_request_export_empty; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cont_request_export_empty (
    request_export_empty_id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    facility_id character varying(60),
    container_type_id character varying(60),
    number_containers integer,
    leave_trailer character varying(1),
    request_date_time timestamp without time zone,
    early_date_time_expected timestamp without time zone,
    late_date_time_expected timestamp without time zone,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    party_customer_id uuid
);


ALTER TABLE public.cont_request_export_empty OWNER TO postgres;

--
-- TOC entry 342 (class 1259 OID 25363)
-- Name: cont_request_export_full; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cont_request_export_full (
    request_export_full_id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    facility_id character varying(60),
    port_id character varying(60),
    container_type_id character varying(60),
    number_containers integer,
    has_trailer character varying(1),
    request_date_time timestamp without time zone,
    early_date_time_expected timestamp without time zone,
    late_date_time_expected timestamp without time zone,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    party_customer_id uuid
);


ALTER TABLE public.cont_request_export_full OWNER TO postgres;

--
-- TOC entry 339 (class 1259 OID 25307)
-- Name: cont_request_import_empty; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cont_request_import_empty (
    request_import_empty_id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    facility_id character varying(60),
    container_type_id character varying(60),
    number_containers integer,
    has_trailer character varying(1),
    request_date_time timestamp without time zone,
    early_date_time_expected timestamp without time zone,
    late_date_time_expected timestamp without time zone,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    party_customer_id uuid
);


ALTER TABLE public.cont_request_import_empty OWNER TO postgres;

--
-- TOC entry 340 (class 1259 OID 25324)
-- Name: cont_request_import_full; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cont_request_import_full (
    request_import_full_id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    facility_id character varying(60),
    port_id character varying(60),
    container_type_id character varying(60),
    number_containers integer,
    leave_trailer character varying(1),
    request_date_time timestamp without time zone,
    early_date_time_expected timestamp without time zone,
    late_date_time_expected timestamp without time zone,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    party_customer_id uuid
);


ALTER TABLE public.cont_request_import_full OWNER TO postgres;

--
-- TOC entry 334 (class 1259 OID 25257)
-- Name: cont_trailer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cont_trailer (
    trailer_id character varying(60) NOT NULL,
    description character varying(200),
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.cont_trailer OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 23494)
-- Name: contact_mech_purpose_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contact_mech_purpose_type (
    contact_mech_purpose_type_id character varying(60) NOT NULL,
    description text,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.contact_mech_purpose_type OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 23316)
-- Name: content; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.content (
    content_id uuid NOT NULL,
    content_type_id character varying(60),
    mime_type character varying(255),
    character_set character varying(100),
    url character varying(255),
    created_at timestamp without time zone,
    last_updated_at timestamp without time zone,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.content OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 23302)
-- Name: content_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.content_type (
    content_type_id character varying(60) NOT NULL,
    parent_type_id character varying(60),
    description character varying(10000),
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.content_type OWNER TO postgres;

--
-- TOC entry 308 (class 1259 OID 24917)
-- Name: current_locations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.current_locations (
    party_id uuid NOT NULL,
    location character varying(255),
    time_point timestamp without time zone,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.current_locations OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 23743)
-- Name: customer_salesman; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customer_salesman (
    customer_salesman_id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    party_customer_id uuid NOT NULL,
    party_salesman_id uuid NOT NULL,
    from_date timestamp without time zone,
    thru_date timestamp without time zone
);


ALTER TABLE public.customer_salesman OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 23759)
-- Name: customer_salesman_vendor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customer_salesman_vendor (
    customer_salesman_vendor_id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    party_customer_id uuid NOT NULL,
    party_salesman_id uuid NOT NULL,
    party_vendor_id uuid NOT NULL,
    from_date timestamp without time zone,
    thru_date timestamp without time zone
);


ALTER TABLE public.customer_salesman_vendor OWNER TO postgres;

--
-- TOC entry 299 (class 1259 OID 24734)
-- Name: delivery_plan; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.delivery_plan (
    delivery_plan_id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    delivery_date timestamp without time zone,
    description text,
    facility_id character varying(60),
    created_by character varying(60),
    status_id character varying(60),
    total_weight_shipment_items numeric,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.delivery_plan OWNER TO postgres;

--
-- TOC entry 302 (class 1259 OID 24786)
-- Name: delivery_plan_solution; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.delivery_plan_solution (
    delivery_plan_id uuid NOT NULL,
    delivery_plan_solution_seq_id character varying(60) NOT NULL,
    status_id character varying(60),
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.delivery_plan_solution OWNER TO postgres;

--
-- TOC entry 303 (class 1259 OID 24802)
-- Name: delivery_trip; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.delivery_trip (
    delivery_trip_id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    delivery_plan_id uuid,
    delivery_plan_solution_seq_id character varying(60),
    vehicle_id character varying(60),
    driver_id uuid,
    execute_date timestamp without time zone,
    distance numeric,
    total_weight numeric,
    total_pallet numeric,
    total_execution_time numeric,
    total_location integer,
    execute_external_vehicle_type_id character varying(60),
    status_id character varying(60),
    completed_delivery_trip_detail_count integer DEFAULT 0,
    delivery_trip_detail_count integer DEFAULT 0,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT now()
);


ALTER TABLE public.delivery_trip OWNER TO postgres;

--
-- TOC entry 304 (class 1259 OID 24844)
-- Name: delivery_trip_detail; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.delivery_trip_detail (
    delivery_trip_detail_id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    delivery_trip_id uuid,
    sequence_id integer,
    shipment_item_id uuid,
    delivery_quantity integer,
    status_id character varying(60),
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT now()
);


ALTER TABLE public.delivery_trip_detail OWNER TO postgres;

--
-- TOC entry 305 (class 1259 OID 24866)
-- Name: delivery_trip_detail_status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.delivery_trip_detail_status (
    delivery_trip_detail_status_id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    delivery_trip_detail_id uuid NOT NULL,
    status_id character varying(60),
    from_date timestamp without time zone,
    thru_date timestamp without time zone,
    updated_by_user_login_id character varying(60),
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT now()
);


ALTER TABLE public.delivery_trip_detail_status OWNER TO postgres;

--
-- TOC entry 306 (class 1259 OID 24888)
-- Name: delivery_trip_status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.delivery_trip_status (
    delivery_trip_status_id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    delivery_trip_id uuid NOT NULL,
    status_id character varying(60),
    from_date timestamp without time zone,
    thru_date timestamp without time zone,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT now()
);


ALTER TABLE public.delivery_trip_status OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 23525)
-- Name: department; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.department (
    department_id character varying(60) NOT NULL,
    department_name character varying(100),
    party_id uuid,
    start_date timestamp without time zone,
    created_by_userlogin_id character varying(255),
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.department OWNER TO postgres;

--
-- TOC entry 344 (class 1259 OID 25472)
-- Name: distance_travel_time_geo_points; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.distance_travel_time_geo_points (
    from_geo_point_id uuid NOT NULL,
    to_geo_point_id uuid NOT NULL,
    distance numeric,
    travel_time numeric,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.distance_travel_time_geo_points OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 23465)
-- Name: distance_travel_time_postal_address; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.distance_travel_time_postal_address (
    from_contact_mech_id uuid NOT NULL,
    to_contact_mech_id uuid NOT NULL,
    distance numeric,
    travel_time numeric,
    travel_time_truck numeric,
    travel_time_motorbike numeric,
    updated_by_user_login_id character varying(60),
    updated_date timestamp without time zone,
    source_enum_id character varying(60),
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.distance_travel_time_postal_address OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 23400)
-- Name: district; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.district (
    district_id character varying(60) NOT NULL,
    district_name character varying(200),
    province_id character varying(60),
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.district OWNER TO postgres;

--
-- TOC entry 316 (class 1259 OID 24983)
-- Name: edu_class; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.edu_class (
    class_id character varying(60) NOT NULL,
    class_name character varying(200),
    course_id character varying(60),
    class_type character varying(60),
    department_id character varying(60),
    semester_id character varying(60),
    session_id character varying(200),
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone
);


ALTER TABLE public.edu_class OWNER TO postgres;

--
-- TOC entry 319 (class 1259 OID 25026)
-- Name: edu_class_teacher_asignment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.edu_class_teacher_asignment (
    class_id character varying(60) NOT NULL,
    teacher_id character varying(60) NOT NULL,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone
);


ALTER TABLE public.edu_class_teacher_asignment OWNER TO postgres;

--
-- TOC entry 314 (class 1259 OID 24973)
-- Name: edu_course; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.edu_course (
    course_id character varying(60) NOT NULL,
    course_name character varying(200),
    credit integer,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone
);


ALTER TABLE public.edu_course OWNER TO postgres;

--
-- TOC entry 318 (class 1259 OID 25011)
-- Name: edu_course_teacher_preference; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.edu_course_teacher_preference (
    course_id character varying(60) NOT NULL,
    teacher_id character varying(60) NOT NULL,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone
);


ALTER TABLE public.edu_course_teacher_preference OWNER TO postgres;

--
-- TOC entry 313 (class 1259 OID 24968)
-- Name: edu_department; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.edu_department (
    department_id character varying(60) NOT NULL,
    department_name character varying(200),
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone
);


ALTER TABLE public.edu_department OWNER TO postgres;

--
-- TOC entry 315 (class 1259 OID 24978)
-- Name: edu_semester; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.edu_semester (
    semester_id character varying(60) NOT NULL,
    semester_name character varying(200),
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone
);


ALTER TABLE public.edu_semester OWNER TO postgres;

--
-- TOC entry 317 (class 1259 OID 25006)
-- Name: edu_teacher; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.edu_teacher (
    teacher_id character varying(60) NOT NULL,
    teacher_name character varying(200),
    email character varying(30),
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone
);


ALTER TABLE public.edu_teacher OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 23260)
-- Name: enumeration; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.enumeration (
    enum_id character varying(60) NOT NULL,
    enum_type_id character varying(60),
    enum_code character varying(60),
    sequence_id character varying(60),
    description text,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.enumeration OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 23246)
-- Name: enumeration_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.enumeration_type (
    enumeration_type_id character varying(60) NOT NULL,
    parent_type_id character varying(60),
    description text,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.enumeration_type OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 23644)
-- Name: facility; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.facility (
    facility_id character varying(60) NOT NULL,
    facility_type_id character varying(60),
    parent_facility_id character varying(60),
    facility_name character varying(100),
    contact_mech_id uuid,
    opened_date timestamp without time zone,
    closed_date timestamp without time zone,
    description text,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.facility OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 23630)
-- Name: facility_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.facility_type (
    facility_type_id character varying(60) NOT NULL,
    parent_type_id character varying(60),
    description text,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.facility_type OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 23422)
-- Name: geo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.geo (
    geo_id character varying(60) NOT NULL,
    geo_type_id character varying(60),
    geo_name character varying(100),
    geo_code character varying(60),
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.geo OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 23433)
-- Name: geo_point; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.geo_point (
    geo_point_id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    longitude character varying(30) NOT NULL,
    latitude character varying(30) NOT NULL,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.geo_point OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 23388)
-- Name: geo_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.geo_type (
    geo_type_id character varying(60) NOT NULL,
    parent_type_id character varying(60),
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.geo_type OWNER TO postgres;

--
-- TOC entry 270 (class 1259 OID 24253)
-- Name: inventory_item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inventory_item (
    inventory_item_id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    product_id character varying(60),
    status_id character varying(60),
    datetime_received timestamp without time zone,
    datetime_manufactured timestamp without time zone,
    expire_date timestamp without time zone,
    activation_valid_thru timestamp without time zone,
    facility_id character varying(60),
    lot_id character varying(60),
    uom_id character varying(60),
    unit_cost numeric(18,6),
    currency_uom_id character varying(60),
    quantity_on_hand_total numeric(18,6),
    available_to_promise_total numeric(18,6),
    description text,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.inventory_item OWNER TO postgres;

--
-- TOC entry 271 (class 1259 OID 24283)
-- Name: inventory_item_detail; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inventory_item_detail (
    inventory_item_detail_id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    inventory_item_id uuid NOT NULL,
    effective_date timestamp without time zone,
    quantity_on_hand_diff numeric(18,6),
    order_id character varying(60),
    order_item_seq_id character varying(60),
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.inventory_item_detail OWNER TO postgres;

--
-- TOC entry 280 (class 1259 OID 24443)
-- Name: invoice; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.invoice (
    invoice_id character varying(60) NOT NULL,
    invoice_type_id character varying(60),
    status_id character varying(60),
    invoice_date timestamp without time zone,
    to_party_customer_id uuid,
    from_vendor_id uuid,
    amount numeric(18,2),
    paid_amount numeric(18,2),
    currency_uom_id character varying(60),
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.invoice OWNER TO postgres;

--
-- TOC entry 281 (class 1259 OID 24474)
-- Name: invoice_item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.invoice_item (
    invoice_id character varying(60) NOT NULL,
    invoice_item_seq_id character varying(60) NOT NULL,
    invoice_item_type_id character varying(60),
    amount numeric(18,2),
    currency_uom_id character varying(60),
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.invoice_item OWNER TO postgres;

--
-- TOC entry 279 (class 1259 OID 24437)
-- Name: invoice_item_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.invoice_item_type (
    invoice_item_type_id character varying(60) NOT NULL,
    description character varying(200),
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.invoice_item_type OWNER TO postgres;

--
-- TOC entry 289 (class 1259 OID 24600)
-- Name: invoice_sequence_id; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.invoice_sequence_id (
    id integer NOT NULL
);


ALTER TABLE public.invoice_sequence_id OWNER TO postgres;

--
-- TOC entry 288 (class 1259 OID 24598)
-- Name: invoice_sequence_id_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.invoice_sequence_id_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.invoice_sequence_id_id_seq OWNER TO postgres;

--
-- TOC entry 4392 (class 0 OID 0)
-- Dependencies: 288
-- Name: invoice_sequence_id_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.invoice_sequence_id_id_seq OWNED BY public.invoice_sequence_id.id;


--
-- TOC entry 283 (class 1259 OID 24511)
-- Name: invoice_status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.invoice_status (
    invoice_status_id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    invoice_id character varying(60),
    status_id character varying(60),
    from_date timestamp without time zone,
    thru_date timestamp without time zone,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.invoice_status OWNER TO postgres;

--
-- TOC entry 278 (class 1259 OID 24431)
-- Name: invoice_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.invoice_type (
    invoice_type_id character varying(60) NOT NULL,
    description character varying(200),
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.invoice_type OWNER TO postgres;

--
-- TOC entry 268 (class 1259 OID 24205)
-- Name: order_adjustment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_adjustment (
    order_adjustment_id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    order_adjustment_type_id character varying(60),
    order_id character varying(60),
    order_item_seq_id character varying(60),
    product_promo_rule_id uuid NOT NULL,
    product_id character varying(60),
    tax_authority_rate_seq_id uuid,
    description text,
    amount numeric(18,3) DEFAULT NULL::numeric,
    quantity integer,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.order_adjustment OWNER TO postgres;

--
-- TOC entry 267 (class 1259 OID 24190)
-- Name: order_adjustment_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_adjustment_type (
    order_adjustment_type_id character varying(60) NOT NULL,
    parent_type_id character varying(60) DEFAULT NULL::character varying,
    description text,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.order_adjustment_type OWNER TO postgres;

--
-- TOC entry 256 (class 1259 OID 23963)
-- Name: order_header; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_header (
    order_id character varying(60) NOT NULL,
    order_type_id character varying(60),
    original_facility_id character varying(60),
    product_store_id character varying(60),
    sales_channel_id character varying(60),
    created_by character varying(60),
    order_date timestamp without time zone,
    currency_uom_id character varying(60),
    ship_to_address_id uuid,
    grand_total numeric(18,2),
    description text,
    exported boolean,
    party_customer_id uuid,
    vendor_id uuid,
    party_salesman_id uuid,
    sale_man_id character varying(60),
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.order_header OWNER TO postgres;

--
-- TOC entry 258 (class 1259 OID 24031)
-- Name: order_item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_item (
    order_id character varying(60) NOT NULL,
    order_item_seq_id character varying(60) NOT NULL,
    order_item_type_id character varying(60),
    product_id character varying(60),
    unit_price numeric,
    quantity integer,
    exported_quantity integer DEFAULT 0,
    status_id character varying(60),
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.order_item OWNER TO postgres;

--
-- TOC entry 282 (class 1259 OID 24490)
-- Name: order_item_billing; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_item_billing (
    order_id character varying(60) NOT NULL,
    order_item_seq_id character varying(60) NOT NULL,
    invoice_id character varying(60) NOT NULL,
    invoice_item_seq_id character varying(60) NOT NULL,
    quantity integer,
    amount numeric(18,2),
    currency_uom_id character varying(60),
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.order_item_billing OWNER TO postgres;

--
-- TOC entry 257 (class 1259 OID 24017)
-- Name: order_item_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_item_type (
    order_item_type_id character varying(60) NOT NULL,
    parent_type_id character varying(60) NOT NULL,
    description text,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.order_item_type OWNER TO postgres;

--
-- TOC entry 259 (class 1259 OID 24061)
-- Name: order_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_role (
    order_id character varying(60) NOT NULL,
    party_id uuid NOT NULL,
    role_type_id character varying(60) NOT NULL,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.order_role OWNER TO postgres;

--
-- TOC entry 347 (class 1259 OID 25520)
-- Name: order_shipment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_shipment (
    order_shipment_id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    order_id character varying(60),
    order_item_seq_id character varying(60),
    shipment_item_id uuid,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.order_shipment OWNER TO postgres;

--
-- TOC entry 260 (class 1259 OID 24082)
-- Name: order_status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_status (
    order_status_id character varying(60) NOT NULL,
    status_id character varying(60),
    order_id character varying(60),
    status_datetime timestamp without time zone,
    status_user_login_id character varying(60),
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.order_status OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 23949)
-- Name: order_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_type (
    order_type_id character varying(60) NOT NULL,
    parent_type_id character varying(60),
    description text,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.order_type OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 23079)
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
-- TOC entry 233 (class 1259 OID 23503)
-- Name: party_contact_mech_purpose; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.party_contact_mech_purpose (
    party_id uuid NOT NULL,
    contact_mech_id uuid NOT NULL,
    contact_mech_purpose_type_id character varying(60) NOT NULL,
    from_date timestamp without time zone NOT NULL,
    thru_date timestamp without time zone,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.party_contact_mech_purpose OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 23558)
-- Name: party_customer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.party_customer (
    party_id uuid NOT NULL,
    customer_code character varying(100),
    customer_name character varying(200),
    status_id character varying(60),
    party_type_id character varying(60),
    description text,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.party_customer OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 23536)
-- Name: party_department; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.party_department (
    party_department_id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    party_id uuid NOT NULL,
    department_id character varying(60),
    role_type_id character varying(60),
    from_date timestamp without time zone,
    thru_date timestamp without time zone,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.party_department OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 23606)
-- Name: party_distributor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.party_distributor (
    party_id uuid NOT NULL,
    distributor_code character varying(100),
    distributor_name character varying(100),
    status_id character varying(60),
    party_type_id character varying(60),
    description text,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.party_distributor OWNER TO postgres;

--
-- TOC entry 297 (class 1259 OID 24700)
-- Name: party_driver; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.party_driver (
    party_id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    status_id character varying(60),
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.party_driver OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 23341)
-- Name: party_relationship; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.party_relationship (
    party_relationship_id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    from_party_id uuid NOT NULL,
    to_party_id uuid NOT NULL,
    role_type_id character varying(60),
    from_date timestamp without time zone,
    thru_date timestamp without time zone,
    description text,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.party_relationship OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 23582)
-- Name: party_retail_outlet; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.party_retail_outlet (
    party_id uuid NOT NULL,
    retail_outlet_code character varying(100),
    retail_outlet_name character varying(200),
    status_id character varying(60),
    party_type_id character varying(60),
    description text,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.party_retail_outlet OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 23731)
-- Name: party_salesman; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.party_salesman (
    party_id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    status_id character varying(60),
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.party_salesman OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 23051)
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
-- TOC entry 286 (class 1259 OID 24540)
-- Name: payment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payment (
    payment_id character varying(60) NOT NULL,
    payment_type_id character varying(60),
    payment_method_id character varying(60),
    from_customer_id uuid,
    to_vendor_id uuid,
    amount numeric(18,2),
    currency_uom_id character varying(60),
    effective_date timestamp without time zone,
    status_id character varying(60),
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.payment OWNER TO postgres;

--
-- TOC entry 287 (class 1259 OID 24576)
-- Name: payment_application; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payment_application (
    payment_application_id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    payment_id character varying(60),
    invoice_id character varying(60),
    applied_amount numeric(18,2),
    currency_uom_id character varying(60),
    effective_date timestamp without time zone,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.payment_application OWNER TO postgres;

--
-- TOC entry 285 (class 1259 OID 24534)
-- Name: payment_method; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payment_method (
    payment_method_id character varying(60) NOT NULL,
    description character varying(200),
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.payment_method OWNER TO postgres;

--
-- TOC entry 291 (class 1259 OID 24608)
-- Name: payment_sequence_id; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payment_sequence_id (
    id integer NOT NULL
);


ALTER TABLE public.payment_sequence_id OWNER TO postgres;

--
-- TOC entry 290 (class 1259 OID 24606)
-- Name: payment_sequence_id_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payment_sequence_id_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.payment_sequence_id_id_seq OWNER TO postgres;

--
-- TOC entry 4393 (class 0 OID 0)
-- Dependencies: 290
-- Name: payment_sequence_id_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payment_sequence_id_id_seq OWNED BY public.payment_sequence_id.id;


--
-- TOC entry 284 (class 1259 OID 24528)
-- Name: payment_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payment_type (
    payment_type_id character varying(60) NOT NULL,
    description character varying(200),
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.payment_type OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 23099)
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
-- TOC entry 321 (class 1259 OID 25047)
-- Name: post_customer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.post_customer (
    post_customer_id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    post_customer_name character varying(200),
    contact_mech_id uuid,
    phone_num character varying(20),
    party_id uuid,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.post_customer OWNER TO postgres;

--
-- TOC entry 323 (class 1259 OID 25094)
-- Name: post_office; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.post_office (
    post_office_id character varying(60) NOT NULL,
    post_office_name character varying(200),
    contact_mech_id uuid NOT NULL,
    post_office_level integer,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.post_office OWNER TO postgres;

--
-- TOC entry 325 (class 1259 OID 25117)
-- Name: post_office_fixed_trip; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.post_office_fixed_trip (
    post_office_fixed_trip_id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    from_post_office_id character varying(60),
    to_post_office_id character varying(60),
    schedule_departure_time character varying(20),
    from_date timestamp without time zone,
    thru_date timestamp without time zone,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.post_office_fixed_trip OWNER TO postgres;

--
-- TOC entry 327 (class 1259 OID 25150)
-- Name: post_office_fixed_trip_execute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.post_office_fixed_trip_execute (
    post_office_fixed_trip_execute_id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    post_office_fixed_trip_id uuid NOT NULL,
    postman_id uuid NOT NULL,
    departure_date_time timestamp without time zone,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.post_office_fixed_trip_execute OWNER TO postgres;

--
-- TOC entry 324 (class 1259 OID 25100)
-- Name: post_office_relationship; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.post_office_relationship (
    post_office_relationship_id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    post_office_id character varying(60),
    parent_post_office_id character varying(60),
    from_date timestamp without time zone,
    thru_date timestamp without time zone,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.post_office_relationship OWNER TO postgres;

--
-- TOC entry 320 (class 1259 OID 25041)
-- Name: post_package_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.post_package_type (
    post_package_type_id character varying(60) NOT NULL,
    post_package_type_name character varying(200),
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.post_package_type OWNER TO postgres;

--
-- TOC entry 322 (class 1259 OID 25064)
-- Name: post_ship_order; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.post_ship_order (
    post_ship_order_id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    from_customer_id uuid NOT NULL,
    to_customer_id uuid NOT NULL,
    package_name character varying(200),
    package_type_id character varying(60),
    weight numeric,
    description text,
    pickup_date timestamp without time zone,
    expected_delivery_date timestamp without time zone,
    status_id character varying(60),
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.post_ship_order OWNER TO postgres;

--
-- TOC entry 330 (class 1259 OID 25206)
-- Name: post_ship_order_fixed_trip_post_office_assignment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.post_ship_order_fixed_trip_post_office_assignment (
    post_ship_order_fixed_trip_post_office_assignment_id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    post_ship_order_id uuid NOT NULL,
    post_office_fixed_trip_execute_id uuid NOT NULL,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.post_ship_order_fixed_trip_post_office_assignment OWNER TO postgres;

--
-- TOC entry 331 (class 1259 OID 25223)
-- Name: post_ship_order_itinerary; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.post_ship_order_itinerary (
    post_ship_order_itinerary_id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    post_ship_order_id uuid NOT NULL,
    post_office_id character varying(60) NOT NULL,
    arrival_date_time timestamp without time zone,
    delivery_fixed_trip_post_office_execute_id uuid,
    departure_date_time timestamp without time zone,
    pickup_fixed_trip_post_office_execute_id uuid,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.post_ship_order_itinerary OWNER TO postgres;

--
-- TOC entry 328 (class 1259 OID 25167)
-- Name: post_ship_order_post_office_assignment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.post_ship_order_post_office_assignment (
    post_ship_order_post_office_assignment_id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    post_ship_order_id uuid NOT NULL,
    post_office_id character varying(60) NOT NULL,
    assigned_date timestamp without time zone,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.post_ship_order_post_office_assignment OWNER TO postgres;

--
-- TOC entry 329 (class 1259 OID 25184)
-- Name: post_ship_order_postman_last_mile_assignment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.post_ship_order_postman_last_mile_assignment (
    post_ship_order_postman_last_mile_assignment_id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    post_ship_order_id uuid NOT NULL,
    postman_id uuid NOT NULL,
    pickup_delivery character varying(1),
    status_id character varying(60),
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.post_ship_order_postman_last_mile_assignment OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 23440)
-- Name: postal_address; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.postal_address (
    contact_mech_id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    location_code character varying(60),
    address character varying(200),
    postal_code character varying(60),
    geo_point_id uuid,
    country_geo_id character varying(60),
    state_province_geo_id character varying(60),
    city character varying(200),
    max_load_weight numeric,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.postal_address OWNER TO postgres;

--
-- TOC entry 326 (class 1259 OID 25134)
-- Name: postman; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.postman (
    postman_id uuid NOT NULL,
    postman_name character varying(200),
    post_office_id character varying(60),
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.postman OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 23682)
-- Name: product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product (
    product_id character varying(60) NOT NULL,
    product_type_id character varying(60),
    product_name character varying(200),
    weight numeric,
    hs_thu integer,
    hs_pal integer,
    introductiondate timestamp without time zone,
    quantity_uom_id character varying(60),
    weight_uom_id character varying(60),
    width_uom_id character varying(60),
    length_uom_id character varying(60),
    height_uom_id character varying(60),
    created_by_user_login_id character varying(60),
    product_transport_category_id character varying(60),
    description text,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.product OWNER TO postgres;

--
-- TOC entry 272 (class 1259 OID 24300)
-- Name: product_facility; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_facility (
    product_id character varying(60) NOT NULL,
    facility_id character varying(60) NOT NULL,
    atp_inventory_count integer,
    last_inventory_count integer,
    description text,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.product_facility OWNER TO postgres;

--
-- TOC entry 269 (class 1259 OID 24236)
-- Name: product_price; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_price (
    product_price_id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    product_id character varying(60) NOT NULL,
    currency_uom_id character varying(60),
    from_date timestamp without time zone,
    thru_date timestamp without time zone,
    tax_in_price character varying(1),
    price numeric(18,3),
    created_by_user_login_id character varying(60),
    created_date timestamp without time zone,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.product_price OWNER TO postgres;

--
-- TOC entry 262 (class 1259 OID 24114)
-- Name: product_promo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_promo (
    product_promo_id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    promo_name character varying(100),
    promo_text character varying(255),
    product_promo_type_id character varying(60),
    from_date timestamp without time zone,
    thru_date timestamp without time zone,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.product_promo OWNER TO postgres;

--
-- TOC entry 264 (class 1259 OID 24145)
-- Name: product_promo_product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_promo_product (
    product_promo_rule_id uuid NOT NULL,
    product_id character varying(60) NOT NULL,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.product_promo_product OWNER TO postgres;

--
-- TOC entry 263 (class 1259 OID 24126)
-- Name: product_promo_rule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_promo_rule (
    product_promo_rule_id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    product_promo_id uuid NOT NULL,
    product_promo_rule_enum_id character varying(60) NOT NULL,
    rule_name character varying(100),
    json_params text,
    last_updated_stamp timestamp with time zone,
    last_updated_tx_stamp timestamp with time zone,
    created_stamp timestamp with time zone,
    created_tx_stamp timestamp with time zone
);


ALTER TABLE public.product_promo_rule OWNER TO postgres;

--
-- TOC entry 261 (class 1259 OID 24103)
-- Name: product_promo_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_promo_type (
    product_promo_type_id character varying(60) NOT NULL,
    parent_type_id character varying(60),
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.product_promo_type OWNER TO postgres;

--
-- TOC entry 346 (class 1259 OID 25501)
-- Name: product_store; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_store (
    product_store_id character varying(60) NOT NULL,
    store_name character varying(100),
    product_store_group_id character varying(60),
    owner_party_id uuid,
    description text,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.product_store OWNER TO postgres;

--
-- TOC entry 345 (class 1259 OID 25492)
-- Name: product_store_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_store_group (
    product_store_group_id character varying(60) NOT NULL,
    description text,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.product_store_group OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 23668)
-- Name: product_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_type (
    product_type_id character varying(60) NOT NULL,
    parent_type_id character varying(60),
    description text,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.product_type OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 23394)
-- Name: province; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.province (
    province_id character varying(60) NOT NULL,
    province_name character varying(200),
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.province OWNER TO postgres;

--
-- TOC entry 246 (class 1259 OID 23780)
-- Name: retail_outlet_salesman_vendor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.retail_outlet_salesman_vendor (
    retail_outlet_salesman_vendor_id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    party_retail_outlet_id uuid NOT NULL,
    party_salesman_id uuid NOT NULL,
    party_vendor_id uuid NOT NULL,
    from_date timestamp without time zone,
    thru_date timestamp without time zone
);


ALTER TABLE public.retail_outlet_salesman_vendor OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 23218)
-- Name: role_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role_type (
    role_type_id character varying(60) NOT NULL,
    parent_type_id character varying(60),
    description text,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.role_type OWNER TO postgres;

--
-- TOC entry 254 (class 1259 OID 23943)
-- Name: sales_channel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sales_channel (
    sales_channel_id character varying(60) NOT NULL,
    sales_channel_name character varying(100),
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.sales_channel OWNER TO postgres;

--
-- TOC entry 248 (class 1259 OID 23807)
-- Name: sales_route_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sales_route_config (
    sales_route_config_id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    visit_frequency_id character varying(10),
    days character varying(60),
    repeat_week integer,
    status_id character varying(60),
    description text,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.sales_route_config OWNER TO postgres;

--
-- TOC entry 250 (class 1259 OID 23846)
-- Name: sales_route_config_customer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sales_route_config_customer (
    sales_route_config_customer_id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    sales_route_planning_period_id uuid NOT NULL,
    sales_route_config_id uuid NOT NULL,
    customer_salesman_vendor_id uuid NOT NULL,
    status_id character varying(60),
    start_execute_week integer,
    number_days_per_week integer,
    repeat_week integer,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.sales_route_config_customer OWNER TO postgres;

--
-- TOC entry 251 (class 1259 OID 23868)
-- Name: sales_route_config_retail_outlet; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sales_route_config_retail_outlet (
    sales_route_config_retail_outlet_id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    sales_route_planning_period_id uuid NOT NULL,
    visit_frequency_id character varying(10),
    sales_route_config_id uuid NOT NULL,
    retail_outlet_salesman_vendor_id uuid NOT NULL,
    status_id character varying(60),
    start_execute_week integer,
    start_execute_date character varying(60),
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.sales_route_config_retail_outlet OWNER TO postgres;

--
-- TOC entry 252 (class 1259 OID 23895)
-- Name: sales_route_detail; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sales_route_detail (
    sales_route_detail_id uuid NOT NULL,
    party_salesman_id uuid NOT NULL,
    party_retail_outlet_id uuid NOT NULL,
    party_distributor_id uuid NOT NULL,
    sequence integer,
    execute_date character varying(60),
    sales_route_config_retail_outlet_id uuid NOT NULL,
    sales_route_planning_period_id uuid,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.sales_route_detail OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 23827)
-- Name: sales_route_planning_period; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sales_route_planning_period (
    sales_route_planning_period_id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    from_date character varying(60),
    to_date character varying(60),
    created_by character varying(60),
    description text,
    status_id character varying(60)
);


ALTER TABLE public.sales_route_planning_period OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 23801)
-- Name: sales_route_visit_frequency; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sales_route_visit_frequency (
    visit_frequency_id character varying(10) NOT NULL,
    description character varying(100),
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.sales_route_visit_frequency OWNER TO postgres;

--
-- TOC entry 253 (class 1259 OID 23926)
-- Name: salesman_checkin_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.salesman_checkin_history (
    salesman_checkin_history_id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    user_login_id character varying(60),
    party_id uuid,
    location character varying(60),
    check_in_action character varying(1),
    time_point timestamp without time zone,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.salesman_checkin_history OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 23135)
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
-- TOC entry 211 (class 1259 OID 23153)
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
-- TOC entry 210 (class 1259 OID 23144)
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
-- TOC entry 274 (class 1259 OID 24333)
-- Name: shipment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shipment (
    shipment_id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    shipment_type_id character varying(60),
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.shipment OWNER TO postgres;

--
-- TOC entry 275 (class 1259 OID 24345)
-- Name: shipment_item; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shipment_item (
    shipment_item_id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    shipment_id uuid NOT NULL,
    quantity integer,
    pallet numeric,
    party_customer_id uuid,
    ship_to_location_id uuid,
    order_id character varying(60),
    order_item_seq_id character varying(60),
    facility_id character varying(60),
    expected_delivery_date timestamp without time zone,
    product_transport_category_id character varying(60),
    status_id character varying(60),
    scheduled_quantity integer DEFAULT 0,
    completed_quantity integer DEFAULT 0,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.shipment_item OWNER TO postgres;

--
-- TOC entry 301 (class 1259 OID 24770)
-- Name: shipment_item_delivery_plan; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shipment_item_delivery_plan (
    delivery_plan_id uuid NOT NULL,
    shipment_item_id uuid NOT NULL,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.shipment_item_delivery_plan OWNER TO postgres;

--
-- TOC entry 277 (class 1259 OID 24409)
-- Name: shipment_item_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shipment_item_role (
    shipment_item_role_id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    shipment_item_id uuid NOT NULL,
    party_id uuid NOT NULL,
    role_type_id character varying(60),
    from_date timestamp without time zone,
    thru_date timestamp without time zone,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.shipment_item_role OWNER TO postgres;

--
-- TOC entry 276 (class 1259 OID 24392)
-- Name: shipment_item_status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shipment_item_status (
    shipment_item_status_id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    shipment_item_id uuid NOT NULL,
    status_id character varying(60),
    from_date timestamp without time zone,
    thru_date timestamp without time zone,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.shipment_item_status OWNER TO postgres;

--
-- TOC entry 273 (class 1259 OID 24319)
-- Name: shipment_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shipment_type (
    shipment_type_id character varying(60) NOT NULL,
    parent_type_id character varying(60),
    description text,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.shipment_type OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 23037)
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
-- TOC entry 216 (class 1259 OID 23232)
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
-- TOC entry 203 (class 1259 OID 23023)
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
-- TOC entry 266 (class 1259 OID 24170)
-- Name: tax_authority_rate_product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tax_authority_rate_product (
    tax_authority_rate_seq_id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    tax_auth_rate_type_id character varying(60),
    product_id character varying(60),
    tax_percentage numeric(18,6),
    from_date timestamp without time zone,
    thru_date timestamp without time zone,
    description text,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.tax_authority_rate_product OWNER TO postgres;

--
-- TOC entry 265 (class 1259 OID 24161)
-- Name: tax_authority_rate_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tax_authority_rate_type (
    tax_auth_rate_type_id character varying(60) NOT NULL,
    description text,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.tax_authority_rate_type OWNER TO postgres;

--
-- TOC entry 307 (class 1259 OID 24905)
-- Name: track_locations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.track_locations (
    track_location_id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    party_id uuid,
    location character varying(255),
    time_point timestamp without time zone,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.track_locations OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 23288)
-- Name: uom; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.uom (
    uom_id character varying(60) NOT NULL,
    uom_type_id character varying(60),
    abbreviation character varying(60),
    description text,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.uom OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 23274)
-- Name: uom_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.uom_type (
    uom_type_id character varying(60) NOT NULL,
    parent_type_id character varying(60),
    description text,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.uom_type OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 23110)
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
-- TOC entry 212 (class 1259 OID 23169)
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
-- TOC entry 351 (class 1259 OID 28152)
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
-- TOC entry 293 (class 1259 OID 24628)
-- Name: vehicle; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vehicle (
    vehicle_id character varying(60) NOT NULL,
    vehicle_type_id character varying(60),
    capacity numeric,
    long integer,
    width integer,
    height integer,
    pallet numeric,
    status_id character varying(60),
    product_transport_category_id character varying(60),
    priority integer,
    maxdistancepertrip integer,
    average_speed integer,
    description text,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.vehicle OWNER TO postgres;

--
-- TOC entry 300 (class 1259 OID 24759)
-- Name: vehicle_delivery_plan; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vehicle_delivery_plan (
    delivery_plan_id uuid NOT NULL,
    vehicle_id character varying(60) NOT NULL,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.vehicle_delivery_plan OWNER TO postgres;

--
-- TOC entry 298 (class 1259 OID 24717)
-- Name: vehicle_driver; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vehicle_driver (
    vehicle_driver_id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    party_driver_id uuid NOT NULL,
    vehicle_id character varying(60),
    from_date timestamp without time zone,
    thru_date timestamp without time zone,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.vehicle_driver OWNER TO postgres;

--
-- TOC entry 295 (class 1259 OID 24667)
-- Name: vehicle_forbidden_geo_point; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vehicle_forbidden_geo_point (
    vehicle_forbidden_geo_point_id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    vehicle_id character varying(60),
    geo_point_id uuid,
    from_date timestamp without time zone,
    thru_date timestamp without time zone,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.vehicle_forbidden_geo_point OWNER TO postgres;

--
-- TOC entry 296 (class 1259 OID 24684)
-- Name: vehicle_location_priority; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vehicle_location_priority (
    vehicle_location_priority_id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    vehicle_id character varying(60),
    contact_mech_id uuid,
    priority integer,
    from_date timestamp without time zone,
    thru_date timestamp without time zone
);


ALTER TABLE public.vehicle_location_priority OWNER TO postgres;

--
-- TOC entry 294 (class 1259 OID 24652)
-- Name: vehicle_maintenance_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vehicle_maintenance_history (
    vehicle_maintenance_history_id uuid DEFAULT public.uuid_generate_v1() NOT NULL,
    vehicle_id character varying(60) NOT NULL,
    maintenance_date timestamp without time zone,
    thru_date timestamp without time zone,
    capacity numeric,
    long integer,
    width integer,
    height integer,
    pallet numeric,
    description text,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.vehicle_maintenance_history OWNER TO postgres;

--
-- TOC entry 292 (class 1259 OID 24614)
-- Name: vehicle_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vehicle_type (
    vehicle_type_id character varying(60) NOT NULL,
    capacity numeric,
    long integer,
    width integer,
    height integer,
    pallet numeric,
    product_transport_category_id character varying(60),
    description text,
    last_updated_stamp timestamp without time zone,
    created_stamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.vehicle_type OWNER TO postgres;

--
-- TOC entry 3453 (class 2604 OID 24603)
-- Name: invoice_sequence_id id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice_sequence_id ALTER COLUMN id SET DEFAULT nextval('public.invoice_sequence_id_id_seq'::regclass);


--
-- TOC entry 3454 (class 2604 OID 24611)
-- Name: payment_sequence_id id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_sequence_id ALTER COLUMN id SET DEFAULT nextval('public.payment_sequence_id_id_seq'::regclass);


--
-- TOC entry 4248 (class 0 OID 23194)
-- Dependencies: 214
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
-- TOC entry 4247 (class 0 OID 23185)
-- Dependencies: 213
-- Data for Name: application_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.application_type VALUES ('MENU', 'Menu application type', '2020-05-09 22:27:45.03032', '2020-05-09 22:27:45.03032');
INSERT INTO public.application_type VALUES ('SCREEN', 'Screen application type', '2020-05-09 22:27:45.03132', '2020-05-09 22:27:45.03132');
INSERT INTO public.application_type VALUES ('MODULE', 'Module application type', '2020-05-09 22:27:45.03332', '2020-05-09 22:27:45.03332');
INSERT INTO public.application_type VALUES ('SERVICE', 'Service application type', '2020-05-09 22:27:45.03432', '2020-05-09 22:27:45.03432');
INSERT INTO public.application_type VALUES ('ENTITY', 'Entity application type', '2020-05-09 22:27:45.035321', '2020-05-09 22:27:45.035321');


--
-- TOC entry 4382 (class 0 OID 28129)
-- Dependencies: 348
-- Data for Name: author; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.author VALUES (1, 'authorA');
INSERT INTO public.author VALUES (2, 'Bthor C');
INSERT INTO public.author VALUES (3, 'Cthen D');
INSERT INTO public.author VALUES (11, 'David Messi');


--
-- TOC entry 4343 (class 0 OID 24924)
-- Dependencies: 309
-- Data for Name: backlog_project; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4345 (class 0 OID 24934)
-- Dependencies: 311
-- Data for Name: backlog_task; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4346 (class 0 OID 24947)
-- Dependencies: 312
-- Data for Name: backlog_task_assignment; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4344 (class 0 OID 24929)
-- Dependencies: 310
-- Data for Name: backlog_task_category; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4383 (class 0 OID 28134)
-- Dependencies: 349
-- Data for Name: book; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.book VALUES (1, 'this is book1');
INSERT INTO public.book VALUES (2, 'this is the book2');
INSERT INTO public.book VALUES (3, 'this is cat book3');


--
-- TOC entry 4384 (class 0 OID 28139)
-- Dependencies: 350
-- Data for Name: book_author; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.book_author VALUES (1, 1);
INSERT INTO public.book_author VALUES (1, 2);
INSERT INTO public.book_author VALUES (2, 2);
INSERT INTO public.book_author VALUES (1, 3);
INSERT INTO public.book_author VALUES (3, 1);
INSERT INTO public.book_author VALUES (3, 2);
INSERT INTO public.book_author VALUES (3, 3);
INSERT INTO public.book_author VALUES (2, 11);


--
-- TOC entry 4261 (class 0 OID 23411)
-- Dependencies: 227
-- Data for Name: commune; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4367 (class 0 OID 25246)
-- Dependencies: 333
-- Data for Name: cont_container; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4366 (class 0 OID 25240)
-- Dependencies: 332
-- Data for Name: cont_container_type; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4372 (class 0 OID 25296)
-- Dependencies: 338
-- Data for Name: cont_depot_container; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4371 (class 0 OID 25285)
-- Dependencies: 337
-- Data for Name: cont_depot_trailer; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4370 (class 0 OID 25274)
-- Dependencies: 336
-- Data for Name: cont_depot_truck; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4369 (class 0 OID 25263)
-- Dependencies: 335
-- Data for Name: cont_port; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4377 (class 0 OID 25385)
-- Dependencies: 343
-- Data for Name: cont_request_between_warehouse; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4375 (class 0 OID 25346)
-- Dependencies: 341
-- Data for Name: cont_request_export_empty; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4376 (class 0 OID 25363)
-- Dependencies: 342
-- Data for Name: cont_request_export_full; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4373 (class 0 OID 25307)
-- Dependencies: 339
-- Data for Name: cont_request_import_empty; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4374 (class 0 OID 25324)
-- Dependencies: 340
-- Data for Name: cont_request_import_full; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4368 (class 0 OID 25257)
-- Dependencies: 334
-- Data for Name: cont_trailer; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4266 (class 0 OID 23494)
-- Dependencies: 232
-- Data for Name: contact_mech_purpose_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.contact_mech_purpose_type VALUES ('SHIPPING_LOCATION', 'Shipping Destination Address', NULL, '2020-05-09 22:27:41.329109');
INSERT INTO public.contact_mech_purpose_type VALUES ('PRIMARY_LOCATION', 'Primary Address', NULL, '2020-05-09 22:27:41.333109');


--
-- TOC entry 4256 (class 0 OID 23316)
-- Dependencies: 222
-- Data for Name: content; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4255 (class 0 OID 23302)
-- Dependencies: 221
-- Data for Name: content_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.content_type VALUES ('DOCUMENT', NULL, 'Document', '2017-01-03 10:11:28.217', '2017-01-03 10:11:28.217');


--
-- TOC entry 4342 (class 0 OID 24917)
-- Dependencies: 308
-- Data for Name: current_locations; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4278 (class 0 OID 23743)
-- Dependencies: 244
-- Data for Name: customer_salesman; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4279 (class 0 OID 23759)
-- Dependencies: 245
-- Data for Name: customer_salesman_vendor; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4333 (class 0 OID 24734)
-- Dependencies: 299
-- Data for Name: delivery_plan; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4336 (class 0 OID 24786)
-- Dependencies: 302
-- Data for Name: delivery_plan_solution; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4337 (class 0 OID 24802)
-- Dependencies: 303
-- Data for Name: delivery_trip; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4338 (class 0 OID 24844)
-- Dependencies: 304
-- Data for Name: delivery_trip_detail; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4339 (class 0 OID 24866)
-- Dependencies: 305
-- Data for Name: delivery_trip_detail_status; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4340 (class 0 OID 24888)
-- Dependencies: 306
-- Data for Name: delivery_trip_status; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4268 (class 0 OID 23525)
-- Dependencies: 234
-- Data for Name: department; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4378 (class 0 OID 25472)
-- Dependencies: 344
-- Data for Name: distance_travel_time_geo_points; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4265 (class 0 OID 23465)
-- Dependencies: 231
-- Data for Name: distance_travel_time_postal_address; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4260 (class 0 OID 23400)
-- Dependencies: 226
-- Data for Name: district; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4350 (class 0 OID 24983)
-- Dependencies: 316
-- Data for Name: edu_class; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4353 (class 0 OID 25026)
-- Dependencies: 319
-- Data for Name: edu_class_teacher_asignment; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4348 (class 0 OID 24973)
-- Dependencies: 314
-- Data for Name: edu_course; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4352 (class 0 OID 25011)
-- Dependencies: 318
-- Data for Name: edu_course_teacher_preference; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4347 (class 0 OID 24968)
-- Dependencies: 313
-- Data for Name: edu_department; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4349 (class 0 OID 24978)
-- Dependencies: 315
-- Data for Name: edu_semester; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4351 (class 0 OID 25006)
-- Dependencies: 317
-- Data for Name: edu_teacher; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4252 (class 0 OID 23260)
-- Dependencies: 218
-- Data for Name: enumeration; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.enumeration VALUES ('PROD_PROMO_DISCOUNT_PERCENTAGE', 'PROD_PROMO_RULE', NULL, NULL, NULL, NULL, '2020-02-15 21:28:45.612');
INSERT INTO public.enumeration VALUES ('KHO', 'PRODUCT_TRANSPORT_CATEGORY', NULL, NULL, NULL, NULL, '2020-03-09 16:01:14.82');
INSERT INTO public.enumeration VALUES ('LANH', 'PRODUCT_TRANSPORT_CATEGORY', NULL, NULL, NULL, NULL, '2020-03-09 16:01:14.82');
INSERT INTO public.enumeration VALUES ('DONG', 'PRODUCT_TRANSPORT_CATEGORY', NULL, NULL, NULL, NULL, '2020-03-09 16:01:14.82');
INSERT INTO public.enumeration VALUES ('GOOGLE', 'DISTANCE_SOURCE', NULL, NULL, NULL, NULL, '2020-03-22 23:55:50.746');
INSERT INTO public.enumeration VALUES ('HAVERSINE', 'DISTANCE_SOURCE', NULL, NULL, NULL, NULL, '2020-03-22 23:55:50.746');
INSERT INTO public.enumeration VALUES ('OPEN_STREET_MAP', 'DISTANCE_SOURCE', NULL, NULL, NULL, NULL, '2020-03-22 23:55:50.746');


--
-- TOC entry 4251 (class 0 OID 23246)
-- Dependencies: 217
-- Data for Name: enumeration_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.enumeration_type VALUES ('PROD_PROMO_RULE', NULL, NULL, NULL, '2020-02-15 21:27:25.628');
INSERT INTO public.enumeration_type VALUES ('PRODUCT_TRANSPORT_CATEGORY', NULL, NULL, NULL, '2020-03-09 15:59:16.836');
INSERT INTO public.enumeration_type VALUES ('DISTANCE_SOURCE', NULL, NULL, NULL, '2020-03-22 23:53:59.1');


--
-- TOC entry 4274 (class 0 OID 23644)
-- Dependencies: 240
-- Data for Name: facility; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.facility VALUES ('FAHN00001', 'WAREHOUSE', NULL, 'Kho Hà Nội', NULL, NULL, NULL, NULL, NULL, '2020-08-15 20:28:46.495666');
INSERT INTO public.facility VALUES ('FAHCM00002', 'WAREHOUSE', NULL, 'Kho HCM', NULL, NULL, NULL, NULL, NULL, '2020-08-15 20:28:46.495666');


--
-- TOC entry 4273 (class 0 OID 23630)
-- Dependencies: 239
-- Data for Name: facility_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.facility_type VALUES ('WAREHOUSE', NULL, 'Warehouse', NULL, '2020-08-15 20:28:46.492666');
INSERT INTO public.facility_type VALUES ('RETAIL_STORE', NULL, 'Retail Store', NULL, '2020-08-15 20:28:46.492666');


--
-- TOC entry 4262 (class 0 OID 23422)
-- Dependencies: 228
-- Data for Name: geo; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4263 (class 0 OID 23433)
-- Dependencies: 229
-- Data for Name: geo_point; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.geo_point VALUES ('c08818e8-4d6d-11ea-967f-54bf64436441', '105.723729', '21.000712', NULL, '2020-02-12 15:00:36.514');
INSERT INTO public.geo_point VALUES ('4b6745f4-4d70-11ea-9682-54bf64436441', '105.780846', '21.052961', NULL, '2020-02-12 15:18:48.495');
INSERT INTO public.geo_point VALUES ('9d0e8cd6-4d71-11ea-9685-54bf64436441', '105.801801', '21.007741', NULL, '2020-02-12 15:28:14.984');


--
-- TOC entry 4258 (class 0 OID 23388)
-- Dependencies: 224
-- Data for Name: geo_type; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4304 (class 0 OID 24253)
-- Dependencies: 270
-- Data for Name: inventory_item; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4305 (class 0 OID 24283)
-- Dependencies: 271
-- Data for Name: inventory_item_detail; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4314 (class 0 OID 24443)
-- Dependencies: 280
-- Data for Name: invoice; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4315 (class 0 OID 24474)
-- Dependencies: 281
-- Data for Name: invoice_item; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4313 (class 0 OID 24437)
-- Dependencies: 279
-- Data for Name: invoice_item_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.invoice_item_type VALUES ('SALES_INVOICE_PRODUCT_ITEM', 'Doanh thu bán hàng hóa sản phẩm', NULL, '2020-05-09 22:26:59.932741');


--
-- TOC entry 4323 (class 0 OID 24600)
-- Dependencies: 289
-- Data for Name: invoice_sequence_id; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4317 (class 0 OID 24511)
-- Dependencies: 283
-- Data for Name: invoice_status; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4312 (class 0 OID 24431)
-- Dependencies: 278
-- Data for Name: invoice_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.invoice_type VALUES ('SALES_INVOICE', 'Hoá đơn bán hàng', NULL, '2020-05-09 22:26:59.929741');


--
-- TOC entry 4302 (class 0 OID 24205)
-- Dependencies: 268
-- Data for Name: order_adjustment; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4301 (class 0 OID 24190)
-- Dependencies: 267
-- Data for Name: order_adjustment_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.order_adjustment_type VALUES ('DISCOUNT_ADJUSTMENT', NULL, NULL, NULL, '2020-08-15 20:28:46.548669');


--
-- TOC entry 4290 (class 0 OID 23963)
-- Dependencies: 256
-- Data for Name: order_header; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4292 (class 0 OID 24031)
-- Dependencies: 258
-- Data for Name: order_item; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4316 (class 0 OID 24490)
-- Dependencies: 282
-- Data for Name: order_item_billing; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4291 (class 0 OID 24017)
-- Dependencies: 257
-- Data for Name: order_item_type; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4293 (class 0 OID 24061)
-- Dependencies: 259
-- Data for Name: order_role; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4381 (class 0 OID 25520)
-- Dependencies: 347
-- Data for Name: order_shipment; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4294 (class 0 OID 24082)
-- Dependencies: 260
-- Data for Name: order_status; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4289 (class 0 OID 23949)
-- Dependencies: 255
-- Data for Name: order_type; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4240 (class 0 OID 23079)
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
-- TOC entry 4267 (class 0 OID 23503)
-- Dependencies: 233
-- Data for Name: party_contact_mech_purpose; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.party_contact_mech_purpose VALUES ('5ae20c48-4d6c-11ea-967e-54bf64436441', 'f581f14a-4d6d-11ea-9680-54bf64436441', 'PRIMARY_LOCATION', '2020-02-12 15:04:40.675', NULL, NULL, '2020-02-12 15:04:40.675');
INSERT INTO public.party_contact_mech_purpose VALUES ('d8d8fb18-4d6f-11ea-9681-54bf64436441', '9bd89006-4d70-11ea-9683-54bf64436441', 'PRIMARY_LOCATION', '2020-02-12 15:21:35.321', NULL, NULL, '2020-02-12 15:21:35.321');
INSERT INTO public.party_contact_mech_purpose VALUES ('5b63a1ea-4d71-11ea-9684-54bf64436441', 'b6a4f66c-4d71-11ea-9686-54bf64436441', 'PRIMARY_LOCATION', '2020-02-12 15:30:03.371', NULL, NULL, '2020-02-12 15:30:03.371');


--
-- TOC entry 4270 (class 0 OID 23558)
-- Dependencies: 236
-- Data for Name: party_customer; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.party_customer VALUES ('8161d37e-4026-11ea-9be3-54bf64436441', NULL, 'Nhà phân phối Sóc Sơn', NULL, NULL, NULL, NULL, '2020-01-26 17:30:54.982');
INSERT INTO public.party_customer VALUES ('875704ac-4026-11ea-9be4-54bf64436441', NULL, 'Nhà phân phối Đông Anh', NULL, NULL, NULL, NULL, '2020-01-26 17:30:54.982');
INSERT INTO public.party_customer VALUES ('5ae20c48-4d6c-11ea-967e-54bf64436441', NULL, 'VinMart Thăng Long A', NULL, NULL, NULL, NULL, '2020-02-12 15:13:10.113');
INSERT INTO public.party_customer VALUES ('d8d8fb18-4d6f-11ea-9681-54bf64436441', NULL, 'VinMart Bắc Từ Liêm', NULL, NULL, NULL, NULL, '2020-02-12 15:18:13.122');
INSERT INTO public.party_customer VALUES ('5b63a1ea-4d71-11ea-9684-54bf64436441', NULL, 'VinMart Trung Hòa', NULL, NULL, NULL, NULL, '2020-02-12 15:27:28.832');


--
-- TOC entry 4269 (class 0 OID 23536)
-- Dependencies: 235
-- Data for Name: party_department; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4272 (class 0 OID 23606)
-- Dependencies: 238
-- Data for Name: party_distributor; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4331 (class 0 OID 24700)
-- Dependencies: 297
-- Data for Name: party_driver; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4257 (class 0 OID 23341)
-- Dependencies: 223
-- Data for Name: party_relationship; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4271 (class 0 OID 23582)
-- Dependencies: 237
-- Data for Name: party_retail_outlet; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4277 (class 0 OID 23731)
-- Dependencies: 243
-- Data for Name: party_salesman; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4239 (class 0 OID 23051)
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
-- TOC entry 4320 (class 0 OID 24540)
-- Dependencies: 286
-- Data for Name: payment; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4321 (class 0 OID 24576)
-- Dependencies: 287
-- Data for Name: payment_application; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4319 (class 0 OID 24534)
-- Dependencies: 285
-- Data for Name: payment_method; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.payment_method VALUES ('CASH', 'Tiền mặt', NULL, '2020-05-09 22:26:59.941741');
INSERT INTO public.payment_method VALUES ('BANK', 'Chuyển khoản', NULL, '2020-05-09 22:26:59.944741');


--
-- TOC entry 4325 (class 0 OID 24608)
-- Dependencies: 291
-- Data for Name: payment_sequence_id; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4318 (class 0 OID 24528)
-- Dependencies: 284
-- Data for Name: payment_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.payment_type VALUES ('CUSTOMER_PAYMENT', 'Khách hàng thanh toán', NULL, '2020-05-09 22:26:59.934741');
INSERT INTO public.payment_type VALUES ('COMPANY_PAYMENT', 'Công ty thanh toán', NULL, '2020-05-09 22:26:59.939741');


--
-- TOC entry 4241 (class 0 OID 23099)
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
-- TOC entry 4355 (class 0 OID 25047)
-- Dependencies: 321
-- Data for Name: post_customer; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4357 (class 0 OID 25094)
-- Dependencies: 323
-- Data for Name: post_office; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4359 (class 0 OID 25117)
-- Dependencies: 325
-- Data for Name: post_office_fixed_trip; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4361 (class 0 OID 25150)
-- Dependencies: 327
-- Data for Name: post_office_fixed_trip_execute; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4358 (class 0 OID 25100)
-- Dependencies: 324
-- Data for Name: post_office_relationship; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4354 (class 0 OID 25041)
-- Dependencies: 320
-- Data for Name: post_package_type; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4356 (class 0 OID 25064)
-- Dependencies: 322
-- Data for Name: post_ship_order; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4364 (class 0 OID 25206)
-- Dependencies: 330
-- Data for Name: post_ship_order_fixed_trip_post_office_assignment; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4365 (class 0 OID 25223)
-- Dependencies: 331
-- Data for Name: post_ship_order_itinerary; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4362 (class 0 OID 25167)
-- Dependencies: 328
-- Data for Name: post_ship_order_post_office_assignment; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4363 (class 0 OID 25184)
-- Dependencies: 329
-- Data for Name: post_ship_order_postman_last_mile_assignment; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4264 (class 0 OID 23440)
-- Dependencies: 230
-- Data for Name: postal_address; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.postal_address VALUES ('f581f14a-4d6d-11ea-9680-54bf64436441', NULL, 'Khu đô thị VinHomes Thăng Long, đại lộ Thăng Long, phố Lê Trọng Tấn, thành phố Hà Nội', NULL, 'c08818e8-4d6d-11ea-967f-54bf64436441', NULL, NULL, NULL, NULL, NULL, '2020-02-12 15:02:05.392');
INSERT INTO public.postal_address VALUES ('9bd89006-4d70-11ea-9683-54bf64436441', NULL, 'Khu B1 Trung tâm thương mại Vincom Plaza Bắc Từ Liêm, CC Green Stars, số 234 Phạm Văn Đồng, phường Cổ nhuế 1, quận Bắc Từ Liêm, thành phố Hà Nội', NULL, '4b6745f4-4d70-11ea-9682-54bf64436441', NULL, NULL, NULL, NULL, NULL, '2020-02-12 15:21:03.456');
INSERT INTO public.postal_address VALUES ('b6a4f66c-4d71-11ea-9686-54bf64436441', NULL, 'Tầng hầm B1, N05, khu đô thị Trung Hòa Nhân Chính, phường Hoàng Đạo Thúy, quận Cầu Giấy, thành phố Hà Nội', NULL, '9d0e8cd6-4d71-11ea-9685-54bf64436441', NULL, NULL, NULL, NULL, NULL, '2020-02-12 15:28:57.913');


--
-- TOC entry 4360 (class 0 OID 25134)
-- Dependencies: 326
-- Data for Name: postman; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4276 (class 0 OID 23682)
-- Dependencies: 242
-- Data for Name: product; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.product VALUES ('20201260001', 'FINISHED_GOOD', 'Nước mắm chinsu', NULL, NULL, NULL, NULL, 'WT_jar', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 20:28:46.504667');
INSERT INTO public.product VALUES ('20201260002', 'FINISHED_GOOD', 'Tương ớt chinsu', NULL, NULL, NULL, NULL, 'WT_jar', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 20:28:46.504667');
INSERT INTO public.product VALUES ('20201260003', 'FINISHED_GOOD', 'Sữa tươi', NULL, NULL, NULL, NULL, 'WT_box', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 20:28:46.504667');
INSERT INTO public.product VALUES ('20201260004', 'FINISHED_GOOD', 'Mỳ koreno', NULL, NULL, NULL, NULL, 'WT_package', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 20:28:46.504667');
INSERT INTO public.product VALUES ('20201260005', 'FINISHED_GOOD', 'Mỳ hảo hảo', NULL, NULL, NULL, NULL, 'WT_package', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 20:28:46.504667');
INSERT INTO public.product VALUES ('20201260006', 'FINISHED_GOOD', 'Mỳ udon', NULL, NULL, NULL, NULL, 'WT_package', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 20:28:46.504667');
INSERT INTO public.product VALUES ('20201260007', 'FINISHED_GOOD', 'Dầu ăn tường an', NULL, NULL, NULL, NULL, 'WT_jar', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 20:28:46.504667');
INSERT INTO public.product VALUES ('20201260008', 'FINISHED_GOOD', 'Dầu ăn hướng dương', NULL, NULL, NULL, NULL, 'WT_jar', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-08-15 20:28:46.504667');


--
-- TOC entry 4306 (class 0 OID 24300)
-- Dependencies: 272
-- Data for Name: product_facility; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4303 (class 0 OID 24236)
-- Dependencies: 269
-- Data for Name: product_price; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4296 (class 0 OID 24114)
-- Dependencies: 262
-- Data for Name: product_promo; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.product_promo VALUES ('4022313c-4ffe-11ea-82dd-54bf64436441', 'CT khuyến mại tết', NULL, 'SALES_PROMO', '2020-02-15 10:00:00', NULL, NULL, '2020-08-15 20:28:46.56767');


--
-- TOC entry 4298 (class 0 OID 24145)
-- Dependencies: 264
-- Data for Name: product_promo_product; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.product_promo_product VALUES ('5c21abae-5000-11ea-82de-54bf64436441', '20201260002', NULL, '2020-08-15 20:28:46.576671');
INSERT INTO public.product_promo_product VALUES ('5c21abae-5000-11ea-82de-54bf64436441', '20201260003', NULL, '2020-08-15 20:28:46.576671');
INSERT INTO public.product_promo_product VALUES ('5c21abae-5000-11ea-82de-54bf64436441', '20201260004', NULL, '2020-08-15 20:28:46.576671');
INSERT INTO public.product_promo_product VALUES ('5c21abae-5000-11ea-82de-54bf64436441', '20201260005', NULL, '2020-08-15 20:28:46.576671');
INSERT INTO public.product_promo_product VALUES ('5c21abae-5000-11ea-82de-54bf64436441', '20201260006', NULL, '2020-08-15 20:28:46.576671');
INSERT INTO public.product_promo_product VALUES ('5c21abae-5000-11ea-82de-54bf64436441', '20201260007', NULL, '2020-08-15 20:28:46.576671');
INSERT INTO public.product_promo_product VALUES ('5c21abae-5000-11ea-82de-54bf64436441', '20201260008', NULL, '2020-08-15 20:28:46.576671');


--
-- TOC entry 4297 (class 0 OID 24126)
-- Dependencies: 263
-- Data for Name: product_promo_rule; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.product_promo_rule VALUES ('5c21abae-5000-11ea-82de-54bf64436441', '4022313c-4ffe-11ea-82dd-54bf64436441', 'PROD_PROMO_DISCOUNT_PERCENTAGE', NULL, '{"discountpercentage":0.05}', NULL, NULL, NULL, NULL);


--
-- TOC entry 4295 (class 0 OID 24103)
-- Dependencies: 261
-- Data for Name: product_promo_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.product_promo_type VALUES ('SALES_PROMO', NULL, NULL, '2020-08-15 20:28:46.544669');


--
-- TOC entry 4380 (class 0 OID 25501)
-- Dependencies: 346
-- Data for Name: product_store; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4379 (class 0 OID 25492)
-- Dependencies: 345
-- Data for Name: product_store_group; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4275 (class 0 OID 23668)
-- Dependencies: 241
-- Data for Name: product_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.product_type VALUES ('FINISHED_GOOD', NULL, 'finished goods', NULL, '2020-05-09 22:27:47.549464');


--
-- TOC entry 4259 (class 0 OID 23394)
-- Dependencies: 225
-- Data for Name: province; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4280 (class 0 OID 23780)
-- Dependencies: 246
-- Data for Name: retail_outlet_salesman_vendor; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4249 (class 0 OID 23218)
-- Dependencies: 215
-- Data for Name: role_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.role_type VALUES ('BILL_TO_CUSTOMER', NULL, 'Hóa đơn đến khách hàng', NULL, '2020-05-09 22:27:47.559465');
INSERT INTO public.role_type VALUES ('SALES_EXECUTIVE', NULL, 'Hóa đơn của nhân viên bán hàng', NULL, '2020-05-09 22:27:47.562465');
INSERT INTO public.role_type VALUES ('CREATE_DELIVERY_TRIP', NULL, 'Tạo chuyến giao hàng', NULL, '2020-05-09 22:27:47.564465');
INSERT INTO public.role_type VALUES ('SALESMAN_SELL_FROM_DISTRIBUTOR', NULL, 'Nhân viên bán hàng bán từ nhà phân phối', NULL, '2020-05-09 22:27:47.573466');
INSERT INTO public.role_type VALUES ('SALESMAN_SELL_TO_RETAIL_OUTLET', NULL, 'Nhân viên bán hàng đến đại lí bán lẻ', NULL, '2020-05-09 22:27:47.575466');
INSERT INTO public.role_type VALUES ('SUPERVISOR_OF_SALESMAN', NULL, 'Giám sát của nhân viên bán hàng', NULL, '2020-05-09 22:27:47.576466');
INSERT INTO public.role_type VALUES ('HEAD_DEPARTMENT', NULL, 'Trưởng phòng', NULL, '2020-05-09 22:27:47.578466');
INSERT INTO public.role_type VALUES ('EMPLOYEE_DEPARTMENT', NULL, 'Nhân viên của phòng', NULL, '2020-05-09 22:27:47.580466');


--
-- TOC entry 4288 (class 0 OID 23943)
-- Dependencies: 254
-- Data for Name: sales_channel; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4282 (class 0 OID 23807)
-- Dependencies: 248
-- Data for Name: sales_route_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sales_route_config VALUES ('956783fc-9209-11ea-8c14-cf4523728113', 'FW3', '2,4,6', 1, NULL, NULL, NULL, '2020-05-09 22:27:24.707158');
INSERT INTO public.sales_route_config VALUES ('95682046-9209-11ea-8c15-abb3b0fcd149', 'FW2', '2,4', 1, NULL, NULL, NULL, '2020-05-09 22:27:24.707158');
INSERT INTO public.sales_route_config VALUES ('95682047-9209-11ea-8c16-4f3ccbbc25ed', 'FW2', '3,5', 1, NULL, NULL, NULL, '2020-05-09 22:27:24.707158');
INSERT INTO public.sales_route_config VALUES ('95682048-9209-11ea-8c17-0724810d131b', 'FW2', '4,6', 1, NULL, NULL, NULL, '2020-05-09 22:27:24.707158');
INSERT INTO public.sales_route_config VALUES ('95684756-9209-11ea-8c18-1f668ca92d6c', 'F2W', '4', 2, NULL, NULL, NULL, '2020-05-09 22:27:24.707158');
INSERT INTO public.sales_route_config VALUES ('95684757-9209-11ea-8c19-a3e8fdfde095', 'F3W', '5', 3, NULL, NULL, NULL, '2020-05-09 22:27:24.707158');
INSERT INTO public.sales_route_config VALUES ('95684758-9209-11ea-8c1a-6bb0c77e798f', 'F4W', '6', 4, NULL, NULL, NULL, '2020-05-09 22:27:24.707158');
INSERT INTO public.sales_route_config VALUES ('9a7d031c-9209-11ea-8c1b-53ae917a72ae', 'FW3', '2,4,6', 1, NULL, NULL, NULL, '2020-05-09 22:27:33.246646');
INSERT INTO public.sales_route_config VALUES ('9a7d2a2c-9209-11ea-8c1c-cf56ebcfbc9e', 'FW2', '2,4', 1, NULL, NULL, NULL, '2020-05-09 22:27:33.246646');
INSERT INTO public.sales_route_config VALUES ('9a7d2a2d-9209-11ea-8c1d-4b136ef7a012', 'FW2', '3,5', 1, NULL, NULL, NULL, '2020-05-09 22:27:33.246646');
INSERT INTO public.sales_route_config VALUES ('9a7d513c-9209-11ea-8c1e-3b637fc3f8d4', 'FW2', '4,6', 1, NULL, NULL, NULL, '2020-05-09 22:27:33.246646');
INSERT INTO public.sales_route_config VALUES ('9a7d513d-9209-11ea-8c1f-438c4a6f96df', 'F2W', '4', 2, NULL, NULL, NULL, '2020-05-09 22:27:33.246646');
INSERT INTO public.sales_route_config VALUES ('9a7d513e-9209-11ea-8c20-0bb5f51e53ed', 'F3W', '5', 3, NULL, NULL, NULL, '2020-05-09 22:27:33.246646');
INSERT INTO public.sales_route_config VALUES ('9a7d784c-9209-11ea-8c21-cbceeb3c2fb1', 'F4W', '6', 4, NULL, NULL, NULL, '2020-05-09 22:27:33.246646');
INSERT INTO public.sales_route_config VALUES ('9c7ea706-9209-11ea-8c22-630f6ee6a8a4', 'FW3', '2,4,6', 1, NULL, NULL, NULL, '2020-05-09 22:27:36.611839');
INSERT INTO public.sales_route_config VALUES ('9c7ece16-9209-11ea-8c23-d3922c8eda43', 'FW2', '2,4', 1, NULL, NULL, NULL, '2020-05-09 22:27:36.611839');
INSERT INTO public.sales_route_config VALUES ('9c7ece17-9209-11ea-8c24-17a25423345f', 'FW2', '3,5', 1, NULL, NULL, NULL, '2020-05-09 22:27:36.611839');
INSERT INTO public.sales_route_config VALUES ('9c7ef526-9209-11ea-8c25-dfe1f4a5055b', 'FW2', '4,6', 1, NULL, NULL, NULL, '2020-05-09 22:27:36.611839');
INSERT INTO public.sales_route_config VALUES ('9c7ef527-9209-11ea-8c26-db46b6437156', 'F2W', '4', 2, NULL, NULL, NULL, '2020-05-09 22:27:36.611839');
INSERT INTO public.sales_route_config VALUES ('9c7f1c36-9209-11ea-8c27-378573d8f56c', 'F3W', '5', 3, NULL, NULL, NULL, '2020-05-09 22:27:36.611839');
INSERT INTO public.sales_route_config VALUES ('9c7f1c37-9209-11ea-8c28-cbb7041684e7', 'F4W', '6', 4, NULL, NULL, NULL, '2020-05-09 22:27:36.611839');
INSERT INTO public.sales_route_config VALUES ('657a0112-defb-11ea-9a42-c7551487e6a1', 'FW3', '2,4,6', 1, NULL, NULL, NULL, '2020-08-15 20:29:50.881349');
INSERT INTO public.sales_route_config VALUES ('657a9d52-defb-11ea-9a43-8b78db8aa477', 'FW2', '2,4', 1, NULL, NULL, NULL, '2020-08-15 20:29:50.881349');
INSERT INTO public.sales_route_config VALUES ('657ac462-defb-11ea-9a44-ffc049f7e7a4', 'FW2', '3,5', 1, NULL, NULL, NULL, '2020-08-15 20:29:50.881349');
INSERT INTO public.sales_route_config VALUES ('657aeb72-defb-11ea-9a45-d7f8acc781f6', 'FW2', '4,6', 1, NULL, NULL, NULL, '2020-08-15 20:29:50.881349');
INSERT INTO public.sales_route_config VALUES ('657aeb73-defb-11ea-9a46-cfb95eded70f', 'F2W', '4', 2, NULL, NULL, NULL, '2020-08-15 20:29:50.881349');
INSERT INTO public.sales_route_config VALUES ('657b128c-defb-11ea-9a47-df6d29033df9', 'F3W', '5', 3, NULL, NULL, NULL, '2020-08-15 20:29:50.881349');
INSERT INTO public.sales_route_config VALUES ('657b128d-defb-11ea-9a48-fbd4cfb86dd9', 'F4W', '6', 4, NULL, NULL, NULL, '2020-08-15 20:29:50.881349');


--
-- TOC entry 4284 (class 0 OID 23846)
-- Dependencies: 250
-- Data for Name: sales_route_config_customer; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4285 (class 0 OID 23868)
-- Dependencies: 251
-- Data for Name: sales_route_config_retail_outlet; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4286 (class 0 OID 23895)
-- Dependencies: 252
-- Data for Name: sales_route_detail; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4283 (class 0 OID 23827)
-- Dependencies: 249
-- Data for Name: sales_route_planning_period; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4281 (class 0 OID 23801)
-- Dependencies: 247
-- Data for Name: sales_route_visit_frequency; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sales_route_visit_frequency VALUES ('FW1', '1 tuần thăm 1 lần', NULL, '2020-05-09 22:27:24.703158');
INSERT INTO public.sales_route_visit_frequency VALUES ('FW2', '1 tuần thăm 2 lần', NULL, '2020-05-09 22:27:24.703158');
INSERT INTO public.sales_route_visit_frequency VALUES ('FW3', '1 tuần thăm 3 lần', NULL, '2020-05-09 22:27:24.703158');
INSERT INTO public.sales_route_visit_frequency VALUES ('FW4', '1 tuần thăm 4 lần', NULL, '2020-05-09 22:27:24.703158');
INSERT INTO public.sales_route_visit_frequency VALUES ('FW5', '1 tuần thăm 5 lần', NULL, '2020-05-09 22:27:24.703158');
INSERT INTO public.sales_route_visit_frequency VALUES ('FW6', '1 tuần thăm 6 lần', NULL, '2020-05-09 22:27:24.703158');
INSERT INTO public.sales_route_visit_frequency VALUES ('FW7', '1 tuần thăm 7 lần', NULL, '2020-05-09 22:27:24.703158');
INSERT INTO public.sales_route_visit_frequency VALUES ('F2W', '2 tuần thăm 1 lần', NULL, '2020-05-09 22:27:24.703158');
INSERT INTO public.sales_route_visit_frequency VALUES ('F3W', '3 tuần thăm 1 lần', NULL, '2020-05-09 22:27:24.703158');
INSERT INTO public.sales_route_visit_frequency VALUES ('F4W', '4 tuần thăm 1 lần', NULL, '2020-05-09 22:27:24.703158');


--
-- TOC entry 4287 (class 0 OID 23926)
-- Dependencies: 253
-- Data for Name: salesman_checkin_history; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4243 (class 0 OID 23135)
-- Dependencies: 209
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
-- TOC entry 4245 (class 0 OID 23153)
-- Dependencies: 211
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
-- TOC entry 4244 (class 0 OID 23144)
-- Dependencies: 210
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
-- TOC entry 4308 (class 0 OID 24333)
-- Dependencies: 274
-- Data for Name: shipment; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4309 (class 0 OID 24345)
-- Dependencies: 275
-- Data for Name: shipment_item; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4335 (class 0 OID 24770)
-- Dependencies: 301
-- Data for Name: shipment_item_delivery_plan; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4311 (class 0 OID 24409)
-- Dependencies: 277
-- Data for Name: shipment_item_role; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4310 (class 0 OID 24392)
-- Dependencies: 276
-- Data for Name: shipment_item_status; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4307 (class 0 OID 24319)
-- Dependencies: 273
-- Data for Name: shipment_type; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4238 (class 0 OID 23037)
-- Dependencies: 204
-- Data for Name: status; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.status VALUES ('SINGLE', 'MARRY_STATUS', 'SINGLE', '0', 'Độc thân', '2020-05-09 22:27:44.944315', '2020-05-09 22:27:44.944315');
INSERT INTO public.status VALUES ('MARRIED', 'MARRY_STATUS', 'MARRIED', '0', 'Đã kết hôn', '2020-05-09 22:27:44.950316', '2020-05-09 22:27:44.950316');
INSERT INTO public.status VALUES ('DIVORCED', 'MARRY_STATUS', 'DIVORCED', '0', 'Đã ly dị', '2020-05-09 22:27:44.953316', '2020-05-09 22:27:44.953316');
INSERT INTO public.status VALUES ('PARTY_ENABLED', 'PARTY_STATUS', 'ENABLED', '0', 'Đã kích hoạt', '2020-05-09 22:27:44.956316', '2020-05-09 22:27:44.956316');
INSERT INTO public.status VALUES ('PARTY_DISABLED', 'PARTY_STATUS', 'DISABLED', '0', 'Đã bị vô hiệu hóa', '2020-05-09 22:27:44.959316', '2020-05-09 22:27:44.959316');


--
-- TOC entry 4250 (class 0 OID 23232)
-- Dependencies: 216
-- Data for Name: status_item; Type: TABLE DATA; Schema: public; Owner: postgres
--

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
INSERT INTO public.status_item VALUES ('USER_REGISTERED', 'USER_STATUS', 'REGISTERED', 'Đã đăng ký', NULL, '2020-09-03 11:47:11.315541');
INSERT INTO public.status_item VALUES ('USER_APPROVED', 'USER_STATUS', 'APPROVED', 'Đã phê duyệt', NULL, '2020-09-03 11:47:11.315541');


--
-- TOC entry 4237 (class 0 OID 23023)
-- Dependencies: 203
-- Data for Name: status_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.status_type VALUES ('ORDER_STATUS', NULL, 'Order Status', NULL, '2020-02-01 21:35:10.048');
INSERT INTO public.status_type VALUES ('DELIVERY_STATUS', NULL, 'Delivery status', NULL, '2020-03-08 08:43:46.697');
INSERT INTO public.status_type VALUES ('PARTY_STATUS', NULL, 'Party status', '2020-05-09 22:27:44.930314', '2020-05-09 22:27:44.930314');
INSERT INTO public.status_type VALUES ('MARRY_STATUS', NULL, 'Marry status', '2020-05-09 22:27:44.934315', '2020-05-09 22:27:44.934315');
INSERT INTO public.status_type VALUES ('SERVICE_STATUS', NULL, 'Service status', '2020-05-09 22:27:44.936315', '2020-05-09 22:27:44.936315');
INSERT INTO public.status_type VALUES ('INVOICE_STATUS', NULL, 'invoice Status', '2020-05-09 22:27:44.938315', '2020-05-09 22:27:44.938315');
INSERT INTO public.status_type VALUES ('USER_STATUS', NULL, 'users status', NULL, '2020-09-03 11:47:10.043468');


--
-- TOC entry 4300 (class 0 OID 24170)
-- Dependencies: 266
-- Data for Name: tax_authority_rate_product; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4299 (class 0 OID 24161)
-- Dependencies: 265
-- Data for Name: tax_authority_rate_type; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4341 (class 0 OID 24905)
-- Dependencies: 307
-- Data for Name: track_locations; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.track_locations VALUES ('fbd859cf-bdd9-4cf2-a279-d01966eb7014', 'bd6322f2-2121-11ea-81a8-979e2f76b5a4', '21.4378,105.8773', '2020-08-14 15:11:05.973', NULL, NULL);
INSERT INTO public.track_locations VALUES ('58fe79c2-0bc6-4630-b329-c1c28177387e', 'bd6322f2-2121-11ea-81a8-979e2f76b5a4', '21.429,105.9411', '2020-08-14 15:12:17', NULL, NULL);


--
-- TOC entry 4254 (class 0 OID 23288)
-- Dependencies: 220
-- Data for Name: uom; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.uom VALUES ('WT_kg', 'WEIGHT_MEASURE', NULL, 'Kg', NULL, '2020-05-09 22:27:47.555465');
INSERT INTO public.uom VALUES ('WT_g', 'WEIGHT_MEASURE', NULL, 'g', NULL, '2020-05-09 22:27:47.555465');
INSERT INTO public.uom VALUES ('WT_package', 'UNIT_MEASURE', NULL, 'gói', NULL, '2020-05-09 22:27:47.555465');
INSERT INTO public.uom VALUES ('WT_box', 'UNIT_MEASURE', NULL, 'hộp', NULL, '2020-05-09 22:27:47.555465');
INSERT INTO public.uom VALUES ('WT_jar', 'UNIT_MEASURE', NULL, 'lọ', NULL, '2020-05-09 22:27:47.555465');
INSERT INTO public.uom VALUES ('CUR_vnd', 'CURRENCY_MEASURE', NULL, 'VND', NULL, '2020-05-09 22:27:47.555465');


--
-- TOC entry 4253 (class 0 OID 23274)
-- Dependencies: 219
-- Data for Name: uom_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.uom_type VALUES ('WEIGHT_MEASURE', NULL, 'Weight', NULL, '2020-05-09 22:27:47.551464');
INSERT INTO public.uom_type VALUES ('LENGTH_MEASURE', NULL, 'Length', NULL, '2020-05-09 22:27:47.551464');
INSERT INTO public.uom_type VALUES ('UNIT_MEASURE', NULL, 'Unit', NULL, '2020-05-09 22:27:47.551464');
INSERT INTO public.uom_type VALUES ('CURRENCY_MEASURE', NULL, 'Currency Measure', NULL, '2020-05-09 22:27:47.551464');


--
-- TOC entry 4242 (class 0 OID 23110)
-- Dependencies: 208
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
-- TOC entry 4246 (class 0 OID 23169)
-- Dependencies: 212
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
-- TOC entry 4385 (class 0 OID 28152)
-- Dependencies: 351
-- Data for Name: user_register; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4327 (class 0 OID 24628)
-- Dependencies: 293
-- Data for Name: vehicle; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4334 (class 0 OID 24759)
-- Dependencies: 300
-- Data for Name: vehicle_delivery_plan; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4332 (class 0 OID 24717)
-- Dependencies: 298
-- Data for Name: vehicle_driver; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4329 (class 0 OID 24667)
-- Dependencies: 295
-- Data for Name: vehicle_forbidden_geo_point; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4330 (class 0 OID 24684)
-- Dependencies: 296
-- Data for Name: vehicle_location_priority; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4328 (class 0 OID 24652)
-- Dependencies: 294
-- Data for Name: vehicle_maintenance_history; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4326 (class 0 OID 24614)
-- Dependencies: 292
-- Data for Name: vehicle_type; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4394 (class 0 OID 0)
-- Dependencies: 288
-- Name: invoice_sequence_id_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.invoice_sequence_id_id_seq', 1, false);


--
-- TOC entry 4395 (class 0 OID 0)
-- Dependencies: 290
-- Name: payment_sequence_id_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payment_sequence_id_id_seq', 1, false);


--
-- TOC entry 3819 (class 2606 OID 28133)
-- Name: author author_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.author
    ADD CONSTRAINT author_pkey PRIMARY KEY (author_id);


--
-- TOC entry 3821 (class 2606 OID 28138)
-- Name: book book_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book
    ADD CONSTRAINT book_pkey PRIMARY KEY (book_id);


--
-- TOC entry 3811 (class 2606 OID 25491)
-- Name: distance_travel_time_geo_points distance_travel_time_geo_points_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.distance_travel_time_geo_points
    ADD CONSTRAINT distance_travel_time_geo_points_pk PRIMARY KEY (from_geo_point_id, to_geo_point_id);


--
-- TOC entry 3702 (class 2606 OID 24605)
-- Name: invoice_sequence_id invoice_sequence_id_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice_sequence_id
    ADD CONSTRAINT invoice_sequence_id_pkey PRIMARY KEY (id);


--
-- TOC entry 3704 (class 2606 OID 24613)
-- Name: payment_sequence_id payment_sequence_id_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_sequence_id
    ADD CONSTRAINT payment_sequence_id_pkey PRIMARY KEY (id);


--
-- TOC entry 3554 (class 2606 OID 23202)
-- Name: application pk_application; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.application
    ADD CONSTRAINT pk_application PRIMARY KEY (application_id);


--
-- TOC entry 3552 (class 2606 OID 23193)
-- Name: application_type pk_application_type; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.application_type
    ADD CONSTRAINT pk_application_type PRIMARY KEY (application_type_id);


--
-- TOC entry 3740 (class 2606 OID 24928)
-- Name: backlog_project pk_backlog_project; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backlog_project
    ADD CONSTRAINT pk_backlog_project PRIMARY KEY (backlog_project_id);


--
-- TOC entry 3744 (class 2606 OID 24941)
-- Name: backlog_task pk_backlog_task; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backlog_task
    ADD CONSTRAINT pk_backlog_task PRIMARY KEY (backlog_task_id);


--
-- TOC entry 3746 (class 2606 OID 24952)
-- Name: backlog_task_assignment pk_backlog_task_assignment; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backlog_task_assignment
    ADD CONSTRAINT pk_backlog_task_assignment PRIMARY KEY (backlog_task_assignment_id);


--
-- TOC entry 3742 (class 2606 OID 24933)
-- Name: backlog_task_category pk_backlog_task_category; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backlog_task_category
    ADD CONSTRAINT pk_backlog_task_category PRIMARY KEY (backlog_task_category_id);


--
-- TOC entry 3760 (class 2606 OID 25030)
-- Name: edu_class_teacher_asignment pk_class_teacher_assignment; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.edu_class_teacher_asignment
    ADD CONSTRAINT pk_class_teacher_assignment PRIMARY KEY (class_id, teacher_id);


--
-- TOC entry 3580 (class 2606 OID 23416)
-- Name: commune pk_commune; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commune
    ADD CONSTRAINT pk_commune PRIMARY KEY (commune_id);


--
-- TOC entry 3788 (class 2606 OID 25251)
-- Name: cont_container pk_cont_container; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cont_container
    ADD CONSTRAINT pk_cont_container PRIMARY KEY (container_id);


--
-- TOC entry 3786 (class 2606 OID 25245)
-- Name: cont_container_type pk_cont_container_type; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cont_container_type
    ADD CONSTRAINT pk_cont_container_type PRIMARY KEY (container_type_id);


--
-- TOC entry 3798 (class 2606 OID 25301)
-- Name: cont_depot_container pk_cont_depot_container; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cont_depot_container
    ADD CONSTRAINT pk_cont_depot_container PRIMARY KEY (depot_container_id);


--
-- TOC entry 3796 (class 2606 OID 25290)
-- Name: cont_depot_trailer pk_cont_depot_trailer; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cont_depot_trailer
    ADD CONSTRAINT pk_cont_depot_trailer PRIMARY KEY (depot_trailer_id);


--
-- TOC entry 3794 (class 2606 OID 25279)
-- Name: cont_depot_truck pk_cont_depot_truck; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cont_depot_truck
    ADD CONSTRAINT pk_cont_depot_truck PRIMARY KEY (depot_truck_id);


--
-- TOC entry 3792 (class 2606 OID 25268)
-- Name: cont_port pk_cont_port; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cont_port
    ADD CONSTRAINT pk_cont_port PRIMARY KEY (port_id);


--
-- TOC entry 3808 (class 2606 OID 25391)
-- Name: cont_request_between_warehouse pk_cont_request_between_warehouse; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cont_request_between_warehouse
    ADD CONSTRAINT pk_cont_request_between_warehouse PRIMARY KEY (request_between_warehouse_id);


--
-- TOC entry 3804 (class 2606 OID 25352)
-- Name: cont_request_export_empty pk_cont_request_export_empty; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cont_request_export_empty
    ADD CONSTRAINT pk_cont_request_export_empty PRIMARY KEY (request_export_empty_id);


--
-- TOC entry 3806 (class 2606 OID 25369)
-- Name: cont_request_export_full pk_cont_request_export_full; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cont_request_export_full
    ADD CONSTRAINT pk_cont_request_export_full PRIMARY KEY (request_export_full_id);


--
-- TOC entry 3800 (class 2606 OID 25313)
-- Name: cont_request_import_empty pk_cont_request_import_empty; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cont_request_import_empty
    ADD CONSTRAINT pk_cont_request_import_empty PRIMARY KEY (request_import_empty_id);


--
-- TOC entry 3802 (class 2606 OID 25330)
-- Name: cont_request_import_full pk_cont_request_import_full; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cont_request_import_full
    ADD CONSTRAINT pk_cont_request_import_full PRIMARY KEY (request_import_full_id);


--
-- TOC entry 3590 (class 2606 OID 23502)
-- Name: contact_mech_purpose_type pk_contact_mech_purpose_type; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contact_mech_purpose_type
    ADD CONSTRAINT pk_contact_mech_purpose_type PRIMARY KEY (contact_mech_purpose_type_id);


--
-- TOC entry 3570 (class 2606 OID 23324)
-- Name: content pk_content; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.content
    ADD CONSTRAINT pk_content PRIMARY KEY (content_id);


--
-- TOC entry 3568 (class 2606 OID 23310)
-- Name: content_type pk_content_type; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.content_type
    ADD CONSTRAINT pk_content_type PRIMARY KEY (content_type_id);


--
-- TOC entry 3738 (class 2606 OID 24922)
-- Name: current_locations pk_current_locations_party_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.current_locations
    ADD CONSTRAINT pk_current_locations_party_id PRIMARY KEY (party_id);


--
-- TOC entry 3614 (class 2606 OID 23748)
-- Name: customer_salesman pk_customer_salesman; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_salesman
    ADD CONSTRAINT pk_customer_salesman PRIMARY KEY (customer_salesman_id);


--
-- TOC entry 3616 (class 2606 OID 23764)
-- Name: customer_salesman_vendor pk_customer_salesman_vendor; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_salesman_vendor
    ADD CONSTRAINT pk_customer_salesman_vendor PRIMARY KEY (customer_salesman_vendor_id);


--
-- TOC entry 3720 (class 2606 OID 24743)
-- Name: delivery_plan pk_delivery_plan; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.delivery_plan
    ADD CONSTRAINT pk_delivery_plan PRIMARY KEY (delivery_plan_id);


--
-- TOC entry 3726 (class 2606 OID 24791)
-- Name: delivery_plan_solution pk_delivery_plan_solution; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.delivery_plan_solution
    ADD CONSTRAINT pk_delivery_plan_solution PRIMARY KEY (delivery_plan_id, delivery_plan_solution_seq_id);


--
-- TOC entry 3728 (class 2606 OID 24813)
-- Name: delivery_trip pk_delivery_trip; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.delivery_trip
    ADD CONSTRAINT pk_delivery_trip PRIMARY KEY (delivery_trip_id);


--
-- TOC entry 3730 (class 2606 OID 24850)
-- Name: delivery_trip_detail pk_delivery_trip_detail; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.delivery_trip_detail
    ADD CONSTRAINT pk_delivery_trip_detail PRIMARY KEY (delivery_trip_detail_id);


--
-- TOC entry 3732 (class 2606 OID 24872)
-- Name: delivery_trip_detail_status pk_delivery_trip_detail_status; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.delivery_trip_detail_status
    ADD CONSTRAINT pk_delivery_trip_detail_status PRIMARY KEY (delivery_trip_detail_status_id);


--
-- TOC entry 3734 (class 2606 OID 24894)
-- Name: delivery_trip_status pk_delivery_trip_status_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.delivery_trip_status
    ADD CONSTRAINT pk_delivery_trip_status_id PRIMARY KEY (delivery_trip_status_id);


--
-- TOC entry 3594 (class 2606 OID 23530)
-- Name: department pk_department; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT pk_department PRIMARY KEY (department_id);


--
-- TOC entry 3588 (class 2606 OID 23473)
-- Name: distance_travel_time_postal_address pk_distance_travel_time_postal_address; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.distance_travel_time_postal_address
    ADD CONSTRAINT pk_distance_travel_time_postal_address PRIMARY KEY (from_contact_mech_id, to_contact_mech_id);


--
-- TOC entry 3578 (class 2606 OID 23405)
-- Name: district pk_district; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.district
    ADD CONSTRAINT pk_district PRIMARY KEY (district_id);


--
-- TOC entry 3754 (class 2606 OID 24990)
-- Name: edu_class pk_edu_class; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.edu_class
    ADD CONSTRAINT pk_edu_class PRIMARY KEY (class_id);


--
-- TOC entry 3750 (class 2606 OID 24977)
-- Name: edu_course pk_edu_course; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.edu_course
    ADD CONSTRAINT pk_edu_course PRIMARY KEY (course_id);


--
-- TOC entry 3758 (class 2606 OID 25015)
-- Name: edu_course_teacher_preference pk_edu_course_teacher_preference; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.edu_course_teacher_preference
    ADD CONSTRAINT pk_edu_course_teacher_preference PRIMARY KEY (course_id, teacher_id);


--
-- TOC entry 3748 (class 2606 OID 24972)
-- Name: edu_department pk_edu_department; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.edu_department
    ADD CONSTRAINT pk_edu_department PRIMARY KEY (department_id);


--
-- TOC entry 3756 (class 2606 OID 25010)
-- Name: edu_teacher pk_edu_teacher; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.edu_teacher
    ADD CONSTRAINT pk_edu_teacher PRIMARY KEY (teacher_id);


--
-- TOC entry 3562 (class 2606 OID 23268)
-- Name: enumeration pk_enum_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enumeration
    ADD CONSTRAINT pk_enum_id PRIMARY KEY (enum_id);


--
-- TOC entry 3560 (class 2606 OID 23254)
-- Name: enumeration_type pk_enumeration_type_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enumeration_type
    ADD CONSTRAINT pk_enumeration_type_id PRIMARY KEY (enumeration_type_id);


--
-- TOC entry 3606 (class 2606 OID 23652)
-- Name: facility pk_facility_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.facility
    ADD CONSTRAINT pk_facility_id PRIMARY KEY (facility_id);


--
-- TOC entry 3604 (class 2606 OID 23638)
-- Name: facility_type pk_facility_type_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.facility_type
    ADD CONSTRAINT pk_facility_type_id PRIMARY KEY (facility_type_id);


--
-- TOC entry 3582 (class 2606 OID 23427)
-- Name: geo pk_geo; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.geo
    ADD CONSTRAINT pk_geo PRIMARY KEY (geo_id);


--
-- TOC entry 3584 (class 2606 OID 23439)
-- Name: geo_point pk_geo_point; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.geo_point
    ADD CONSTRAINT pk_geo_point PRIMARY KEY (geo_point_id);


--
-- TOC entry 3574 (class 2606 OID 23393)
-- Name: geo_type pk_geo_type; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.geo_type
    ADD CONSTRAINT pk_geo_type PRIMARY KEY (geo_type_id);


--
-- TOC entry 3668 (class 2606 OID 24289)
-- Name: inventory_item_detail pk_inventory_item_detail; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_item_detail
    ADD CONSTRAINT pk_inventory_item_detail PRIMARY KEY (inventory_item_detail_id);


--
-- TOC entry 3666 (class 2606 OID 24262)
-- Name: inventory_item pk_inventory_item_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_item
    ADD CONSTRAINT pk_inventory_item_id PRIMARY KEY (inventory_item_id);


--
-- TOC entry 3686 (class 2606 OID 24448)
-- Name: invoice pk_invoice; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice
    ADD CONSTRAINT pk_invoice PRIMARY KEY (invoice_id);


--
-- TOC entry 3688 (class 2606 OID 24479)
-- Name: invoice_item pk_invoice_item; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice_item
    ADD CONSTRAINT pk_invoice_item PRIMARY KEY (invoice_id, invoice_item_seq_id);


--
-- TOC entry 3684 (class 2606 OID 24442)
-- Name: invoice_item_type pk_invoice_item_type; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice_item_type
    ADD CONSTRAINT pk_invoice_item_type PRIMARY KEY (invoice_item_type_id);


--
-- TOC entry 3692 (class 2606 OID 24517)
-- Name: invoice_status pk_invoice_status; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice_status
    ADD CONSTRAINT pk_invoice_status PRIMARY KEY (invoice_status_id);


--
-- TOC entry 3682 (class 2606 OID 24436)
-- Name: invoice_type pk_invoice_type; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice_type
    ADD CONSTRAINT pk_invoice_type PRIMARY KEY (invoice_type_id);


--
-- TOC entry 3638 (class 2606 OID 23971)
-- Name: order_header pk_order; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_header
    ADD CONSTRAINT pk_order PRIMARY KEY (order_id);


--
-- TOC entry 3662 (class 2606 OID 24215)
-- Name: order_adjustment pk_order_adjustment; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_adjustment
    ADD CONSTRAINT pk_order_adjustment PRIMARY KEY (order_adjustment_id);


--
-- TOC entry 3660 (class 2606 OID 24199)
-- Name: order_adjustment_type pk_order_adjustment_type; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_adjustment_type
    ADD CONSTRAINT pk_order_adjustment_type PRIMARY KEY (order_adjustment_type_id);


--
-- TOC entry 3690 (class 2606 OID 24495)
-- Name: order_item_billing pk_order_item_billing; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_item_billing
    ADD CONSTRAINT pk_order_item_billing PRIMARY KEY (order_id, order_item_seq_id, invoice_id, invoice_item_seq_id);


--
-- TOC entry 3642 (class 2606 OID 24040)
-- Name: order_item pk_order_item_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_item
    ADD CONSTRAINT pk_order_item_id PRIMARY KEY (order_id, order_item_seq_id);


--
-- TOC entry 3640 (class 2606 OID 24025)
-- Name: order_item_type pk_order_item_type_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_item_type
    ADD CONSTRAINT pk_order_item_type_id PRIMARY KEY (order_item_type_id);


--
-- TOC entry 3644 (class 2606 OID 24066)
-- Name: order_role pk_order_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_role
    ADD CONSTRAINT pk_order_role PRIMARY KEY (order_id, party_id, role_type_id);


--
-- TOC entry 3817 (class 2606 OID 25526)
-- Name: order_shipment pk_order_shipment; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_shipment
    ADD CONSTRAINT pk_order_shipment PRIMARY KEY (order_shipment_id);


--
-- TOC entry 3646 (class 2606 OID 24087)
-- Name: order_status pk_order_status_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_status
    ADD CONSTRAINT pk_order_status_id PRIMARY KEY (order_status_id);


--
-- TOC entry 3636 (class 2606 OID 23957)
-- Name: order_type pk_order_type_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_type
    ADD CONSTRAINT pk_order_type_id PRIMARY KEY (order_type_id);


--
-- TOC entry 3566 (class 2606 OID 23296)
-- Name: uom pk_oum; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.uom
    ADD CONSTRAINT pk_oum PRIMARY KEY (uom_id);


--
-- TOC entry 3564 (class 2606 OID 23282)
-- Name: uom_type pk_oum_type_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.uom_type
    ADD CONSTRAINT pk_oum_type_id PRIMARY KEY (uom_type_id);


--
-- TOC entry 3536 (class 2606 OID 23088)
-- Name: party pk_party; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party
    ADD CONSTRAINT pk_party PRIMARY KEY (party_id);


--
-- TOC entry 3592 (class 2606 OID 23508)
-- Name: party_contact_mech_purpose pk_party_contact_mech_purpose; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party_contact_mech_purpose
    ADD CONSTRAINT pk_party_contact_mech_purpose PRIMARY KEY (party_id, contact_mech_id, contact_mech_purpose_type_id, from_date);


--
-- TOC entry 3598 (class 2606 OID 23566)
-- Name: party_customer pk_party_customer_party_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party_customer
    ADD CONSTRAINT pk_party_customer_party_id PRIMARY KEY (party_id);


--
-- TOC entry 3596 (class 2606 OID 23542)
-- Name: party_department pk_party_department; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party_department
    ADD CONSTRAINT pk_party_department PRIMARY KEY (party_department_id);


--
-- TOC entry 3602 (class 2606 OID 23614)
-- Name: party_distributor pk_party_distributor_party_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party_distributor
    ADD CONSTRAINT pk_party_distributor_party_id PRIMARY KEY (party_id);


--
-- TOC entry 3716 (class 2606 OID 24706)
-- Name: party_driver pk_party_driver; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party_driver
    ADD CONSTRAINT pk_party_driver PRIMARY KEY (party_id);


--
-- TOC entry 3572 (class 2606 OID 23350)
-- Name: party_relationship pk_party_relationship; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party_relationship
    ADD CONSTRAINT pk_party_relationship PRIMARY KEY (party_relationship_id);


--
-- TOC entry 3600 (class 2606 OID 23590)
-- Name: party_retail_outlet pk_party_retail_outlet_party_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party_retail_outlet
    ADD CONSTRAINT pk_party_retail_outlet_party_id PRIMARY KEY (party_id);


--
-- TOC entry 3612 (class 2606 OID 23737)
-- Name: party_salesman pk_party_salesman; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party_salesman
    ADD CONSTRAINT pk_party_salesman PRIMARY KEY (party_id);


--
-- TOC entry 3534 (class 2606 OID 23059)
-- Name: party_type pk_party_type; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party_type
    ADD CONSTRAINT pk_party_type PRIMARY KEY (party_type_id);


--
-- TOC entry 3698 (class 2606 OID 24545)
-- Name: payment pk_payment; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT pk_payment PRIMARY KEY (payment_id);


--
-- TOC entry 3700 (class 2606 OID 24582)
-- Name: payment_application pk_payment_application; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_application
    ADD CONSTRAINT pk_payment_application PRIMARY KEY (payment_application_id);


--
-- TOC entry 3696 (class 2606 OID 24539)
-- Name: payment_method pk_payment_method; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_method
    ADD CONSTRAINT pk_payment_method PRIMARY KEY (payment_method_id);


--
-- TOC entry 3694 (class 2606 OID 24533)
-- Name: payment_type pk_payment_type; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_type
    ADD CONSTRAINT pk_payment_type PRIMARY KEY (payment_type_id);


--
-- TOC entry 3538 (class 2606 OID 23104)
-- Name: person pk_person; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT pk_person PRIMARY KEY (party_id);


--
-- TOC entry 3764 (class 2606 OID 25053)
-- Name: post_customer pk_post_customer; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_customer
    ADD CONSTRAINT pk_post_customer PRIMARY KEY (post_customer_id);


--
-- TOC entry 3776 (class 2606 OID 25156)
-- Name: post_office_fixed_trip_execute pk_post_office_fixed_trip_execute_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_office_fixed_trip_execute
    ADD CONSTRAINT pk_post_office_fixed_trip_execute_id PRIMARY KEY (post_office_fixed_trip_execute_id);


--
-- TOC entry 3772 (class 2606 OID 25123)
-- Name: post_office_fixed_trip pk_post_office_fixed_trip_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_office_fixed_trip
    ADD CONSTRAINT pk_post_office_fixed_trip_id PRIMARY KEY (post_office_fixed_trip_id);


--
-- TOC entry 3768 (class 2606 OID 25099)
-- Name: post_office pk_post_office_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_office
    ADD CONSTRAINT pk_post_office_id PRIMARY KEY (post_office_id);


--
-- TOC entry 3770 (class 2606 OID 25106)
-- Name: post_office_relationship pk_post_office_relationship_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_office_relationship
    ADD CONSTRAINT pk_post_office_relationship_id PRIMARY KEY (post_office_relationship_id);


--
-- TOC entry 3762 (class 2606 OID 25046)
-- Name: post_package_type pk_post_package_type; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_package_type
    ADD CONSTRAINT pk_post_package_type PRIMARY KEY (post_package_type_id);


--
-- TOC entry 3782 (class 2606 OID 25212)
-- Name: post_ship_order_fixed_trip_post_office_assignment pk_post_ship_order_fixed_trip_post_office_assignment; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_ship_order_fixed_trip_post_office_assignment
    ADD CONSTRAINT pk_post_ship_order_fixed_trip_post_office_assignment PRIMARY KEY (post_ship_order_fixed_trip_post_office_assignment_id);


--
-- TOC entry 3784 (class 2606 OID 25229)
-- Name: post_ship_order_itinerary pk_post_ship_order_itinerary_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_ship_order_itinerary
    ADD CONSTRAINT pk_post_ship_order_itinerary_id PRIMARY KEY (post_ship_order_itinerary_id);


--
-- TOC entry 3778 (class 2606 OID 25173)
-- Name: post_ship_order_post_office_assignment pk_post_ship_order_post_office_assignment_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_ship_order_post_office_assignment
    ADD CONSTRAINT pk_post_ship_order_post_office_assignment_id PRIMARY KEY (post_ship_order_post_office_assignment_id);


--
-- TOC entry 3780 (class 2606 OID 25190)
-- Name: post_ship_order_postman_last_mile_assignment pk_post_ship_order_postman_last_mile_assignment_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_ship_order_postman_last_mile_assignment
    ADD CONSTRAINT pk_post_ship_order_postman_last_mile_assignment_id PRIMARY KEY (post_ship_order_postman_last_mile_assignment_id);


--
-- TOC entry 3586 (class 2606 OID 23449)
-- Name: postal_address pk_postal_address; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.postal_address
    ADD CONSTRAINT pk_postal_address PRIMARY KEY (contact_mech_id);


--
-- TOC entry 3774 (class 2606 OID 25139)
-- Name: postman pk_postman_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.postman
    ADD CONSTRAINT pk_postman_id PRIMARY KEY (postman_id);


--
-- TOC entry 3670 (class 2606 OID 24308)
-- Name: product_facility pk_product_facility; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_facility
    ADD CONSTRAINT pk_product_facility PRIMARY KEY (product_id, facility_id);


--
-- TOC entry 3610 (class 2606 OID 23690)
-- Name: product pk_product_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT pk_product_id PRIMARY KEY (product_id);


--
-- TOC entry 3664 (class 2606 OID 24242)
-- Name: product_price pk_product_price; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_price
    ADD CONSTRAINT pk_product_price PRIMARY KEY (product_price_id);


--
-- TOC entry 3650 (class 2606 OID 24120)
-- Name: product_promo pk_product_promo; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_promo
    ADD CONSTRAINT pk_product_promo PRIMARY KEY (product_promo_id);


--
-- TOC entry 3654 (class 2606 OID 24150)
-- Name: product_promo_product pk_product_promo_product; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_promo_product
    ADD CONSTRAINT pk_product_promo_product PRIMARY KEY (product_promo_rule_id, product_id);


--
-- TOC entry 3652 (class 2606 OID 24134)
-- Name: product_promo_rule pk_product_promo_rule; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_promo_rule
    ADD CONSTRAINT pk_product_promo_rule PRIMARY KEY (product_promo_rule_id);


--
-- TOC entry 3648 (class 2606 OID 24108)
-- Name: product_promo_type pk_product_promo_type; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_promo_type
    ADD CONSTRAINT pk_product_promo_type PRIMARY KEY (product_promo_type_id);


--
-- TOC entry 3813 (class 2606 OID 25500)
-- Name: product_store_group pk_product_store_group_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_store_group
    ADD CONSTRAINT pk_product_store_group_id PRIMARY KEY (product_store_group_id);


--
-- TOC entry 3815 (class 2606 OID 25509)
-- Name: product_store pk_product_store_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_store
    ADD CONSTRAINT pk_product_store_id PRIMARY KEY (product_store_id);


--
-- TOC entry 3608 (class 2606 OID 23676)
-- Name: product_type pk_product_type_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_type
    ADD CONSTRAINT pk_product_type_id PRIMARY KEY (product_type_id);


--
-- TOC entry 3576 (class 2606 OID 23399)
-- Name: province pk_province; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.province
    ADD CONSTRAINT pk_province PRIMARY KEY (province_id);


--
-- TOC entry 3618 (class 2606 OID 23785)
-- Name: retail_outlet_salesman_vendor pk_retail_outlet_salesman_vendor; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.retail_outlet_salesman_vendor
    ADD CONSTRAINT pk_retail_outlet_salesman_vendor PRIMARY KEY (retail_outlet_salesman_vendor_id);


--
-- TOC entry 3556 (class 2606 OID 23226)
-- Name: role_type pk_role_type_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_type
    ADD CONSTRAINT pk_role_type_id PRIMARY KEY (role_type_id);


--
-- TOC entry 3634 (class 2606 OID 23948)
-- Name: sales_channel pk_sales_channel_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales_channel
    ADD CONSTRAINT pk_sales_channel_id PRIMARY KEY (sales_channel_id);


--
-- TOC entry 3624 (class 2606 OID 23835)
-- Name: sales_route_planning_period pk_sales_planning_period; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales_route_planning_period
    ADD CONSTRAINT pk_sales_planning_period PRIMARY KEY (sales_route_planning_period_id);


--
-- TOC entry 3622 (class 2606 OID 23816)
-- Name: sales_route_config pk_sales_route_config; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales_route_config
    ADD CONSTRAINT pk_sales_route_config PRIMARY KEY (sales_route_config_id);


--
-- TOC entry 3626 (class 2606 OID 23852)
-- Name: sales_route_config_customer pk_sales_route_config_customer; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales_route_config_customer
    ADD CONSTRAINT pk_sales_route_config_customer PRIMARY KEY (sales_route_config_customer_id);


--
-- TOC entry 3628 (class 2606 OID 23874)
-- Name: sales_route_config_retail_outlet pk_sales_route_config_retail_outlet; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales_route_config_retail_outlet
    ADD CONSTRAINT pk_sales_route_config_retail_outlet PRIMARY KEY (sales_route_config_retail_outlet_id);


--
-- TOC entry 3630 (class 2606 OID 23900)
-- Name: sales_route_detail pk_sales_route_detail; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales_route_detail
    ADD CONSTRAINT pk_sales_route_detail PRIMARY KEY (sales_route_detail_id);


--
-- TOC entry 3620 (class 2606 OID 23806)
-- Name: sales_route_visit_frequency pk_sales_route_frequency; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales_route_visit_frequency
    ADD CONSTRAINT pk_sales_route_frequency PRIMARY KEY (visit_frequency_id);


--
-- TOC entry 3632 (class 2606 OID 23932)
-- Name: salesman_checkin_history pk_salesman_checkin_history; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.salesman_checkin_history
    ADD CONSTRAINT pk_salesman_checkin_history PRIMARY KEY (salesman_checkin_history_id);


--
-- TOC entry 3544 (class 2606 OID 23143)
-- Name: security_group pk_security_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.security_group
    ADD CONSTRAINT pk_security_group PRIMARY KEY (group_id);


--
-- TOC entry 3548 (class 2606 OID 23158)
-- Name: security_group_permission pk_security_group_permission; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.security_group_permission
    ADD CONSTRAINT pk_security_group_permission PRIMARY KEY (group_id, permission_id);


--
-- TOC entry 3546 (class 2606 OID 23152)
-- Name: security_permission pk_security_permission; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.security_permission
    ADD CONSTRAINT pk_security_permission PRIMARY KEY (permission_id);


--
-- TOC entry 3752 (class 2606 OID 24982)
-- Name: edu_semester pk_semester; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.edu_semester
    ADD CONSTRAINT pk_semester PRIMARY KEY (semester_id);


--
-- TOC entry 3766 (class 2606 OID 25073)
-- Name: post_ship_order pk_ship_order; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_ship_order
    ADD CONSTRAINT pk_ship_order PRIMARY KEY (post_ship_order_id);


--
-- TOC entry 3674 (class 2606 OID 24339)
-- Name: shipment pk_shipment; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipment
    ADD CONSTRAINT pk_shipment PRIMARY KEY (shipment_id);


--
-- TOC entry 3676 (class 2606 OID 24356)
-- Name: shipment_item pk_shipment_item; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipment_item
    ADD CONSTRAINT pk_shipment_item PRIMARY KEY (shipment_item_id);


--
-- TOC entry 3724 (class 2606 OID 24775)
-- Name: shipment_item_delivery_plan pk_shipment_item_delivery_plan; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipment_item_delivery_plan
    ADD CONSTRAINT pk_shipment_item_delivery_plan PRIMARY KEY (delivery_plan_id, shipment_item_id);


--
-- TOC entry 3680 (class 2606 OID 24415)
-- Name: shipment_item_role pk_shipment_item_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipment_item_role
    ADD CONSTRAINT pk_shipment_item_role PRIMARY KEY (shipment_item_role_id);


--
-- TOC entry 3678 (class 2606 OID 24398)
-- Name: shipment_item_status pk_shipment_item_status; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipment_item_status
    ADD CONSTRAINT pk_shipment_item_status PRIMARY KEY (shipment_item_status_id);


--
-- TOC entry 3672 (class 2606 OID 24327)
-- Name: shipment_type pk_shipment_type; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipment_type
    ADD CONSTRAINT pk_shipment_type PRIMARY KEY (shipment_type_id);


--
-- TOC entry 3532 (class 2606 OID 23045)
-- Name: status pk_status; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.status
    ADD CONSTRAINT pk_status PRIMARY KEY (status_id);


--
-- TOC entry 3558 (class 2606 OID 23240)
-- Name: status_item pk_status_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.status_item
    ADD CONSTRAINT pk_status_id PRIMARY KEY (status_id);


--
-- TOC entry 3530 (class 2606 OID 23031)
-- Name: status_type pk_status_type; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.status_type
    ADD CONSTRAINT pk_status_type PRIMARY KEY (status_type_id);


--
-- TOC entry 3658 (class 2606 OID 24179)
-- Name: tax_authority_rate_product pk_tax_auth_rate_prod; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tax_authority_rate_product
    ADD CONSTRAINT pk_tax_auth_rate_prod PRIMARY KEY (tax_authority_rate_seq_id);


--
-- TOC entry 3656 (class 2606 OID 24169)
-- Name: tax_authority_rate_type pk_tax_auth_rate_type; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tax_authority_rate_type
    ADD CONSTRAINT pk_tax_auth_rate_type PRIMARY KEY (tax_auth_rate_type_id);


--
-- TOC entry 3736 (class 2606 OID 24911)
-- Name: track_locations pk_track_locations; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.track_locations
    ADD CONSTRAINT pk_track_locations PRIMARY KEY (track_location_id);


--
-- TOC entry 3790 (class 2606 OID 25262)
-- Name: cont_trailer pk_trailer; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cont_trailer
    ADD CONSTRAINT pk_trailer PRIMARY KEY (trailer_id);


--
-- TOC entry 3540 (class 2606 OID 23119)
-- Name: user_login pk_user_login; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_login
    ADD CONSTRAINT pk_user_login PRIMARY KEY (user_login_id);


--
-- TOC entry 3550 (class 2606 OID 23174)
-- Name: user_login_security_group pk_user_login_security_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_login_security_group
    ADD CONSTRAINT pk_user_login_security_group PRIMARY KEY (user_login_id, group_id);


--
-- TOC entry 3823 (class 2606 OID 28160)
-- Name: user_register pk_user_register_user_login_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_register
    ADD CONSTRAINT pk_user_register_user_login_id PRIMARY KEY (user_login_id);


--
-- TOC entry 3722 (class 2606 OID 24764)
-- Name: vehicle_delivery_plan pk_vehicle_delivery_plan; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicle_delivery_plan
    ADD CONSTRAINT pk_vehicle_delivery_plan PRIMARY KEY (delivery_plan_id, vehicle_id);


--
-- TOC entry 3718 (class 2606 OID 24723)
-- Name: vehicle_driver pk_vehicle_driver; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicle_driver
    ADD CONSTRAINT pk_vehicle_driver PRIMARY KEY (vehicle_driver_id);


--
-- TOC entry 3712 (class 2606 OID 24673)
-- Name: vehicle_forbidden_geo_point pk_vehicle_forbidden_geo_point; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicle_forbidden_geo_point
    ADD CONSTRAINT pk_vehicle_forbidden_geo_point PRIMARY KEY (vehicle_forbidden_geo_point_id);


--
-- TOC entry 3708 (class 2606 OID 24636)
-- Name: vehicle pk_vehicle_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicle
    ADD CONSTRAINT pk_vehicle_id PRIMARY KEY (vehicle_id);


--
-- TOC entry 3714 (class 2606 OID 24689)
-- Name: vehicle_location_priority pk_vehicle_location_priority; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicle_location_priority
    ADD CONSTRAINT pk_vehicle_location_priority PRIMARY KEY (vehicle_location_priority_id);


--
-- TOC entry 3710 (class 2606 OID 24661)
-- Name: vehicle_maintenance_history pk_vehicle_maintenance_history; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicle_maintenance_history
    ADD CONSTRAINT pk_vehicle_maintenance_history PRIMARY KEY (vehicle_maintenance_history_id);


--
-- TOC entry 3706 (class 2606 OID 24622)
-- Name: vehicle_type pk_vehicle_type; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicle_type
    ADD CONSTRAINT pk_vehicle_type PRIMARY KEY (vehicle_type_id);


--
-- TOC entry 3542 (class 2606 OID 25429)
-- Name: user_login user_login_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_login
    ADD CONSTRAINT user_login_email_key UNIQUE (email);


--
-- TOC entry 3809 (class 1259 OID 25489)
-- Name: distance_travel_time_geo_points_from_geo_point_id_to_geo_point_; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX distance_travel_time_geo_points_from_geo_point_id_to_geo_point_ ON public.distance_travel_time_geo_points USING btree (from_geo_point_id, to_geo_point_id);


--
-- TOC entry 4107 (class 2620 OID 25442)
-- Name: application application_last_updated_stamp; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER application_last_updated_stamp BEFORE UPDATE ON public.application FOR EACH ROW EXECUTE FUNCTION public.set_last_updated_stamp();


--
-- TOC entry 4106 (class 2620 OID 25441)
-- Name: application_type application_type_last_updated_stamp; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER application_type_last_updated_stamp BEFORE UPDATE ON public.application_type FOR EACH ROW EXECUTE FUNCTION public.set_last_updated_stamp();


--
-- TOC entry 4109 (class 2620 OID 25445)
-- Name: content content_last_updated_stamp; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER content_last_updated_stamp BEFORE UPDATE ON public.content FOR EACH ROW EXECUTE FUNCTION public.set_last_updated_stamp();


--
-- TOC entry 4108 (class 2620 OID 25444)
-- Name: content_type content_type_last_updated_stamp; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER content_type_last_updated_stamp BEFORE UPDATE ON public.content_type FOR EACH ROW EXECUTE FUNCTION public.set_last_updated_stamp();


--
-- TOC entry 4099 (class 2620 OID 25434)
-- Name: party party_last_updated_stamp; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER party_last_updated_stamp BEFORE UPDATE ON public.party FOR EACH ROW EXECUTE FUNCTION public.set_last_updated_stamp();


--
-- TOC entry 4098 (class 2620 OID 25433)
-- Name: party_type party_type_last_updated_stamp; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER party_type_last_updated_stamp BEFORE UPDATE ON public.party_type FOR EACH ROW EXECUTE FUNCTION public.set_last_updated_stamp();


--
-- TOC entry 4100 (class 2620 OID 25435)
-- Name: person person_last_updated_stamp; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER person_last_updated_stamp BEFORE UPDATE ON public.person FOR EACH ROW EXECUTE FUNCTION public.set_last_updated_stamp();


--
-- TOC entry 4102 (class 2620 OID 25437)
-- Name: security_group security_group_last_updated_stamp; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER security_group_last_updated_stamp BEFORE UPDATE ON public.security_group FOR EACH ROW EXECUTE FUNCTION public.set_last_updated_stamp();


--
-- TOC entry 4104 (class 2620 OID 25439)
-- Name: security_group_permission security_group_permission_last_updated_stamp; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER security_group_permission_last_updated_stamp BEFORE UPDATE ON public.security_group_permission FOR EACH ROW EXECUTE FUNCTION public.set_last_updated_stamp();


--
-- TOC entry 4103 (class 2620 OID 25438)
-- Name: security_permission security_permission_last_updated_stamp; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER security_permission_last_updated_stamp BEFORE UPDATE ON public.security_permission FOR EACH ROW EXECUTE FUNCTION public.set_last_updated_stamp();


--
-- TOC entry 4097 (class 2620 OID 25432)
-- Name: status status_last_updated_stamp; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER status_last_updated_stamp BEFORE UPDATE ON public.status FOR EACH ROW EXECUTE FUNCTION public.set_last_updated_stamp();


--
-- TOC entry 4110 (class 2620 OID 25443)
-- Name: track_locations track_locations_last_updated_stamp; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER track_locations_last_updated_stamp BEFORE UPDATE ON public.track_locations FOR EACH ROW EXECUTE FUNCTION public.set_last_updated_stamp();


--
-- TOC entry 4101 (class 2620 OID 25436)
-- Name: user_login user_login_last_updated_stamp; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER user_login_last_updated_stamp BEFORE UPDATE ON public.user_login FOR EACH ROW EXECUTE FUNCTION public.set_last_updated_stamp();


--
-- TOC entry 4105 (class 2620 OID 25440)
-- Name: user_login_security_group user_login_security_group_last_updated_stamp; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER user_login_security_group_last_updated_stamp BEFORE UPDATE ON public.user_login_security_group FOR EACH ROW EXECUTE FUNCTION public.set_last_updated_stamp();


--
-- TOC entry 3837 (class 2606 OID 23208)
-- Name: application application_application_module; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.application
    ADD CONSTRAINT application_application_module FOREIGN KEY (module_id) REFERENCES public.application(application_id);


--
-- TOC entry 3838 (class 2606 OID 23203)
-- Name: application application_application_type; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.application
    ADD CONSTRAINT application_application_type FOREIGN KEY (application_type_id) REFERENCES public.application_type(application_type_id);


--
-- TOC entry 3839 (class 2606 OID 23213)
-- Name: application application_permission; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.application
    ADD CONSTRAINT application_permission FOREIGN KEY (permission_id) REFERENCES public.security_permission(permission_id);


--
-- TOC entry 4094 (class 2606 OID 28147)
-- Name: book_author book_author_author_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_author
    ADD CONSTRAINT book_author_author_id_fkey FOREIGN KEY (author_id) REFERENCES public.author(author_id);


--
-- TOC entry 4095 (class 2606 OID 28142)
-- Name: book_author book_author_book_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book_author
    ADD CONSTRAINT book_author_book_id_fkey FOREIGN KEY (book_id) REFERENCES public.book(book_id);


--
-- TOC entry 3846 (class 2606 OID 23311)
-- Name: content_type cntnt_type_parent; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.content_type
    ADD CONSTRAINT cntnt_type_parent FOREIGN KEY (parent_type_id) REFERENCES public.content_type(content_type_id);


--
-- TOC entry 3847 (class 2606 OID 23325)
-- Name: content content_to_type; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.content
    ADD CONSTRAINT content_to_type FOREIGN KEY (content_type_id) REFERENCES public.content_type(content_type_id);


--
-- TOC entry 4088 (class 2606 OID 25479)
-- Name: distance_travel_time_geo_points distance_travel_time_geo_points_geo_point_geo_point_id_from_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.distance_travel_time_geo_points
    ADD CONSTRAINT distance_travel_time_geo_points_geo_point_geo_point_id_from_fk FOREIGN KEY (from_geo_point_id) REFERENCES public.geo_point(geo_point_id);


--
-- TOC entry 4089 (class 2606 OID 25484)
-- Name: distance_travel_time_geo_points distance_travel_time_geo_points_geo_point_geo_point_id_to_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.distance_travel_time_geo_points
    ADD CONSTRAINT distance_travel_time_geo_points_geo_point_geo_point_id_to_fk FOREIGN KEY (to_geo_point_id) REFERENCES public.geo_point(geo_point_id);


--
-- TOC entry 4033 (class 2606 OID 24958)
-- Name: backlog_task_assignment fk_backlog_task_assignment_backlog_taks_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backlog_task_assignment
    ADD CONSTRAINT fk_backlog_task_assignment_backlog_taks_id FOREIGN KEY (backlog_task_id) REFERENCES public.backlog_task(backlog_task_id);


--
-- TOC entry 4034 (class 2606 OID 24963)
-- Name: backlog_task_assignment fk_backlog_task_assignment_status_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backlog_task_assignment
    ADD CONSTRAINT fk_backlog_task_assignment_status_id FOREIGN KEY (status_id) REFERENCES public.status_item(status_id);


--
-- TOC entry 4035 (class 2606 OID 24953)
-- Name: backlog_task_assignment fk_backlog_task_assignment_to_assigned_party_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backlog_task_assignment
    ADD CONSTRAINT fk_backlog_task_assignment_to_assigned_party_id FOREIGN KEY (assigned_to_party_id) REFERENCES public.party(party_id);


--
-- TOC entry 4032 (class 2606 OID 24942)
-- Name: backlog_task fk_backlog_task_category_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.backlog_task
    ADD CONSTRAINT fk_backlog_task_category_id FOREIGN KEY (backlog_task_category_id) REFERENCES public.backlog_task_category(backlog_task_category_id);


--
-- TOC entry 4041 (class 2606 OID 25036)
-- Name: edu_class_teacher_asignment fk_class_teacher_assignment_class_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.edu_class_teacher_asignment
    ADD CONSTRAINT fk_class_teacher_assignment_class_id FOREIGN KEY (class_id) REFERENCES public.edu_class(class_id);


--
-- TOC entry 4042 (class 2606 OID 25031)
-- Name: edu_class_teacher_asignment fk_class_teacher_assignment_teacher_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.edu_class_teacher_asignment
    ADD CONSTRAINT fk_class_teacher_assignment_teacher_id FOREIGN KEY (teacher_id) REFERENCES public.edu_teacher(teacher_id);


--
-- TOC entry 3852 (class 2606 OID 23417)
-- Name: commune fk_commune_district_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commune
    ADD CONSTRAINT fk_commune_district_id FOREIGN KEY (district_id) REFERENCES public.district(district_id);


--
-- TOC entry 4066 (class 2606 OID 25252)
-- Name: cont_container fk_cont_container; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cont_container
    ADD CONSTRAINT fk_cont_container FOREIGN KEY (container_type_id) REFERENCES public.cont_container_type(container_type_id);


--
-- TOC entry 4070 (class 2606 OID 25302)
-- Name: cont_depot_container fk_cont_depot_container_contact_mech; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cont_depot_container
    ADD CONSTRAINT fk_cont_depot_container_contact_mech FOREIGN KEY (contact_mech_id) REFERENCES public.postal_address(contact_mech_id);


--
-- TOC entry 4069 (class 2606 OID 25291)
-- Name: cont_depot_trailer fk_cont_depot_trailer_contact_mech; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cont_depot_trailer
    ADD CONSTRAINT fk_cont_depot_trailer_contact_mech FOREIGN KEY (contact_mech_id) REFERENCES public.postal_address(contact_mech_id);


--
-- TOC entry 4068 (class 2606 OID 25280)
-- Name: cont_depot_truck fk_cont_depot_truck_contact_mech; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cont_depot_truck
    ADD CONSTRAINT fk_cont_depot_truck_contact_mech FOREIGN KEY (contact_mech_id) REFERENCES public.postal_address(contact_mech_id);


--
-- TOC entry 4067 (class 2606 OID 25269)
-- Name: cont_port fk_cont_port_contact_mech_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cont_port
    ADD CONSTRAINT fk_cont_port_contact_mech_id FOREIGN KEY (contact_mech_id) REFERENCES public.postal_address(contact_mech_id);


--
-- TOC entry 4085 (class 2606 OID 25402)
-- Name: cont_request_between_warehouse fk_cont_request_between_warehouse_container_type; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cont_request_between_warehouse
    ADD CONSTRAINT fk_cont_request_between_warehouse_container_type FOREIGN KEY (container_type_id) REFERENCES public.cont_container_type(container_type_id);


--
-- TOC entry 4086 (class 2606 OID 25392)
-- Name: cont_request_between_warehouse fk_cont_request_between_warehouse_from_facility; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cont_request_between_warehouse
    ADD CONSTRAINT fk_cont_request_between_warehouse_from_facility FOREIGN KEY (from_facility_id) REFERENCES public.facility(facility_id);


--
-- TOC entry 4087 (class 2606 OID 25397)
-- Name: cont_request_between_warehouse fk_cont_request_between_warehouse_to_facility; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cont_request_between_warehouse
    ADD CONSTRAINT fk_cont_request_between_warehouse_to_facility FOREIGN KEY (to_facility_id) REFERENCES public.facility(facility_id);


--
-- TOC entry 4078 (class 2606 OID 25358)
-- Name: cont_request_export_empty fk_cont_request_export_empty_container_type; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cont_request_export_empty
    ADD CONSTRAINT fk_cont_request_export_empty_container_type FOREIGN KEY (container_type_id) REFERENCES public.cont_container_type(container_type_id);


--
-- TOC entry 4079 (class 2606 OID 25353)
-- Name: cont_request_export_empty fk_cont_request_export_empty_facility; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cont_request_export_empty
    ADD CONSTRAINT fk_cont_request_export_empty_facility FOREIGN KEY (facility_id) REFERENCES public.facility(facility_id);


--
-- TOC entry 4080 (class 2606 OID 25422)
-- Name: cont_request_export_empty fk_cont_request_export_empty_party_customer; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cont_request_export_empty
    ADD CONSTRAINT fk_cont_request_export_empty_party_customer FOREIGN KEY (party_customer_id) REFERENCES public.party_customer(party_id);


--
-- TOC entry 4083 (class 2606 OID 25380)
-- Name: cont_request_export_full fk_cont_request_export_full_container_type; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cont_request_export_full
    ADD CONSTRAINT fk_cont_request_export_full_container_type FOREIGN KEY (container_type_id) REFERENCES public.cont_container_type(container_type_id);


--
-- TOC entry 4081 (class 2606 OID 25370)
-- Name: cont_request_export_full fk_cont_request_export_full_facility; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cont_request_export_full
    ADD CONSTRAINT fk_cont_request_export_full_facility FOREIGN KEY (facility_id) REFERENCES public.facility(facility_id);


--
-- TOC entry 4084 (class 2606 OID 25417)
-- Name: cont_request_export_full fk_cont_request_export_full_party_customer; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cont_request_export_full
    ADD CONSTRAINT fk_cont_request_export_full_party_customer FOREIGN KEY (party_customer_id) REFERENCES public.party_customer(party_id);


--
-- TOC entry 4082 (class 2606 OID 25375)
-- Name: cont_request_export_full fk_cont_request_export_full_port; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cont_request_export_full
    ADD CONSTRAINT fk_cont_request_export_full_port FOREIGN KEY (port_id) REFERENCES public.cont_port(port_id);


--
-- TOC entry 4071 (class 2606 OID 25319)
-- Name: cont_request_import_empty fk_cont_request_import_empty_container_type; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cont_request_import_empty
    ADD CONSTRAINT fk_cont_request_import_empty_container_type FOREIGN KEY (container_type_id) REFERENCES public.cont_container_type(container_type_id);


--
-- TOC entry 4072 (class 2606 OID 25314)
-- Name: cont_request_import_empty fk_cont_request_import_empty_facility; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cont_request_import_empty
    ADD CONSTRAINT fk_cont_request_import_empty_facility FOREIGN KEY (facility_id) REFERENCES public.facility(facility_id);


--
-- TOC entry 4073 (class 2606 OID 25412)
-- Name: cont_request_import_empty fk_cont_request_import_empty_party_customer; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cont_request_import_empty
    ADD CONSTRAINT fk_cont_request_import_empty_party_customer FOREIGN KEY (party_customer_id) REFERENCES public.party_customer(party_id);


--
-- TOC entry 4076 (class 2606 OID 25341)
-- Name: cont_request_import_full fk_cont_request_import_full_container_type; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cont_request_import_full
    ADD CONSTRAINT fk_cont_request_import_full_container_type FOREIGN KEY (container_type_id) REFERENCES public.cont_container_type(container_type_id);


--
-- TOC entry 4074 (class 2606 OID 25331)
-- Name: cont_request_import_full fk_cont_request_import_full_facility; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cont_request_import_full
    ADD CONSTRAINT fk_cont_request_import_full_facility FOREIGN KEY (facility_id) REFERENCES public.facility(facility_id);


--
-- TOC entry 4077 (class 2606 OID 25407)
-- Name: cont_request_import_full fk_cont_request_import_full_party_customer; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cont_request_import_full
    ADD CONSTRAINT fk_cont_request_import_full_party_customer FOREIGN KEY (party_customer_id) REFERENCES public.party_customer(party_id);


--
-- TOC entry 4075 (class 2606 OID 25336)
-- Name: cont_request_import_full fk_cont_request_import_full_port; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cont_request_import_full
    ADD CONSTRAINT fk_cont_request_import_full_port FOREIGN KEY (port_id) REFERENCES public.cont_port(port_id);


--
-- TOC entry 3883 (class 2606 OID 23696)
-- Name: product fk_created_by_user_login_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT fk_created_by_user_login_id FOREIGN KEY (created_by_user_login_id) REFERENCES public.user_login(user_login_id);


--
-- TOC entry 3922 (class 2606 OID 23992)
-- Name: order_header fk_currency_uom_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_header
    ADD CONSTRAINT fk_currency_uom_id FOREIGN KEY (currency_uom_id) REFERENCES public.uom(uom_id);


--
-- TOC entry 3891 (class 2606 OID 23749)
-- Name: customer_salesman fk_customer_salesman_customer; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_salesman
    ADD CONSTRAINT fk_customer_salesman_customer FOREIGN KEY (party_customer_id) REFERENCES public.party_customer(party_id);


--
-- TOC entry 3892 (class 2606 OID 23754)
-- Name: customer_salesman fk_customer_salesman_salesman; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_salesman
    ADD CONSTRAINT fk_customer_salesman_salesman FOREIGN KEY (party_salesman_id) REFERENCES public.party_salesman(party_id);


--
-- TOC entry 3893 (class 2606 OID 23765)
-- Name: customer_salesman_vendor fk_customer_salesman_vendor_customer; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_salesman_vendor
    ADD CONSTRAINT fk_customer_salesman_vendor_customer FOREIGN KEY (party_customer_id) REFERENCES public.party(party_id);


--
-- TOC entry 3894 (class 2606 OID 23770)
-- Name: customer_salesman_vendor fk_customer_salesman_vendor_salesman; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_salesman_vendor
    ADD CONSTRAINT fk_customer_salesman_vendor_salesman FOREIGN KEY (party_salesman_id) REFERENCES public.party(party_id);


--
-- TOC entry 3895 (class 2606 OID 23775)
-- Name: customer_salesman_vendor fk_customer_salesman_vendor_vendor; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_salesman_vendor
    ADD CONSTRAINT fk_customer_salesman_vendor_vendor FOREIGN KEY (party_vendor_id) REFERENCES public.party(party_id);


--
-- TOC entry 4009 (class 2606 OID 24749)
-- Name: delivery_plan fk_delivery_plan_created_by; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.delivery_plan
    ADD CONSTRAINT fk_delivery_plan_created_by FOREIGN KEY (created_by) REFERENCES public.user_login(user_login_id);


--
-- TOC entry 4010 (class 2606 OID 24744)
-- Name: delivery_plan fk_delivery_plan_facility_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.delivery_plan
    ADD CONSTRAINT fk_delivery_plan_facility_id FOREIGN KEY (facility_id) REFERENCES public.facility(facility_id);


--
-- TOC entry 4015 (class 2606 OID 24797)
-- Name: delivery_plan_solution fk_delivery_plan_solution_delivery_plan; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.delivery_plan_solution
    ADD CONSTRAINT fk_delivery_plan_solution_delivery_plan FOREIGN KEY (delivery_plan_id) REFERENCES public.delivery_plan(delivery_plan_id);


--
-- TOC entry 4016 (class 2606 OID 24792)
-- Name: delivery_plan_solution fk_delivery_plan_solution_status; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.delivery_plan_solution
    ADD CONSTRAINT fk_delivery_plan_solution_status FOREIGN KEY (status_id) REFERENCES public.status_item(status_id);


--
-- TOC entry 4011 (class 2606 OID 24754)
-- Name: delivery_plan fk_delivery_plan_status_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.delivery_plan
    ADD CONSTRAINT fk_delivery_plan_status_id FOREIGN KEY (status_id) REFERENCES public.status_item(status_id);


--
-- TOC entry 4018 (class 2606 OID 24819)
-- Name: delivery_trip fk_delivery_trip_delivery_plan_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.delivery_trip
    ADD CONSTRAINT fk_delivery_trip_delivery_plan_id FOREIGN KEY (delivery_plan_id) REFERENCES public.delivery_plan(delivery_plan_id);


--
-- TOC entry 4023 (class 2606 OID 24851)
-- Name: delivery_trip_detail fk_delivery_trip_detail_delivery_trip; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.delivery_trip_detail
    ADD CONSTRAINT fk_delivery_trip_detail_delivery_trip FOREIGN KEY (delivery_trip_id) REFERENCES public.delivery_trip(delivery_trip_id);


--
-- TOC entry 4024 (class 2606 OID 24856)
-- Name: delivery_trip_detail fk_delivery_trip_detail_shipment; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.delivery_trip_detail
    ADD CONSTRAINT fk_delivery_trip_detail_shipment FOREIGN KEY (shipment_item_id) REFERENCES public.shipment_item(shipment_item_id);


--
-- TOC entry 4025 (class 2606 OID 24861)
-- Name: delivery_trip_detail fk_delivery_trip_detail_status; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.delivery_trip_detail
    ADD CONSTRAINT fk_delivery_trip_detail_status FOREIGN KEY (status_id) REFERENCES public.status_item(status_id);


--
-- TOC entry 4026 (class 2606 OID 24873)
-- Name: delivery_trip_detail_status fk_delivery_trip_detail_status_delivery_trip_detail_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.delivery_trip_detail_status
    ADD CONSTRAINT fk_delivery_trip_detail_status_delivery_trip_detail_id FOREIGN KEY (delivery_trip_detail_id) REFERENCES public.delivery_trip_detail(delivery_trip_detail_id);


--
-- TOC entry 4027 (class 2606 OID 24878)
-- Name: delivery_trip_detail_status fk_delivery_trip_detail_status_status_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.delivery_trip_detail_status
    ADD CONSTRAINT fk_delivery_trip_detail_status_status_id FOREIGN KEY (status_id) REFERENCES public.status_item(status_id);


--
-- TOC entry 4028 (class 2606 OID 24883)
-- Name: delivery_trip_detail_status fk_delivery_trip_detail_status_updated_by_user_login_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.delivery_trip_detail_status
    ADD CONSTRAINT fk_delivery_trip_detail_status_updated_by_user_login_id FOREIGN KEY (updated_by_user_login_id) REFERENCES public.user_login(user_login_id);


--
-- TOC entry 4017 (class 2606 OID 24814)
-- Name: delivery_trip fk_delivery_trip_driver_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.delivery_trip
    ADD CONSTRAINT fk_delivery_trip_driver_id FOREIGN KEY (driver_id) REFERENCES public.party_driver(party_id);


--
-- TOC entry 4019 (class 2606 OID 24824)
-- Name: delivery_trip fk_delivery_trip_external_vehicle_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.delivery_trip
    ADD CONSTRAINT fk_delivery_trip_external_vehicle_type_id FOREIGN KEY (execute_external_vehicle_type_id) REFERENCES public.vehicle_type(vehicle_type_id);


--
-- TOC entry 4020 (class 2606 OID 24829)
-- Name: delivery_trip fk_delivery_trip_plan_solution; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.delivery_trip
    ADD CONSTRAINT fk_delivery_trip_plan_solution FOREIGN KEY (delivery_plan_id, delivery_plan_solution_seq_id) REFERENCES public.delivery_plan_solution(delivery_plan_id, delivery_plan_solution_seq_id);


--
-- TOC entry 4021 (class 2606 OID 24834)
-- Name: delivery_trip fk_delivery_trip_status; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.delivery_trip
    ADD CONSTRAINT fk_delivery_trip_status FOREIGN KEY (status_id) REFERENCES public.status_item(status_id);


--
-- TOC entry 4029 (class 2606 OID 24895)
-- Name: delivery_trip_status fk_delivery_trip_status_delivery_trip_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.delivery_trip_status
    ADD CONSTRAINT fk_delivery_trip_status_delivery_trip_id FOREIGN KEY (delivery_trip_id) REFERENCES public.delivery_trip(delivery_trip_id);


--
-- TOC entry 4030 (class 2606 OID 24900)
-- Name: delivery_trip_status fk_delivery_trip_status_status_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.delivery_trip_status
    ADD CONSTRAINT fk_delivery_trip_status_status_id FOREIGN KEY (status_id) REFERENCES public.status_item(status_id);


--
-- TOC entry 4022 (class 2606 OID 24839)
-- Name: delivery_trip fk_delivery_trip_vehicle_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.delivery_trip
    ADD CONSTRAINT fk_delivery_trip_vehicle_id FOREIGN KEY (vehicle_id) REFERENCES public.vehicle(vehicle_id);


--
-- TOC entry 3864 (class 2606 OID 23531)
-- Name: department fk_department_create_by_user_login_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT fk_department_create_by_user_login_id FOREIGN KEY (created_by_userlogin_id) REFERENCES public.user_login(user_login_id);


--
-- TOC entry 3857 (class 2606 OID 23474)
-- Name: distance_travel_time_postal_address fk_distance_travel_time_postal_address_from; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.distance_travel_time_postal_address
    ADD CONSTRAINT fk_distance_travel_time_postal_address_from FOREIGN KEY (from_contact_mech_id) REFERENCES public.postal_address(contact_mech_id);


--
-- TOC entry 3859 (class 2606 OID 23484)
-- Name: distance_travel_time_postal_address fk_distance_travel_time_postal_address_source_enum_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.distance_travel_time_postal_address
    ADD CONSTRAINT fk_distance_travel_time_postal_address_source_enum_id FOREIGN KEY (source_enum_id) REFERENCES public.enumeration(enum_id);


--
-- TOC entry 3858 (class 2606 OID 23479)
-- Name: distance_travel_time_postal_address fk_distance_travel_time_postal_address_to; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.distance_travel_time_postal_address
    ADD CONSTRAINT fk_distance_travel_time_postal_address_to FOREIGN KEY (to_contact_mech_id) REFERENCES public.postal_address(contact_mech_id);


--
-- TOC entry 3860 (class 2606 OID 23489)
-- Name: distance_travel_time_postal_address fk_distance_travel_time_postal_address_updated_by_user_login; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.distance_travel_time_postal_address
    ADD CONSTRAINT fk_distance_travel_time_postal_address_updated_by_user_login FOREIGN KEY (updated_by_user_login_id) REFERENCES public.user_login(user_login_id);


--
-- TOC entry 3851 (class 2606 OID 23406)
-- Name: district fk_district_province_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.district
    ADD CONSTRAINT fk_district_province_id FOREIGN KEY (province_id) REFERENCES public.province(province_id);


--
-- TOC entry 4036 (class 2606 OID 24991)
-- Name: edu_class fk_edu_class; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.edu_class
    ADD CONSTRAINT fk_edu_class FOREIGN KEY (department_id) REFERENCES public.edu_department(department_id);


--
-- TOC entry 4037 (class 2606 OID 25001)
-- Name: edu_class fk_edu_class_course_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.edu_class
    ADD CONSTRAINT fk_edu_class_course_id FOREIGN KEY (course_id) REFERENCES public.edu_course(course_id);


--
-- TOC entry 4038 (class 2606 OID 24996)
-- Name: edu_class fk_edu_class_semester_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.edu_class
    ADD CONSTRAINT fk_edu_class_semester_id FOREIGN KEY (semester_id) REFERENCES public.edu_semester(semester_id);


--
-- TOC entry 4039 (class 2606 OID 25016)
-- Name: edu_course_teacher_preference fk_edu_course_teacher_preference_course_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.edu_course_teacher_preference
    ADD CONSTRAINT fk_edu_course_teacher_preference_course_id FOREIGN KEY (course_id) REFERENCES public.edu_course(course_id);


--
-- TOC entry 4040 (class 2606 OID 25021)
-- Name: edu_course_teacher_preference fk_edu_course_teacher_preference_teacher_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.edu_course_teacher_preference
    ADD CONSTRAINT fk_edu_course_teacher_preference_teacher_id FOREIGN KEY (teacher_id) REFERENCES public.edu_teacher(teacher_id);


--
-- TOC entry 3843 (class 2606 OID 23269)
-- Name: enumeration fk_enum_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enumeration
    ADD CONSTRAINT fk_enum_type_id FOREIGN KEY (enum_type_id) REFERENCES public.enumeration_type(enumeration_type_id);


--
-- TOC entry 3878 (class 2606 OID 23653)
-- Name: facility fk_facility_contact_mech_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.facility
    ADD CONSTRAINT fk_facility_contact_mech_id FOREIGN KEY (contact_mech_id) REFERENCES public.postal_address(contact_mech_id);


--
-- TOC entry 3968 (class 2606 OID 24382)
-- Name: shipment_item fk_facility_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipment_item
    ADD CONSTRAINT fk_facility_id FOREIGN KEY (facility_id) REFERENCES public.facility(facility_id);


--
-- TOC entry 3879 (class 2606 OID 23658)
-- Name: facility fk_facility_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.facility
    ADD CONSTRAINT fk_facility_type_id FOREIGN KEY (facility_type_id) REFERENCES public.facility_type(facility_type_id);


--
-- TOC entry 3853 (class 2606 OID 23428)
-- Name: geo fk_geo_geo_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.geo
    ADD CONSTRAINT fk_geo_geo_type_id FOREIGN KEY (geo_type_id) REFERENCES public.geo_type(geo_type_id);


--
-- TOC entry 3888 (class 2606 OID 23721)
-- Name: product fk_height_uom_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT fk_height_uom_id FOREIGN KEY (height_uom_id) REFERENCES public.uom(uom_id);


--
-- TOC entry 3955 (class 2606 OID 24273)
-- Name: inventory_item fk_inventory_item_currency_uom_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_item
    ADD CONSTRAINT fk_inventory_item_currency_uom_id FOREIGN KEY (currency_uom_id) REFERENCES public.uom(uom_id);


--
-- TOC entry 3957 (class 2606 OID 24290)
-- Name: inventory_item_detail fk_inventory_item_detail_inventory_item_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_item_detail
    ADD CONSTRAINT fk_inventory_item_detail_inventory_item_id FOREIGN KEY (inventory_item_id) REFERENCES public.inventory_item(inventory_item_id);


--
-- TOC entry 3958 (class 2606 OID 24295)
-- Name: inventory_item_detail fk_inventory_item_detail_order_id_order_item_seq_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_item_detail
    ADD CONSTRAINT fk_inventory_item_detail_order_id_order_item_seq_id FOREIGN KEY (order_id, order_item_seq_id) REFERENCES public.order_item(order_id, order_item_seq_id);


--
-- TOC entry 3956 (class 2606 OID 24278)
-- Name: inventory_item fk_inventory_item_facility_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_item
    ADD CONSTRAINT fk_inventory_item_facility_id FOREIGN KEY (facility_id) REFERENCES public.facility(facility_id);


--
-- TOC entry 3953 (class 2606 OID 24263)
-- Name: inventory_item fk_inventory_item_product_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_item
    ADD CONSTRAINT fk_inventory_item_product_id FOREIGN KEY (product_id) REFERENCES public.product(product_id);


--
-- TOC entry 3954 (class 2606 OID 24268)
-- Name: inventory_item fk_inventory_item_status_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory_item
    ADD CONSTRAINT fk_inventory_item_status_id FOREIGN KEY (status_id) REFERENCES public.status_item(status_id);


--
-- TOC entry 3978 (class 2606 OID 24464)
-- Name: invoice fk_invoice_currency_uom_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice
    ADD CONSTRAINT fk_invoice_currency_uom_id FOREIGN KEY (currency_uom_id) REFERENCES public.uom(uom_id);


--
-- TOC entry 3977 (class 2606 OID 24459)
-- Name: invoice fk_invoice_from_vendor_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice
    ADD CONSTRAINT fk_invoice_from_vendor_id FOREIGN KEY (from_vendor_id) REFERENCES public.party(party_id);


--
-- TOC entry 3975 (class 2606 OID 24449)
-- Name: invoice fk_invoice_invoice_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice
    ADD CONSTRAINT fk_invoice_invoice_type_id FOREIGN KEY (invoice_type_id) REFERENCES public.invoice_type(invoice_type_id);


--
-- TOC entry 3980 (class 2606 OID 24480)
-- Name: invoice_item fk_invoice_item_currency_uom_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice_item
    ADD CONSTRAINT fk_invoice_item_currency_uom_id FOREIGN KEY (currency_uom_id) REFERENCES public.uom(uom_id);


--
-- TOC entry 3982 (class 2606 OID 24501)
-- Name: order_item_billing fk_invoice_item_currency_uom_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_item_billing
    ADD CONSTRAINT fk_invoice_item_currency_uom_id FOREIGN KEY (currency_uom_id) REFERENCES public.uom(uom_id);


--
-- TOC entry 3981 (class 2606 OID 24485)
-- Name: invoice_item fk_invoice_item_invoice_item_type; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice_item
    ADD CONSTRAINT fk_invoice_item_invoice_item_type FOREIGN KEY (invoice_item_type_id) REFERENCES public.invoice_item_type(invoice_item_type_id);


--
-- TOC entry 3979 (class 2606 OID 24469)
-- Name: invoice fk_invoice_status_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice
    ADD CONSTRAINT fk_invoice_status_id FOREIGN KEY (status_id) REFERENCES public.status_item(status_id);


--
-- TOC entry 3985 (class 2606 OID 24518)
-- Name: invoice_status fk_invoice_status_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice_status
    ADD CONSTRAINT fk_invoice_status_id FOREIGN KEY (status_id) REFERENCES public.status_item(status_id);


--
-- TOC entry 3986 (class 2606 OID 24523)
-- Name: invoice_status fk_invoice_status_invoice_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice_status
    ADD CONSTRAINT fk_invoice_status_invoice_id FOREIGN KEY (invoice_id) REFERENCES public.invoice(invoice_id);


--
-- TOC entry 3976 (class 2606 OID 24454)
-- Name: invoice fk_invoice_to_party_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice
    ADD CONSTRAINT fk_invoice_to_party_customer_id FOREIGN KEY (to_party_customer_id) REFERENCES public.party(party_id);


--
-- TOC entry 3886 (class 2606 OID 23711)
-- Name: product fk_length_uom_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT fk_length_uom_id FOREIGN KEY (length_uom_id) REFERENCES public.uom(uom_id);


--
-- TOC entry 3920 (class 2606 OID 23982)
-- Name: order_header fk_order_address_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_header
    ADD CONSTRAINT fk_order_address_id FOREIGN KEY (ship_to_address_id) REFERENCES public.postal_address(contact_mech_id);


--
-- TOC entry 3947 (class 2606 OID 24216)
-- Name: order_adjustment fk_order_adjustment_order_adjustment_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_adjustment
    ADD CONSTRAINT fk_order_adjustment_order_adjustment_type_id FOREIGN KEY (order_adjustment_type_id) REFERENCES public.order_adjustment_type(order_adjustment_type_id);


--
-- TOC entry 3948 (class 2606 OID 24221)
-- Name: order_adjustment fk_order_adjustment_order_order_item; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_adjustment
    ADD CONSTRAINT fk_order_adjustment_order_order_item FOREIGN KEY (order_id, order_item_seq_id) REFERENCES public.order_item(order_id, order_item_seq_id);


--
-- TOC entry 3950 (class 2606 OID 24231)
-- Name: order_adjustment fk_order_adjustment_product_promo_product; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_adjustment
    ADD CONSTRAINT fk_order_adjustment_product_promo_product FOREIGN KEY (product_promo_rule_id, product_id) REFERENCES public.product_promo_product(product_promo_rule_id, product_id);


--
-- TOC entry 3949 (class 2606 OID 24226)
-- Name: order_adjustment fk_order_adjustment_tax_auth_rate_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_adjustment
    ADD CONSTRAINT fk_order_adjustment_tax_auth_rate_type_id FOREIGN KEY (tax_authority_rate_seq_id) REFERENCES public.tax_authority_rate_product(tax_authority_rate_seq_id);


--
-- TOC entry 3946 (class 2606 OID 24200)
-- Name: order_adjustment_type fk_order_adjustment_type; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_adjustment_type
    ADD CONSTRAINT fk_order_adjustment_type FOREIGN KEY (parent_type_id) REFERENCES public.order_adjustment_type(order_adjustment_type_id);


--
-- TOC entry 3924 (class 2606 OID 24002)
-- Name: order_header fk_order_header_party_salesman_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_header
    ADD CONSTRAINT fk_order_header_party_salesman_id FOREIGN KEY (party_salesman_id) REFERENCES public.party(party_id);


--
-- TOC entry 3925 (class 2606 OID 24007)
-- Name: order_header fk_order_header_vendor_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_header
    ADD CONSTRAINT fk_order_header_vendor_id FOREIGN KEY (vendor_id) REFERENCES public.party(party_id);


--
-- TOC entry 3983 (class 2606 OID 24506)
-- Name: order_item_billing fk_order_item_billing_invoice_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_item_billing
    ADD CONSTRAINT fk_order_item_billing_invoice_id FOREIGN KEY (invoice_id, invoice_item_seq_id) REFERENCES public.invoice_item(invoice_id, invoice_item_seq_id);


--
-- TOC entry 3984 (class 2606 OID 24496)
-- Name: order_item_billing fk_order_item_billing_order_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_item_billing
    ADD CONSTRAINT fk_order_item_billing_order_id FOREIGN KEY (order_id, order_item_seq_id) REFERENCES public.order_item(order_id, order_item_seq_id);


--
-- TOC entry 3930 (class 2606 OID 24051)
-- Name: order_item fk_order_item_order_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_item
    ADD CONSTRAINT fk_order_item_order_id FOREIGN KEY (order_id) REFERENCES public.order_header(order_id);


--
-- TOC entry 3929 (class 2606 OID 24046)
-- Name: order_item fk_order_item_product_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_item
    ADD CONSTRAINT fk_order_item_product_id FOREIGN KEY (product_id) REFERENCES public.product(product_id);


--
-- TOC entry 3928 (class 2606 OID 24041)
-- Name: order_item fk_order_item_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_item
    ADD CONSTRAINT fk_order_item_type_id FOREIGN KEY (order_item_type_id) REFERENCES public.order_item_type(order_item_type_id);


--
-- TOC entry 3932 (class 2606 OID 24067)
-- Name: order_role fk_order_role_order_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_role
    ADD CONSTRAINT fk_order_role_order_id FOREIGN KEY (order_id) REFERENCES public.order_header(order_id);


--
-- TOC entry 3933 (class 2606 OID 24072)
-- Name: order_role fk_order_role_party_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_role
    ADD CONSTRAINT fk_order_role_party_id FOREIGN KEY (party_id) REFERENCES public.party(party_id);


--
-- TOC entry 3934 (class 2606 OID 24077)
-- Name: order_role fk_order_role_role_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_role
    ADD CONSTRAINT fk_order_role_role_type_id FOREIGN KEY (role_type_id) REFERENCES public.role_type(role_type_id);


--
-- TOC entry 4092 (class 2606 OID 25527)
-- Name: order_shipment fk_order_shipment_order_item; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_shipment
    ADD CONSTRAINT fk_order_shipment_order_item FOREIGN KEY (order_id, order_item_seq_id) REFERENCES public.order_item(order_id, order_item_seq_id);


--
-- TOC entry 4093 (class 2606 OID 25532)
-- Name: order_shipment fk_order_shipment_shipment_item; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_shipment
    ADD CONSTRAINT fk_order_shipment_shipment_item FOREIGN KEY (shipment_item_id) REFERENCES public.shipment_item(shipment_item_id);


--
-- TOC entry 3935 (class 2606 OID 24093)
-- Name: order_status fk_order_status_order_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_status
    ADD CONSTRAINT fk_order_status_order_id FOREIGN KEY (order_id) REFERENCES public.order_header(order_id);


--
-- TOC entry 3936 (class 2606 OID 24088)
-- Name: order_status fk_order_status_status_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_status
    ADD CONSTRAINT fk_order_status_status_id FOREIGN KEY (status_id) REFERENCES public.status_item(status_id);


--
-- TOC entry 3918 (class 2606 OID 23972)
-- Name: order_header fk_order_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_header
    ADD CONSTRAINT fk_order_type_id FOREIGN KEY (order_type_id) REFERENCES public.order_type(order_type_id);


--
-- TOC entry 3919 (class 2606 OID 23977)
-- Name: order_header fk_original_facility_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_header
    ADD CONSTRAINT fk_original_facility_id FOREIGN KEY (original_facility_id) REFERENCES public.facility(facility_id);


--
-- TOC entry 3880 (class 2606 OID 23663)
-- Name: facility fk_parent_facility_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.facility
    ADD CONSTRAINT fk_parent_facility_id FOREIGN KEY (parent_facility_id) REFERENCES public.facility(facility_id);


--
-- TOC entry 3917 (class 2606 OID 23958)
-- Name: order_type fk_parent_type; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_type
    ADD CONSTRAINT fk_parent_type FOREIGN KEY (parent_type_id) REFERENCES public.order_type(order_type_id);


--
-- TOC entry 3840 (class 2606 OID 23227)
-- Name: role_type fk_parent_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_type
    ADD CONSTRAINT fk_parent_type_id FOREIGN KEY (parent_type_id) REFERENCES public.role_type(role_type_id);


--
-- TOC entry 3842 (class 2606 OID 23255)
-- Name: enumeration_type fk_parent_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enumeration_type
    ADD CONSTRAINT fk_parent_type_id FOREIGN KEY (parent_type_id) REFERENCES public.enumeration_type(enumeration_type_id);


--
-- TOC entry 3844 (class 2606 OID 23283)
-- Name: uom_type fk_parent_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.uom_type
    ADD CONSTRAINT fk_parent_type_id FOREIGN KEY (parent_type_id) REFERENCES public.uom_type(uom_type_id);


--
-- TOC entry 3877 (class 2606 OID 23639)
-- Name: facility_type fk_parent_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.facility_type
    ADD CONSTRAINT fk_parent_type_id FOREIGN KEY (parent_type_id) REFERENCES public.facility_type(facility_type_id);


--
-- TOC entry 3881 (class 2606 OID 23677)
-- Name: product_type fk_parent_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_type
    ADD CONSTRAINT fk_parent_type_id FOREIGN KEY (parent_type_id) REFERENCES public.product_type(product_type_id);


--
-- TOC entry 3927 (class 2606 OID 24026)
-- Name: order_item_type fk_parent_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_item_type
    ADD CONSTRAINT fk_parent_type_id FOREIGN KEY (parent_type_id) REFERENCES public.order_item_type(order_item_type_id);


--
-- TOC entry 3861 (class 2606 OID 23514)
-- Name: party_contact_mech_purpose fk_party_contact_mech_purpose_contact_mech_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party_contact_mech_purpose
    ADD CONSTRAINT fk_party_contact_mech_purpose_contact_mech_id FOREIGN KEY (contact_mech_id) REFERENCES public.postal_address(contact_mech_id);


--
-- TOC entry 3862 (class 2606 OID 23519)
-- Name: party_contact_mech_purpose fk_party_contact_mech_purpose_contact_mech_purpose_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party_contact_mech_purpose
    ADD CONSTRAINT fk_party_contact_mech_purpose_contact_mech_purpose_type_id FOREIGN KEY (contact_mech_purpose_type_id) REFERENCES public.contact_mech_purpose_type(contact_mech_purpose_type_id);


--
-- TOC entry 3863 (class 2606 OID 23509)
-- Name: party_contact_mech_purpose fk_party_contact_mech_purpose_party_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party_contact_mech_purpose
    ADD CONSTRAINT fk_party_contact_mech_purpose_party_id FOREIGN KEY (party_id) REFERENCES public.party(party_id);


--
-- TOC entry 3926 (class 2606 OID 24012)
-- Name: order_header fk_party_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_header
    ADD CONSTRAINT fk_party_customer_id FOREIGN KEY (party_customer_id) REFERENCES public.party(party_id);


--
-- TOC entry 3865 (class 2606 OID 23553)
-- Name: party_department fk_party_department_department_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party_department
    ADD CONSTRAINT fk_party_department_department_id FOREIGN KEY (department_id) REFERENCES public.department(department_id);


--
-- TOC entry 3866 (class 2606 OID 23548)
-- Name: party_department fk_party_department_party_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party_department
    ADD CONSTRAINT fk_party_department_party_id FOREIGN KEY (party_id) REFERENCES public.party(party_id);


--
-- TOC entry 3867 (class 2606 OID 23543)
-- Name: party_department fk_party_department_role_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party_department
    ADD CONSTRAINT fk_party_department_role_type_id FOREIGN KEY (role_type_id) REFERENCES public.role_type(role_type_id);


--
-- TOC entry 4005 (class 2606 OID 24707)
-- Name: party_driver fk_party_driver; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party_driver
    ADD CONSTRAINT fk_party_driver FOREIGN KEY (party_id) REFERENCES public.party(party_id);


--
-- TOC entry 4006 (class 2606 OID 24712)
-- Name: party_driver fk_party_driver_status_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party_driver
    ADD CONSTRAINT fk_party_driver_status_id FOREIGN KEY (status_id) REFERENCES public.status_item(status_id);


--
-- TOC entry 3848 (class 2606 OID 23351)
-- Name: party_relationship fk_party_relationship_from_party_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party_relationship
    ADD CONSTRAINT fk_party_relationship_from_party_id FOREIGN KEY (from_party_id) REFERENCES public.party(party_id);


--
-- TOC entry 3849 (class 2606 OID 23361)
-- Name: party_relationship fk_party_relationship_role_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party_relationship
    ADD CONSTRAINT fk_party_relationship_role_type_id FOREIGN KEY (role_type_id) REFERENCES public.role_type(role_type_id);


--
-- TOC entry 3850 (class 2606 OID 23356)
-- Name: party_relationship fk_party_relationship_to_party_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party_relationship
    ADD CONSTRAINT fk_party_relationship_to_party_id FOREIGN KEY (to_party_id) REFERENCES public.party(party_id);


--
-- TOC entry 3890 (class 2606 OID 23738)
-- Name: party_salesman fk_party_salesman_status_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party_salesman
    ADD CONSTRAINT fk_party_salesman_status_id FOREIGN KEY (status_id) REFERENCES public.status_item(status_id);


--
-- TOC entry 3993 (class 2606 OID 24588)
-- Name: payment_application fk_payment_application_currency_uom_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_application
    ADD CONSTRAINT fk_payment_application_currency_uom_id FOREIGN KEY (currency_uom_id) REFERENCES public.uom(uom_id);


--
-- TOC entry 3994 (class 2606 OID 24593)
-- Name: payment_application fk_payment_application_invoice_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_application
    ADD CONSTRAINT fk_payment_application_invoice_id FOREIGN KEY (invoice_id) REFERENCES public.invoice(invoice_id);


--
-- TOC entry 3995 (class 2606 OID 24583)
-- Name: payment_application fk_payment_application_payment_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_application
    ADD CONSTRAINT fk_payment_application_payment_id FOREIGN KEY (payment_id) REFERENCES public.payment(payment_id);


--
-- TOC entry 3991 (class 2606 OID 24566)
-- Name: payment fk_payment_currency_uom_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT fk_payment_currency_uom_id FOREIGN KEY (currency_uom_id) REFERENCES public.uom(uom_id);


--
-- TOC entry 3988 (class 2606 OID 24551)
-- Name: payment fk_payment_from_party_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT fk_payment_from_party_id FOREIGN KEY (from_customer_id) REFERENCES public.party(party_id);


--
-- TOC entry 3990 (class 2606 OID 24561)
-- Name: payment fk_payment_payment_method_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT fk_payment_payment_method_id FOREIGN KEY (payment_method_id) REFERENCES public.payment_method(payment_method_id);


--
-- TOC entry 3987 (class 2606 OID 24546)
-- Name: payment fk_payment_payment_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT fk_payment_payment_type_id FOREIGN KEY (payment_type_id) REFERENCES public.payment_type(payment_type_id);


--
-- TOC entry 3992 (class 2606 OID 24571)
-- Name: payment fk_payment_status_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT fk_payment_status_id FOREIGN KEY (status_id) REFERENCES public.status_item(status_id);


--
-- TOC entry 3989 (class 2606 OID 24556)
-- Name: payment fk_payment_to_party_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT fk_payment_to_party_id FOREIGN KEY (to_vendor_id) REFERENCES public.party(party_id);


--
-- TOC entry 4043 (class 2606 OID 25059)
-- Name: post_customer fk_post_customer_contact_mech_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_customer
    ADD CONSTRAINT fk_post_customer_contact_mech_id FOREIGN KEY (contact_mech_id) REFERENCES public.postal_address(contact_mech_id);


--
-- TOC entry 4044 (class 2606 OID 25054)
-- Name: post_customer fk_post_customer_party_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_customer
    ADD CONSTRAINT fk_post_customer_party_id FOREIGN KEY (party_id) REFERENCES public.party(party_id);


--
-- TOC entry 4055 (class 2606 OID 25157)
-- Name: post_office_fixed_trip_execute fk_post_office_fixed_trip_execute_post_office_fixed_trip; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_office_fixed_trip_execute
    ADD CONSTRAINT fk_post_office_fixed_trip_execute_post_office_fixed_trip FOREIGN KEY (post_office_fixed_trip_id) REFERENCES public.post_office_fixed_trip(post_office_fixed_trip_id);


--
-- TOC entry 4056 (class 2606 OID 25162)
-- Name: post_office_fixed_trip_execute fk_post_office_fixed_trip_execute_postman_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_office_fixed_trip_execute
    ADD CONSTRAINT fk_post_office_fixed_trip_execute_postman_id FOREIGN KEY (postman_id) REFERENCES public.postman(postman_id);


--
-- TOC entry 4051 (class 2606 OID 25124)
-- Name: post_office_fixed_trip fk_post_office_fixed_trip_from_post_office_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_office_fixed_trip
    ADD CONSTRAINT fk_post_office_fixed_trip_from_post_office_id FOREIGN KEY (from_post_office_id) REFERENCES public.post_office(post_office_id);


--
-- TOC entry 4052 (class 2606 OID 25129)
-- Name: post_office_fixed_trip fk_post_office_fixed_trip_to_post_office_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_office_fixed_trip
    ADD CONSTRAINT fk_post_office_fixed_trip_to_post_office_id FOREIGN KEY (to_post_office_id) REFERENCES public.post_office(post_office_id);


--
-- TOC entry 4049 (class 2606 OID 25112)
-- Name: post_office_relationship fk_post_office_relationship_parent_post_office_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_office_relationship
    ADD CONSTRAINT fk_post_office_relationship_parent_post_office_id FOREIGN KEY (parent_post_office_id) REFERENCES public.post_office(post_office_id);


--
-- TOC entry 4050 (class 2606 OID 25107)
-- Name: post_office_relationship fk_post_office_relationship_post_office_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_office_relationship
    ADD CONSTRAINT fk_post_office_relationship_post_office_id FOREIGN KEY (post_office_id) REFERENCES public.post_office(post_office_id);


--
-- TOC entry 4062 (class 2606 OID 25213)
-- Name: post_ship_order_fixed_trip_post_office_assignment fk_post_ship_order_fixed_trip_post_office_assignment_fixed_trip; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_ship_order_fixed_trip_post_office_assignment
    ADD CONSTRAINT fk_post_ship_order_fixed_trip_post_office_assignment_fixed_trip FOREIGN KEY (post_office_fixed_trip_execute_id) REFERENCES public.post_office_fixed_trip_execute(post_office_fixed_trip_execute_id);


--
-- TOC entry 4063 (class 2606 OID 25218)
-- Name: post_ship_order_fixed_trip_post_office_assignment fk_post_ship_order_fixed_trip_post_office_assignment_order; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_ship_order_fixed_trip_post_office_assignment
    ADD CONSTRAINT fk_post_ship_order_fixed_trip_post_office_assignment_order FOREIGN KEY (post_ship_order_id) REFERENCES public.post_ship_order(post_ship_order_id);


--
-- TOC entry 4064 (class 2606 OID 25230)
-- Name: post_ship_order_itinerary fk_post_ship_order_itinerary_order_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_ship_order_itinerary
    ADD CONSTRAINT fk_post_ship_order_itinerary_order_id FOREIGN KEY (post_ship_order_id) REFERENCES public.post_ship_order(post_ship_order_id);


--
-- TOC entry 4065 (class 2606 OID 25235)
-- Name: post_ship_order_itinerary fk_post_ship_order_itinerary_post_office_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_ship_order_itinerary
    ADD CONSTRAINT fk_post_ship_order_itinerary_post_office_id FOREIGN KEY (post_office_id) REFERENCES public.post_office(post_office_id);


--
-- TOC entry 4057 (class 2606 OID 25174)
-- Name: post_ship_order_post_office_assignment fk_post_ship_order_post_office_assignment_order; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_ship_order_post_office_assignment
    ADD CONSTRAINT fk_post_ship_order_post_office_assignment_order FOREIGN KEY (post_ship_order_id) REFERENCES public.post_ship_order(post_ship_order_id);


--
-- TOC entry 4058 (class 2606 OID 25179)
-- Name: post_ship_order_post_office_assignment fk_post_ship_order_post_office_assignment_post_office; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_ship_order_post_office_assignment
    ADD CONSTRAINT fk_post_ship_order_post_office_assignment_post_office FOREIGN KEY (post_office_id) REFERENCES public.post_office(post_office_id);


--
-- TOC entry 4059 (class 2606 OID 25191)
-- Name: post_ship_order_postman_last_mile_assignment fk_post_ship_order_postman_last_mile_assignment_post_ship_order; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_ship_order_postman_last_mile_assignment
    ADD CONSTRAINT fk_post_ship_order_postman_last_mile_assignment_post_ship_order FOREIGN KEY (post_ship_order_id) REFERENCES public.post_ship_order(post_ship_order_id);


--
-- TOC entry 4060 (class 2606 OID 25196)
-- Name: post_ship_order_postman_last_mile_assignment fk_post_ship_order_postman_last_mile_assignment_postman_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_ship_order_postman_last_mile_assignment
    ADD CONSTRAINT fk_post_ship_order_postman_last_mile_assignment_postman_id FOREIGN KEY (postman_id) REFERENCES public.postman(postman_id);


--
-- TOC entry 4061 (class 2606 OID 25201)
-- Name: post_ship_order_postman_last_mile_assignment fk_post_ship_order_postman_last_mile_assignment_status_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_ship_order_postman_last_mile_assignment
    ADD CONSTRAINT fk_post_ship_order_postman_last_mile_assignment_status_id FOREIGN KEY (status_id) REFERENCES public.status_item(status_id);


--
-- TOC entry 4046 (class 2606 OID 25079)
-- Name: post_ship_order fk_post_ship_order_status; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_ship_order
    ADD CONSTRAINT fk_post_ship_order_status FOREIGN KEY (status_id) REFERENCES public.status_item(status_id);


--
-- TOC entry 3854 (class 2606 OID 23455)
-- Name: postal_address fk_postal_address_country_geo_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.postal_address
    ADD CONSTRAINT fk_postal_address_country_geo_id FOREIGN KEY (country_geo_id) REFERENCES public.geo(geo_id);


--
-- TOC entry 3855 (class 2606 OID 23450)
-- Name: postal_address fk_postal_address_geo_point_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.postal_address
    ADD CONSTRAINT fk_postal_address_geo_point_id FOREIGN KEY (geo_point_id) REFERENCES public.geo_point(geo_point_id);


--
-- TOC entry 3856 (class 2606 OID 23460)
-- Name: postal_address fk_postal_address_state_province_geo_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.postal_address
    ADD CONSTRAINT fk_postal_address_state_province_geo_id FOREIGN KEY (state_province_geo_id) REFERENCES public.geo(geo_id);


--
-- TOC entry 4053 (class 2606 OID 25140)
-- Name: postman fk_postman_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.postman
    ADD CONSTRAINT fk_postman_id FOREIGN KEY (postman_id) REFERENCES public.party(party_id);


--
-- TOC entry 4054 (class 2606 OID 25145)
-- Name: postman fk_postman_post_office_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.postman
    ADD CONSTRAINT fk_postman_post_office_id FOREIGN KEY (post_office_id) REFERENCES public.post_office(post_office_id);


--
-- TOC entry 3959 (class 2606 OID 24309)
-- Name: product_facility fk_product_facility_facility_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_facility
    ADD CONSTRAINT fk_product_facility_facility_id FOREIGN KEY (facility_id) REFERENCES public.facility(facility_id);


--
-- TOC entry 3960 (class 2606 OID 24314)
-- Name: product_facility fk_product_facility_product_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_facility
    ADD CONSTRAINT fk_product_facility_product_id FOREIGN KEY (product_id) REFERENCES public.product(product_id);


--
-- TOC entry 3951 (class 2606 OID 24248)
-- Name: product_price fk_product_price_created_by_user_login_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_price
    ADD CONSTRAINT fk_product_price_created_by_user_login_id FOREIGN KEY (created_by_user_login_id) REFERENCES public.user_login(user_login_id);


--
-- TOC entry 3952 (class 2606 OID 24243)
-- Name: product_price fk_product_price_currency_uom_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_price
    ADD CONSTRAINT fk_product_price_currency_uom_id FOREIGN KEY (currency_uom_id) REFERENCES public.uom(uom_id);


--
-- TOC entry 3938 (class 2606 OID 24109)
-- Name: product_promo_type fk_product_promo_parent_type; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_promo_type
    ADD CONSTRAINT fk_product_promo_parent_type FOREIGN KEY (parent_type_id) REFERENCES public.product_promo_type(product_promo_type_id);


--
-- TOC entry 3942 (class 2606 OID 24156)
-- Name: product_promo_product fk_product_promo_product_product; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_promo_product
    ADD CONSTRAINT fk_product_promo_product_product FOREIGN KEY (product_id) REFERENCES public.product(product_id);


--
-- TOC entry 3939 (class 2606 OID 24121)
-- Name: product_promo fk_product_promo_product_promo_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_promo
    ADD CONSTRAINT fk_product_promo_product_promo_type_id FOREIGN KEY (product_promo_type_id) REFERENCES public.product_promo_type(product_promo_type_id);


--
-- TOC entry 3943 (class 2606 OID 24151)
-- Name: product_promo_product fk_product_promo_product_rule; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_promo_product
    ADD CONSTRAINT fk_product_promo_product_rule FOREIGN KEY (product_promo_rule_id) REFERENCES public.product_promo_rule(product_promo_rule_id);


--
-- TOC entry 3940 (class 2606 OID 24140)
-- Name: product_promo_rule fk_product_promo_rule_enum; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_promo_rule
    ADD CONSTRAINT fk_product_promo_rule_enum FOREIGN KEY (product_promo_rule_enum_id) REFERENCES public.enumeration(enum_id);


--
-- TOC entry 3941 (class 2606 OID 24135)
-- Name: product_promo_rule fk_product_promo_rule_product_promo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_promo_rule
    ADD CONSTRAINT fk_product_promo_rule_product_promo FOREIGN KEY (product_promo_id) REFERENCES public.product_promo(product_promo_id);


--
-- TOC entry 3921 (class 2606 OID 23987)
-- Name: order_header fk_product_store_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_header
    ADD CONSTRAINT fk_product_store_id FOREIGN KEY (product_store_id) REFERENCES public.facility(facility_id);


--
-- TOC entry 4090 (class 2606 OID 25510)
-- Name: product_store fk_product_store_owner_party_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_store
    ADD CONSTRAINT fk_product_store_owner_party_id FOREIGN KEY (owner_party_id) REFERENCES public.party(party_id);


--
-- TOC entry 4091 (class 2606 OID 25515)
-- Name: product_store fk_product_store_product_store_group; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_store
    ADD CONSTRAINT fk_product_store_product_store_group FOREIGN KEY (product_store_group_id) REFERENCES public.product_store_group(product_store_group_id);


--
-- TOC entry 3882 (class 2606 OID 23691)
-- Name: product fk_product_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT fk_product_type_id FOREIGN KEY (product_type_id) REFERENCES public.product_type(product_type_id);


--
-- TOC entry 3884 (class 2606 OID 23701)
-- Name: product fk_quantity_uom_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT fk_quantity_uom_id FOREIGN KEY (quantity_uom_id) REFERENCES public.uom(uom_id);


--
-- TOC entry 3896 (class 2606 OID 23786)
-- Name: retail_outlet_salesman_vendor fk_retail_outlet_salesman_vendor_customer; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.retail_outlet_salesman_vendor
    ADD CONSTRAINT fk_retail_outlet_salesman_vendor_customer FOREIGN KEY (party_retail_outlet_id) REFERENCES public.party(party_id);


--
-- TOC entry 3897 (class 2606 OID 23791)
-- Name: retail_outlet_salesman_vendor fk_retail_outlet_salesman_vendor_salesman; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.retail_outlet_salesman_vendor
    ADD CONSTRAINT fk_retail_outlet_salesman_vendor_salesman FOREIGN KEY (party_salesman_id) REFERENCES public.party(party_id);


--
-- TOC entry 3898 (class 2606 OID 23796)
-- Name: retail_outlet_salesman_vendor fk_retail_outlet_salesman_vendor_vendor; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.retail_outlet_salesman_vendor
    ADD CONSTRAINT fk_retail_outlet_salesman_vendor_vendor FOREIGN KEY (party_vendor_id) REFERENCES public.party(party_id);


--
-- TOC entry 3923 (class 2606 OID 23997)
-- Name: order_header fk_sales_channel_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_header
    ADD CONSTRAINT fk_sales_channel_id FOREIGN KEY (sales_channel_id) REFERENCES public.sales_channel(sales_channel_id);


--
-- TOC entry 3901 (class 2606 OID 23836)
-- Name: sales_route_planning_period fk_sales_planning_period_created_by; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales_route_planning_period
    ADD CONSTRAINT fk_sales_planning_period_created_by FOREIGN KEY (created_by) REFERENCES public.user_login(user_login_id);


--
-- TOC entry 3902 (class 2606 OID 23841)
-- Name: sales_route_planning_period fk_sales_planning_period_status; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales_route_planning_period
    ADD CONSTRAINT fk_sales_planning_period_status FOREIGN KEY (status_id) REFERENCES public.status_item(status_id);


--
-- TOC entry 3903 (class 2606 OID 23863)
-- Name: sales_route_config_customer fk_sales_route_config_customer_customer_salesman_vendor_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales_route_config_customer
    ADD CONSTRAINT fk_sales_route_config_customer_customer_salesman_vendor_id FOREIGN KEY (customer_salesman_vendor_id) REFERENCES public.customer_salesman_vendor(customer_salesman_vendor_id);


--
-- TOC entry 3904 (class 2606 OID 23853)
-- Name: sales_route_config_customer fk_sales_route_config_customer_sales_route_config_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales_route_config_customer
    ADD CONSTRAINT fk_sales_route_config_customer_sales_route_config_id FOREIGN KEY (sales_route_config_id) REFERENCES public.sales_route_config(sales_route_config_id);


--
-- TOC entry 3905 (class 2606 OID 23858)
-- Name: sales_route_config_customer fk_sales_route_config_customer_sales_route_planning_period_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales_route_config_customer
    ADD CONSTRAINT fk_sales_route_config_customer_sales_route_planning_period_id FOREIGN KEY (sales_route_planning_period_id) REFERENCES public.sales_route_planning_period(sales_route_planning_period_id);


--
-- TOC entry 3909 (class 2606 OID 23890)
-- Name: sales_route_config_retail_outlet fk_sales_route_config_retail_outlet_retail_outlet_salesman_vend; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales_route_config_retail_outlet
    ADD CONSTRAINT fk_sales_route_config_retail_outlet_retail_outlet_salesman_vend FOREIGN KEY (retail_outlet_salesman_vendor_id) REFERENCES public.retail_outlet_salesman_vendor(retail_outlet_salesman_vendor_id);


--
-- TOC entry 3907 (class 2606 OID 23880)
-- Name: sales_route_config_retail_outlet fk_sales_route_config_retail_outlet_sales_route_config_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales_route_config_retail_outlet
    ADD CONSTRAINT fk_sales_route_config_retail_outlet_sales_route_config_id FOREIGN KEY (sales_route_config_id) REFERENCES public.sales_route_config(sales_route_config_id);


--
-- TOC entry 3908 (class 2606 OID 23885)
-- Name: sales_route_config_retail_outlet fk_sales_route_config_retail_outlet_sales_route_planning_period; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales_route_config_retail_outlet
    ADD CONSTRAINT fk_sales_route_config_retail_outlet_sales_route_planning_period FOREIGN KEY (sales_route_planning_period_id) REFERENCES public.sales_route_planning_period(sales_route_planning_period_id);


--
-- TOC entry 3899 (class 2606 OID 23817)
-- Name: sales_route_config fk_sales_route_config_retail_outlet_visit_frequency; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales_route_config
    ADD CONSTRAINT fk_sales_route_config_retail_outlet_visit_frequency FOREIGN KEY (visit_frequency_id) REFERENCES public.sales_route_visit_frequency(visit_frequency_id);


--
-- TOC entry 3906 (class 2606 OID 23875)
-- Name: sales_route_config_retail_outlet fk_sales_route_config_retail_outlet_visit_frequency; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales_route_config_retail_outlet
    ADD CONSTRAINT fk_sales_route_config_retail_outlet_visit_frequency FOREIGN KEY (visit_frequency_id) REFERENCES public.sales_route_visit_frequency(visit_frequency_id);


--
-- TOC entry 3900 (class 2606 OID 23822)
-- Name: sales_route_config fk_sales_route_config_status; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales_route_config
    ADD CONSTRAINT fk_sales_route_config_status FOREIGN KEY (status_id) REFERENCES public.status_item(status_id);


--
-- TOC entry 3912 (class 2606 OID 23911)
-- Name: sales_route_detail fk_sales_route_detail_party_distributor_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales_route_detail
    ADD CONSTRAINT fk_sales_route_detail_party_distributor_id FOREIGN KEY (party_distributor_id) REFERENCES public.party_distributor(party_id);


--
-- TOC entry 3911 (class 2606 OID 23906)
-- Name: sales_route_detail fk_sales_route_detail_party_retail_outlet; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales_route_detail
    ADD CONSTRAINT fk_sales_route_detail_party_retail_outlet FOREIGN KEY (party_retail_outlet_id) REFERENCES public.party_retail_outlet(party_id);


--
-- TOC entry 3910 (class 2606 OID 23901)
-- Name: sales_route_detail fk_sales_route_detail_sales_route_config_retail_outlet; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales_route_detail
    ADD CONSTRAINT fk_sales_route_detail_sales_route_config_retail_outlet FOREIGN KEY (sales_route_config_retail_outlet_id) REFERENCES public.sales_route_config_retail_outlet(sales_route_config_retail_outlet_id);


--
-- TOC entry 3914 (class 2606 OID 23921)
-- Name: sales_route_detail fk_sales_route_detail_sales_route_planning_period_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales_route_detail
    ADD CONSTRAINT fk_sales_route_detail_sales_route_planning_period_id FOREIGN KEY (sales_route_planning_period_id) REFERENCES public.sales_route_planning_period(sales_route_planning_period_id);


--
-- TOC entry 3913 (class 2606 OID 23916)
-- Name: sales_route_detail fk_sales_route_detail_salesman_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales_route_detail
    ADD CONSTRAINT fk_sales_route_detail_salesman_id FOREIGN KEY (party_salesman_id) REFERENCES public.party_salesman(party_id);


--
-- TOC entry 3915 (class 2606 OID 23938)
-- Name: salesman_checkin_history fk_salesman_checkin_history_party_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.salesman_checkin_history
    ADD CONSTRAINT fk_salesman_checkin_history_party_id FOREIGN KEY (party_id) REFERENCES public.party(party_id);


--
-- TOC entry 3916 (class 2606 OID 23933)
-- Name: salesman_checkin_history fk_salesman_checkin_history_user_login_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.salesman_checkin_history
    ADD CONSTRAINT fk_salesman_checkin_history_user_login_id FOREIGN KEY (user_login_id) REFERENCES public.user_login(user_login_id);


--
-- TOC entry 4047 (class 2606 OID 25084)
-- Name: post_ship_order fk_ship_order_from_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_ship_order
    ADD CONSTRAINT fk_ship_order_from_customer_id FOREIGN KEY (from_customer_id) REFERENCES public.post_customer(post_customer_id);


--
-- TOC entry 4045 (class 2606 OID 25074)
-- Name: post_ship_order fk_ship_order_package_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_ship_order
    ADD CONSTRAINT fk_ship_order_package_type_id FOREIGN KEY (package_type_id) REFERENCES public.post_package_type(post_package_type_id);


--
-- TOC entry 4048 (class 2606 OID 25089)
-- Name: post_ship_order fk_ship_order_to_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_ship_order
    ADD CONSTRAINT fk_ship_order_to_customer_id FOREIGN KEY (to_customer_id) REFERENCES public.post_customer(post_customer_id);


--
-- TOC entry 3961 (class 2606 OID 24328)
-- Name: shipment_type fk_shipment; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipment_type
    ADD CONSTRAINT fk_shipment FOREIGN KEY (parent_type_id) REFERENCES public.shipment_type(shipment_type_id);


--
-- TOC entry 4013 (class 2606 OID 24776)
-- Name: shipment_item_delivery_plan fk_shipment_item_delivery_plan_delivery_plan; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipment_item_delivery_plan
    ADD CONSTRAINT fk_shipment_item_delivery_plan_delivery_plan FOREIGN KEY (delivery_plan_id) REFERENCES public.delivery_plan(delivery_plan_id);


--
-- TOC entry 4014 (class 2606 OID 24781)
-- Name: shipment_item_delivery_plan fk_shipment_item_delivery_plan_shipment_item; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipment_item_delivery_plan
    ADD CONSTRAINT fk_shipment_item_delivery_plan_shipment_item FOREIGN KEY (shipment_item_id) REFERENCES public.shipment_item(shipment_item_id);


--
-- TOC entry 3967 (class 2606 OID 24377)
-- Name: shipment_item fk_shipment_item_order_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipment_item
    ADD CONSTRAINT fk_shipment_item_order_id FOREIGN KEY (order_id) REFERENCES public.order_header(order_id);


--
-- TOC entry 3966 (class 2606 OID 24372)
-- Name: shipment_item fk_shipment_item_party_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipment_item
    ADD CONSTRAINT fk_shipment_item_party_customer_id FOREIGN KEY (party_customer_id) REFERENCES public.party(party_id);


--
-- TOC entry 3972 (class 2606 OID 24426)
-- Name: shipment_item_role fk_shipment_item_role_party_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipment_item_role
    ADD CONSTRAINT fk_shipment_item_role_party_id FOREIGN KEY (party_id) REFERENCES public.party(party_id);


--
-- TOC entry 3973 (class 2606 OID 24416)
-- Name: shipment_item_role fk_shipment_item_role_role_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipment_item_role
    ADD CONSTRAINT fk_shipment_item_role_role_type_id FOREIGN KEY (role_type_id) REFERENCES public.role_type(role_type_id);


--
-- TOC entry 3974 (class 2606 OID 24421)
-- Name: shipment_item_role fk_shipment_item_role_shipment_item_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipment_item_role
    ADD CONSTRAINT fk_shipment_item_role_shipment_item_id FOREIGN KEY (shipment_item_id) REFERENCES public.shipment_item(shipment_item_id);


--
-- TOC entry 3964 (class 2606 OID 24362)
-- Name: shipment_item fk_shipment_item_ship_to_location_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipment_item
    ADD CONSTRAINT fk_shipment_item_ship_to_location_id FOREIGN KEY (ship_to_location_id) REFERENCES public.postal_address(contact_mech_id);


--
-- TOC entry 3963 (class 2606 OID 24357)
-- Name: shipment_item fk_shipment_item_shipment_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipment_item
    ADD CONSTRAINT fk_shipment_item_shipment_id FOREIGN KEY (shipment_id) REFERENCES public.shipment(shipment_id);


--
-- TOC entry 3970 (class 2606 OID 24399)
-- Name: shipment_item_status fk_shipment_item_status_shipment_item_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipment_item_status
    ADD CONSTRAINT fk_shipment_item_status_shipment_item_id FOREIGN KEY (shipment_item_id) REFERENCES public.shipment_item(shipment_item_id);


--
-- TOC entry 3971 (class 2606 OID 24404)
-- Name: shipment_item_status fk_shipment_item_status_status_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipment_item_status
    ADD CONSTRAINT fk_shipment_item_status_status_id FOREIGN KEY (status_id) REFERENCES public.status_item(status_id);


--
-- TOC entry 3962 (class 2606 OID 24340)
-- Name: shipment fk_shipment_shipment_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipment
    ADD CONSTRAINT fk_shipment_shipment_type_id FOREIGN KEY (shipment_type_id) REFERENCES public.shipment_type(shipment_type_id);


--
-- TOC entry 3931 (class 2606 OID 24056)
-- Name: order_item fk_status_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_item
    ADD CONSTRAINT fk_status_id FOREIGN KEY (status_id) REFERENCES public.status_item(status_id);


--
-- TOC entry 3969 (class 2606 OID 24387)
-- Name: shipment_item fk_status_item; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipment_item
    ADD CONSTRAINT fk_status_item FOREIGN KEY (status_id) REFERENCES public.status_item(status_id);


--
-- TOC entry 3841 (class 2606 OID 23241)
-- Name: status_item fk_status_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.status_item
    ADD CONSTRAINT fk_status_type_id FOREIGN KEY (status_type_id) REFERENCES public.status_type(status_type_id);


--
-- TOC entry 3937 (class 2606 OID 24098)
-- Name: order_status fk_status_user_login_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_status
    ADD CONSTRAINT fk_status_user_login_id FOREIGN KEY (status_user_login_id) REFERENCES public.user_login(user_login_id);


--
-- TOC entry 3944 (class 2606 OID 24180)
-- Name: tax_authority_rate_product fk_tax_auth_rate_prod_product_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tax_authority_rate_product
    ADD CONSTRAINT fk_tax_auth_rate_prod_product_id FOREIGN KEY (product_id) REFERENCES public.product(product_id);


--
-- TOC entry 3945 (class 2606 OID 24185)
-- Name: tax_authority_rate_product fk_tax_auth_rate_prod_tax_auth_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tax_authority_rate_product
    ADD CONSTRAINT fk_tax_auth_rate_prod_tax_auth_type_id FOREIGN KEY (tax_auth_rate_type_id) REFERENCES public.tax_authority_rate_type(tax_auth_rate_type_id);


--
-- TOC entry 3845 (class 2606 OID 23297)
-- Name: uom fk_uom_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.uom
    ADD CONSTRAINT fk_uom_type_id FOREIGN KEY (uom_type_id) REFERENCES public.uom_type(uom_type_id);


--
-- TOC entry 4096 (class 2606 OID 28161)
-- Name: user_register fk_user_register_status_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_register
    ADD CONSTRAINT fk_user_register_status_id FOREIGN KEY (status_id) REFERENCES public.status_item(status_id);


--
-- TOC entry 4012 (class 2606 OID 24765)
-- Name: vehicle_delivery_plan fk_vehicle_delivery_plan_vehicle_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicle_delivery_plan
    ADD CONSTRAINT fk_vehicle_delivery_plan_vehicle_id FOREIGN KEY (vehicle_id) REFERENCES public.vehicle(vehicle_id);


--
-- TOC entry 4007 (class 2606 OID 24729)
-- Name: vehicle_driver fk_vehicle_driver_party_driver_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicle_driver
    ADD CONSTRAINT fk_vehicle_driver_party_driver_id FOREIGN KEY (party_driver_id) REFERENCES public.party_driver(party_id);


--
-- TOC entry 4008 (class 2606 OID 24724)
-- Name: vehicle_driver fk_vehicle_driver_vehicle_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicle_driver
    ADD CONSTRAINT fk_vehicle_driver_vehicle_id FOREIGN KEY (vehicle_id) REFERENCES public.vehicle(vehicle_id);


--
-- TOC entry 4001 (class 2606 OID 24679)
-- Name: vehicle_forbidden_geo_point fk_vehicle_forbidden_geo_point_geo_point_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicle_forbidden_geo_point
    ADD CONSTRAINT fk_vehicle_forbidden_geo_point_geo_point_id FOREIGN KEY (geo_point_id) REFERENCES public.geo_point(geo_point_id);


--
-- TOC entry 4002 (class 2606 OID 24674)
-- Name: vehicle_forbidden_geo_point fk_vehicle_forbidden_geo_point_vehicle_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicle_forbidden_geo_point
    ADD CONSTRAINT fk_vehicle_forbidden_geo_point_vehicle_id FOREIGN KEY (vehicle_id) REFERENCES public.vehicle(vehicle_id);


--
-- TOC entry 4003 (class 2606 OID 24695)
-- Name: vehicle_location_priority fk_vehicle_location_priority_contact_mech_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicle_location_priority
    ADD CONSTRAINT fk_vehicle_location_priority_contact_mech_id FOREIGN KEY (contact_mech_id) REFERENCES public.postal_address(contact_mech_id);


--
-- TOC entry 4004 (class 2606 OID 24690)
-- Name: vehicle_location_priority fk_vehicle_location_priority_vehicle_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicle_location_priority
    ADD CONSTRAINT fk_vehicle_location_priority_vehicle_id FOREIGN KEY (vehicle_id) REFERENCES public.vehicle(vehicle_id);


--
-- TOC entry 4000 (class 2606 OID 24662)
-- Name: vehicle_maintenance_history fk_vehicle_maintenance_history_vehicle_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicle_maintenance_history
    ADD CONSTRAINT fk_vehicle_maintenance_history_vehicle_id FOREIGN KEY (vehicle_id) REFERENCES public.vehicle(vehicle_id);


--
-- TOC entry 3997 (class 2606 OID 24642)
-- Name: vehicle fk_vehicle_status_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicle
    ADD CONSTRAINT fk_vehicle_status_id FOREIGN KEY (status_id) REFERENCES public.status_item(status_id);


--
-- TOC entry 3889 (class 2606 OID 23726)
-- Name: product fk_vehicle_type_product_transport_category_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT fk_vehicle_type_product_transport_category_id FOREIGN KEY (product_transport_category_id) REFERENCES public.enumeration(enum_id);


--
-- TOC entry 3965 (class 2606 OID 24367)
-- Name: shipment_item fk_vehicle_type_product_transport_category_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shipment_item
    ADD CONSTRAINT fk_vehicle_type_product_transport_category_id FOREIGN KEY (product_transport_category_id) REFERENCES public.enumeration(enum_id);


--
-- TOC entry 3996 (class 2606 OID 24623)
-- Name: vehicle_type fk_vehicle_type_product_transport_category_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicle_type
    ADD CONSTRAINT fk_vehicle_type_product_transport_category_id FOREIGN KEY (product_transport_category_id) REFERENCES public.enumeration(enum_id);


--
-- TOC entry 3998 (class 2606 OID 24647)
-- Name: vehicle fk_vehicle_type_product_transport_category_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicle
    ADD CONSTRAINT fk_vehicle_type_product_transport_category_id FOREIGN KEY (product_transport_category_id) REFERENCES public.enumeration(enum_id);


--
-- TOC entry 3999 (class 2606 OID 24637)
-- Name: vehicle fk_vehicle_vehicle_type; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicle
    ADD CONSTRAINT fk_vehicle_vehicle_type FOREIGN KEY (vehicle_type_id) REFERENCES public.vehicle_type(vehicle_type_id);


--
-- TOC entry 3885 (class 2606 OID 23706)
-- Name: product fk_weight_uom_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT fk_weight_uom_id FOREIGN KEY (weight_uom_id) REFERENCES public.uom(uom_id);


--
-- TOC entry 3887 (class 2606 OID 23716)
-- Name: product fk_width_uom_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT fk_width_uom_id FOREIGN KEY (width_uom_id) REFERENCES public.uom(uom_id);


--
-- TOC entry 3868 (class 2606 OID 23567)
-- Name: party_customer fp_party_customer_party_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party_customer
    ADD CONSTRAINT fp_party_customer_party_id FOREIGN KEY (party_id) REFERENCES public.party(party_id);


--
-- TOC entry 3869 (class 2606 OID 23572)
-- Name: party_customer fp_party_customer_party_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party_customer
    ADD CONSTRAINT fp_party_customer_party_type_id FOREIGN KEY (party_type_id) REFERENCES public.party_type(party_type_id);


--
-- TOC entry 3870 (class 2606 OID 23577)
-- Name: party_customer fp_party_customer_status_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party_customer
    ADD CONSTRAINT fp_party_customer_status_id FOREIGN KEY (status_id) REFERENCES public.status_item(status_id);


--
-- TOC entry 3874 (class 2606 OID 23615)
-- Name: party_distributor fp_party_distributor_party_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party_distributor
    ADD CONSTRAINT fp_party_distributor_party_id FOREIGN KEY (party_id) REFERENCES public.party(party_id);


--
-- TOC entry 3875 (class 2606 OID 23620)
-- Name: party_distributor fp_party_distributor_party_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party_distributor
    ADD CONSTRAINT fp_party_distributor_party_type_id FOREIGN KEY (party_type_id) REFERENCES public.party_type(party_type_id);


--
-- TOC entry 3876 (class 2606 OID 23625)
-- Name: party_distributor fp_party_distributor_status_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party_distributor
    ADD CONSTRAINT fp_party_distributor_status_id FOREIGN KEY (status_id) REFERENCES public.status_item(status_id);


--
-- TOC entry 3871 (class 2606 OID 23591)
-- Name: party_retail_outlet fp_party_retail_outlet_party_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party_retail_outlet
    ADD CONSTRAINT fp_party_retail_outlet_party_id FOREIGN KEY (party_id) REFERENCES public.party(party_id);


--
-- TOC entry 3872 (class 2606 OID 23596)
-- Name: party_retail_outlet fp_party_retail_outlet_party_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party_retail_outlet
    ADD CONSTRAINT fp_party_retail_outlet_party_type_id FOREIGN KEY (party_type_id) REFERENCES public.party_type(party_type_id);


--
-- TOC entry 3873 (class 2606 OID 23601)
-- Name: party_retail_outlet fp_party_retail_outlet_status_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party_retail_outlet
    ADD CONSTRAINT fp_party_retail_outlet_status_id FOREIGN KEY (status_id) REFERENCES public.status_item(status_id);


--
-- TOC entry 3830 (class 2606 OID 23130)
-- Name: party party_c_user_login; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party
    ADD CONSTRAINT party_c_user_login FOREIGN KEY (created_by_user_login) REFERENCES public.user_login(user_login_id);


--
-- TOC entry 3829 (class 2606 OID 23125)
-- Name: party party_m_user_login; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party
    ADD CONSTRAINT party_m_user_login FOREIGN KEY (last_modified_by_user_login) REFERENCES public.user_login(user_login_id);


--
-- TOC entry 3828 (class 2606 OID 23094)
-- Name: party party_pty_typ; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party
    ADD CONSTRAINT party_pty_typ FOREIGN KEY (party_type_id) REFERENCES public.party_type(party_type_id);


--
-- TOC entry 3827 (class 2606 OID 23089)
-- Name: party party_status_item; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party
    ADD CONSTRAINT party_status_item FOREIGN KEY (status_id) REFERENCES public.status(status_id);


--
-- TOC entry 3826 (class 2606 OID 23060)
-- Name: party_type party_type_par; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.party_type
    ADD CONSTRAINT party_type_par FOREIGN KEY (parent_type_id) REFERENCES public.party_type(party_type_id);


--
-- TOC entry 3831 (class 2606 OID 23105)
-- Name: person person_party; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT person_party FOREIGN KEY (party_id) REFERENCES public.party(party_id);


--
-- TOC entry 3833 (class 2606 OID 23159)
-- Name: security_group_permission sec_grp_perm_grp; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.security_group_permission
    ADD CONSTRAINT sec_grp_perm_grp FOREIGN KEY (group_id) REFERENCES public.security_group(group_id);


--
-- TOC entry 3834 (class 2606 OID 23164)
-- Name: security_group_permission sec_grp_perm_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.security_group_permission
    ADD CONSTRAINT sec_grp_perm_perm FOREIGN KEY (permission_id) REFERENCES public.security_permission(permission_id);


--
-- TOC entry 3825 (class 2606 OID 23046)
-- Name: status status_to_type; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.status
    ADD CONSTRAINT status_to_type FOREIGN KEY (status_type_id) REFERENCES public.status_type(status_type_id);


--
-- TOC entry 3824 (class 2606 OID 23032)
-- Name: status_type status_type_parent; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.status_type
    ADD CONSTRAINT status_type_parent FOREIGN KEY (parent_type_id) REFERENCES public.status_type(status_type_id);


--
-- TOC entry 4031 (class 2606 OID 24912)
-- Name: track_locations track_location_party; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.track_locations
    ADD CONSTRAINT track_location_party FOREIGN KEY (party_id) REFERENCES public.party(party_id);


--
-- TOC entry 3832 (class 2606 OID 23120)
-- Name: user_login user_party; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_login
    ADD CONSTRAINT user_party FOREIGN KEY (party_id) REFERENCES public.party(party_id);


--
-- TOC entry 3835 (class 2606 OID 23175)
-- Name: user_login_security_group user_secgrp_grp; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_login_security_group
    ADD CONSTRAINT user_secgrp_grp FOREIGN KEY (group_id) REFERENCES public.security_group(group_id);


--
-- TOC entry 3836 (class 2606 OID 23180)
-- Name: user_login_security_group user_secgrp_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_login_security_group
    ADD CONSTRAINT user_secgrp_user FOREIGN KEY (user_login_id) REFERENCES public.user_login(user_login_id);


-- Completed on 2020-09-04 21:07:34

--
-- PostgreSQL database dump complete
--

