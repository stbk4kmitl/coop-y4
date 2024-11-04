--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3
-- Dumped by pg_dump version 16.3

-- Started on 2024-11-03 14:35:09

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
-- TOC entry 220 (class 1259 OID 50577)
-- Name: brands; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.brands (
    brandid integer NOT NULL,
    brandname text,
    brandname_m character varying(10)
);


ALTER TABLE public.brands OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 50576)
-- Name: brands_brandid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.brands_brandid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.brands_brandid_seq OWNER TO postgres;

--
-- TOC entry 5118 (class 0 OID 0)
-- Dependencies: 219
-- Name: brands_brandid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.brands_brandid_seq OWNED BY public.brands.brandid;


--
-- TOC entry 222 (class 1259 OID 50586)
-- Name: clusters; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clusters (
    clusterid integer NOT NULL,
    clustername text,
    clustername_m character varying(10)
);


ALTER TABLE public.clusters OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 50585)
-- Name: clusters_clusterid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.clusters_clusterid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.clusters_clusterid_seq OWNER TO postgres;

--
-- TOC entry 5119 (class 0 OID 0)
-- Dependencies: 221
-- Name: clusters_clusterid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.clusters_clusterid_seq OWNED BY public.clusters.clusterid;


--
-- TOC entry 245 (class 1259 OID 2225109)
-- Name: device_phycon; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.device_phycon (
    deviceid_phy integer NOT NULL,
    device_names text,
    result_type text,
    rack_position text
);


ALTER TABLE public.device_phycon OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 50595)
-- Name: domains; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.domains (
    domainid integer NOT NULL,
    domainname text,
    domainname_m character varying(10)
);


ALTER TABLE public.domains OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 50594)
-- Name: domains_domainid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.domains_domainid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.domains_domainid_seq OWNER TO postgres;

--
-- TOC entry 5120 (class 0 OID 0)
-- Dependencies: 223
-- Name: domains_domainid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.domains_domainid_seq OWNED BY public.domains.domainid;


--
-- TOC entry 274 (class 1259 OID 4465899)
-- Name: edit_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.edit_log (
    id integer NOT NULL,
    table_name text,
    units text,
    original_value text,
    updated_value text,
    "timestamp" timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.edit_log OWNER TO postgres;

--
-- TOC entry 273 (class 1259 OID 4465898)
-- Name: edit_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.edit_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.edit_log_id_seq OWNER TO postgres;

--
-- TOC entry 5121 (class 0 OID 0)
-- Dependencies: 273
-- Name: edit_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.edit_log_id_seq OWNED BY public.edit_log.id;


--
-- TOC entry 238 (class 1259 OID 50664)
-- Name: inputdata; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inputdata (
    inputid integer NOT NULL,
    site_input character varying(10),
    domain_input text,
    brand_input text,
    cluster_input text,
    node_input text,
    rackposition_input character varying(10),
    rackunit_input character varying(10)
);


ALTER TABLE public.inputdata OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 50663)
-- Name: inputdata_inputid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.inputdata_inputid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.inputdata_inputid_seq OWNER TO postgres;

--
-- TOC entry 5122 (class 0 OID 0)
-- Dependencies: 237
-- Name: inputdata_inputid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.inputdata_inputid_seq OWNED BY public.inputdata.inputid;


--
-- TOC entry 244 (class 1259 OID 2033174)
-- Name: map_acc; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.map_acc (
    type_hw text
);


ALTER TABLE public.map_acc OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 72031)
-- Name: map_agg; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.map_agg (
    type_hw text
);


ALTER TABLE public.map_agg OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 3864366)
-- Name: map_ms; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.map_ms (
    type_hw text,
    port_1 text,
    port_2 text,
    port_3 text,
    port_4 text
);


ALTER TABLE public.map_ms OWNER TO postgres;

--
-- TOC entry 246 (class 1259 OID 3815518)
-- Name: map_srv; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.map_srv (
    type_hw text,
    port_1 text,
    port_2 text
);


ALTER TABLE public.map_srv OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 50654)
-- Name: mappingdevices; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mappingdevices (
    deviceid integer NOT NULL,
    inputid character varying,
    device_names character varying,
    positions character varying(10),
    units character varying(10)
);


ALTER TABLE public.mappingdevices OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 50653)
-- Name: mappingdevices_deviceid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.mappingdevices_deviceid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.mappingdevices_deviceid_seq OWNER TO postgres;

--
-- TOC entry 5123 (class 0 OID 0)
-- Dependencies: 235
-- Name: mappingdevices_deviceid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.mappingdevices_deviceid_seq OWNED BY public.mappingdevices.deviceid;


--
-- TOC entry 243 (class 1259 OID 2012243)
-- Name: maptypes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.maptypes (
    typeid integer NOT NULL,
    typeresult text,
    typenames1 text,
    typenames2 text,
    typenames3 text
);


ALTER TABLE public.maptypes OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 2012242)
-- Name: maptypes_typeid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.maptypes_typeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.maptypes_typeid_seq OWNER TO postgres;

--
-- TOC entry 5124 (class 0 OID 0)
-- Dependencies: 242
-- Name: maptypes_typeid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.maptypes_typeid_seq OWNED BY public.maptypes.typeid;


--
-- TOC entry 240 (class 1259 OID 70997)
-- Name: nodes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.nodes (
    nodeid integer NOT NULL,
    nodename text,
    nodename_m character varying(10),
    node_extension character varying(10)
);


ALTER TABLE public.nodes OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 70996)
-- Name: nodes_nodeid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.nodes_nodeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.nodes_nodeid_seq OWNER TO postgres;

--
-- TOC entry 5125 (class 0 OID 0)
-- Dependencies: 239
-- Name: nodes_nodeid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.nodes_nodeid_seq OWNED BY public.nodes.nodeid;


--
-- TOC entry 226 (class 1259 OID 50613)
-- Name: positions_rst; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.positions_rst (
    r_positionsid integer NOT NULL,
    r_positions text,
    r_positions_m character varying(10)
);


ALTER TABLE public.positions_rst OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 50612)
-- Name: positions_rst_r_positionsid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.positions_rst_r_positionsid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.positions_rst_r_positionsid_seq OWNER TO postgres;

--
-- TOC entry 5126 (class 0 OID 0)
-- Dependencies: 225
-- Name: positions_rst_r_positionsid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.positions_rst_r_positionsid_seq OWNED BY public.positions_rst.r_positionsid;


--
-- TOC entry 228 (class 1259 OID 50622)
-- Name: positions_snk; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.positions_snk (
    s_positionsid integer NOT NULL,
    s_positions text,
    s_positions_m character varying(10)
);


ALTER TABLE public.positions_snk OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 50621)
-- Name: positions_snk_s_positionsid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.positions_snk_s_positionsid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.positions_snk_s_positionsid_seq OWNER TO postgres;

--
-- TOC entry 5127 (class 0 OID 0)
-- Dependencies: 227
-- Name: positions_snk_s_positionsid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.positions_snk_s_positionsid_seq OWNED BY public.positions_snk.s_positionsid;


--
-- TOC entry 230 (class 1259 OID 50631)
-- Name: positions_tyb; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.positions_tyb (
    t_positionsid integer NOT NULL,
    t_positions text,
    t_positions_m character varying(10)
);


ALTER TABLE public.positions_tyb OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 50630)
-- Name: positions_tyb_t_positionsid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.positions_tyb_t_positionsid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.positions_tyb_t_positionsid_seq OWNER TO postgres;

--
-- TOC entry 5128 (class 0 OID 0)
-- Dependencies: 229
-- Name: positions_tyb_t_positionsid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.positions_tyb_t_positionsid_seq OWNED BY public.positions_tyb.t_positionsid;


--
-- TOC entry 232 (class 1259 OID 50640)
-- Name: sites; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sites (
    siteid integer NOT NULL,
    sitename character varying(10)
);


ALTER TABLE public.sites OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 50639)
-- Name: sites_siteid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sites_siteid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sites_siteid_seq OWNER TO postgres;

--
-- TOC entry 5129 (class 0 OID 0)
-- Dependencies: 231
-- Name: sites_siteid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sites_siteid_seq OWNED BY public.sites.siteid;


--
-- TOC entry 266 (class 1259 OID 4465863)
-- Name: snk_oob_acc_1; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.snk_oob_acc_1 (
    port_id integer NOT NULL,
    port text,
    device_names text,
    rack_position text
);


ALTER TABLE public.snk_oob_acc_1 OWNER TO postgres;

--
-- TOC entry 265 (class 1259 OID 4465862)
-- Name: snk_oob_acc_1_port_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.snk_oob_acc_1_port_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.snk_oob_acc_1_port_id_seq OWNER TO postgres;

--
-- TOC entry 5130 (class 0 OID 0)
-- Dependencies: 265
-- Name: snk_oob_acc_1_port_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.snk_oob_acc_1_port_id_seq OWNED BY public.snk_oob_acc_1.port_id;


--
-- TOC entry 268 (class 1259 OID 4465872)
-- Name: snk_oob_acc_2; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.snk_oob_acc_2 (
    port_id integer NOT NULL,
    port text,
    device_names text,
    rack_position text
);


ALTER TABLE public.snk_oob_acc_2 OWNER TO postgres;

--
-- TOC entry 267 (class 1259 OID 4465871)
-- Name: snk_oob_acc_2_port_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.snk_oob_acc_2_port_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.snk_oob_acc_2_port_id_seq OWNER TO postgres;

--
-- TOC entry 5131 (class 0 OID 0)
-- Dependencies: 267
-- Name: snk_oob_acc_2_port_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.snk_oob_acc_2_port_id_seq OWNED BY public.snk_oob_acc_2.port_id;


--
-- TOC entry 270 (class 1259 OID 4465881)
-- Name: snk_oob_acc_3; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.snk_oob_acc_3 (
    port_id integer NOT NULL,
    port text,
    device_names text,
    rack_position text
);


ALTER TABLE public.snk_oob_acc_3 OWNER TO postgres;

--
-- TOC entry 269 (class 1259 OID 4465880)
-- Name: snk_oob_acc_3_port_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.snk_oob_acc_3_port_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.snk_oob_acc_3_port_id_seq OWNER TO postgres;

--
-- TOC entry 5132 (class 0 OID 0)
-- Dependencies: 269
-- Name: snk_oob_acc_3_port_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.snk_oob_acc_3_port_id_seq OWNED BY public.snk_oob_acc_3.port_id;


--
-- TOC entry 272 (class 1259 OID 4465890)
-- Name: snk_oob_acc_4; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.snk_oob_acc_4 (
    port_id integer NOT NULL,
    port text,
    device_names text,
    rack_position text
);


ALTER TABLE public.snk_oob_acc_4 OWNER TO postgres;

--
-- TOC entry 271 (class 1259 OID 4465889)
-- Name: snk_oob_acc_4_port_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.snk_oob_acc_4_port_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.snk_oob_acc_4_port_id_seq OWNER TO postgres;

--
-- TOC entry 5133 (class 0 OID 0)
-- Dependencies: 271
-- Name: snk_oob_acc_4_port_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.snk_oob_acc_4_port_id_seq OWNED BY public.snk_oob_acc_4.port_id;


--
-- TOC entry 262 (class 1259 OID 4465845)
-- Name: snk_oob_agg_1; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.snk_oob_agg_1 (
    port_id integer NOT NULL,
    port text,
    device_names text,
    rack_position text
);


ALTER TABLE public.snk_oob_agg_1 OWNER TO postgres;

--
-- TOC entry 261 (class 1259 OID 4465844)
-- Name: snk_oob_agg_1_port_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.snk_oob_agg_1_port_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.snk_oob_agg_1_port_id_seq OWNER TO postgres;

--
-- TOC entry 5134 (class 0 OID 0)
-- Dependencies: 261
-- Name: snk_oob_agg_1_port_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.snk_oob_agg_1_port_id_seq OWNED BY public.snk_oob_agg_1.port_id;


--
-- TOC entry 264 (class 1259 OID 4465854)
-- Name: snk_oob_agg_2; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.snk_oob_agg_2 (
    port_id integer NOT NULL,
    port text,
    device_names text,
    rack_position text
);


ALTER TABLE public.snk_oob_agg_2 OWNER TO postgres;

--
-- TOC entry 263 (class 1259 OID 4465853)
-- Name: snk_oob_agg_2_port_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.snk_oob_agg_2_port_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.snk_oob_agg_2_port_id_seq OWNER TO postgres;

--
-- TOC entry 5135 (class 0 OID 0)
-- Dependencies: 263
-- Name: snk_oob_agg_2_port_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.snk_oob_agg_2_port_id_seq OWNED BY public.snk_oob_agg_2.port_id;


--
-- TOC entry 255 (class 1259 OID 4465813)
-- Name: snk_r1; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.snk_r1 (
    units text,
    device_names character varying
);


ALTER TABLE public.snk_r1 OWNER TO postgres;

--
-- TOC entry 258 (class 1259 OID 4465828)
-- Name: snk_r2; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.snk_r2 (
    units text,
    device_names character varying
);


ALTER TABLE public.snk_r2 OWNER TO postgres;

--
-- TOC entry 251 (class 1259 OID 4465793)
-- Name: snk_r3; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.snk_r3 (
    units text,
    device_names character varying
);


ALTER TABLE public.snk_r3 OWNER TO postgres;

--
-- TOC entry 248 (class 1259 OID 4465778)
-- Name: snk_r4; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.snk_r4 (
    units text,
    device_names character varying
);


ALTER TABLE public.snk_r4 OWNER TO postgres;

--
-- TOC entry 260 (class 1259 OID 4465838)
-- Name: snk_r5; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.snk_r5 (
    units text,
    device_names character varying
);


ALTER TABLE public.snk_r5 OWNER TO postgres;

--
-- TOC entry 252 (class 1259 OID 4465798)
-- Name: snk_r6; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.snk_r6 (
    units text,
    device_names character varying
);


ALTER TABLE public.snk_r6 OWNER TO postgres;

--
-- TOC entry 254 (class 1259 OID 4465808)
-- Name: snk_r7; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.snk_r7 (
    units text,
    device_names character varying
);


ALTER TABLE public.snk_r7 OWNER TO postgres;

--
-- TOC entry 253 (class 1259 OID 4465803)
-- Name: snk_swr1; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.snk_swr1 (
    units text,
    device_names character varying
);


ALTER TABLE public.snk_swr1 OWNER TO postgres;

--
-- TOC entry 259 (class 1259 OID 4465833)
-- Name: snk_swr2; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.snk_swr2 (
    units text,
    device_names character varying
);


ALTER TABLE public.snk_swr2 OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 4465783)
-- Name: snk_swr3; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.snk_swr3 (
    units text,
    device_names character varying
);


ALTER TABLE public.snk_swr3 OWNER TO postgres;

--
-- TOC entry 256 (class 1259 OID 4465818)
-- Name: snk_swr4; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.snk_swr4 (
    units text,
    device_names character varying
);


ALTER TABLE public.snk_swr4 OWNER TO postgres;

--
-- TOC entry 257 (class 1259 OID 4465823)
-- Name: snk_swr5; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.snk_swr5 (
    units text,
    device_names character varying
);


ALTER TABLE public.snk_swr5 OWNER TO postgres;

--
-- TOC entry 250 (class 1259 OID 4465788)
-- Name: snk_swr6; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.snk_swr6 (
    units text,
    device_names character varying
);


ALTER TABLE public.snk_swr6 OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 50647)
-- Name: units; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.units (
    rackunitsid integer NOT NULL,
    rackunits character varying(10)
);


ALTER TABLE public.units OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 50646)
-- Name: units_rackunitsid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.units_rackunitsid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.units_rackunitsid_seq OWNER TO postgres;

--
-- TOC entry 5136 (class 0 OID 0)
-- Dependencies: 233
-- Name: units_rackunitsid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.units_rackunitsid_seq OWNED BY public.units.rackunitsid;


--
-- TOC entry 4854 (class 2604 OID 50580)
-- Name: brands brandid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.brands ALTER COLUMN brandid SET DEFAULT nextval('public.brands_brandid_seq'::regclass);


--
-- TOC entry 4855 (class 2604 OID 50589)
-- Name: clusters clusterid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clusters ALTER COLUMN clusterid SET DEFAULT nextval('public.clusters_clusterid_seq'::regclass);


--
-- TOC entry 4856 (class 2604 OID 50598)
-- Name: domains domainid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.domains ALTER COLUMN domainid SET DEFAULT nextval('public.domains_domainid_seq'::regclass);


--
-- TOC entry 4872 (class 2604 OID 4465902)
-- Name: edit_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.edit_log ALTER COLUMN id SET DEFAULT nextval('public.edit_log_id_seq'::regclass);


--
-- TOC entry 4863 (class 2604 OID 50667)
-- Name: inputdata inputid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inputdata ALTER COLUMN inputid SET DEFAULT nextval('public.inputdata_inputid_seq'::regclass);


--
-- TOC entry 4862 (class 2604 OID 50657)
-- Name: mappingdevices deviceid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mappingdevices ALTER COLUMN deviceid SET DEFAULT nextval('public.mappingdevices_deviceid_seq'::regclass);


--
-- TOC entry 4865 (class 2604 OID 2012246)
-- Name: maptypes typeid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.maptypes ALTER COLUMN typeid SET DEFAULT nextval('public.maptypes_typeid_seq'::regclass);


--
-- TOC entry 4864 (class 2604 OID 71000)
-- Name: nodes nodeid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nodes ALTER COLUMN nodeid SET DEFAULT nextval('public.nodes_nodeid_seq'::regclass);


--
-- TOC entry 4857 (class 2604 OID 50616)
-- Name: positions_rst r_positionsid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions_rst ALTER COLUMN r_positionsid SET DEFAULT nextval('public.positions_rst_r_positionsid_seq'::regclass);


--
-- TOC entry 4858 (class 2604 OID 50625)
-- Name: positions_snk s_positionsid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions_snk ALTER COLUMN s_positionsid SET DEFAULT nextval('public.positions_snk_s_positionsid_seq'::regclass);


--
-- TOC entry 4859 (class 2604 OID 50634)
-- Name: positions_tyb t_positionsid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions_tyb ALTER COLUMN t_positionsid SET DEFAULT nextval('public.positions_tyb_t_positionsid_seq'::regclass);


--
-- TOC entry 4860 (class 2604 OID 50643)
-- Name: sites siteid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sites ALTER COLUMN siteid SET DEFAULT nextval('public.sites_siteid_seq'::regclass);


--
-- TOC entry 4868 (class 2604 OID 4465866)
-- Name: snk_oob_acc_1 port_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.snk_oob_acc_1 ALTER COLUMN port_id SET DEFAULT nextval('public.snk_oob_acc_1_port_id_seq'::regclass);


--
-- TOC entry 4869 (class 2604 OID 4465875)
-- Name: snk_oob_acc_2 port_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.snk_oob_acc_2 ALTER COLUMN port_id SET DEFAULT nextval('public.snk_oob_acc_2_port_id_seq'::regclass);


