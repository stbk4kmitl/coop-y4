--1
CREATE TABLE brands (
	brandid SERIAL PRIMARY KEY ,	
	brandname TEXT,
	brandname_m VARCHAR(10));
COPY brands FROM 'E:\Project\db_tables\db_brands.csv' DELIMITER ',' ; 

--2
CREATE TABLE clusters (	
	clusterid SERIAL PRIMARY KEY ,
	clustername TEXT,
	clustername_m VARCHAR(10));	
COPY clusters FROM 'E:\Project\db_tables\db_clusters.csv' DELIMITER ',' ; 

--3
CREATE TABLE domains (	
	domainid SERIAL PRIMARY KEY ,
	domainname TEXT,
	domainname_m VARCHAR(10));	
COPY domains FROM 'E:\Project\db_tables\db_domains.csv' DELIMITER ',' ; 

--4
CREATE TABLE nodes (	
	nodeid SERIAL PRIMARY KEY ,
	nodename TEXT,
	nodename_m VARCHAR(10),
	node_extension VARCHAR (10));	
COPY nodes FROM 'E:\Project\db_tables\db_nodes.csv' DELIMITER ',' ; 

--5
CREATE TABLE positions_rst (		
	r_positionsid SERIAL PRIMARY KEY ,	
	r_positions TEXT,	
	r_positions_m VARCHAR(10));		
COPY positions_rst FROM 'E:\Project\db_tables\db_positions_rst.csv' DELIMITER ',' ; 

--6
CREATE TABLE positions_snk (
	s_positionsid SERIAL PRIMARY KEY,
	s_positions TEXT,
	s_positions_m VARCHAR(10));
COPY positions_snk FROM 'E:\Project\db_tables\db_positions_snk.csv' DELIMITER ',' ; 

--7
CREATE TABLE positions_tyb (		
	t_positionsid SERIAL PRIMARY KEY ,	
	t_positions TEXT,	
	t_positiont_m VARCHAR(10));		
COPY positions_tyb FROM 'E:\Project\db_tables\db_positions_tyb.csv' DELIMITER ',' ; 

--8
CREATE TABLE sites (		
	siteid SERIAL PRIMARY KEY ,	
	sitename VARCHAR(10));		
COPY sites FROM 'E:\Project\db_tables\db_sites.csv' DELIMITER ',' ; 

--9
CREATE TABLE units (		
	rackunitsid SERIAL PRIMARY KEY ,	
	rackunits VARCHAR(10));		
COPY units FROM 'E:\Project\db_tables\db_units.csv' DELIMITER ',' ; 

--10
CREATE TABLE inputdata (
	inputid SERIAL PRIMARY KEY,
	site_input VARCHAR(10),
	domain_input TEXT,
	brand_input TEXT,
	cluster_input TEXT,
	node_input TEXT,
	rackposition_input VARCHAR(10),
	rackunit_input VARCHAR(10)
)
	select * from	nodes;
	select * from inputdata;
	select * from mappingdevices;
--11
CREATE TABLE mappingdevices (
	deviceid SERIAL PRIMARY KEY,
	device_names VARCHAR,
	positions VARCHAR(10),
	units VARCHAR(10));

TRUNCATE TABLE inputdata RESTART IDENTITY;
TRUNCATE TABLE mappingdevices RESTART IDENTITY;

SELECT site_input, domain_input, brand_input, cluster_input, node_input, rackposition_input, rackunit_input 
	FROM inputdata

create table device_phycon (
	deviceid_phy integer PRIMARY KEY,
	device_names text,
	result_type text,
	rack_position text);

create table maptypes (
	typeid SERIAL PRIMARY KEY,
	typeresult text,
	typenames1 text,
	typenames2 text ); 
copy maptypes from 'E:\Project\db_tables\maptypes.csv' delimiter ',' CSV HEADER ;


CREATE TABLE oob_agg_1 (
	port_id SERIAL PRIMARY KEY,
    port TEXT,               -- คอลัมน์แรกเก็บข้อมูล port ในรูปแบบ TEXT
    device_names TEXT,        -- คอลัมน์ที่สอง ชื่อ device_names เก็บข้อมูลเป็น TEXT
    rack_position TEXT        -- คอลัมน์ที่สาม ชื่อ rack_position เก็บข้อมูลเป็น TEXT
);
DO $$
BEGIN
    FOR i IN 1..52 LOOP
        INSERT INTO oob_agg_1 (port) VALUES (NULL);  -- แทรกข้อมูลเพื่อสร้าง 52 แถว
    END LOOP;
END $$;
DO $$
BEGIN
    FOR i IN 1..52 LOOP
        UPDATE oob_agg_1
        SET port = '0/1/1/' || i
        WHERE port_id = i;
    END LOOP;
END $$;



create table map_agg (
	aggid serial,
	type_hw text
)


create table map_acc (
	type_hw text
);
	
copy map_acc from 'E:\Project\db_tables\map_acc.csv' delimiter ',' ;


create table map_ms (
	type_hw text,
	port_1 text,
	port_2 text,
	port_3 text,
	port_4 text);
	
copy map_ms from 'E:\Project\db_tables\map_ms.csv' delimiter ',' CSV ;

create table map_srv (
	type_hw text,
	port_1 text,
	port_2 text);

copy map_srv from 'E:\Project\db_tables\map_srv.csv' delimiter ',' CSV ;