--
-- TOC entry 4870 (class 2604 OID 4465884)
-- Name: snk_oob_acc_3 port_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.snk_oob_acc_3 ALTER COLUMN port_id SET DEFAULT nextval('public.snk_oob_acc_3_port_id_seq'::regclass);


--
-- TOC entry 4871 (class 2604 OID 4465893)
-- Name: snk_oob_acc_4 port_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.snk_oob_acc_4 ALTER COLUMN port_id SET DEFAULT nextval('public.snk_oob_acc_4_port_id_seq'::regclass);


--
-- TOC entry 4866 (class 2604 OID 4465848)
-- Name: snk_oob_agg_1 port_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.snk_oob_agg_1 ALTER COLUMN port_id SET DEFAULT nextval('public.snk_oob_agg_1_port_id_seq'::regclass);


--
-- TOC entry 4867 (class 2604 OID 4465857)
-- Name: snk_oob_agg_2 port_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.snk_oob_agg_2 ALTER COLUMN port_id SET DEFAULT nextval('public.snk_oob_agg_2_port_id_seq'::regclass);


--
-- TOC entry 4861 (class 2604 OID 50650)
-- Name: units rackunitsid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.units ALTER COLUMN rackunitsid SET DEFAULT nextval('public.units_rackunitsid_seq'::regclass);


--
-- TOC entry 5058 (class 0 OID 50577)
-- Dependencies: 220
-- Data for Name: brands; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.brands (brandid, brandname, brandname_m) FROM stdin;
1	ZTE	ZT
2	Fortinet	FT
3	H3C	H3
\.


--
-- TOC entry 5060 (class 0 OID 50586)
-- Dependencies: 222
-- Data for Name: clusters; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.clusters (clusterid, clustername, clustername_m) FROM stdin;
1	Support Node 01	01
2	OCP HUB Cluster 01	01
3	UME R50s 01	01
4	SDN 01	01
5	BN EMS 01	01
6	ZTE CI/CD 01	01
7	Splunk HF 01	01
8	H3C UniServer 01	01
9	H3C TAP8000-CE54_Tapping 01	01
10	Backup Storage 01	01
11	Backup Server 01	01
12	VAScanner 01	01
13	KMS 01	01
14	CA 01	01
15	FW EMS 01	01
16	FW 01	01
17	Splitter 01	01
18	SW-MGT 01	01
19	OCP  Cluster 03	03
20	HSM03	03
21	SW-Secure 03	03
22	OCP Cluster 02	02
23	Splunk HF 02	02
24	SW-Non Exposed 02	02
25	SW-Non Exposed 03	03
26	SW-OOB 01	01
27	SW-Mng&Stor Spine 01	01
28	SW-Service Spine 01	01
29	DCGW 01	01
30	SW-Secure 01	01
31	OCP Cluster 01	01
\.


--
-- TOC entry 5083 (class 0 OID 2225109)
-- Dependencies: 245
-- Data for Name: device_phycon; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.device_phycon (deviceid_phy, device_names, result_type, rack_position) FROM stdin;
1	TUC-SNK50M01ZTSUPAB11-02U-01	RH OCP Support	R1/02U
2	TUC-SNK50M01ZTSUPAB10-02U-02	RH OCP Support	R2/02U
3	TUC-SNK50M01ZTCOMAB11-03U-SDNC01	Server SDN-C	R1/03U
4	TUC-SNK50M01ZTCOMAB10-03U-SDNC02	Server SDN-C	R2/03U
5	TUC-SNK50M01ZTCOMAB09-03U-SDNC03	Server SDN-C	R3/03U
6	TUC-SNK50M01ZTCOMAB11-01U-SDNADAPTER01	SDN Adapter	R1/01U
7	TUC-SNK50M01ZTCOMAB10-01U-SDNADAPTER02	SDN Adapter	R2/01U
8	TUC-SNK50M01ZTCOMAB09-01U-SDNADAPTER03	SDN Adapter	R3/01U
9	TUC-SNK50M01ZTCOMAB09-02U-EMSSW01	Server BN EMS	R3/02U
10	TUC-SNK50M01ZTCOMAB10-05U-SPLUNK01	Server Splunk	R2/05U
11	TUC-SNK50M01ZTCOMAB10-06U-SPLUNK02	Server Splunk	R2/06U
12	TUC-SNK50M01H3TAPAB11-14U-CTRL01	Tapping	R1/14U
13	TUC-SNK50M01H3TAPAB10-14U-CTRL02	Tapping	R2/14U
14	TUC-SNK50M01H3TAPDB05-22U-NPBSW01	NPBSW	SW R3/22U
15	TUC-SNK50M01H3TAPDB04-22U-NPBSW02	NPBSW	SW R4/22U
16	TUC-SNK50M01ZTBAKAB09-06U-STORAGE01	Backup Storage	R3/06U
17	TUC-SNK50M01ZTBAKAB11-04U-SERVER01	Server Backup	R1/04U
18	TUC-SNK50M01ZTBAKAB10-04U-SERVER02	Server Backup	R2/04U
19	TUC-SNK50M01ZTBAKAB09-04U-SERVER03	Server Backup	R3/04U
20	TUC-SNK50M01ZTCOMAB11-05U-VASCAN01	Server VAScanner	R1/05U
21	TUC-SNK50M01ZTCOMAB11-06U-VASCAN02	Server VAScanner	R1/06U
22	TUC-SNK50M01ZTCOMAB11-07U-VASCAN03	Server VAScanner	R1/07U
23	TUC-SNK50M01ZTCOMAB11-30U-EMSFW01	Server EMS FW	R1/30U
24	TUC-SNK50M01ZTCOMAB10-30U-EMSFW02	Server EMS FW	R2/30U
25	TUC-SNK50M01FTIFWAB11-23U-01	FW-I	R1/23U
26	TUC-SNK50M01FTIFWAB10-23U-02	FW-I	R2/23U
27	TUC-SNK50M01FTFW4AB11-25U-01	FW4	R1/25U
28	TUC-SNK50M01FTFW4AB10-25U-02	FW4	R2/25U
29	TUC-SNK50M01FTWAFAB11-28U-WAF-I01	WAF-I	R1/28U
30	TUC-SNK50M01FTWAFAB10-28U-WAF-I02	WAF-I	R2/28U
31	TUC-SNK50M01H3ATPDB05-24U-SPLT01	Splitter	SW R3/24U
32	TUC-SNK50M01ZTTAPDB05-20U-MASSW01	MAS SW	SW R3/20U
33	TUC-SNK50M01ZTTAPDB04-20U-MASSW02	MAS SW	SW R4/20U
34	TUC-SNK50M01ZTLEFAB11-17U-M&S01	M&S Leaf M	R1/17U
35	TUC-SNK50M01ZTLEFAB10-17U-M&S02	M&S Leaf M	R2/17U
36	TUC-SNK50M01ZTLEFAB11-19U-SRV01	SRV Leaf M	R1/19U
37	TUC-SNK50M01ZTLEFAB10-19U-SRV02	SRV Leaf M	R2/19U
38	TUC-SNK50S01ZTMASDC07-05U-01	RH APP Master S01	R4/05U
39	TUC-SNK50S01ZTMASDC07-06U-02	RH APP Master S01	R4/06U
40	TUC-SNK50S01ZTMASDC06-05U-03	RH APP Master S01	R5/05U
41	TUC-SNK50S01ZTINFDC07-07U-01	RH Infra Logging S01	R4/07U
42	TUC-SNK50S01ZTINFDC06-06U-02	RH Infra Logging S01	R5/06U
43	TUC-SNK50S01ZTINFDC06-07U-03	RH Infra Logging S01	R5/07U
44	TUC-SNK50S01ZTWRKDC07-08U-01	Server Workload S01	R4/08U
45	TUC-SNK50S01ZTWRKDC07-09U-02	Server Workload S01	R4/09U
46	TUC-SNK50S01ZTWRKDC07-10U-03	Server Workload S01	R4/10U
47	TUC-SNK50S01ZTWRKDC07-11U-04	Server Workload S01	R4/11U
48	TUC-SNK50S01ZTWRKDC07-12U-05	Server Workload S01	R4/12U
49	TUC-SNK50S01ZTWRKDC07-13U-06	Server Workload S01	R4/13U
50	TUC-SNK50S01ZTWRKDC07-14U-07	Server Workload S01	R4/14U
51	TUC-SNK50S01ZTWRKDC07-24U-08	Server Workload S01	R4/24U
52	TUC-SNK50S01ZTWRKDC07-25U-09	Server Workload S01	R4/25U
53	TUC-SNK50S01ZTWRKDC07-26U-10	Server Workload S01	R4/26U
54	TUC-SNK50S01ZTWRKDC07-27U-11	Server Workload S01	R4/27U
55	TUC-SNK50S01ZTWRKDC07-28U-12	Server Workload S01	R4/28U
56	TUC-SNK50S01ZTWRKDC07-29U-13	Server Workload S01	R4/29U
57	TUC-SNK50S01ZTWRKDC07-30U-14	Server Workload S01	R4/30U
58	TUC-SNK50S01ZTWRKDC07-31U-15	Server Workload S01	R4/31U
59	TUC-SNK50S01ZTWRKDC07-32U-16	Server Workload S01	R4/32U
60	TUC-SNK50S01ZTWRKDC07-33U-17	Server Workload S01	R4/33U
61	TUC-SNK50S01ZTWRKDC07-34U-18	Server Workload S01	R4/34U
62	TUC-SNK50S01ZTWRKDC06-08U-19	Server Workload S01	R5/08U
63	TUC-SNK50S01ZTWRKDC06-09U-20	Server Workload S01	R5/09U
64	TUC-SNK50S01ZTWRKDC06-10U-21	Server Workload S01	R5/10U
65	TUC-SNK50S01ZTWRKDC06-11U-22	Server Workload S01	R5/11U
66	TUC-SNK50S01ZTWRKDC06-12U-23	Server Workload S01	R5/12U
67	TUC-SNK50S01ZTWRKDC06-13U-24	Server Workload S01	R5/13U
68	TUC-SNK50S01ZTWRKDC06-14U-25	Server Workload S01	R5/14U
69	TUC-SNK50S01ZTCEPDC07-01U-01	RH OCP CEPH S01	R4/01U
70	TUC-SNK50S01ZTCEPDC07-03U-02	RH OCP CEPH S01	R4/03U
71	TUC-SNK50S01ZTCEPDC06-01U-03	RH OCP CEPH S01	R5/01U
72	TUC-SNK50S01ZTCEPDC06-03U-04	RH OCP CEPH S01	R5/03U
73	TUC-SNK50S01ZTCOMDC06-24U-HSM01	Server HSM S01	R5/24U
74	TUC-SNK50S01ZTCOMDC06-25U-HSM02	Server HSM S01	R5/25U
75	TUC-SNK50S01ZTCOMDC06-26U-HSM03	Server HSM S01	R5/26U
76	TUC-SNK50S01ZTCOMDC06-27U-HSM04	Server HSM S01	R5/27U
77	TUC-SNK50S01ZTCOMDC06-28U-HSM05	Server HSM S01	R5/28U
78	TUC-SNK50S01ZTCOMDC06-29U-HSM06	Server HSM S01	R5/29U
79	TUC-SNK50S01ZTCOMDC06-30U-HSM07	Server HSM S01	R5/30U
80	TUC-SNK50S01ZTCOMDC06-22U-SPLUNK01	Server Splunk	R5/22U
81	TUC-SNK50S01ZTCOMDC06-23U-SPLUNK02	Server Splunk	R5/23U
82	TUC-SNK50S01ZTLEFDC07-16U-M&S01	M&S Leaf S	R4/16U
83	TUC-SNK50S01ZTLEFDC06-16U-M&S02	M&S Leaf S	R5/16U
84	TUC-SNK50S01ZTLEFDC07-18U-M&S03	M&S Leaf S	R4/18U
85	TUC-SNK50S01ZTLEFDC06-18U-M&S04	M&S Leaf S	R5/18U
86	TUC-SNK50S01ZTLEFDC07-20U-SRV01	SRV Leaf S	R4/20U
87	TUC-SNK50S01ZTLEFDC06-20U-SRV02	SRV Leaf S	R5/20U
88	TUC-SNK50N01ZTMASDC03-05U-01	RH APP Master N01	R6/05U
89	TUC-SNK50N01ZTMASDC03-06U-02	RH APP Master N01	R6/06U
90	TUC-SNK50N01ZTMASDC02-05U-03	RH APP Master N01	R7/05U
91	TUC-SNK50N01ZTINFDC03-07U-01	RH Infra Logging N01	R6/07U
92	TUC-SNK50N01ZTINFDC02-06U-02	RH Infra Logging N01	R7/06U
93	TUC-SNK50N01ZTINFDC02-07U-03	RH Infra Logging N01	R7/07U
94	TUC-SNK50N01ZTWRKDC03-08U-01	Server Workload N01	R6/08U
95	TUC-SNK50N01ZTWRKDC03-09U-02	Server Workload N01	R6/09U
96	TUC-SNK50N01ZTWRKDC03-10U-03	Server Workload N01	R6/10U
97	TUC-SNK50N01ZTWRKDC03-11U-04	Server Workload N01	R6/11U
98	TUC-SNK50N01ZTWRKDC03-12U-05	Server Workload N01	R6/12U
99	TUC-SNK50N01ZTWRKDC03-13U-06	Server Workload N01	R6/13U
100	TUC-SNK50N01ZTWRKDC03-14U-07	Server Workload N01	R6/14U
101	TUC-SNK50N01ZTWRKDC03-24U-08	Server Workload N01	R6/24U
102	TUC-SNK50N01ZTWRKDC03-25U-09	Server Workload N01	R6/25U
103	TUC-SNK50N01ZTWRKDC03-26U-10	Server Workload N01	R6/26U
104	TUC-SNK50N01ZTWRKDC03-27U-11	Server Workload N01	R6/27U
105	TUC-SNK50N01ZTWRKDC03-28U-12	Server Workload N01	R6/28U
106	TUC-SNK50N01ZTWRKDC03-29U-13	Server Workload N01	R6/29U
107	TUC-SNK50N01ZTWRKDC03-30U-14	Server Workload N01	R6/30U
108	TUC-SNK50N01ZTWRKDC03-31U-15	Server Workload N01	R6/31U
109	TUC-SNK50N01ZTWRKDC03-32U-16	Server Workload N01	R6/32U
110	TUC-SNK50N01ZTWRKDC03-33U-17	Server Workload N01	R6/33U
111	TUC-SNK50N01ZTWRKDC03-34U-18	Server Workload N01	R6/34U
112	TUC-SNK50N01ZTWRKDC02-08U-19	Server Workload N01	R7/08U
113	TUC-SNK50N01ZTWRKDC02-09U-20	Server Workload N01	R7/09U
114	TUC-SNK50N01ZTWRKDC02-10U-21	Server Workload N01	R7/10U
115	TUC-SNK50N01ZTWRKDC02-11U-22	Server Workload N01	R7/11U
116	TUC-SNK50N01ZTWRKDC02-12U-23	Server Workload N01	R7/12U
117	TUC-SNK50N01ZTWRKDC02-13U-24	Server Workload N01	R7/13U
118	TUC-SNK50N01ZTWRKDC02-14U-25	Server Workload N01	R7/14U
119	TUC-SNK50N01ZTWRKDC02-26U-26	Server Workload N01	R7/26U
120	TUC-SNK50N01ZTWRKDC02-27U-27	Server Workload N01	R7/27U
121	TUC-SNK50N01ZTWRKDC02-28U-28	Server Workload N01	R7/28U
122	TUC-SNK50N01ZTWRKDC02-29U-29	Server Workload N01	R7/29U
123	TUC-SNK50N01ZTWRKDC02-30U-30	Server Workload N01	R7/30U
124	TUC-SNK50N01ZTCEPDC03-01U-01	RH OCP CEPH N01	R6/01U
125	TUC-SNK50N01ZTCEPDC03-03U-02	RH OCP CEPH N01	R6/03U
126	TUC-SNK50N01ZTCEPDC02-01U-03	RH OCP CEPH N01	R7/01U
127	TUC-SNK50N01ZTCEPDC02-03U-04	RH OCP CEPH N01	R7/03U
128	TUC-SNK50N01ZTCOMDC02-24U-SPLUNK01	Server Splunk	R7/24U
129	TUC-SNK50N01ZTCOMDC02-25U-SPLUNK02	Server Splunk	R7/25U
130	TUC-SNK50N01ZTLEFDC03-16U-M&S01	M&S Leaf N01	R6/16U
131	TUC-SNK50N01ZTLEFDC02-16U-M&S02	M&S Leaf N01	R7/16U
132	TUC-SNK50N01ZTLEFDC03-18U-M&S03	M&S Leaf N01	R6/18U
133	TUC-SNK50N01ZTLEFDC02-18U-M&S04	M&S Leaf N01	R7/18U
134	TUC-SNK50N01ZTLEFDC03-20U-SRV01	SRV Leaf N01	R6/20U
135	TUC-SNK50N01ZTLEFDC02-20U-SRV02	SRV Leaf N01	R7/20U
136	TUC-SNK50M01ZTOOBAB09-21U-ACC01	OOB ACC	R3/21U
137	TUC-SNK50M01ZTOOBDC07-22U-ACC02	OOB ACC	R4/22U
138	TUC-SNK50M01ZTOOBDC03-22U-ACC03	OOB ACC	R6/22U
139	TUC-SNK50M01ZTOOBDC02-22U-ACC04	OOB ACC	R7/22U
140	TUC-SNK50M01ZTOOBAB11-21U-AGG01	OOB AGG	R1/21U
141	TUC-SNK50M01ZTOOBAB10-21U-AGG02	OOB AGG	R2/21U
142	TUC-SNK50M01ZTSPNDB05-26U-M&S01	M&S Spine	SW R3/26U
143	TUC-SNK50M01ZTSPNDB04-26U-M&S02	M&S Spine	SW R4/26U
144	TUC-SNK50M01ZTSPNDB02-01U-SRV01	SRV Spine	SW R5/01U
145	TUC-SNK50M01ZTSPNDB01-01U-SRV02	SRV Spine	SW R6/01U
146	TUC-SNK50M01ZTDCGDB10-01U-01	DCGW	SW R1/01U
147	TUC-SNK50M01ZTDCGDB09-01U-02	DCGW	SW R2/01U
\.


--
-- TOC entry 5062 (class 0 OID 50595)
-- Dependencies: 224
-- Data for Name: domains; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.domains (domainid, domainname, domainname_m) FROM stdin;
1	Management Domain	M
2	Secure Domain	S
3	Non Exposed Domain	N
4	All Domain	M
\.


--
-- TOC entry 5112 (class 0 OID 4465899)
-- Dependencies: 274
-- Data for Name: edit_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.edit_log (id, table_name, units, original_value, updated_value, "timestamp") FROM stdin;
1	snk_r1	31U	None	TUC-SNK50M01ZTCOMAB11-31U-EMSFW01	2024-11-02 11:55:14.134085
2	snk_r1	30U	TUC-SNK50M01ZTCOMAB11-30U-EMSFW01		2024-11-02 11:55:14.134085
3	snk_r3	22U	None	TUC-SNK50M01ZTOOBAB09-22U-ACC01	2024-11-02 11:55:14.134085
4	snk_r3	21U	TUC-SNK50M01ZTOOBAB09-21U-ACC01		2024-11-02 11:55:14.134085
5	snk_r1	31U	None	TUC-SNK50M01ZTCOMAB11-31U-EMSFW01	2024-11-02 12:05:12.321937
6	snk_r1	30U	TUC-SNK50M01ZTCOMAB11-30U-EMSFW01		2024-11-02 12:05:12.321937
7	snk_r3	22U	None	TUC-SNK50M01ZTOOBAB09-22U-ACC01	2024-11-02 12:05:12.321937
8	snk_r3	21U	TUC-SNK50M01ZTOOBAB09-21U-ACC01		2024-11-02 12:05:12.321937
9	snk_r7	34U	None	TUC-SNK50N01ZTWRKDC02-30U-30	2024-11-02 12:05:12.321937
10	snk_r7	33U	None	TUC-SNK50N01ZTWRKDC02-29U-29	2024-11-02 12:05:12.321937
11	snk_r7	32U	None	TUC-SNK50N01ZTWRKDC02-28U-28	2024-11-02 12:05:12.321937
12	snk_r7	31U	None	TUC-SNK50N01ZTWRKDC02-27U-27	2024-11-02 12:05:12.321937
13	snk_r7	30U	TUC-SNK50N01ZTWRKDC02-30U-30	TUC-SNK50N01ZTWRKDC02-26U-26	2024-11-02 12:05:12.321937
14	snk_r7	29U	TUC-SNK50N01ZTWRKDC02-29U-29	TUC-SNK50N01ZTWRKDC02-14U-25	2024-11-02 12:05:12.321937
15	snk_r7	28U	TUC-SNK50N01ZTWRKDC02-28U-28		2024-11-02 12:05:12.321937
16	snk_r7	27U	TUC-SNK50N01ZTWRKDC02-27U-27		2024-11-02 12:05:12.321937
17	snk_r7	26U	TUC-SNK50N01ZTWRKDC02-26U-26		2024-11-02 12:05:12.321937
18	snk_r7	14U	TUC-SNK50N01ZTWRKDC02-14U-25		2024-11-02 12:05:12.321937
19	snk_swr3	20U	TUC-SNK50M01ZTTAPDB05-20U-MASSW01		2024-11-02 12:08:05.574961
20	snk_swr3	18U	None	TUC-SNK50M01ZTTAPDB05-18U-MASSW01	2024-11-02 12:08:05.574961
21	snk_swr4	20U	TUC-SNK50M01ZTTAPDB04-20U-MASSW02		2024-11-02 12:08:05.574961
22	snk_swr4	18U	None	TUC-SNK50M01ZTTAPDB04-18U-MASSW02	2024-11-02 12:08:05.574961
\.


--
-- TOC entry 5076 (class 0 OID 50664)
-- Dependencies: 238
-- Data for Name: inputdata; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inputdata (inputid, site_input, domain_input, brand_input, cluster_input, node_input, rackposition_input, rackunit_input) FROM stdin;
1	SNK	Management Domain	ZTE	Support Node 01	R5200G5(Arch2-2)RH Supporting Node for OCP	R1	02U
2	SNK	Management Domain	ZTE	Support Node 01	R5200G5(Arch2-2)RH Supporting Node for OCP	R2	02U
3	SNK	Management Domain	ZTE	SDN 01	R5200G5(Arch2-2) ZTE ZENIC(SDN-C)	R1	03U
4	SNK	Management Domain	ZTE	SDN 01	R5200G5(Arch2-2) ZTE ZENIC(SDN-C)	R2	03U
5	SNK	Management Domain	ZTE	SDN 01	R5200G5(Arch2-2) ZTE ZENIC(SDN-C)	R3	03U
6	SNK	Management Domain	ZTE	SDN 01	R5200G5(Arch2-2) ZTE TECS Openstack(PIM & BM & OCP-SDN-Adapter)	R1	01U
7	SNK	Management Domain	ZTE	SDN 01	R5200G5(Arch2-2) ZTE TECS Openstack(PIM & BM & OCP-SDN-Adapter)	R2	01U
8	SNK	Management Domain	ZTE	SDN 01	R5200G5(Arch2-2) ZTE TECS Openstack(PIM & BM & OCP-SDN-Adapter)	R3	01U
9	SNK	Management Domain	ZTE	BN EMS 01	R5200G5(Arch2-2) BN EMS Server	R3	02U
10	SNK	Management Domain	ZTE	Splunk HF 01	R5200G5(Arch2-2)Splunk forwarder	R2	05U
11	SNK	Management Domain	ZTE	Splunk HF 01	R5200G5(Arch2-2)Splunk forwarder	R2	06U
12	SNK	Management Domain	H3C	H3C UniServer 01	H3C UniServer R4900 G5_Tapping	R1	14U
13	SNK	Management Domain	H3C	H3C UniServer 01	H3C UniServer R4900 G5_Tapping	R2	14U
14	SNK	Management Domain	H3C	H3C TAP8000-CE54_Tapping 01	H3C TAP8000-CE54_Tapping	SW R3	22U
15	SNK	Management Domain	H3C	H3C TAP8000-CE54_Tapping 01	H3C TAP8000-CE54_Tapping	SW R4	22U
16	SNK	Management Domain	ZTE	Backup Storage 01	KS3200 V2 ZTE Backup Storage	R3	06U
17	SNK	Management Domain	ZTE	Backup Server 01	R5200G5(Arch2-1)Backup Server	R1	04U
18	SNK	Management Domain	ZTE	Backup Server 01	R5200G5(Arch2-1)Backup Server	R2	04U
19	SNK	Management Domain	ZTE	Backup Server 01	R5200G5(Arch2-1)Backup Server	R3	04U
20	SNK	Management Domain	ZTE	VAScanner 01	R5200G5(Arch2-2)VAScanner	R1	05U
21	SNK	Management Domain	ZTE	VAScanner 01	R5200G5(Arch2-2)VAScanner	R1	06U
22	SNK	Management Domain	ZTE	VAScanner 01	R5200G5(Arch2-2)VAScanner	R1	07U
23	SNK	Management Domain	ZTE	FW EMS 01	R5300G5(Arch3) FW EMS Server	R1	30U
24	SNK	Management Domain	ZTE	FW EMS 01	R5300G5(Arch3) FW EMS Server	R2	30U
25	SNK	Management Domain	Fortinet	FW 01	FG-2600F-DC	R1	23U
26	SNK	Management Domain	Fortinet	FW 01	FG-2600F-DC	R2	23U
27	SNK	Management Domain	Fortinet	FW 01	FG-1800F-DC	R1	25U
28	SNK	Management Domain	Fortinet	FW 01	FG-1800F-DC	R2	25U
29	SNK	Management Domain	Fortinet	FW 01	FAD-1200F-DC	R1	28U
30	SNK	Management Domain	Fortinet	FW 01	FAD-1200F-DC	R2	28U
31	SNK	Management Domain	H3C	Splitter 01	TRC-OEO-ODN-8M-MPO Splitter	SW R3	24U
32	SNK	Management Domain	ZTE	SW-MGT 01	ZXR10 5960X-56QU-HF (MAS)	SW R3	20U
33	SNK	Management Domain	ZTE	SW-MGT 01	ZXR10 5960X-56QU-HF (MAS)	SW R4	20U
34	SNK	Management Domain	ZTE	SW-MGT 01	ZXR10 5960X-56QU-HF (MNG&STOR Leaf SW)	R1	17U
35	SNK	Management Domain	ZTE	SW-MGT 01	ZXR10 5960X-56QU-HF (MNG&STOR Leaf SW)	R2	17U
36	SNK	Management Domain	ZTE	SW-MGT 01	ZXR10 5960X-56QU-HF (Service Leaf 25G SW)	R1	19U
37	SNK	Management Domain	ZTE	SW-MGT 01	ZXR10 5960X-56QU-HF (Service Leaf 25G SW)	R2	19U
38	SNK	Secure Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-2)RH APP Master Node	R4	05U
39	SNK	Secure Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-2)RH APP Master Node	R4	06U
40	SNK	Secure Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-2)RH APP Master Node	R5	05U
41	SNK	Secure Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-2)RH Infra Logging-Metrics-Router	R4	07U
42	SNK	Secure Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-2)RH Infra Logging-Metrics-Router	R5	06U
43	SNK	Secure Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-2)RH Infra Logging-Metrics-Router	R5	07U
44	SNK	Secure Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-1)Workload_Cluster 01	R4	08U
45	SNK	Secure Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-1)Workload_Cluster 01	R4	09U
46	SNK	Secure Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-1)Workload_Cluster 01	R4	10U
47	SNK	Secure Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-1)Workload_Cluster 01	R4	11U
48	SNK	Secure Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-1)Workload_Cluster 01	R4	12U
49	SNK	Secure Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-1)Workload_Cluster 01	R4	13U
50	SNK	Secure Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-1)Workload_Cluster 01	R4	14U
51	SNK	Secure Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-1)Workload_Cluster 01	R4	24U
52	SNK	Secure Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-1)Workload_Cluster 01	R4	25U
53	SNK	Secure Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-1)Workload_Cluster 01	R4	26U
54	SNK	Secure Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-1)Workload_Cluster 01	R4	27U
55	SNK	Secure Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-1)Workload_Cluster 01	R4	28U
56	SNK	Secure Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-1)Workload_Cluster 01	R4	29U
57	SNK	Secure Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-1)Workload_Cluster 01	R4	30U
58	SNK	Secure Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-1)Workload_Cluster 01	R4	31U
59	SNK	Secure Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-1)Workload_Cluster 01	R4	32U
60	SNK	Secure Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-1)Workload_Cluster 01	R4	33U
61	SNK	Secure Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-1)Workload_Cluster 01	R4	34U
62	SNK	Secure Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-1)Workload_Cluster 01	R5	08U
63	SNK	Secure Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-1)Workload_Cluster 01	R5	09U
64	SNK	Secure Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-1)Workload_Cluster 01	R5	10U
65	SNK	Secure Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-1)Workload_Cluster 01	R5	11U
66	SNK	Secure Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-1)Workload_Cluster 01	R5	12U
67	SNK	Secure Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-1)Workload_Cluster 01	R5	13U
68	SNK	Secure Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-1)Workload_Cluster 01	R5	14U
69	SNK	Secure Domain	ZTE	OCP Cluster 01	R5300G5(Arch3)RH ODF for OCP Cluster 01	R4	01U
70	SNK	Secure Domain	ZTE	OCP Cluster 01	R5300G5(Arch3)RH ODF for OCP Cluster 01	R4	03U
71	SNK	Secure Domain	ZTE	OCP Cluster 01	R5300G5(Arch3)RH ODF for OCP Cluster 01	R5	01U
72	SNK	Secure Domain	ZTE	OCP Cluster 01	R5300G5(Arch3)RH ODF for OCP Cluster 01	R5	03U
73	SNK	Secure Domain	ZTE	OCP Cluster 01	R5200G5(HSM)HSM_Pool 01	R5	24U
74	SNK	Secure Domain	ZTE	OCP Cluster 01	R5200G5(HSM)HSM_Pool 01	R5	25U
75	SNK	Secure Domain	ZTE	OCP Cluster 01	R5200G5(HSM)HSM_Pool 01	R5	26U
76	SNK	Secure Domain	ZTE	OCP Cluster 01	R5200G5(HSM)HSM_Pool 01	R5	27U
77	SNK	Secure Domain	ZTE	OCP Cluster 01	R5200G5(HSM)HSM_Pool 01	R5	28U
78	SNK	Secure Domain	ZTE	OCP Cluster 01	R5200G5(HSM)HSM_Pool 01	R5	29U
79	SNK	Secure Domain	ZTE	OCP Cluster 01	R5200G5(HSM)HSM_Pool 01	R5	30U
80	SNK	Secure Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-2)Splunk forwarder	R5	22U
81	SNK	Secure Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-2)Splunk forwarder	R5	23U
82	SNK	Secure Domain	ZTE	OCP Cluster 01	ZXR10 5960X-56QU-HF (MNG&STOR Leaf SW)	R4	16U
83	SNK	Secure Domain	ZTE	OCP Cluster 01	ZXR10 5960X-56QU-HF (MNG&STOR Leaf SW)	R5	16U
84	SNK	Secure Domain	ZTE	OCP Cluster 01	ZXR10 5960X-56QU-HF (MNG&STOR Leaf SW)	R4	18U
85	SNK	Secure Domain	ZTE	OCP Cluster 01	ZXR10 5960X-56QU-HF (MNG&STOR Leaf SW)	R5	18U
86	SNK	Secure Domain	ZTE	OCP Cluster 01	ZXR10 5960X-56QU-HF (Service Leaf 25G SW)	R4	20U
87	SNK	Secure Domain	ZTE	OCP Cluster 01	ZXR10 5960X-56QU-HF (Service Leaf 25G SW)	R5	20U
88	SNK	Non Exposed Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-2)RH APP Master Node	R6	05U
89	SNK	Non Exposed Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-2)RH APP Master Node	R6	06U
90	SNK	Non Exposed Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-2)RH APP Master Node	R7	05U
91	SNK	Non Exposed Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-2)RH Infra Logging-Metrics-Router	R6	07U
92	SNK	Non Exposed Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-2)RH Infra Logging-Metrics-Router	R7	06U
93	SNK	Non Exposed Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-2)RH Infra Logging-Metrics-Router	R7	07U
94	SNK	Non Exposed Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-1)Workload_Cluster 01	R6	08U
95	SNK	Non Exposed Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-1)Workload_Cluster 01	R6	09U
96	SNK	Non Exposed Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-1)Workload_Cluster 01	R6	10U
97	SNK	Non Exposed Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-1)Workload_Cluster 01	R6	11U
98	SNK	Non Exposed Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-1)Workload_Cluster 01	R6	12U
99	SNK	Non Exposed Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-1)Workload_Cluster 01	R6	13U
100	SNK	Non Exposed Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-1)Workload_Cluster 01	R6	14U
101	SNK	Non Exposed Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-1)Workload_Cluster 01	R6	24U
102	SNK	Non Exposed Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-1)Workload_Cluster 01	R6	25U
103	SNK	Non Exposed Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-1)Workload_Cluster 01	R6	26U
104	SNK	Non Exposed Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-1)Workload_Cluster 01	R6	27U
105	SNK	Non Exposed Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-1)Workload_Cluster 01	R6	28U
106	SNK	Non Exposed Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-1)Workload_Cluster 01	R6	29U
107	SNK	Non Exposed Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-1)Workload_Cluster 01	R6	30U
108	SNK	Non Exposed Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-1)Workload_Cluster 01	R6	31U
109	SNK	Non Exposed Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-1)Workload_Cluster 01	R6	32U
110	SNK	Non Exposed Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-1)Workload_Cluster 01	R6	33U
111	SNK	Non Exposed Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-1)Workload_Cluster 01	R6	34U
112	SNK	Non Exposed Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-1)Workload_Cluster 01	R7	08U
113	SNK	Non Exposed Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-1)Workload_Cluster 01	R7	09U
114	SNK	Non Exposed Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-1)Workload_Cluster 01	R7	10U
115	SNK	Non Exposed Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-1)Workload_Cluster 01	R7	11U
116	SNK	Non Exposed Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-1)Workload_Cluster 01	R7	12U
117	SNK	Non Exposed Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-1)Workload_Cluster 01	R7	13U
118	SNK	Non Exposed Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-1)Workload_Cluster 01	R7	14U
119	SNK	Non Exposed Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-1)Workload_Cluster 01	R7	26U
120	SNK	Non Exposed Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-1)Workload_Cluster 01	R7	27U
121	SNK	Non Exposed Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-1)Workload_Cluster 01	R7	28U
122	SNK	Non Exposed Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-1)Workload_Cluster 01	R7	29U
123	SNK	Non Exposed Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-1)Workload_Cluster 01	R7	30U
124	SNK	Non Exposed Domain	ZTE	OCP Cluster 01	R5300G5(Arch3)RH ODF for OCP Cluster 01	R6	01U
125	SNK	Non Exposed Domain	ZTE	OCP Cluster 01	R5300G5(Arch3)RH ODF for OCP Cluster 01	R6	03U
126	SNK	Non Exposed Domain	ZTE	OCP Cluster 01	R5300G5(Arch3)RH ODF for OCP Cluster 01	R7	01U
127	SNK	Non Exposed Domain	ZTE	OCP Cluster 01	R5300G5(Arch3)RH ODF for OCP Cluster 01	R7	03U
128	SNK	Non Exposed Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-2)Splunk forwarder	R7	24U
129	SNK	Non Exposed Domain	ZTE	OCP Cluster 01	R5200G5(Arch2-2)Splunk forwarder	R7	25U
130	SNK	Non Exposed Domain	ZTE	OCP Cluster 01	ZXR10 5960X-56QU-HF (MNG&STOR Leaf SW for Cluster 01)	R6	16U
131	SNK	Non Exposed Domain	ZTE	OCP Cluster 01	ZXR10 5960X-56QU-HF (MNG&STOR Leaf SW for Cluster 01)	R7	16U
132	SNK	Non Exposed Domain	ZTE	OCP Cluster 01	ZXR10 5960X-56QU-HF (MNG&STOR Leaf SW for Cluster 01)	R6	18U
133	SNK	Non Exposed Domain	ZTE	OCP Cluster 01	ZXR10 5960X-56QU-HF (MNG&STOR Leaf SW for Cluster 01)	R7	18U
134	SNK	Non Exposed Domain	ZTE	OCP Cluster 01	ZXR10 5960X-56QU-HF (Service Leaf 25G SW for Cluster 01)	R6	20U
135	SNK	Non Exposed Domain	ZTE	OCP Cluster 01	ZXR10 5960X-56QU-HF (Service Leaf 25G SW for Cluster 01)	R7	20U
136	SNK	All Domain	ZTE	OCP Cluster 01	ZXR10 5950-60TM-E (OOB ACC)_All Dom	R3	21U
137	SNK	All Domain	ZTE	OCP Cluster 01	ZXR10 5950-60TM-E (OOB ACC)_All Dom	R4	22U
138	SNK	All Domain	ZTE	OCP Cluster 01	ZXR10 5950-60TM-E (OOB ACC)_All Dom	R6	22U
139	SNK	All Domain	ZTE	OCP Cluster 01	ZXR10 5950-60TM-E (OOB ACC)_All Dom	R7	22U
140	SNK	All Domain	ZTE	OCP Cluster 01	ZXR10 5950-60TM-E (OOB AGG)_All Dom	R1	21U
141	SNK	All Domain	ZTE	OCP Cluster 01	ZXR10 5950-60TM-E (OOB AGG)_All Dom	R2	21U
142	SNK	All Domain	ZTE	OCP Cluster 01	ZXR10 9904X (MNG&STOR Spine SW)_Switch_Y2024	SW R3	26U
143	SNK	All Domain	ZTE	OCP Cluster 01	ZXR10 9904X (MNG&STOR Spine SW)_Switch_Y2024	SW R4	26U
144	SNK	All Domain	ZTE	OCP Cluster 01	ZXR10 9916X (Service Spine SW)_Switch_Y2024	SW R5	01U
145	SNK	All Domain	ZTE	OCP Cluster 01	ZXR10 9916X (Service Spine SW)_Switch_Y2024	SW R6	01U
146	SNK	All Domain	ZTE	OCP Cluster 01	ZXR10 M6000-18S (DCGW RT)_Router_Y2024	SW R1	01U
147	SNK	All Domain	ZTE	OCP Cluster 01	ZXR10 M6000-18S (DCGW RT)_Router_Y2024	SW R2	01U
\.


--
-- TOC entry 5082 (class 0 OID 2033174)
-- Dependencies: 244
-- Data for Name: map_acc; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.map_acc (type_hw) FROM stdin;
﻿M&S Leaf M
SRV Leaf M
M&S Leaf S
SRV Leaf S
M&S Leaf N01
SRV Leaf N01
OOB AGG
\.


--
-- TOC entry 5079 (class 0 OID 72031)
-- Dependencies: 241
-- Data for Name: map_agg; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.map_agg (type_hw) FROM stdin;
DCGW
M&S Spine
SRV Spine
MAS SW
NPBSW
FW-I
FW4
WAF-I
OOB ACC
OOB AGG
\.


--
-- TOC entry 5085 (class 0 OID 3864366)
-- Dependencies: 247
-- Data for Name: map_ms; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.map_ms (type_hw, port_1, port_2, port_3, port_4) FROM stdin;
RH OCP Support	ens1f0	ens2f0	ens1f1	ens2f1
Server Backup	ens1f0	ens1f1	ens2f0	ens2f1
Server VAScanner	ens1f0	ens2f0	ens1f1	ens2f1
Server EMS FW	ens5f0	ens5f1	ens7f0	ens7f1
Server Splunk	ens1f0	ens2f0	ens1f1	ens2f1
Backup Storage	HBA-0_10GE(iscsi)-1	HBA-1_10GE(iscsi)-1	HBA-0_10GE(iscsi)-2\n	HBA-1_10GE(iscsi)-2
SDN Adapter	ens1f0	\N	ens1f1	\N
Server SDN-C	ens1f0	\N	ens1f1	\N
RH OCP CEPH S01	ens5f0	ens7f0	ens5f1	ens7f1
RH APP Master S01	ens1f0	ens2f0	ens1f1	ens2f1
RH Infra Logging S01	ens1f0	ens2f0	ens1f1	ens2f1
Server Workload S01	ens1f0	\N	ens1f1	\N
Server HSM S01	ens1f0	\N	ens1f1	\N
RH OCP CEPH N01	ens5f0	ens7f0	ens5f1	ens7f1
RH APP Master N01	ens1f0	ens2f0	ens1f1	ens2f1
RH Infra Logging N01	ens1f0	ens2f0	ens1f1	ens2f1
Server Workload N01	ens1f0	\N	ens1f1	\N
\.


--
-- TOC entry 5084 (class 0 OID 3815518)
-- Dependencies: 246
-- Data for Name: map_srv; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.map_srv (type_hw, port_1, port_2) FROM stdin;
SDN Adapter	ens2f0	ens2f1
Server SDN-C	ens2f0	ens2f1
Server Workload S01	ens2f0	ens2f1
Server HSM S01	ens2f0	ens2f1
Server Workload N01	ens2f0	ens2f1
\.


--
-- TOC entry 5074 (class 0 OID 50654)
-- Dependencies: 236
-- Data for Name: mappingdevices; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mappingdevices (deviceid, inputid, device_names, positions, units) FROM stdin;
1	1	TUC-SNK50M01ZTSUPAB11-02U-01	AB11	02U
2	2	TUC-SNK50M01ZTSUPAB10-02U-02	AB10	02U
3	3	TUC-SNK50M01ZTCOMAB11-03U-SDNC01	AB11	03U
4	4	TUC-SNK50M01ZTCOMAB10-03U-SDNC02	AB10	03U
5	5	TUC-SNK50M01ZTCOMAB09-03U-SDNC03	AB09	03U
6	6	TUC-SNK50M01ZTCOMAB11-01U-SDNADAPTER01	AB11	01U
7	7	TUC-SNK50M01ZTCOMAB10-01U-SDNADAPTER02	AB10	01U
8	8	TUC-SNK50M01ZTCOMAB09-01U-SDNADAPTER03	AB09	01U
9	9	TUC-SNK50M01ZTCOMAB09-02U-EMSSW01	AB09	02U
10	10	TUC-SNK50M01ZTCOMAB10-05U-SPLUNK01	AB10	05U
11	11	TUC-SNK50M01ZTCOMAB10-06U-SPLUNK02	AB10	06U
12	12	TUC-SNK50M01H3TAPAB11-14U-CTRL01	AB11	14U
13	13	TUC-SNK50M01H3TAPAB10-14U-CTRL02	AB10	14U
14	14	TUC-SNK50M01H3TAPDB05-22U-NPBSW01	DB05	22U
15	15	TUC-SNK50M01H3TAPDB04-22U-NPBSW02	DB04	22U
16	16	TUC-SNK50M01ZTBAKAB09-06U-STORAGE01	AB09	06U
17	17	TUC-SNK50M01ZTBAKAB11-04U-SERVER01	AB11	04U
18	18	TUC-SNK50M01ZTBAKAB10-04U-SERVER02	AB10	04U
19	19	TUC-SNK50M01ZTBAKAB09-04U-SERVER03	AB09	04U
20	20	TUC-SNK50M01ZTCOMAB11-05U-VASCAN01	AB11	05U
21	21	TUC-SNK50M01ZTCOMAB11-06U-VASCAN02	AB11	06U
22	22	TUC-SNK50M01ZTCOMAB11-07U-VASCAN03	AB11	07U
23	23	TUC-SNK50M01ZTCOMAB11-30U-EMSFW01	AB11	30U
24	24	TUC-SNK50M01ZTCOMAB10-30U-EMSFW02	AB10	30U
25	25	TUC-SNK50M01FTIFWAB11-23U-01	AB11	23U
26	26	TUC-SNK50M01FTIFWAB10-23U-02	AB10	23U
27	27	TUC-SNK50M01FTFW4AB11-25U-01	AB11	25U
28	28	TUC-SNK50M01FTFW4AB10-25U-02	AB10	25U
29	29	TUC-SNK50M01FTWAFAB11-28U-WAF-I01	AB11	28U
30	30	TUC-SNK50M01FTWAFAB10-28U-WAF-I02	AB10	28U
31	31	TUC-SNK50M01H3ATPDB05-24U-SPLT01	DB05	24U
32	32	TUC-SNK50M01ZTTAPDB05-20U-MASSW01	DB05	20U
33	33	TUC-SNK50M01ZTTAPDB04-20U-MASSW02	DB04	20U
34	34	TUC-SNK50M01ZTLEFAB11-17U-M&S01	AB11	17U
35	35	TUC-SNK50M01ZTLEFAB10-17U-M&S02	AB10	17U
36	36	TUC-SNK50M01ZTLEFAB11-19U-SRV01	AB11	19U
37	37	TUC-SNK50M01ZTLEFAB10-19U-SRV02	AB10	19U
38	38	TUC-SNK50S01ZTMASDC07-05U-01	DC07	05U
39	39	TUC-SNK50S01ZTMASDC07-06U-02	DC07	06U
40	40	TUC-SNK50S01ZTMASDC06-05U-03	DC06	05U
41	41	TUC-SNK50S01ZTINFDC07-07U-01	DC07	07U
42	42	TUC-SNK50S01ZTINFDC06-06U-02	DC06	06U
43	43	TUC-SNK50S01ZTINFDC06-07U-03	DC06	07U
44	44	TUC-SNK50S01ZTWRKDC07-08U-01	DC07	08U
45	45	TUC-SNK50S01ZTWRKDC07-09U-02	DC07	09U
46	46	TUC-SNK50S01ZTWRKDC07-10U-03	DC07	10U
47	47	TUC-SNK50S01ZTWRKDC07-11U-04	DC07	11U
48	48	TUC-SNK50S01ZTWRKDC07-12U-05	DC07	12U
49	49	TUC-SNK50S01ZTWRKDC07-13U-06	DC07	13U
50	50	TUC-SNK50S01ZTWRKDC07-14U-07	DC07	14U
51	51	TUC-SNK50S01ZTWRKDC07-24U-08	DC07	24U
52	52	TUC-SNK50S01ZTWRKDC07-25U-09	DC07	25U
53	53	TUC-SNK50S01ZTWRKDC07-26U-10	DC07	26U
54	54	TUC-SNK50S01ZTWRKDC07-27U-11	DC07	27U
55	55	TUC-SNK50S01ZTWRKDC07-28U-12	DC07	28U
56	56	TUC-SNK50S01ZTWRKDC07-29U-13	DC07	29U
57	57	TUC-SNK50S01ZTWRKDC07-30U-14	DC07	30U
58	58	TUC-SNK50S01ZTWRKDC07-31U-15	DC07	31U
59	59	TUC-SNK50S01ZTWRKDC07-32U-16	DC07	32U
60	60	TUC-SNK50S01ZTWRKDC07-33U-17	DC07	33U
61	61	TUC-SNK50S01ZTWRKDC07-34U-18	DC07	34U
62	62	TUC-SNK50S01ZTWRKDC06-08U-19	DC06	08U
63	63	TUC-SNK50S01ZTWRKDC06-09U-20	DC06	09U
64	64	TUC-SNK50S01ZTWRKDC06-10U-21	DC06	10U
65	65	TUC-SNK50S01ZTWRKDC06-11U-22	DC06	11U
66	66	TUC-SNK50S01ZTWRKDC06-12U-23	DC06	12U
67	67	TUC-SNK50S01ZTWRKDC06-13U-24	DC06	13U
68	68	TUC-SNK50S01ZTWRKDC06-14U-25	DC06	14U
69	69	TUC-SNK50S01ZTCEPDC07-01U-01	DC07	01U
70	70	TUC-SNK50S01ZTCEPDC07-03U-02	DC07	03U
71	71	TUC-SNK50S01ZTCEPDC06-01U-03	DC06	01U
72	72	TUC-SNK50S01ZTCEPDC06-03U-04	DC06	03U
73	73	TUC-SNK50S01ZTCOMDC06-24U-HSM01	DC06	24U
74	74	TUC-SNK50S01ZTCOMDC06-25U-HSM02	DC06	25U
75	75	TUC-SNK50S01ZTCOMDC06-26U-HSM03	DC06	26U
76	76	TUC-SNK50S01ZTCOMDC06-27U-HSM04	DC06	27U
77	77	TUC-SNK50S01ZTCOMDC06-28U-HSM05	DC06	28U
78	78	TUC-SNK50S01ZTCOMDC06-29U-HSM06	DC06	29U
79	79	TUC-SNK50S01ZTCOMDC06-30U-HSM07	DC06	30U
80	80	TUC-SNK50S01ZTCOMDC06-22U-SPLUNK01	DC06	22U
81	81	TUC-SNK50S01ZTCOMDC06-23U-SPLUNK02	DC06	23U
82	82	TUC-SNK50S01ZTLEFDC07-16U-M&S01	DC07	16U
83	83	TUC-SNK50S01ZTLEFDC06-16U-M&S02	DC06	16U
84	84	TUC-SNK50S01ZTLEFDC07-18U-M&S03	DC07	18U
85	85	TUC-SNK50S01ZTLEFDC06-18U-M&S04	DC06	18U
86	86	TUC-SNK50S01ZTLEFDC07-20U-SRV01	DC07	20U
87	87	TUC-SNK50S01ZTLEFDC06-20U-SRV02	DC06	20U
88	88	TUC-SNK50N01ZTMASDC03-05U-01	DC03	05U
89	89	TUC-SNK50N01ZTMASDC03-06U-02	DC03	06U
90	90	TUC-SNK50N01ZTMASDC02-05U-03	DC02	05U
91	91	TUC-SNK50N01ZTINFDC03-07U-01	DC03	07U
92	92	TUC-SNK50N01ZTINFDC02-06U-02	DC02	06U
93	93	TUC-SNK50N01ZTINFDC02-07U-03	DC02	07U
94	94	TUC-SNK50N01ZTWRKDC03-08U-01	DC03	08U
95	95	TUC-SNK50N01ZTWRKDC03-09U-02	DC03	09U
96	96	TUC-SNK50N01ZTWRKDC03-10U-03	DC03	10U
97	97	TUC-SNK50N01ZTWRKDC03-11U-04	DC03	11U
98	98	TUC-SNK50N01ZTWRKDC03-12U-05	DC03	12U
99	99	TUC-SNK50N01ZTWRKDC03-13U-06	DC03	13U
100	100	TUC-SNK50N01ZTWRKDC03-14U-07	DC03	14U
101	101	TUC-SNK50N01ZTWRKDC03-24U-08	DC03	24U
102	102	TUC-SNK50N01ZTWRKDC03-25U-09	DC03	25U
103	103	TUC-SNK50N01ZTWRKDC03-26U-10	DC03	26U
104	104	TUC-SNK50N01ZTWRKDC03-27U-11	DC03	27U
105	105	TUC-SNK50N01ZTWRKDC03-28U-12	DC03	28U
106	106	TUC-SNK50N01ZTWRKDC03-29U-13	DC03	29U
107	107	TUC-SNK50N01ZTWRKDC03-30U-14	DC03	30U
108	108	TUC-SNK50N01ZTWRKDC03-31U-15	DC03	31U
109	109	TUC-SNK50N01ZTWRKDC03-32U-16	DC03	32U
110	110	TUC-SNK50N01ZTWRKDC03-33U-17	DC03	33U
111	111	TUC-SNK50N01ZTWRKDC03-34U-18	DC03	34U
112	112	TUC-SNK50N01ZTWRKDC02-08U-19	DC02	08U
113	113	TUC-SNK50N01ZTWRKDC02-09U-20	DC02	09U
114	114	TUC-SNK50N01ZTWRKDC02-10U-21	DC02	10U
115	115	TUC-SNK50N01ZTWRKDC02-11U-22	DC02	11U
116	116	TUC-SNK50N01ZTWRKDC02-12U-23	DC02	12U
117	117	TUC-SNK50N01ZTWRKDC02-13U-24	DC02	13U
118	118	TUC-SNK50N01ZTWRKDC02-14U-25	DC02	14U
119	119	TUC-SNK50N01ZTWRKDC02-26U-26	DC02	26U
120	120	TUC-SNK50N01ZTWRKDC02-27U-27	DC02	27U
121	121	TUC-SNK50N01ZTWRKDC02-28U-28	DC02	28U
122	122	TUC-SNK50N01ZTWRKDC02-29U-29	DC02	29U
123	123	TUC-SNK50N01ZTWRKDC02-30U-30	DC02	30U
124	124	TUC-SNK50N01ZTCEPDC03-01U-01	DC03	01U
125	125	TUC-SNK50N01ZTCEPDC03-03U-02	DC03	03U
126	126	TUC-SNK50N01ZTCEPDC02-01U-03	DC02	01U
127	127	TUC-SNK50N01ZTCEPDC02-03U-04	DC02	03U
128	128	TUC-SNK50N01ZTCOMDC02-24U-SPLUNK01	DC02	24U
129	129	TUC-SNK50N01ZTCOMDC02-25U-SPLUNK02	DC02	25U
130	130	TUC-SNK50N01ZTLEFDC03-16U-M&S01	DC03	16U
131	131	TUC-SNK50N01ZTLEFDC02-16U-M&S02	DC02	16U
132	132	TUC-SNK50N01ZTLEFDC03-18U-M&S03	DC03	18U
133	133	TUC-SNK50N01ZTLEFDC02-18U-M&S04	DC02	18U
134	134	TUC-SNK50N01ZTLEFDC03-20U-SRV01	DC03	20U
135	135	TUC-SNK50N01ZTLEFDC02-20U-SRV02	DC02	20U
136	136	TUC-SNK50M01ZTOOBAB09-21U-ACC01	AB09	21U
137	137	TUC-SNK50M01ZTOOBDC07-22U-ACC02	DC07	22U
138	138	TUC-SNK50M01ZTOOBDC03-22U-ACC03	DC03	22U
139	139	TUC-SNK50M01ZTOOBDC02-22U-ACC04	DC02	22U
140	140	TUC-SNK50M01ZTOOBAB11-21U-AGG01	AB11	21U
141	141	TUC-SNK50M01ZTOOBAB10-21U-AGG02	AB10	21U
142	142	TUC-SNK50M01ZTSPNDB05-26U-M&S01	DB05	26U
143	143	TUC-SNK50M01ZTSPNDB04-26U-M&S02	DB04	26U
144	144	TUC-SNK50M01ZTSPNDB02-01U-SRV01	DB02	01U
145	145	TUC-SNK50M01ZTSPNDB01-01U-SRV02	DB01	01U
146	146	TUC-SNK50M01ZTDCGDB10-01U-01	DB10	01U
147	147	TUC-SNK50M01ZTDCGDB09-01U-02	DB09	01U
\.


--
-- TOC entry 5081 (class 0 OID 2012243)
-- Dependencies: 243
-- Data for Name: maptypes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.maptypes (typeid, typeresult, typenames1, typenames2, typenames3) FROM stdin;
2	Server SDN-C	COM	SDNC	\N
4	Server BN EMS	COM	EMSSW	\N
5	Server Splunk	COM	SPLUNK	\N
6	Tapping	TAP	CTRL	\N
7	NPBSW	TAP	NPBSW	\N
8	Backup Storage	BAK	STORAGE	\N
9	Server Backup	BAK	SERVER	\N
10	Server VAScanner	COM	VASCAN	\N
11	Server EMS FW	COM	EMSFW	\N
12	FW-I	IFW	\N	\N
13	FW4	FW4	\N	\N
14	WAF-I	WAF	WAF-I	\N
15	Splitter	ATP	SPLT	\N
16	MAS SW	TAP	MASSW	\N
17	M&S Leaf M	50M	LEF	M&S
18	SRV Leaf M	50M	LEF	SRV
19	RH APP Master S01	S01	MAS	\N
20	RH Infra Logging S01	S01	INF	\N
21	Server Workload S01	S01	WRK	\N
22	RH OCP CEPH S01	S01	CEP	\N
23	Server HSM S01	COM	HSM	\N
24	Server Splunk	COM	SPLUNK	\N
25	M&S Leaf S	50S	LEF	M&S
26	SRV Leaf S	50S	LEF	SRV
27	RH APP Master N01	N01	MAS	\N
28	RH Infra Logging N01	N01	INF	\N
29	Server Workload N01	N01	WRK	\N
30	RH OCP CEPH N01	N01	CEP	\N
31	M&S Leaf N01	50N	LEF	M&S
32	SRV Leaf N01	50N	LEF	SRV
33	OOB ACC	OOB	ACC	\N
34	OOB AGG	OOB	AGG	\N
35	M&S Spine	SPN	M&S	\N
36	SRV Spine	SPN	SRV	\N
37	DCGW	DCG	\N	\N
1	RH OCP Support	SUP	\N	\N
3	SDN Adapter	COM	SDNADAPTER	\N
\.


--
-- TOC entry 5078 (class 0 OID 70997)
-- Dependencies: 240
-- Data for Name: nodes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.nodes (nodeid, nodename, nodename_m, node_extension) FROM stdin;
1	TRC-OEO-ODN-8M-MPO Splitter	ATP	SPLT
2	KS3200 V2 ZTE Backup Storage	BAK	STORAGE
3	R5200G5(Arch2-1)Backup Server	BAK	SERVER
4	R5300G5(Arch3)RH HUB ODF	CEP	
5	R5300G5(Arch3)RH ODF for OCP Cluster 01	CEP	
6	R5300G5(Arch3)RH ODF for OCP Cluster 02	CEP	
7	R5300G5(Arch3)RH ODF for OCP Cluster 03	CEP	
8	R5200G5 CA Server	COM	CA
9	R5200G5 KMS Server	COM	KMS
10	R5200G5(Arch2-1) UME R50s	COM	EMSCN01
11	R5200G5(Arch2-1)ZTE CI/CD	COM	CICDPNF
12	R5200G5(Arch2-2) BN EMS Server	COM	EMSSW
13	R5200G5(Arch2-2) ZTE TECS Openstack(PIM & BM & OCP-SDN-Adapter)	COM	SDNADAPTER
14	R5200G5(Arch2-2) ZTE ZENIC(SDN-C)	COM	SDNC
15	R5200G5(Arch2-2)Splunk forwarder	COM	SPLUNK
16	R5200G5(Arch2-2)VAScanner	COM	VASCAN
17	R5200G5(HSM)HSM_Pool 01	COM	HSM
18	R5200G5(HSM)HSM_Pool 03	COM	HSM
19	R5300G5(Arch3) FW EMS Server	COM	EMSFW
20	R5300G5(Arch3)UME R50s	COM	EMSCN01
21	ZXR10 M6000-18S (DCGW RT)_Router_Y2024	DCG	
22	FG-1800F-DC	FW4	
23	FG-2600F-DC	IFW	
24	R5200G5(Arch2-2) RH HUB Infra Node for OCP	INF	
25	R5200G5(Arch2-2)RH Infra Logging-Metrics-Router	INF	
26	ZXR10 5960X-56QU-HF (MNG&STOR Leaf SW for Cluster 01)	LEF	M&S
27	ZXR10 5960X-56QU-HF (MNG&STOR Leaf SW for Cluster 02)	LEF	M&S
28	ZXR10 5960X-56QU-HF (MNG&STOR Leaf SW for Cluster 03)	LEF	M&S
29	ZXR10 5960X-56QU-HF (MNG&STOR Leaf SW)	LEF	M&S
30	ZXR10 5960X-56QU-HF (Service Leaf 25G SW for Cluster 01)	LEF	SRV
31	ZXR10 5960X-56QU-HF (Service Leaf 25G SW for Cluster 02)	LEF	SRV
32	ZXR10 5960X-56QU-HF (Service Leaf 25G SW for Cluster 03)	LEF	SRV
33	ZXR10 5960X-56QU-HF (Service Leaf 25G SW)	LEF	SRV
34	R5200G5(Arch2-2)RH APP Master Node	MAS	
35	R5200G5(Arch2-2) RH HUB Master Node for OCP	MAS	
36	ZXR10 5950-60TM-E (OOB ACC)_All Dom	OOB	ACC
37	ZXR10 5950-60TM-E (OOB AGG)_All Dom	OOB	AGG
40	R5200G5(Arch2-2)RH Supporting Node for OCP	SUP	
41	H3C TAP8000-CE54_Tapping	TAP	NPBSW
42	H3C UniServer R4900 G3_Tapping	TAP	CTRL
44	ZXR10 5960X-56QU-HF (MAS)	TAP	MASSW
45	FAD-1200F-DC	WAF	WAF-I
46	R5200G5(Arch2-1)RH HUB Workload(Quay-ACM-ACS)	WRK	
47	R5200G5(Arch2-1)Workload_Cluster 01	WRK	
48	R5200G5(Arch2-1)Workload_Cluster 02	WRK	
49	R5200G5(Arch2-1)Workload_Cluster 03	WRK	
43	H3C UniServer R4900 G5_Tapping	TAP	CTRL
38	ZXR10 9904X (MNG&STOR Spine SW)_Switch_Y2024	SPN	M&S
39	ZXR10 9916X (Service Spine SW)_Switch_Y2024	SPN	SRV
\.


--
-- TOC entry 5064 (class 0 OID 50613)
-- Dependencies: 226
-- Data for Name: positions_rst; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.positions_rst (r_positionsid, r_positions, r_positions_m) FROM stdin;
1	SW R1	DG01
2	SW R2	DG03
3	SW R3	DG04
4	SW R4	DG06
5	SW R5	DG07
6	SW R6	DG08
7	R1	DD04
8	R2	DD05
9	R3	DE0C
10	R4	DE0A
11	R5	DA0A
12	R6	DB0C
13	R7	DB0B
14	R8	DC0C
15	R9	CF01
16	R10	CF03
17	R11	CG01
18	R12	CG02
19	R13	CG06
\.


--
-- TOC entry 5066 (class 0 OID 50622)
-- Dependencies: 228
-- Data for Name: positions_snk; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.positions_snk (s_positionsid, s_positions, s_positions_m) FROM stdin;
1	R1	AB11
2	R2	AB10
3	R3	AB09
4	R4	DC07
5	R5	DC06
6	R6	DC03
7	R7	DC02
8	SW R1	DB10
9	SW R2	DB09
10	SW R3	DB05
11	SW R4	DB04
12	SW R5	DB02
13	SW R6	DB01
\.


--
-- TOC entry 5068 (class 0 OID 50631)
-- Dependencies: 230
-- Data for Name: positions_tyb; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.positions_tyb (t_positionsid, t_positions, t_positions_m) FROM stdin;
1	SW R1	0733
2	SW R2	0732
3	SW R3	0731
4	SW R4	0730
5	SW R5	0729
6	SW R6	0728
7	R1	0727
8	R2	0726
9	R3	0725
10	R4	0724
11	R5	0723
12	R6	0722
13	R7	0721
14	R8	0720
15	R9	0719
16	R10	0718
17	R11	0717
18	R12	0716
\.


--
-- TOC entry 5070 (class 0 OID 50640)
-- Dependencies: 232
-- Data for Name: sites; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sites (siteid, sitename) FROM stdin;
1	RST
2	TYB
3	SNK
\.


--
-- TOC entry 5104 (class 0 OID 4465863)
-- Dependencies: 266
-- Data for Name: snk_oob_acc_1; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.snk_oob_acc_1 (port_id, port, device_names, rack_position) FROM stdin;
12	0/1/1/12	TUC-SNK50M01ZTCOMAB10-01U-SDNADAPTER02	R2/01U
21	0/1/1/21	TUC-SNK50M01ZTCOMAB09-01U-SDNADAPTER03	R3/01U
22	0/1/1/22	TUC-SNK50M01ZTCOMAB09-02U-EMSSW01	R3/02U
16	0/1/1/16	TUC-SNK50M01ZTCOMAB10-05U-SPLUNK01	R2/05U
17	0/1/1/17	TUC-SNK50M01ZTCOMAB10-06U-SPLUNK02	R2/06U
8	0/1/1/8	TUC-SNK50M01H3TAPAB11-14U-CTRL01	R1/14U
9	0/1/1/9	TUC-SNK50M01H3TAPAB11-14U-CTRL01	R1/14U
18	0/1/1/18	TUC-SNK50M01H3TAPAB10-14U-CTRL02	R2/14U
19	0/1/1/19	TUC-SNK50M01H3TAPAB10-14U-CTRL02	R2/14U
25	0/1/1/25	TUC-SNK50M01ZTBAKAB09-06U-STORAGE01	R3/06U
26	0/1/1/26	TUC-SNK50M01ZTBAKAB09-06U-STORAGE01	R3/06U
4	0/1/1/4	TUC-SNK50M01ZTBAKAB11-04U-SERVER01	R1/04U
15	0/1/1/15	TUC-SNK50M01ZTBAKAB10-04U-SERVER02	R2/04U
24	0/1/1/24	TUC-SNK50M01ZTBAKAB09-04U-SERVER03	R3/04U
5	0/1/1/5	TUC-SNK50M01ZTCOMAB11-05U-VASCAN01	R1/05U
6	0/1/1/6	TUC-SNK50M01ZTCOMAB11-06U-VASCAN02	R1/06U
7	0/1/1/7	TUC-SNK50M01ZTCOMAB11-07U-VASCAN03	R1/07U
10	0/1/1/10	TUC-SNK50M01ZTCOMAB11-30U-EMSFW01	R1/30U
20	0/1/1/20	TUC-SNK50M01ZTCOMAB10-30U-EMSFW02	R2/30U
27	0/1/1/27	\N	\N
53	\N	\N	\N
54	\N	\N	\N
55	\N	\N	\N
56	\N	\N	\N
28	0/1/1/28	\N	\N
29	0/1/1/29	\N	\N
30	0/1/1/30	\N	\N
31	0/1/1/31	\N	\N
32	0/1/1/32	\N	\N
11	0/1/1/11	TUC-SNK50M01ZTCOMAB11-31U-EMSFW01	R2/01U
57	\N	\N	\N
58	\N	\N	\N
59	\N	\N	\N
60	\N	\N	\N
61	\N	\N	\N
62	\N	\N	\N
2	0/1/1/2	TUC-SNK50M01ZTSUPAB11-02U-01	R1/02U
13	0/1/1/13	TUC-SNK50M01ZTSUPAB10-02U-02	R2/02U
33	0/1/1/33	\N	\N
34	0/1/1/34	\N	\N
3	0/1/1/3	TUC-SNK50M01ZTCOMAB11-03U-SDNC01	R1/03U
14	0/1/1/14	TUC-SNK50M01ZTCOMAB10-03U-SDNC02	R2/03U
23	0/1/1/23	TUC-SNK50M01ZTCOMAB09-03U-SDNC03	R3/03U
1	0/1/1/1	TUC-SNK50M01ZTCOMAB11-01U-SDNADAPTER01	R1/01U
63	\N	\N	\N
64	\N	\N	\N
65	\N	\N	\N
66	\N	\N	\N
67	\N	\N	\N
68	\N	\N	\N
69	\N	\N	\N
70	\N	\N	\N
71	\N	\N	\N
72	\N	\N	\N
73	\N	\N	\N
74	\N	\N	\N
75	\N	\N	\N
76	\N	\N	\N
77	\N	\N	\N
78	\N	\N	\N
79	\N	\N	\N
80	\N	\N	\N
81	\N	\N	\N
82	\N	\N	\N
83	\N	\N	\N
84	\N	\N	\N
85	\N	\N	\N
86	\N	\N	\N
87	\N	\N	\N
88	\N	\N	\N
89	\N	\N	\N
90	\N	\N	\N
91	\N	\N	\N
92	\N	\N	\N
93	\N	\N	\N
94	\N	\N	\N
95	\N	\N	\N
96	\N	\N	\N
97	\N	\N	\N
98	\N	\N	\N
99	\N	\N	\N
100	\N	\N	\N
101	\N	\N	\N
102	\N	\N	\N
103	\N	\N	\N
104	\N	\N	\N
105	\N	\N	\N
106	\N	\N	\N
107	\N	\N	\N
108	\N	\N	\N
109	\N	\N	\N
110	\N	\N	\N
111	\N	\N	\N
112	\N	\N	\N
113	\N	\N	\N
114	\N	\N	\N
115	\N	\N	\N
116	\N	\N	\N
117	\N	\N	\N
118	\N	\N	\N
119	\N	\N	\N
120	\N	\N	\N
121	\N	\N	\N
122	\N	\N	\N
123	\N	\N	\N
124	\N	\N	\N
125	\N	\N	\N
126	\N	\N	\N
127	\N	\N	\N
128	\N	\N	\N
129	\N	\N	\N
130	\N	\N	\N
131	\N	\N	\N
132	\N	\N	\N
133	\N	\N	\N
134	\N	\N	\N
135	\N	\N	\N
136	\N	\N	\N
137	\N	\N	\N
138	\N	\N	\N
139	\N	\N	\N
140	\N	\N	\N
141	\N	\N	\N
142	\N	\N	\N
143	\N	\N	\N
144	\N	\N	\N
145	\N	\N	\N
146	\N	\N	\N
147	\N	\N	\N
148	\N	\N	\N
149	\N	\N	\N
150	\N	\N	\N
151	\N	\N	\N
152	\N	\N	\N
153	\N	\N	\N
154	\N	\N	\N
155	\N	\N	\N
156	\N	\N	\N
35	0/1/1/35	\N	\N
36	0/1/1/36	\N	\N
37	0/1/1/37	\N	\N
38	0/1/1/38	\N	\N
39	0/1/1/39	\N	\N
40	0/1/1/40	\N	\N
41	0/1/1/41	\N	\N
42	0/1/1/42	\N	\N
49	0/1/1/49	\N	\N
50	0/1/1/50	\N	\N
51	0/1/1/51	\N	\N
52	0/1/1/52	\N	\N
43	0/1/1/43	TUC-SNK50M01ZTLEFAB11-17U-M&S01	R1/17U
44	0/1/1/44	TUC-SNK50M01ZTLEFAB10-17U-M&S02	R2/17U
45	0/1/1/45	TUC-SNK50M01ZTLEFAB11-19U-SRV01	R1/19U
46	0/1/1/46	TUC-SNK50M01ZTLEFAB10-19U-SRV02	R2/19U
47	0/1/1/47	TUC-SNK50M01ZTOOBAB11-21U-AGG01	R1/21U
48	0/1/1/48	TUC-SNK50M01ZTOOBAB10-21U-AGG02	R2/21U
\.


--
-- TOC entry 5106 (class 0 OID 4465872)
-- Dependencies: 268
-- Data for Name: snk_oob_acc_2; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.snk_oob_acc_2 (port_id, port, device_names, rack_position) FROM stdin;
16	0/1/1/16	TUC-SNK50S01ZTWRKDC07-27U-11	R4/27U
17	0/1/1/17	TUC-SNK50S01ZTWRKDC07-28U-12	R4/28U
18	0/1/1/18	TUC-SNK50S01ZTWRKDC07-29U-13	R4/29U
19	0/1/1/19	TUC-SNK50S01ZTWRKDC07-30U-14	R4/30U
20	0/1/1/20	TUC-SNK50S01ZTWRKDC07-31U-15	R4/31U
21	0/1/1/21	TUC-SNK50S01ZTWRKDC07-32U-16	R4/32U
22	0/1/1/22	TUC-SNK50S01ZTWRKDC07-33U-17	R4/33U
23	0/1/1/23	TUC-SNK50S01ZTWRKDC07-34U-18	R4/34U
1	0/1/1/1	TUC-SNK50S01ZTCEPDC07-01U-01	R4/01U
2	0/1/1/2	TUC-SNK50S01ZTCEPDC07-03U-02	R4/03U
24	0/1/1/24	TUC-SNK50S01ZTCEPDC06-01U-03	R5/01U
25	0/1/1/25	TUC-SNK50S01ZTCEPDC06-03U-04	R5/03U
53	\N	\N	\N
54	\N	\N	\N
55	\N	\N	\N
56	\N	\N	\N
57	\N	\N	\N
58	\N	\N	\N
59	\N	\N	\N
60	\N	\N	\N
61	\N	\N	\N
62	\N	\N	\N
63	\N	\N	\N
64	\N	\N	\N
65	\N	\N	\N
66	\N	\N	\N
67	\N	\N	\N
68	\N	\N	\N
69	\N	\N	\N
70	\N	\N	\N
71	\N	\N	\N
72	\N	\N	\N
73	\N	\N	\N
74	\N	\N	\N
75	\N	\N	\N
76	\N	\N	\N
77	\N	\N	\N
78	\N	\N	\N
79	\N	\N	\N
80	\N	\N	\N
81	\N	\N	\N
82	\N	\N	\N
83	\N	\N	\N
84	\N	\N	\N
85	\N	\N	\N
86	\N	\N	\N
87	\N	\N	\N
88	\N	\N	\N
89	\N	\N	\N
90	\N	\N	\N
91	\N	\N	\N
92	\N	\N	\N
93	\N	\N	\N
94	\N	\N	\N
95	\N	\N	\N
96	\N	\N	\N
97	\N	\N	\N
98	\N	\N	\N
99	\N	\N	\N
100	\N	\N	\N
101	\N	\N	\N
102	\N	\N	\N
103	\N	\N	\N
104	\N	\N	\N
3	0/1/1/3	TUC-SNK50S01ZTMASDC07-05U-01	R4/05U
4	0/1/1/4	TUC-SNK50S01ZTMASDC07-06U-02	R4/06U
26	0/1/1/26	TUC-SNK50S01ZTMASDC06-05U-03	R5/05U
5	0/1/1/5	TUC-SNK50S01ZTINFDC07-07U-01	R4/07U
6	0/1/1/6	TUC-SNK50S01ZTWRKDC07-08U-01	R4/08U
7	0/1/1/7	TUC-SNK50S01ZTWRKDC07-09U-02	R4/09U
8	0/1/1/8	TUC-SNK50S01ZTWRKDC07-10U-03	R4/10U
9	0/1/1/9	TUC-SNK50S01ZTWRKDC07-11U-04	R4/11U
10	0/1/1/10	TUC-SNK50S01ZTWRKDC07-12U-05	R4/12U
11	0/1/1/11	TUC-SNK50S01ZTWRKDC07-13U-06	R4/13U
12	0/1/1/12	TUC-SNK50S01ZTWRKDC07-14U-07	R4/14U
13	0/1/1/13	TUC-SNK50S01ZTWRKDC07-24U-08	R4/24U
14	0/1/1/14	TUC-SNK50S01ZTWRKDC07-25U-09	R4/25U
15	0/1/1/15	TUC-SNK50S01ZTWRKDC07-26U-10	R4/26U
49	0/1/1/49	\N	\N
50	0/1/1/50	\N	\N
51	0/1/1/51	\N	\N
52	0/1/1/52	\N	\N
44	0/1/1/44	TUC-SNK50S01ZTLEFDC06-18U-M&S04	R5/18U
45	0/1/1/45	TUC-SNK50S01ZTLEFDC07-20U-SRV01	R4/20U
46	0/1/1/46	TUC-SNK50S01ZTLEFDC06-20U-SRV02	R5/20U
47	0/1/1/47	TUC-SNK50M01ZTOOBAB11-21U-AGG01	R1/21U
48	0/1/1/48	TUC-SNK50M01ZTOOBAB10-21U-AGG02	R2/21U
105	\N	\N	\N
106	\N	\N	\N
107	\N	\N	\N
108	\N	\N	\N
109	\N	\N	\N
110	\N	\N	\N
111	\N	\N	\N
112	\N	\N	\N
113	\N	\N	\N
114	\N	\N	\N
115	\N	\N	\N
116	\N	\N	\N
117	\N	\N	\N
118	\N	\N	\N
119	\N	\N	\N
120	\N	\N	\N
121	\N	\N	\N
122	\N	\N	\N
123	\N	\N	\N
124	\N	\N	\N
125	\N	\N	\N
126	\N	\N	\N
127	\N	\N	\N
128	\N	\N	\N
129	\N	\N	\N
130	\N	\N	\N
131	\N	\N	\N
132	\N	\N	\N
133	\N	\N	\N
134	\N	\N	\N
135	\N	\N	\N
136	\N	\N	\N
137	\N	\N	\N
138	\N	\N	\N
139	\N	\N	\N
140	\N	\N	\N
141	\N	\N	\N
142	\N	\N	\N
143	\N	\N	\N
144	\N	\N	\N
145	\N	\N	\N
146	\N	\N	\N
147	\N	\N	\N
148	\N	\N	\N
149	\N	\N	\N
150	\N	\N	\N
151	\N	\N	\N
152	\N	\N	\N
153	\N	\N	\N
154	\N	\N	\N
155	\N	\N	\N
156	\N	\N	\N
36	0/1/1/36	\N	\N
37	0/1/1/37	\N	\N
38	0/1/1/38	\N	\N
39	0/1/1/39	\N	\N
40	0/1/1/40	\N	\N
27	0/1/1/27	TUC-SNK50S01ZTINFDC06-06U-02	R5/06U
28	0/1/1/28	TUC-SNK50S01ZTINFDC06-07U-03	R5/07U
29	0/1/1/29	TUC-SNK50S01ZTWRKDC06-08U-19	R5/08U
30	0/1/1/30	TUC-SNK50S01ZTWRKDC06-09U-20	R5/09U
31	0/1/1/31	TUC-SNK50S01ZTWRKDC06-10U-21	R5/10U
32	0/1/1/32	TUC-SNK50S01ZTWRKDC06-11U-22	R5/11U
33	0/1/1/33	TUC-SNK50S01ZTWRKDC06-12U-23	R5/12U
34	0/1/1/34	TUC-SNK50S01ZTWRKDC06-13U-24	R5/13U
35	0/1/1/35	TUC-SNK50S01ZTWRKDC06-14U-25	R5/14U
41	0/1/1/41	TUC-SNK50S01ZTLEFDC07-16U-M&S01	R4/16U
42	0/1/1/42	TUC-SNK50S01ZTLEFDC06-16U-M&S02	R5/16U
43	0/1/1/43	TUC-SNK50S01ZTLEFDC07-18U-M&S03	R4/18U
\.


--
-- TOC entry 5108 (class 0 OID 4465881)
-- Dependencies: 270
-- Data for Name: snk_oob_acc_3; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.snk_oob_acc_3 (port_id, port, device_names, rack_position) FROM stdin;
6	0/1/1/6	TUC-SNK50S01ZTCOMDC06-27U-HSM04	R5/27U
7	0/1/1/7	TUC-SNK50S01ZTCOMDC06-28U-HSM05	R5/28U
8	0/1/1/8	TUC-SNK50S01ZTCOMDC06-29U-HSM06	R5/29U
9	0/1/1/9	TUC-SNK50S01ZTCOMDC06-30U-HSM07	R5/30U
1	0/1/1/1	TUC-SNK50S01ZTCOMDC06-22U-SPLUNK01	R5/22U
2	0/1/1/2	TUC-SNK50S01ZTCOMDC06-23U-SPLUNK02	R5/23U
12	0/1/1/12	TUC-SNK50N01ZTMASDC03-05U-01	R6/05U
13	0/1/1/13	TUC-SNK50N01ZTMASDC03-06U-02	R6/06U
14	0/1/1/14	TUC-SNK50N01ZTINFDC03-07U-01	R6/07U
15	0/1/1/15	TUC-SNK50N01ZTWRKDC03-08U-01	R6/08U
16	0/1/1/16	TUC-SNK50N01ZTWRKDC03-09U-02	R6/09U
17	0/1/1/17	TUC-SNK50N01ZTWRKDC03-10U-03	R6/10U
18	0/1/1/18	TUC-SNK50N01ZTWRKDC03-11U-04	R6/11U
19	0/1/1/19	TUC-SNK50N01ZTWRKDC03-12U-05	R6/12U
20	0/1/1/20	TUC-SNK50N01ZTWRKDC03-13U-06	R6/13U
21	0/1/1/21	TUC-SNK50N01ZTWRKDC03-14U-07	R6/14U
22	0/1/1/22	TUC-SNK50N01ZTWRKDC03-24U-08	R6/24U
23	0/1/1/23	TUC-SNK50N01ZTWRKDC03-25U-09	R6/25U
24	0/1/1/24	TUC-SNK50N01ZTWRKDC03-26U-10	R6/26U
25	0/1/1/25	TUC-SNK50N01ZTWRKDC03-27U-11	R6/27U
26	0/1/1/26	TUC-SNK50N01ZTWRKDC03-28U-12	R6/28U
27	0/1/1/27	TUC-SNK50N01ZTWRKDC03-29U-13	R6/29U
28	0/1/1/28	TUC-SNK50N01ZTWRKDC03-30U-14	R6/30U
29	0/1/1/29	TUC-SNK50N01ZTWRKDC03-31U-15	R6/31U
30	0/1/1/30	TUC-SNK50N01ZTWRKDC03-32U-16	R6/32U
31	0/1/1/31	TUC-SNK50N01ZTWRKDC03-33U-17	R6/33U
32	0/1/1/32	TUC-SNK50N01ZTWRKDC03-34U-18	R6/34U
10	0/1/1/10	TUC-SNK50N01ZTCEPDC03-01U-01	R6/01U
11	0/1/1/11	TUC-SNK50N01ZTCEPDC03-03U-02	R6/03U
33	0/1/1/33	\N	\N
34	0/1/1/34	\N	\N
53	\N	\N	\N
54	\N	\N	\N
55	\N	\N	\N
56	\N	\N	\N
57	\N	\N	\N
3	0/1/1/3	TUC-SNK50S01ZTCOMDC06-24U-HSM01	R5/24U
4	0/1/1/4	TUC-SNK50S01ZTCOMDC06-25U-HSM02	R5/25U
5	0/1/1/5	TUC-SNK50S01ZTCOMDC06-26U-HSM03	R5/26U
58	\N	\N	\N
59	\N	\N	\N
60	\N	\N	\N
61	\N	\N	\N
62	\N	\N	\N
63	\N	\N	\N
64	\N	\N	\N
65	\N	\N	\N
66	\N	\N	\N
67	\N	\N	\N
68	\N	\N	\N
69	\N	\N	\N
70	\N	\N	\N
71	\N	\N	\N
72	\N	\N	\N
73	\N	\N	\N
74	\N	\N	\N
75	\N	\N	\N
76	\N	\N	\N
77	\N	\N	\N
78	\N	\N	\N
79	\N	\N	\N
80	\N	\N	\N
81	\N	\N	\N
82	\N	\N	\N
83	\N	\N	\N
84	\N	\N	\N
85	\N	\N	\N
86	\N	\N	\N
87	\N	\N	\N
88	\N	\N	\N
89	\N	\N	\N
90	\N	\N	\N
91	\N	\N	\N
92	\N	\N	\N
93	\N	\N	\N
94	\N	\N	\N
95	\N	\N	\N
96	\N	\N	\N
97	\N	\N	\N
98	\N	\N	\N
99	\N	\N	\N
100	\N	\N	\N
101	\N	\N	\N
102	\N	\N	\N
103	\N	\N	\N
104	\N	\N	\N
105	\N	\N	\N
106	\N	\N	\N
107	\N	\N	\N
108	\N	\N	\N
109	\N	\N	\N
110	\N	\N	\N
111	\N	\N	\N
112	\N	\N	\N
113	\N	\N	\N
114	\N	\N	\N
115	\N	\N	\N
116	\N	\N	\N
117	\N	\N	\N
118	\N	\N	\N
119	\N	\N	\N
120	\N	\N	\N
121	\N	\N	\N
122	\N	\N	\N
123	\N	\N	\N
124	\N	\N	\N
125	\N	\N	\N
126	\N	\N	\N
127	\N	\N	\N
128	\N	\N	\N
129	\N	\N	\N
130	\N	\N	\N
131	\N	\N	\N
132	\N	\N	\N
133	\N	\N	\N
134	\N	\N	\N
135	\N	\N	\N
136	\N	\N	\N
137	\N	\N	\N
138	\N	\N	\N
139	\N	\N	\N
140	\N	\N	\N
141	\N	\N	\N
142	\N	\N	\N
143	\N	\N	\N
144	\N	\N	\N
145	\N	\N	\N
146	\N	\N	\N
147	\N	\N	\N
148	\N	\N	\N
149	\N	\N	\N
150	\N	\N	\N
151	\N	\N	\N
152	\N	\N	\N
153	\N	\N	\N
154	\N	\N	\N
155	\N	\N	\N
156	\N	\N	\N
35	0/1/1/35	\N	\N
36	0/1/1/36	\N	\N
37	0/1/1/37	\N	\N
38	0/1/1/38	\N	\N
39	0/1/1/39	\N	\N
40	0/1/1/40	\N	\N
41	0/1/1/41	\N	\N
42	0/1/1/42	\N	\N
43	0/1/1/43	\N	\N
49	0/1/1/49	\N	\N
50	0/1/1/50	\N	\N
51	0/1/1/51	\N	\N
52	0/1/1/52	\N	\N
44	0/1/1/44	TUC-SNK50N01ZTLEFDC03-16U-M&S01	R6/16U
45	0/1/1/45	TUC-SNK50N01ZTLEFDC03-18U-M&S03	R6/18U
46	0/1/1/46	TUC-SNK50N01ZTLEFDC03-20U-SRV01	R6/20U
47	0/1/1/47	TUC-SNK50M01ZTOOBAB11-21U-AGG01	R1/21U
48	0/1/1/48	TUC-SNK50M01ZTOOBAB10-21U-AGG02	R2/21U
\.


--
-- TOC entry 5110 (class 0 OID 4465890)
-- Dependencies: 272
-- Data for Name: snk_oob_acc_4; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.snk_oob_acc_4 (port_id, port, device_names, rack_position) FROM stdin;
9	0/1/1/9	TUC-SNK50N01ZTWRKDC02-11U-22	R7/11U
10	0/1/1/10	TUC-SNK50N01ZTWRKDC02-12U-23	R7/12U
11	0/1/1/11	TUC-SNK50N01ZTWRKDC02-13U-24	R7/13U
12	0/1/1/12	TUC-SNK50N01ZTWRKDC02-14U-25	R7/14U
18	0/1/1/18	TUC-SNK50N01ZTWRKDC02-14U-25	R7/14U
15	0/1/1/15	TUC-SNK50N01ZTWRKDC02-26U-26	R7/26U
53	\N	\N	\N
54	\N	\N	\N
55	\N	\N	\N
56	\N	\N	\N
57	\N	\N	\N
58	\N	\N	\N
59	\N	\N	\N
60	\N	\N	\N
61	\N	\N	\N
62	\N	\N	\N
63	\N	\N	\N
64	\N	\N	\N
65	\N	\N	\N
19	0/1/1/19	TUC-SNK50N01ZTWRKDC02-26U-26	R7/26U
16	0/1/1/16	TUC-SNK50N01ZTWRKDC02-27U-27	R7/27U
20	0/1/1/20	TUC-SNK50N01ZTWRKDC02-27U-27	R7/27U
17	0/1/1/17	TUC-SNK50N01ZTWRKDC02-28U-28	R7/28U
21	0/1/1/21	TUC-SNK50N01ZTWRKDC02-28U-28	R7/28U
22	0/1/1/22	TUC-SNK50N01ZTWRKDC02-29U-29	R7/29U
23	0/1/1/23	TUC-SNK50N01ZTWRKDC02-30U-30	R7/30U
1	0/1/1/1	TUC-SNK50N01ZTCEPDC02-01U-03	R7/01U
2	0/1/1/2	TUC-SNK50N01ZTCEPDC02-03U-04	R7/03U
13	0/1/1/13	TUC-SNK50N01ZTCOMDC02-24U-SPLUNK01	R7/24U
14	0/1/1/14	TUC-SNK50N01ZTCOMDC02-25U-SPLUNK02	R7/25U
44	0/1/1/44	TUC-SNK50N01ZTLEFDC02-16U-M&S02	R7/16U
45	0/1/1/45	TUC-SNK50N01ZTLEFDC02-18U-M&S04	R7/18U
46	0/1/1/46	TUC-SNK50N01ZTLEFDC02-20U-SRV02	R7/20U
24	0/1/1/24	\N	\N
66	\N	\N	\N
67	\N	\N	\N
68	\N	\N	\N
69	\N	\N	\N
70	\N	\N	\N
3	0/1/1/3	TUC-SNK50N01ZTMASDC02-05U-03	R7/05U
4	0/1/1/4	TUC-SNK50N01ZTINFDC02-06U-02	R7/06U
5	0/1/1/5	TUC-SNK50N01ZTINFDC02-07U-03	R7/07U
25	0/1/1/25	\N	\N
26	0/1/1/26	\N	\N
27	0/1/1/27	\N	\N
6	0/1/1/6	TUC-SNK50N01ZTWRKDC02-08U-19	R7/08U
7	0/1/1/7	TUC-SNK50N01ZTWRKDC02-09U-20	R7/09U
8	0/1/1/8	TUC-SNK50N01ZTWRKDC02-10U-21	R7/10U
28	0/1/1/28	\N	\N
29	0/1/1/29	\N	\N
30	0/1/1/30	\N	\N
31	0/1/1/31	\N	\N
32	0/1/1/32	\N	\N
33	0/1/1/33	\N	\N
34	0/1/1/34	\N	\N
35	0/1/1/35	\N	\N
36	0/1/1/36	\N	\N
37	0/1/1/37	\N	\N
38	0/1/1/38	\N	\N
39	0/1/1/39	\N	\N
40	0/1/1/40	\N	\N
41	0/1/1/41	\N	\N
42	0/1/1/42	\N	\N
43	0/1/1/43	\N	\N
71	\N	\N	\N
72	\N	\N	\N
73	\N	\N	\N
74	\N	\N	\N
75	\N	\N	\N
76	\N	\N	\N
77	\N	\N	\N
78	\N	\N	\N
79	\N	\N	\N
80	\N	\N	\N
81	\N	\N	\N
82	\N	\N	\N
83	\N	\N	\N
84	\N	\N	\N
85	\N	\N	\N
86	\N	\N	\N
87	\N	\N	\N
88	\N	\N	\N
89	\N	\N	\N
90	\N	\N	\N
91	\N	\N	\N
92	\N	\N	\N
93	\N	\N	\N
94	\N	\N	\N
95	\N	\N	\N
96	\N	\N	\N
97	\N	\N	\N
98	\N	\N	\N
99	\N	\N	\N
100	\N	\N	\N
101	\N	\N	\N
102	\N	\N	\N
103	\N	\N	\N
104	\N	\N	\N
105	\N	\N	\N
106	\N	\N	\N
107	\N	\N	\N
108	\N	\N	\N
109	\N	\N	\N
110	\N	\N	\N
111	\N	\N	\N
112	\N	\N	\N
113	\N	\N	\N
114	\N	\N	\N
115	\N	\N	\N
116	\N	\N	\N
117	\N	\N	\N
118	\N	\N	\N
119	\N	\N	\N
120	\N	\N	\N
121	\N	\N	\N
122	\N	\N	\N
123	\N	\N	\N
124	\N	\N	\N
125	\N	\N	\N
126	\N	\N	\N
127	\N	\N	\N
128	\N	\N	\N
129	\N	\N	\N
130	\N	\N	\N
131	\N	\N	\N
132	\N	\N	\N
133	\N	\N	\N
134	\N	\N	\N
135	\N	\N	\N
136	\N	\N	\N
137	\N	\N	\N
138	\N	\N	\N
139	\N	\N	\N
140	\N	\N	\N
141	\N	\N	\N
142	\N	\N	\N
143	\N	\N	\N
144	\N	\N	\N
145	\N	\N	\N
146	\N	\N	\N
147	\N	\N	\N
148	\N	\N	\N
149	\N	\N	\N
150	\N	\N	\N
151	\N	\N	\N
152	\N	\N	\N
153	\N	\N	\N
154	\N	\N	\N
155	\N	\N	\N
156	\N	\N	\N
49	0/1/1/49	\N	\N
50	0/1/1/50	\N	\N
51	0/1/1/51	\N	\N
52	0/1/1/52	\N	\N
47	0/1/1/47	TUC-SNK50M01ZTOOBAB11-21U-AGG01	R1/21U
48	0/1/1/48	TUC-SNK50M01ZTOOBAB10-21U-AGG02	R2/21U
\.


--
-- TOC entry 5100 (class 0 OID 4465845)
-- Dependencies: 262
-- Data for Name: snk_oob_agg_1; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.snk_oob_agg_1 (port_id, port, device_names, rack_position) FROM stdin;
53	\N	\N	\N
54	\N	\N	\N
55	\N	\N	\N
56	\N	\N	\N
57	\N	\N	\N
58	\N	\N	\N
59	\N	\N	\N
60	\N	\N	\N
61	\N	\N	\N
62	\N	\N	\N
63	\N	\N	\N
64	\N	\N	\N
65	\N	\N	\N
1	0/1/1/1	TUC-SNK50M01ZTDCGDB10-01U-01	SW R1/01U
2	0/1/1/2	TUC-SNK50M01ZTDCGDB09-01U-02	SW R2/01U
3	0/1/1/3	TUC-SNK50M01ZTSPNDB05-26U-M&S01	SW R3/26U
4	0/1/1/4	TUC-SNK50M01ZTSPNDB04-26U-M&S02	SW R4/26U
5	0/1/1/5	TUC-SNK50M01ZTSPNDB02-01U-SRV01	SW R5/01U
6	0/1/1/6	TUC-SNK50M01ZTSPNDB01-01U-SRV02	SW R6/01U
7	0/1/1/7	TUC-SNK50M01ZTTAPDB05-20U-MASSW01	SW R3/20U
8	0/1/1/8	TUC-SNK50M01H3TAPDB05-22U-NPBSW01	SW R3/22U
9	0/1/1/9	TUC-SNK50M01FTIFWAB11-23U-01	R1/23U
10	0/1/1/10	TUC-SNK50M01FTIFWAB10-23U-02	R2/23U
11	0/1/1/11	TUC-SNK50M01FTFW4AB11-25U-01	R1/25U
12	0/1/1/12	TUC-SNK50M01FTFW4AB10-25U-02	R2/25U
13	0/1/1/13	TUC-SNK50M01FTWAFAB11-28U-WAF-I01	R1/28U
66	\N	\N	\N
67	\N	\N	\N
68	\N	\N	\N
69	\N	\N	\N
105	\N	\N	\N
106	\N	\N	\N
107	\N	\N	\N
108	\N	\N	\N
109	\N	\N	\N
110	\N	\N	\N
111	\N	\N	\N
112	\N	\N	\N
113	\N	\N	\N
114	\N	\N	\N
70	\N	\N	\N
71	\N	\N	\N
72	\N	\N	\N
73	\N	\N	\N
115	\N	\N	\N
74	\N	\N	\N
116	\N	\N	\N
117	\N	\N	\N
118	\N	\N	\N
119	\N	\N	\N
120	\N	\N	\N
121	\N	\N	\N
122	\N	\N	\N
123	\N	\N	\N
124	\N	\N	\N
125	\N	\N	\N
126	\N	\N	\N
127	\N	\N	\N
128	\N	\N	\N
129	\N	\N	\N
130	\N	\N	\N
131	\N	\N	\N
132	\N	\N	\N
133	\N	\N	\N
134	\N	\N	\N
135	\N	\N	\N
136	\N	\N	\N
137	\N	\N	\N
75	\N	\N	\N
76	\N	\N	\N
77	\N	\N	\N
78	\N	\N	\N
79	\N	\N	\N
80	\N	\N	\N
81	\N	\N	\N
82	\N	\N	\N
83	\N	\N	\N
84	\N	\N	\N
85	\N	\N	\N
86	\N	\N	\N
87	\N	\N	\N
88	\N	\N	\N
89	\N	\N	\N
90	\N	\N	\N
91	\N	\N	\N
92	\N	\N	\N
93	\N	\N	\N
94	\N	\N	\N
95	\N	\N	\N
96	\N	\N	\N
97	\N	\N	\N
98	\N	\N	\N
99	\N	\N	\N
100	\N	\N	\N
101	\N	\N	\N
102	\N	\N	\N
103	\N	\N	\N
104	\N	\N	\N
14	0/1/1/14	\N	\N
15	0/1/1/15	\N	\N
16	0/1/1/16	\N	\N
17	0/1/1/17	\N	\N
18	0/1/1/18	\N	\N
19	0/1/1/19	\N	\N
138	\N	\N	\N
139	\N	\N	\N
140	\N	\N	\N
141	\N	\N	\N
142	\N	\N	\N
143	\N	\N	\N
144	\N	\N	\N
145	\N	\N	\N
146	\N	\N	\N
147	\N	\N	\N
148	\N	\N	\N
20	0/1/1/20	\N	\N
21	0/1/1/21	\N	\N
22	0/1/1/22	\N	\N
23	0/1/1/23	\N	\N
24	0/1/1/24	\N	\N
52	0/1/1/52	TUC-SNK50M01ZTSPNDB05-26U-M&S01	SW R3/26U
49	0/1/1/49	TUC-SNK50M01ZTOOBAB10-21U-AGG02	R2/21U
50	0/1/1/50	TUC-SNK50M01ZTOOBAB10-21U-AGG02	R2/21U
149	\N	\N	\N
150	\N	\N	\N
151	\N	\N	\N
152	\N	\N	\N
153	\N	\N	\N
154	\N	\N	\N
155	\N	\N	\N
156	\N	\N	\N
25	0/1/1/25	\N	\N
26	0/1/1/26	\N	\N
27	0/1/1/27	\N	\N
28	0/1/1/28	\N	\N
29	0/1/1/29	\N	\N
30	0/1/1/30	\N	\N
35	0/1/1/35	\N	\N
36	0/1/1/36	\N	\N
37	0/1/1/37	\N	\N
38	0/1/1/38	\N	\N
39	0/1/1/39	\N	\N
40	0/1/1/40	\N	\N
41	0/1/1/41	\N	\N
42	0/1/1/42	\N	\N
43	0/1/1/43	\N	\N
44	0/1/1/44	\N	\N
45	0/1/1/45	\N	\N
46	0/1/1/46	\N	\N
51	0/1/1/51	\N	\N
31	0/1/1/31	TUC-SNK50M01ZTOOBAB09-21U-ACC01	R3/21U
32	0/1/1/32	TUC-SNK50M01ZTOOBDC07-22U-ACC02	R4/22U
33	0/1/1/33	TUC-SNK50M01ZTOOBDC03-22U-ACC03	R6/22U
34	0/1/1/34	TUC-SNK50M01ZTOOBDC02-22U-ACC04	R7/22U
47	0/1/1/47	TUC-SNK50M01ZTOOBAB10-21U-AGG02	R2/21U
48	0/1/1/48	TUC-SNK50M01ZTOOBAB10-21U-AGG02	R2/21U
\.


--
-- TOC entry 5102 (class 0 OID 4465854)
-- Dependencies: 264
-- Data for Name: snk_oob_agg_2; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.snk_oob_agg_2 (port_id, port, device_names, rack_position) FROM stdin;
53	\N	\N	\N
54	\N	\N	\N
55	\N	\N	\N
56	\N	\N	\N
57	\N	\N	\N
58	\N	\N	\N
59	\N	\N	\N
60	\N	\N	\N
61	\N	\N	\N
62	\N	\N	\N
63	\N	\N	\N
64	\N	\N	\N
65	\N	\N	\N
1	0/1/1/1	TUC-SNK50M01ZTDCGDB10-01U-01	SW R1/01U
2	0/1/1/2	TUC-SNK50M01ZTDCGDB09-01U-02	SW R2/01U
3	0/1/1/3	TUC-SNK50M01ZTSPNDB05-26U-M&S01	SW R3/26U
4	0/1/1/4	TUC-SNK50M01ZTSPNDB04-26U-M&S02	SW R4/26U
5	0/1/1/5	TUC-SNK50M01ZTSPNDB02-01U-SRV01	SW R5/01U
6	0/1/1/6	TUC-SNK50M01ZTSPNDB01-01U-SRV02	SW R6/01U
7	0/1/1/7	TUC-SNK50M01ZTTAPDB04-20U-MASSW02	SW R4/20U
8	0/1/1/8	TUC-SNK50M01H3TAPDB04-22U-NPBSW02	SW R4/22U
9	0/1/1/9	TUC-SNK50M01FTIFWAB11-23U-01	R1/23U
10	0/1/1/10	TUC-SNK50M01FTIFWAB10-23U-02	R2/23U
11	0/1/1/11	TUC-SNK50M01FTFW4AB11-25U-01	R1/25U
12	0/1/1/12	TUC-SNK50M01FTFW4AB10-25U-02	R2/25U
13	0/1/1/13	TUC-SNK50M01FTWAFAB10-28U-WAF-I02	R2/28U
66	\N	\N	\N
67	\N	\N	\N
68	\N	\N	\N
69	\N	\N	\N
105	\N	\N	\N
106	\N	\N	\N
107	\N	\N	\N
108	\N	\N	\N
109	\N	\N	\N
110	\N	\N	\N
111	\N	\N	\N
112	\N	\N	\N
113	\N	\N	\N
114	\N	\N	\N
70	\N	\N	\N
71	\N	\N	\N
72	\N	\N	\N
73	\N	\N	\N
115	\N	\N	\N
74	\N	\N	\N
116	\N	\N	\N
117	\N	\N	\N
118	\N	\N	\N
119	\N	\N	\N
120	\N	\N	\N
121	\N	\N	\N
122	\N	\N	\N
123	\N	\N	\N
124	\N	\N	\N
125	\N	\N	\N
126	\N	\N	\N
127	\N	\N	\N
128	\N	\N	\N
129	\N	\N	\N
130	\N	\N	\N
131	\N	\N	\N
132	\N	\N	\N
133	\N	\N	\N
134	\N	\N	\N
135	\N	\N	\N
136	\N	\N	\N
137	\N	\N	\N
75	\N	\N	\N
76	\N	\N	\N
77	\N	\N	\N
78	\N	\N	\N
79	\N	\N	\N
80	\N	\N	\N
81	\N	\N	\N
82	\N	\N	\N
83	\N	\N	\N
84	\N	\N	\N
85	\N	\N	\N
86	\N	\N	\N
87	\N	\N	\N
88	\N	\N	\N
89	\N	\N	\N
90	\N	\N	\N
91	\N	\N	\N
92	\N	\N	\N
93	\N	\N	\N
94	\N	\N	\N
95	\N	\N	\N
96	\N	\N	\N
97	\N	\N	\N
98	\N	\N	\N
99	\N	\N	\N
100	\N	\N	\N
101	\N	\N	\N
102	\N	\N	\N
103	\N	\N	\N
104	\N	\N	\N
14	0/1/1/14	\N	\N
15	0/1/1/15	\N	\N
16	0/1/1/16	\N	\N
17	0/1/1/17	\N	\N
18	0/1/1/18	\N	\N
19	0/1/1/19	\N	\N
138	\N	\N	\N
139	\N	\N	\N
140	\N	\N	\N
141	\N	\N	\N
142	\N	\N	\N
143	\N	\N	\N
144	\N	\N	\N
145	\N	\N	\N
146	\N	\N	\N
147	\N	\N	\N
148	\N	\N	\N
20	0/1/1/20	\N	\N
21	0/1/1/21	\N	\N
22	0/1/1/22	\N	\N
23	0/1/1/23	\N	\N
24	0/1/1/24	\N	\N
52	0/1/1/52	TUC-SNK50M01ZTSPNDB04-26U-M&S02	SW R4/26U
49	0/1/1/49	TUC-SNK50M01ZTOOBAB11-21U-AGG01	R1/21U
50	0/1/1/50	TUC-SNK50M01ZTOOBAB11-21U-AGG01	R1/21U
149	\N	\N	\N
150	\N	\N	\N
151	\N	\N	\N
152	\N	\N	\N
153	\N	\N	\N
154	\N	\N	\N
155	\N	\N	\N
156	\N	\N	\N
25	0/1/1/25	\N	\N
26	0/1/1/26	\N	\N
27	0/1/1/27	\N	\N
28	0/1/1/28	\N	\N
29	0/1/1/29	\N	\N
30	0/1/1/30	\N	\N
35	0/1/1/35	\N	\N
36	0/1/1/36	\N	\N
37	0/1/1/37	\N	\N
38	0/1/1/38	\N	\N
39	0/1/1/39	\N	\N
40	0/1/1/40	\N	\N
41	0/1/1/41	\N	\N
42	0/1/1/42	\N	\N
43	0/1/1/43	\N	\N
44	0/1/1/44	\N	\N
45	0/1/1/45	\N	\N
46	0/1/1/46	\N	\N
51	0/1/1/51	\N	\N
31	0/1/1/31	TUC-SNK50M01ZTOOBAB09-21U-ACC01	R3/21U
32	0/1/1/32	TUC-SNK50M01ZTOOBDC07-22U-ACC02	R4/22U
33	0/1/1/33	TUC-SNK50M01ZTOOBDC03-22U-ACC03	R6/22U
34	0/1/1/34	TUC-SNK50M01ZTOOBDC02-22U-ACC04	R7/22U
47	0/1/1/47	TUC-SNK50M01ZTOOBAB11-21U-AGG01	R1/21U
48	0/1/1/48	TUC-SNK50M01ZTOOBAB11-21U-AGG01	R1/21U
\.


--
-- TOC entry 5093 (class 0 OID 4465813)
-- Dependencies: 255
-- Data for Name: snk_r1; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.snk_r1 (units, device_names) FROM stdin;
34U	\N
33U	\N
32U	\N
30U	TUC-SNK50M01ZTCOMAB11-30U-EMSFW01
29U	\N
28U	TUC-SNK50M01FTWAFAB11-28U-WAF-I01
27U	\N
26U	\N
25U	TUC-SNK50M01FTFW4AB11-25U-01
24U	\N
23U	TUC-SNK50M01FTIFWAB11-23U-01
22U	\N
21U	TUC-SNK50M01ZTOOBAB11-21U-AGG01
20U	\N
19U	TUC-SNK50M01ZTLEFAB11-19U-SRV01
18U	\N
17U	TUC-SNK50M01ZTLEFAB11-17U-M&S01
16U	\N
15U	\N
14U	TUC-SNK50M01H3TAPAB11-14U-CTRL01
13U	\N
12U	\N
11U	\N
10U	\N
09U	\N
08U	\N
07U	TUC-SNK50M01ZTCOMAB11-07U-VASCAN03
06U	TUC-SNK50M01ZTCOMAB11-06U-VASCAN02
05U	TUC-SNK50M01ZTCOMAB11-05U-VASCAN01
04U	TUC-SNK50M01ZTBAKAB11-04U-SERVER01
03U	TUC-SNK50M01ZTCOMAB11-03U-SDNC01
02U	TUC-SNK50M01ZTSUPAB11-02U-01
01U	TUC-SNK50M01ZTCOMAB11-01U-SDNADAPTER01
31U	TUC-SNK50M01ZTCOMAB11-31U-EMSFW01
\.


--
-- TOC entry 5096 (class 0 OID 4465828)
-- Dependencies: 258
-- Data for Name: snk_r2; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.snk_r2 (units, device_names) FROM stdin;
34U	\N
33U	\N
32U	\N
31U	\N
30U	TUC-SNK50M01ZTCOMAB10-30U-EMSFW02
29U	\N
28U	TUC-SNK50M01FTWAFAB10-28U-WAF-I02
27U	\N
26U	\N
25U	TUC-SNK50M01FTFW4AB10-25U-02
24U	\N
23U	TUC-SNK50M01FTIFWAB10-23U-02
22U	\N
21U	TUC-SNK50M01ZTOOBAB10-21U-AGG02
20U	\N
19U	TUC-SNK50M01ZTLEFAB10-19U-SRV02
18U	\N
17U	TUC-SNK50M01ZTLEFAB10-17U-M&S02
16U	\N
15U	\N
14U	TUC-SNK50M01H3TAPAB10-14U-CTRL02
13U	\N
12U	\N
11U	\N
10U	\N
09U	\N
08U	\N
07U	\N
06U	TUC-SNK50M01ZTCOMAB10-06U-SPLUNK02
05U	TUC-SNK50M01ZTCOMAB10-05U-SPLUNK01
04U	TUC-SNK50M01ZTBAKAB10-04U-SERVER02
03U	TUC-SNK50M01ZTCOMAB10-03U-SDNC02
02U	TUC-SNK50M01ZTSUPAB10-02U-02
01U	TUC-SNK50M01ZTCOMAB10-01U-SDNADAPTER02
\.


--
-- TOC entry 5089 (class 0 OID 4465793)
-- Dependencies: 251
-- Data for Name: snk_r3; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.snk_r3 (units, device_names) FROM stdin;
34U	\N
33U	\N
32U	\N
31U	\N
30U	\N
29U	\N
28U	\N
27U	\N
26U	\N
25U	\N
24U	\N
23U	\N
21U	TUC-SNK50M01ZTOOBAB09-21U-ACC01
20U	\N
19U	\N
18U	\N
17U	\N
16U	\N
15U	\N
14U	\N
13U	\N
12U	\N
11U	\N
10U	\N
09U	\N
08U	\N
07U	\N
06U	TUC-SNK50M01ZTBAKAB09-06U-STORAGE01
05U	\N
04U	TUC-SNK50M01ZTBAKAB09-04U-SERVER03
03U	TUC-SNK50M01ZTCOMAB09-03U-SDNC03
02U	TUC-SNK50M01ZTCOMAB09-02U-EMSSW01
01U	TUC-SNK50M01ZTCOMAB09-01U-SDNADAPTER03
22U	TUC-SNK50M01ZTOOBAB09-22U-ACC01
\.


--
-- TOC entry 5086 (class 0 OID 4465778)
-- Dependencies: 248
-- Data for Name: snk_r4; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.snk_r4 (units, device_names) FROM stdin;
34U	TUC-SNK50S01ZTWRKDC07-34U-18
33U	TUC-SNK50S01ZTWRKDC07-33U-17
32U	TUC-SNK50S01ZTWRKDC07-32U-16
31U	TUC-SNK50S01ZTWRKDC07-31U-15
30U	TUC-SNK50S01ZTWRKDC07-30U-14
29U	TUC-SNK50S01ZTWRKDC07-29U-13
28U	TUC-SNK50S01ZTWRKDC07-28U-12
27U	TUC-SNK50S01ZTWRKDC07-27U-11
26U	TUC-SNK50S01ZTWRKDC07-26U-10
25U	TUC-SNK50S01ZTWRKDC07-25U-09
24U	TUC-SNK50S01ZTWRKDC07-24U-08
23U	\N
22U	TUC-SNK50M01ZTOOBDC07-22U-ACC02
21U	\N
20U	TUC-SNK50S01ZTLEFDC07-20U-SRV01
19U	\N
18U	TUC-SNK50S01ZTLEFDC07-18U-M&S03
17U	\N
16U	TUC-SNK50S01ZTLEFDC07-16U-M&S01
15U	\N
14U	TUC-SNK50S01ZTWRKDC07-14U-07
13U	TUC-SNK50S01ZTWRKDC07-13U-06
12U	TUC-SNK50S01ZTWRKDC07-12U-05
11U	TUC-SNK50S01ZTWRKDC07-11U-04
10U	TUC-SNK50S01ZTWRKDC07-10U-03
09U	TUC-SNK50S01ZTWRKDC07-09U-02
08U	TUC-SNK50S01ZTWRKDC07-08U-01
07U	TUC-SNK50S01ZTINFDC07-07U-01
06U	TUC-SNK50S01ZTMASDC07-06U-02
05U	TUC-SNK50S01ZTMASDC07-05U-01
04U	\N
03U	TUC-SNK50S01ZTCEPDC07-03U-02
02U	\N
01U	TUC-SNK50S01ZTCEPDC07-01U-01
\.


--
-- TOC entry 5098 (class 0 OID 4465838)
-- Dependencies: 260
-- Data for Name: snk_r5; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.snk_r5 (units, device_names) FROM stdin;
34U	\N
33U	\N
32U	\N
31U	\N
30U	TUC-SNK50S01ZTCOMDC06-30U-HSM07
29U	TUC-SNK50S01ZTCOMDC06-29U-HSM06
28U	TUC-SNK50S01ZTCOMDC06-28U-HSM05
27U	TUC-SNK50S01ZTCOMDC06-27U-HSM04
26U	TUC-SNK50S01ZTCOMDC06-26U-HSM03
25U	TUC-SNK50S01ZTCOMDC06-25U-HSM02
24U	TUC-SNK50S01ZTCOMDC06-24U-HSM01
23U	TUC-SNK50S01ZTCOMDC06-23U-SPLUNK02
22U	TUC-SNK50S01ZTCOMDC06-22U-SPLUNK01
21U	\N
20U	TUC-SNK50S01ZTLEFDC06-20U-SRV02
19U	\N
18U	TUC-SNK50S01ZTLEFDC06-18U-M&S04
17U	\N
16U	TUC-SNK50S01ZTLEFDC06-16U-M&S02
15U	\N
14U	TUC-SNK50S01ZTWRKDC06-14U-25
13U	TUC-SNK50S01ZTWRKDC06-13U-24
12U	TUC-SNK50S01ZTWRKDC06-12U-23
11U	TUC-SNK50S01ZTWRKDC06-11U-22
10U	TUC-SNK50S01ZTWRKDC06-10U-21
09U	TUC-SNK50S01ZTWRKDC06-09U-20
08U	TUC-SNK50S01ZTWRKDC06-08U-19
07U	TUC-SNK50S01ZTINFDC06-07U-03
06U	TUC-SNK50S01ZTINFDC06-06U-02
05U	TUC-SNK50S01ZTMASDC06-05U-03
04U	\N
03U	TUC-SNK50S01ZTCEPDC06-03U-04
02U	\N
01U	TUC-SNK50S01ZTCEPDC06-01U-03
\.


--
-- TOC entry 5090 (class 0 OID 4465798)
-- Dependencies: 252
-- Data for Name: snk_r6; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.snk_r6 (units, device_names) FROM stdin;
34U	TUC-SNK50N01ZTWRKDC03-34U-18
33U	TUC-SNK50N01ZTWRKDC03-33U-17
32U	TUC-SNK50N01ZTWRKDC03-32U-16
31U	TUC-SNK50N01ZTWRKDC03-31U-15
30U	TUC-SNK50N01ZTWRKDC03-30U-14
29U	TUC-SNK50N01ZTWRKDC03-29U-13
28U	TUC-SNK50N01ZTWRKDC03-28U-12
27U	TUC-SNK50N01ZTWRKDC03-27U-11
26U	TUC-SNK50N01ZTWRKDC03-26U-10
25U	TUC-SNK50N01ZTWRKDC03-25U-09
24U	TUC-SNK50N01ZTWRKDC03-24U-08
23U	\N
22U	TUC-SNK50M01ZTOOBDC03-22U-ACC03
21U	\N
20U	TUC-SNK50N01ZTLEFDC03-20U-SRV01
19U	\N
18U	TUC-SNK50N01ZTLEFDC03-18U-M&S03
17U	\N
16U	TUC-SNK50N01ZTLEFDC03-16U-M&S01
15U	\N
14U	TUC-SNK50N01ZTWRKDC03-14U-07
13U	TUC-SNK50N01ZTWRKDC03-13U-06
12U	TUC-SNK50N01ZTWRKDC03-12U-05
11U	TUC-SNK50N01ZTWRKDC03-11U-04
10U	TUC-SNK50N01ZTWRKDC03-10U-03
09U	TUC-SNK50N01ZTWRKDC03-09U-02
08U	TUC-SNK50N01ZTWRKDC03-08U-01
07U	TUC-SNK50N01ZTINFDC03-07U-01
06U	TUC-SNK50N01ZTMASDC03-06U-02
05U	TUC-SNK50N01ZTMASDC03-05U-01
04U	\N
03U	TUC-SNK50N01ZTCEPDC03-03U-02
02U	\N
01U	TUC-SNK50N01ZTCEPDC03-01U-01
\.


--
-- TOC entry 5092 (class 0 OID 4465808)
-- Dependencies: 254
-- Data for Name: snk_r7; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.snk_r7 (units, device_names) FROM stdin;
28U	TUC-SNK50N01ZTWRKDC02-28U-28
27U	TUC-SNK50N01ZTWRKDC02-27U-27
26U	TUC-SNK50N01ZTWRKDC02-26U-26
25U	TUC-SNK50N01ZTCOMDC02-25U-SPLUNK02
24U	TUC-SNK50N01ZTCOMDC02-24U-SPLUNK01
23U	\N
22U	TUC-SNK50M01ZTOOBDC02-22U-ACC04
21U	\N
20U	TUC-SNK50N01ZTLEFDC02-20U-SRV02
19U	\N
18U	TUC-SNK50N01ZTLEFDC02-18U-M&S04
17U	\N
16U	TUC-SNK50N01ZTLEFDC02-16U-M&S02
15U	\N
14U	TUC-SNK50N01ZTWRKDC02-14U-25
13U	TUC-SNK50N01ZTWRKDC02-13U-24
12U	TUC-SNK50N01ZTWRKDC02-12U-23
11U	TUC-SNK50N01ZTWRKDC02-11U-22
10U	TUC-SNK50N01ZTWRKDC02-10U-21
09U	TUC-SNK50N01ZTWRKDC02-09U-20
08U	TUC-SNK50N01ZTWRKDC02-08U-19
07U	TUC-SNK50N01ZTINFDC02-07U-03
06U	TUC-SNK50N01ZTINFDC02-06U-02
05U	TUC-SNK50N01ZTMASDC02-05U-03
04U	\N
03U	TUC-SNK50N01ZTCEPDC02-03U-04
02U	\N
01U	TUC-SNK50N01ZTCEPDC02-01U-03
34U	TUC-SNK50N01ZTWRKDC02-30U-30
33U	TUC-SNK50N01ZTWRKDC02-29U-29
32U	TUC-SNK50N01ZTWRKDC02-28U-28
31U	TUC-SNK50N01ZTWRKDC02-27U-27
30U	TUC-SNK50N01ZTWRKDC02-26U-26
29U	TUC-SNK50N01ZTWRKDC02-14U-25
\.


--
-- TOC entry 5091 (class 0 OID 4465803)
-- Dependencies: 253
-- Data for Name: snk_swr1; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.snk_swr1 (units, device_names) FROM stdin;
34U	\N
33U	\N
32U	\N
31U	\N
30U	\N
29U	\N
28U	\N
27U	\N
26U	\N
25U	\N
24U	\N
23U	\N
22U	\N
21U	\N
20U	\N
19U	\N
18U	\N
17U	\N
16U	\N
15U	\N
14U	\N
13U	\N
12U	\N
11U	\N
10U	\N
09U	\N
08U	\N
07U	\N
06U	\N
05U	\N
04U	\N
03U	\N
02U	\N
01U	TUC-SNK50M01ZTDCGDB10-01U-01
\.


--
-- TOC entry 5097 (class 0 OID 4465833)
-- Dependencies: 259
-- Data for Name: snk_swr2; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.snk_swr2 (units, device_names) FROM stdin;
34U	\N
33U	\N
32U	\N
31U	\N
30U	\N
29U	\N
28U	\N
27U	\N
26U	\N
25U	\N
24U	\N
23U	\N
22U	\N
21U	\N
20U	\N
19U	\N
18U	\N
17U	\N
16U	\N
15U	\N
14U	\N
13U	\N
12U	\N
11U	\N
10U	\N
09U	\N
08U	\N
07U	\N
06U	\N
05U	\N
04U	\N
03U	\N
02U	\N
01U	TUC-SNK50M01ZTDCGDB09-01U-02
\.


--
-- TOC entry 5087 (class 0 OID 4465783)
-- Dependencies: 249
-- Data for Name: snk_swr3; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.snk_swr3 (units, device_names) FROM stdin;
34U	\N
33U	\N
32U	\N
31U	\N
30U	\N
29U	\N
28U	\N
27U	\N
26U	TUC-SNK50M01ZTSPNDB05-26U-M&S01
25U	\N
24U	TUC-SNK50M01H3ATPDB05-24U-SPLT01
23U	\N
22U	TUC-SNK50M01H3TAPDB05-22U-NPBSW01
21U	\N
20U	TUC-SNK50M01ZTTAPDB05-20U-MASSW01
19U	\N
17U	\N
16U	\N
15U	\N
14U	\N
13U	\N
12U	\N
11U	\N
10U	\N
09U	\N
08U	\N
07U	\N
06U	\N
05U	\N
04U	\N
03U	\N
02U	\N
01U	\N
18U	TUC-SNK50M01ZTTAPDB05-18U-MASSW01
\.


--
-- TOC entry 5094 (class 0 OID 4465818)
-- Dependencies: 256
-- Data for Name: snk_swr4; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.snk_swr4 (units, device_names) FROM stdin;
34U	\N
33U	\N
32U	\N
31U	\N
30U	\N
29U	\N
28U	\N
27U	\N
26U	TUC-SNK50M01ZTSPNDB04-26U-M&S02
25U	\N
24U	\N
23U	\N
22U	TUC-SNK50M01H3TAPDB04-22U-NPBSW02
21U	\N
20U	TUC-SNK50M01ZTTAPDB04-20U-MASSW02
19U	\N
17U	\N
16U	\N
15U	\N
14U	\N
13U	\N
12U	\N
11U	\N
10U	\N
09U	\N
08U	\N
07U	\N
06U	\N
05U	\N
04U	\N
03U	\N
02U	\N
01U	\N
18U	TUC-SNK50M01ZTTAPDB04-18U-MASSW02
\.


--
-- TOC entry 5095 (class 0 OID 4465823)
-- Dependencies: 257
-- Data for Name: snk_swr5; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.snk_swr5 (units, device_names) FROM stdin;
34U	\N
33U	\N
32U	\N
31U	\N
30U	\N
29U	\N
28U	\N
27U	\N
26U	\N
25U	\N
24U	\N
23U	\N
22U	\N
21U	\N
20U	\N
19U	\N
18U	\N
17U	\N
16U	\N
15U	\N
14U	\N
13U	\N
12U	\N
11U	\N
10U	\N
09U	\N
08U	\N
07U	\N
06U	\N
05U	\N
04U	\N
03U	\N
02U	\N
01U	TUC-SNK50M01ZTSPNDB02-01U-SRV01
\.


--
-- TOC entry 5088 (class 0 OID 4465788)
-- Dependencies: 250
-- Data for Name: snk_swr6; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.snk_swr6 (units, device_names) FROM stdin;
34U	\N
33U	\N
32U	\N
31U	\N
30U	\N
29U	\N
28U	\N
27U	\N
26U	\N
25U	\N
24U	\N
23U	\N
22U	\N
21U	\N
20U	\N
19U	\N
18U	\N
17U	\N
16U	\N
15U	\N
14U	\N
13U	\N
12U	\N
11U	\N
10U	\N
09U	\N
08U	\N
07U	\N
06U	\N
05U	\N
04U	\N
03U	\N
02U	\N
01U	TUC-SNK50M01ZTSPNDB01-01U-SRV02
\.


--
-- TOC entry 5072 (class 0 OID 50647)
-- Dependencies: 234
-- Data for Name: units; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.units (rackunitsid, rackunits) FROM stdin;
1	01U
2	02U
3	03U
4	04U
5	05U
6	06U
7	07U
8	08U
9	09U
10	10U
11	11U
12	12U
13	13U
14	14U
15	15U
16	16U
17	17U
18	18U
19	19U
20	20U
21	21U
22	22U
23	23U
24	24U
25	25U
26	26U
27	27U
28	28U
29	29U
30	30U
31	31U
32	32U
33	33U
34	34U
\.


--
-- TOC entry 5137 (class 0 OID 0)
-- Dependencies: 219
-- Name: brands_brandid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.brands_brandid_seq', 1, false);


--
-- TOC entry 5138 (class 0 OID 0)
-- Dependencies: 221
-- Name: clusters_clusterid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.clusters_clusterid_seq', 1, true);


--
-- TOC entry 5139 (class 0 OID 0)
-- Dependencies: 223
-- Name: domains_domainid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.domains_domainid_seq', 1, false);


--
-- TOC entry 5140 (class 0 OID 0)
-- Dependencies: 273
-- Name: edit_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.edit_log_id_seq', 22, true);


--
-- TOC entry 5141 (class 0 OID 0)
-- Dependencies: 237
-- Name: inputdata_inputid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inputdata_inputid_seq', 147, true);


--
-- TOC entry 5142 (class 0 OID 0)
-- Dependencies: 235
-- Name: mappingdevices_deviceid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mappingdevices_deviceid_seq', 147, true);


--
-- TOC entry 5143 (class 0 OID 0)
-- Dependencies: 242
-- Name: maptypes_typeid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.maptypes_typeid_seq', 1, false);


--
-- TOC entry 5144 (class 0 OID 0)
-- Dependencies: 239
-- Name: nodes_nodeid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.nodes_nodeid_seq', 1, false);


--
-- TOC entry 5145 (class 0 OID 0)
-- Dependencies: 225
-- Name: positions_rst_r_positionsid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.positions_rst_r_positionsid_seq', 1, false);


--
-- TOC entry 5146 (class 0 OID 0)
-- Dependencies: 227
-- Name: positions_snk_s_positionsid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.positions_snk_s_positionsid_seq', 1, false);


--
-- TOC entry 5147 (class 0 OID 0)
-- Dependencies: 229
-- Name: positions_tyb_t_positionsid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.positions_tyb_t_positionsid_seq', 1, false);


--
-- TOC entry 5148 (class 0 OID 0)
-- Dependencies: 231
-- Name: sites_siteid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sites_siteid_seq', 1, false);


--
-- TOC entry 5149 (class 0 OID 0)
-- Dependencies: 265
-- Name: snk_oob_acc_1_port_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.snk_oob_acc_1_port_id_seq', 156, true);


--
-- TOC entry 5150 (class 0 OID 0)
-- Dependencies: 267
-- Name: snk_oob_acc_2_port_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.snk_oob_acc_2_port_id_seq', 156, true);


--
-- TOC entry 5151 (class 0 OID 0)
-- Dependencies: 269
-- Name: snk_oob_acc_3_port_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.snk_oob_acc_3_port_id_seq', 156, true);


--
-- TOC entry 5152 (class 0 OID 0)
-- Dependencies: 271
-- Name: snk_oob_acc_4_port_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.snk_oob_acc_4_port_id_seq', 156, true);


--
-- TOC entry 5153 (class 0 OID 0)
-- Dependencies: 261
-- Name: snk_oob_agg_1_port_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.snk_oob_agg_1_port_id_seq', 156, true);


--
-- TOC entry 5154 (class 0 OID 0)
-- Dependencies: 263
-- Name: snk_oob_agg_2_port_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.snk_oob_agg_2_port_id_seq', 156, true);


--
-- TOC entry 5155 (class 0 OID 0)
-- Dependencies: 233
-- Name: units_rackunitsid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.units_rackunitsid_seq', 1, false);


--
-- TOC entry 4875 (class 2606 OID 50584)
-- Name: brands brands_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.brands
    ADD CONSTRAINT brands_pkey PRIMARY KEY (brandid);


--
-- TOC entry 4877 (class 2606 OID 50593)
-- Name: clusters clusters_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clusters
    ADD CONSTRAINT clusters_pkey PRIMARY KEY (clusterid);


--
-- TOC entry 4899 (class 2606 OID 2225115)
-- Name: device_phycon device_phycon_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.device_phycon
    ADD CONSTRAINT device_phycon_pkey PRIMARY KEY (deviceid_phy);


--
-- TOC entry 4879 (class 2606 OID 50602)
-- Name: domains domains_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.domains
    ADD CONSTRAINT domains_pkey PRIMARY KEY (domainid);


--
-- TOC entry 4913 (class 2606 OID 4465907)
-- Name: edit_log edit_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.edit_log
    ADD CONSTRAINT edit_log_pkey PRIMARY KEY (id);


--
-- TOC entry 4893 (class 2606 OID 50671)
-- Name: inputdata inputdata_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inputdata
    ADD CONSTRAINT inputdata_pkey PRIMARY KEY (inputid);


--
-- TOC entry 4891 (class 2606 OID 50661)
-- Name: mappingdevices mappingdevices_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mappingdevices
    ADD CONSTRAINT mappingdevices_pkey PRIMARY KEY (deviceid);


--
-- TOC entry 4897 (class 2606 OID 2012250)
-- Name: maptypes maptypes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.maptypes
    ADD CONSTRAINT maptypes_pkey PRIMARY KEY (typeid);


--
-- TOC entry 4895 (class 2606 OID 71004)
-- Name: nodes nodes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nodes
    ADD CONSTRAINT nodes_pkey PRIMARY KEY (nodeid);


--
-- TOC entry 4881 (class 2606 OID 50620)
-- Name: positions_rst positions_rst_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions_rst
    ADD CONSTRAINT positions_rst_pkey PRIMARY KEY (r_positionsid);


--
-- TOC entry 4883 (class 2606 OID 50629)
-- Name: positions_snk positions_snk_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions_snk
    ADD CONSTRAINT positions_snk_pkey PRIMARY KEY (s_positionsid);


--
-- TOC entry 4885 (class 2606 OID 50638)
-- Name: positions_tyb positions_tyb_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.positions_tyb
    ADD CONSTRAINT positions_tyb_pkey PRIMARY KEY (t_positionsid);


--
-- TOC entry 4887 (class 2606 OID 50645)
-- Name: sites sites_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sites
    ADD CONSTRAINT sites_pkey PRIMARY KEY (siteid);


--
-- TOC entry 4905 (class 2606 OID 4465870)
-- Name: snk_oob_acc_1 snk_oob_acc_1_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.snk_oob_acc_1
    ADD CONSTRAINT snk_oob_acc_1_pkey PRIMARY KEY (port_id);


--
-- TOC entry 4907 (class 2606 OID 4465879)
-- Name: snk_oob_acc_2 snk_oob_acc_2_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.snk_oob_acc_2
    ADD CONSTRAINT snk_oob_acc_2_pkey PRIMARY KEY (port_id);


--
-- TOC entry 4909 (class 2606 OID 4465888)
-- Name: snk_oob_acc_3 snk_oob_acc_3_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.snk_oob_acc_3
    ADD CONSTRAINT snk_oob_acc_3_pkey PRIMARY KEY (port_id);


--
-- TOC entry 4911 (class 2606 OID 4465897)
-- Name: snk_oob_acc_4 snk_oob_acc_4_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.snk_oob_acc_4
    ADD CONSTRAINT snk_oob_acc_4_pkey PRIMARY KEY (port_id);


--
-- TOC entry 4901 (class 2606 OID 4465852)
-- Name: snk_oob_agg_1 snk_oob_agg_1_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.snk_oob_agg_1
    ADD CONSTRAINT snk_oob_agg_1_pkey PRIMARY KEY (port_id);


--
-- TOC entry 4903 (class 2606 OID 4465861)
-- Name: snk_oob_agg_2 snk_oob_agg_2_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.snk_oob_agg_2
    ADD CONSTRAINT snk_oob_agg_2_pkey PRIMARY KEY (port_id);


--
-- TOC entry 4889 (class 2606 OID 50652)
-- Name: units units_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.units
    ADD CONSTRAINT units_pkey PRIMARY KEY (rackunitsid);


-- Completed on 2024-11-03 14:35:09

--
-- PostgreSQL database dump complete
--

