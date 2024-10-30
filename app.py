from flask import Flask, render_template, request, redirect, url_for, send_file
import pandas as pd
import os
import io
import re
import psycopg2
from psycopg2 import sql
import xlsxwriter
import csv

app = Flask(__name__)
app.config['UPLOAD_FOLDER'] = 'temp'
app.config['ALLOWED_EXTENSIONS'] = {'csv','xls', 'xlsx'}
DATABASE_URL = "postgresql://postgres:2002@localhost:5432/databaseforwebpage"

def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in app.config['ALLOWED_EXTENSIONS']

def check_temp_files(folder):
    return any(os.path.isfile(os.path.join(folder, f)) for f in  os.listdir(folder))

def import_csv_to_db(csv_file_path):
    conn = psycopg2.connect(DATABASE_URL)
    cur = conn.cursor()
    with open(csv_file_path, 'r') as f:
        cur.copy_expert(sql.SQL("""
            COPY inputdata (site_input, domain_input, brand_input, cluster_input, node_input, rackposition_input, rackunit_input)
            FROM STDIN WITH CSV HEADER
        """), f)
    conn.commit()
    cur.close()
    conn.close()

def check_inputfiles():
    if request.method == 'POST':
        if 'file' not in request.files:
            return redirect(url_for('home'))
        file = request.files['file']
        if file.filename == '':
            return redirect(url_for('home'))
        if file and allowed_file(file.filename):
            filename = file.filename
            filepath = os.path.join(app.config['UPLOAD_FOLDER'], filename)
            file.save(filepath)
            if file.filename.lower().endswith('.csv'):
                csv_filepath = filepath
            else: 
                csv_filename = filename.rsplit('.', 1)[0] + '.csv'
                csv_filepath = os.path.join(app.config['UPLOAD_FOLDER'], csv_filename)
                
                df = pd.read_excel(filepath)
                df.to_csv(csv_filepath, index=False)
            
            import_csv_to_db(csv_filepath)
            return redirect(url_for('racklayout'))
        if check_temp_files(app.config['UPLOAD_FOLDER']):
            return redirect(url_for('racklayout'))

def mapping_types():
    conn = psycopg2.connect(DATABASE_URL)
    cur = conn.cursor()

    # ดึงข้อมูลจากตาราง mappingdevices
    cur.execute('SELECT deviceid, device_names FROM mappingdevices')
    mapping_devices_rows = cur.fetchall()

    # สร้างตาราง device_phycon ถ้ายังไม่มี
    cur.execute("""
        CREATE TABLE IF NOT EXISTS device_phycon (
            deviceid_phy integer,
            device_names text,
            result_type text,
            rack_position text
        );
    """)

    # นำข้อมูลจาก mappingdevices ไปใส่ใน device_phycon
    cur.execute("""
        INSERT INTO device_phycon (deviceid_phy, device_names)
        SELECT deviceid, device_names
        FROM mappingdevices;
    """)

    # อัพเดตค่า result_type ใน device_phycon
    for row in mapping_devices_rows:
        device_id = row[0]
        device_names = row[1]
        cur.execute('SELECT typenames1, typenames2, typenames3, typeresult FROM maptypes;')
        maptypes_rows = cur.fetchall()

        for map_row in maptypes_rows:
            typename1 = map_row[0]
            typename2 = map_row[1]
            typename3 = map_row[2]
            typeresult = map_row[3]

            if all([typename1, typename2, typename3]):  # ตรวจสอบว่าทั้งสามตัวไม่เป็น None หรือค่าว่าง
                if typename1 in device_names and typename2 in device_names and typename3 in device_names:
                    cur.execute("""
                        UPDATE device_phycon
                        SET result_type = %s
                        WHERE device_names = %s;
                    """, (typeresult, device_names))

            elif all([typename1, typename2]) and not typename3:  # ตรวจสอบว่า typename1 และ typename2 มีค่า และ typename3 ไม่มีค่า
                if typename1 in device_names and typename2 in device_names:
                    cur.execute("""
                        UPDATE device_phycon
                        SET result_type = %s
                        WHERE device_names = %s;
                    """, (typeresult, device_names))

            elif typename1 and not typename2 and not typename3:  # ตรวจสอบเฉพาะ typename1
                if typename1 in device_names:
                    cur.execute("""
                        UPDATE device_phycon
                        SET result_type = %s
                        WHERE device_names = %s;
                    """, (typeresult, device_names))

    # อัพเดตค่า rack_position ใน device_phycon โดยใช้ deviceid_phy เพื่อตรวจสอบค่าที่ตรงกันใน inputdata
    cur.execute('SELECT deviceid_phy FROM device_phycon')
    device_phycon_rows = cur.fetchall()

    for (deviceid_phy,) in device_phycon_rows:
        cur.execute("""
            SELECT rackposition_input, rackunit_input
            FROM inputdata
            WHERE inputid = %s;
        """, (deviceid_phy,))
        input_data_row = cur.fetchone()

        if input_data_row:
            rackposition_input, rackunit_input = input_data_row
            # ประกอบค่าจาก rackposition_input และ rackunit_input เป็นรูปแบบ R1/02U
            rack_position = f"{rackposition_input}/{rackunit_input}"
            # อัพเดตค่า rack_position ใน device_phycon
            cur.execute("""
                UPDATE device_phycon
                SET rack_position = %s
                WHERE deviceid_phy = %s;
            """, (rack_position, deviceid_phy))

    # Commit และปิดการเชื่อมต่อฐานข้อมูล
    conn.commit()
    cur.close()
    conn.close()

def mapping_data():
    conn = psycopg2.connect(DATABASE_URL)
    cur = conn.cursor()
    cur.execute('SELECT inputid, site_input, domain_input, brand_input, cluster_input, node_input, rackposition_input, rackunit_input FROM inputdata')
    rows = cur.fetchall()

    nodename_counts = {}
    device_counts = {}
    previous_domain = None
    for row in rows:
        inputid, site_input, domain_input, brand_input, cluster_input, node_input, rackposition_input, rackunit_input = row

        cur.execute('SELECT sitename FROM sites WHERE sitename = %s', (site_input,))
        result_site = cur.fetchone()
        if result_site is not None:
            site_map = result_site[0]
        else:
            print(f"Site not found for inputid no. {inputid}")
            site_map = "___"
        
        cur.execute('SELECT domainname_m FROM domains WHERE domainname = %s', (domain_input,))
        result_domain = cur.fetchone()
        if result_domain is not None:
            domain_map = result_domain[0]
        else:
            print(f"Domain not found for inputid no. {inputid}")
            domain_map = "_"

        cur.execute('SELECT brandname_m FROM brands WHERE brandname = %s', (brand_input,))
        result_brand = cur.fetchone()
        if result_brand is not None:
            brand_map = result_brand[0]
        else:
            print(f"Brand not found for inputid no. {inputid}")
            brand_map = "__"

        cur.execute('SELECT clustername_m FROM clusters WHERE clustername = %s', (cluster_input,))
        result_cluster = cur.fetchone()
        if result_cluster is not None:
            cluster_map = result_cluster[0]
        else:
            print(f"Cluster not found for inputid no. {inputid}")
            cluster_map = "__"
  
        cur.execute('SELECT nodename_m FROM nodes WHERE nodename = %s', (node_input,))
        result_node = cur.fetchone()
        if result_node is not None:
            node_map = result_node[0]
        else:
            print(f"Node not found for {inputid}")
            node_map = "___"

        cur.execute('SELECT nodename FROM nodes WHERE nodename = %s', (node_input,))
        result_nodename = cur.fetchone()
        if result_nodename is not None:
            nodename = result_nodename[0]
        else:
            print(f"Node not found for {inputid}")
            nodename = ""

        cur.execute('SELECT node_extension FROM nodes WHERE nodename = %s', (node_input,))
        result_node_ext = cur.fetchone()
        if result_node_ext is not None:
            node_map_ext = result_node_ext[0]
        else:
            print(f"Node not found for {inputid}")
            node_map_ext = ""

    #rst site
        if site_input == 'RST':
            cur.execute('SELECT r_positions_m FROM positions_rst WHERE r_positions = %s', (rackposition_input,))
            result_position = cur.fetchone()
            if result_position is not None:
                position_map = result_position[0]
            else:
                print(f"RST position not found for {inputid}")
                position_map = "____"

    #tyb site
        elif site_input == 'TYB':
            cur.execute('SELECT t_positions_m FROM positions_tyb WHERE t_positions = %s', (rackposition_input,))
            result_position = cur.fetchone()
            if result_position is not None:
                position_map = result_position[0]
            else:
                print(f"TYB position not found for {inputid}")
                position_map = "____"
                
    #snk site            
        elif site_input == 'SNK':
            cur.execute('SELECT s_positions_m FROM positions_snk WHERE s_positions = %s', (rackposition_input,))
            result_position = cur.fetchone()
            if result_position is not None:
                position_map = result_position[0]
            else:
                print(f"SNK position not found for {inputid}")
                position_map = "____"

        else:
            print(f"Position not found for {inputid}")
            position_map = "____"
            

        cur.execute('SELECT rackunits FROM units WHERE rackunits = %s', (rackunit_input,))
        result_unit = cur.fetchone()
        if result_unit is not None:
            unit_map = result_unit[0]
        else:
            print(f"Unit not found for {inputid}")

        if domain_map != previous_domain:
            device_counts = {}
            previous_domain = domain_map
            
        if node_map not in device_counts:
            device_counts[node_map] = 1
        else:
            device_counts[node_map] += 1

        if node_map in ['COM', 'TAP', 'LEF', 'BAK', 'OOB', 'SPN', 'M&S', 'SRV']:
            if domain_map not in nodename_counts:
                nodename_counts[domain_map] = {}       
            
            if nodename not in nodename_counts[domain_map]:
                nodename_counts[domain_map][nodename] = 1
            else:
                nodename_counts[domain_map][nodename] += 1

            device_name = f"TUC-{site_map}50{domain_map}{cluster_map}{brand_map}{node_map}{position_map}-{unit_map}-{node_map_ext}{nodename_counts[domain_map][nodename]:02}"

        else:
            if node_map_ext == "":
                device_name = f"TUC-{site_map}50{domain_map}{cluster_map}{brand_map}{node_map}{position_map}-{unit_map}-{device_counts[node_map]:02}"
                    
            else:
               device_name = f"TUC-{site_map}50{domain_map}{cluster_map}{brand_map}{node_map}{position_map}-{unit_map}-{node_map_ext}{device_counts[node_map]:02}"

        # บันทึก device_name ลงในตาราง mappingdevices
        cur.execute(
            "INSERT INTO mappingdevices (inputid, device_names, positions, units) VALUES (%s,%s,%s,%s)",
            (inputid, device_name, position_map, unit_map)
        )

    conn.commit()
    cur.close()
    conn.close()
    print('def: mapping_data')
    mapping_types()
    print('def: mapping_types')

def get_created_tables():
    conn = psycopg2.connect(DATABASE_URL)
    cur = conn.cursor()
    query = """
        SELECT table_name
        FROM information_schema.tables
        WHERE table_schema = 'public'
        AND (table_name ILIKE 'RST_%' OR table_name ILIKE 'TYB_%' OR table_name ILIKE 'SNK_%');
    """
    cur.execute(query)
    tables = [table[0] for table in cur.fetchall()]
    cur.close()
    conn.close()

    def extract_number(table_name):
        numbers = re.findall(r'\d+', table_name)
        return int(numbers[0]) if numbers else 0

    # เรียงลำดับชื่อเทเบิลตามตัวเลขในชื่อ เช่น rack_1, rack_2
    sorted_tables = sorted(tables, key=extract_number)
    print('def: get_created_tables')
    return sorted_tables

def hardware_each_rack():
    conn = psycopg2.connect(DATABASE_URL)
    cur = conn.cursor()
    
    cur.execute("SELECT inputid, site_input FROM inputdata")
    query_data = cur.fetchall()
    created_tables = []

    # Generate all unit values (01U to 47U) in Python (no need for temp table)
    all_units = [f"{str(i).zfill(2)}U" for i in range(1, 48)] 

    for row in query_data:
        inputid, site_input = row

        if site_input in ["SNK", "RST", "TYB"]:
            if site_input == "SNK":
                query = """
                    SELECT DISTINCT md.positions, ps.s_positions
                    FROM mappingdevices md
                    JOIN positions_snk ps
                    ON md.positions = ps.s_positions_m;
                """
            elif site_input == "RST":
                query = """
                    SELECT DISTINCT md.positions, pr.r_positions
                    FROM mappingdevices md
                    JOIN positions_rst pr
                    ON md.positions = pr.r_positions_m;
                """
            elif site_input == "TYB":
                query = """
                    SELECT DISTINCT md.positions, pt.t_positions
                    FROM mappingdevices md
                    JOIN positions_tyb pt
                    ON md.positions = pt.t_positions_m;
                """
            try:
                cur.execute(query)
                positions_mapping = cur.fetchall()

                for positions, mapped_position in positions_mapping:
                    table_name = f"{site_input}_{mapped_position}"
                    table_name = ''.join(e for e in table_name if e.isalnum() or e == '_')

                    # Create SQL for all units in one query without temp table
                    values = ','.join([f"('{unit}')" for unit in all_units])
                    created_table_query = f"""
                        DROP TABLE IF EXISTS {table_name};
                        CREATE TABLE {table_name} AS
                        WITH units_table AS (
                            SELECT unnest(ARRAY[{','.join([f"'{unit}'" for unit in all_units])}]) AS units
                        )
                        SELECT units_table.units, md.device_names
                        FROM units_table
                        LEFT JOIN mappingdevices md
                        ON units_table.units = md.units
                        AND md.positions = '{positions}'
                        ORDER BY units_table.units DESC;
                    """

                    try:
                        cur.execute(created_table_query)
                        created_tables.append(table_name)
                        conn.commit()
                    except Exception as e:
                        print(f"Error creating table {table_name}: {e}")
                        conn.rollback()

            except Exception as e:
                print(f"Error executing query for site_input == '{site_input}': {e}")
                conn.rollback()

        else:
            print(f"No tables created for inputid: {inputid} and site_input: {site_input}")

    print('def: hardware_each_rack')
    cur.close()
    conn.close()

def get_table_data(table_name):
    conn = psycopg2.connect(DATABASE_URL)
    cur = conn.cursor()
    # ตรวจสอบชื่อเทเบิลเพื่อป้องกัน SQL Injection
    if not re.match(r'^[A-Za-z0-9_]+$', table_name):
        return {}
    query = f"SELECT * FROM {table_name};"
    try:
        cur.execute(query)
        columns = [desc[0] for desc in cur.description]
        rows = cur.fetchall()
    except Exception as e:
        print(f"Error fetching data from {table_name}: {e}")
        columns = []
        rows = []
    cur.close()
    conn.close()
    print('def: get_table_data')
    return {'columns': columns, 'rows': rows}
  
def create_oob_agg_tables():
    conn = psycopg2.connect(DATABASE_URL)
    cur = conn.cursor()

    # ขั้นตอนที่ 1: ดึงข้อมูล result_type และ device_names จากตาราง device_phycon
    cur.execute("""
        SELECT result_type, device_names 
        FROM device_phycon 
        WHERE result_type LIKE 'OOB AGG%';
    """)
    oob_agg_data = cur.fetchall()  # ดึงข้อมูลทั้งหมด
    agg_names = []
    # ขั้นตอนที่ 2: สร้างตารางตามจำนวนที่พบ พร้อม prefix
    for i, (result_type, device_name) in enumerate(oob_agg_data, 1):
        if 'SNK' in device_name:
            prefix = 'snk'
        elif 'RST' in device_name:
            prefix = 'rst'
        elif 'TYB' in device_name:
            prefix = 'tyb'
        else:
            prefix = 'default'

        agg_table_names = f"{prefix}_oob_agg_{i}"
        agg_names.append(agg_table_names)
        cur.execute(f"""
            CREATE TABLE IF NOT EXISTS {agg_table_names} (
                port_id SERIAL PRIMARY KEY,
                port TEXT,
                device_names TEXT,
                rack_position TEXT
            );""")
        print('Created table:', agg_table_names)
    conn.commit()
    # ขั้นตอนที่ 3: เพิ่มข้อมูล 52 แถวในแต่ละตาราง
    for i, (result_type, device_name) in enumerate(oob_agg_data, 1):
        prefix = 'snk' if 'SNK' in device_name else 'rst' if 'RST' in device_name else 'tyb' if 'TYB' in device_name else 'default'
        agg_table_names = f"{prefix}_oob_agg_{i}"

        cur.execute(f"""
            DO $$
            BEGIN
                FOR i IN 1..52 LOOP
                    INSERT INTO {agg_table_names} (port) VALUES (NULL);
                END LOOP;
            END $$;
        """)

        cur.execute(f"""
            DO $$
            BEGIN
                FOR i IN 1..52 LOOP
                    UPDATE {agg_table_names}
                    SET port = '0/1/1/' || i
                    WHERE port_id = i;
                END LOOP;
            END $$;
        """)

    conn.commit()
    cur.close()
    print('def: create_oob_agg_tables')
    return agg_names
    
def create_oob_agg_1(agg_names):

    selected_table_name = next(
        (table for table in agg_names if table.endswith("_oob_agg_1")), None)
    if not selected_table_name:
        print("No suitable table found.")
        return  # ออกจากฟังก์ชันถ้าไม่มีตารางที่ตรงกัน
    
    conn = psycopg2.connect(DATABASE_URL)
    cur = conn.cursor()
    cur.execute('SELECT type_hw FROM map_agg ORDER BY type_hw;')
    map_agg_rows = cur.fetchall()

    cur.execute(f'SELECT port_id, port FROM {selected_table_name} ORDER BY port_id;')
    oob_agg_ports = cur.fetchall()
    port_index = 0

    port_dcgw_to_wafi_limit = 30
    port_oob_acc_start = 30
    port_oob_agg_start = 46

    # ขั้นแรก: อัปเดตข้อมูล DCGW, M&S Spine, SRV Spine
    for map_row in map_agg_rows:
        type_hw = map_row[0]

        if type_hw.lower() in ['dcgw', 'm&s spine', 'srv spine']:
            cur.execute("""
                SELECT device_names, rack_position
                FROM device_phycon
                WHERE result_type = %s
            """, (type_hw,))
            device_phycon_rows = cur.fetchall()  

            for device_phycon_row in device_phycon_rows:
                device_names = device_phycon_row[0]
                rack_position = device_phycon_row[1]

                if port_index < port_dcgw_to_wafi_limit:
                    cur.execute(f"""
                        UPDATE {selected_table_name}
                        SET device_names = %s, rack_position = %s
                        WHERE port_id = %s;
                    """, (device_names,rack_position, oob_agg_ports[port_index][0]))
                    port_index += 1
        else:
            continue

    # ขั้นที่สอง: อัปเดตข้อมูล MAS SW, NPBSW
    for map_row in map_agg_rows:
        type_hw = map_row[0]

        # ข้ามประเภทที่ถูกอัปเดตไปแล้วในขั้นแรก
        if type_hw.lower() in ['dcgw', 'm&s spine', 'srv spine']:
            continue

        if type_hw.lower() in ['mas sw', 'npbsw']:
            cur.execute("""
                SELECT device_names , rack_position
                FROM device_phycon 
                WHERE result_type = %s
            """, (type_hw,))
            device_phycon_rows = cur.fetchall()

            for device_phycon_row in device_phycon_rows:
                device_names = device_phycon_row[0]
                rack_position = device_phycon_row[1]

                if port_index < port_dcgw_to_wafi_limit:
                    if device_names.endswith('01'):
                        cur.execute(f"""
                            UPDATE {selected_table_name}
                            SET device_names = %s, rack_position = %s
                            WHERE port_id = %s;
                        """, (device_names,rack_position, oob_agg_ports[port_index][0]))
                        port_index += 1

    # ขั้นที่สาม: อัปเดตข้อมูล FW-I, FW4, WAF-I
    for map_row in map_agg_rows:
        type_hw = map_row[0]

        # ข้ามประเภทที่ถูกอัปเดตไปแล้วในขั้นแรกและขั้นที่สอง
        if type_hw.lower() in ['dcgw', 'm&s spine', 'srv spine', 'mas sw', 'npbsw']:
            continue

        if type_hw.lower() in ['fw-i', 'fw4', 'waf-i']:
            cur.execute("""
                SELECT device_names , rack_position
                FROM device_phycon 
                WHERE result_type = %s
            """, (type_hw,))
            device_phycon_rows = cur.fetchall()

            for device_phycon_row in device_phycon_rows:
                device_names = device_phycon_row[0]
                rack_position = device_phycon_row[1]

                if type_hw.lower() == 'waf-i' and device_names.endswith('01'):
                    if port_index < port_dcgw_to_wafi_limit:
                        cur.execute(f"""
                            UPDATE {selected_table_name}
                            SET device_names = %s, rack_position = %s
                            WHERE port_id = %s;
                        """, (device_names, rack_position,oob_agg_ports[port_index][0]))
                        port_index += 1
                elif type_hw.lower() in ['fw-i', 'fw4']:
                    if port_index < port_dcgw_to_wafi_limit:
                        cur.execute(f"""
                            UPDATE {selected_table_name}
                            SET device_names = %s, rack_position = %s
                            WHERE port_id = %s;
                        """, (device_names, rack_position,oob_agg_ports[port_index][0]))
                        port_index += 1
# ขั้นที่สี่: อัปเดตข้อมูล OOB ACC, OOB AGG, M&S Spine
    for map_row in map_agg_rows:
        type_hw = map_row[0]

        # ข้ามประเภทที่ถูกอัปเดตไปแล้วในขั้นก่อนหน้า
        if type_hw.lower() in ['dcgw', 'srv spine', 'mas sw', 'npbsw', 'fw-i', 'fw4', 'waf-i']:
            continue

        cur.execute("""
            SELECT device_names , rack_position
            FROM device_phycon 
            WHERE result_type = %s
        """, (type_hw,))
        device_phycon_rows = cur.fetchall()

        for device_phycon_row in device_phycon_rows:
            device_names = device_phycon_row[0]
            rack_position = device_phycon_row[1]

            # เงื่อนไขสำหรับ OOB ACC (Port 31-46)
            if type_hw.lower() == 'oob acc':
                # กำหนดค่า port_index เริ่มจากพอร์ต 31
                port_index = max(port_oob_acc_start, port_index)
                if port_index < port_oob_agg_start:  # ตรวจสอบว่าไม่เกินพอร์ต 46
                    cur.execute(f"""
                        UPDATE {selected_table_name}
                        SET device_names = %s, rack_position = %s
                        WHERE port_id = %s;
                    """, (device_names,  rack_position,oob_agg_ports[port_index][0]))
                    port_index += 1

            # เงื่อนไขสำหรับ OOB AGG (Port 47-51, เลือก device_names ที่ลงท้ายด้วย 02)
            elif type_hw.lower() == 'oob agg' and device_names.endswith('02'):
                # กำหนดค่า port_index เริ่มจากพอร์ต 47
                port_index = max(port_oob_agg_start, port_index)
                for _ in range(4):
                    if port_index <= 51:  # ตรวจสอบว่าไม่เกินพอร์ต 51
                        cur.execute(f"""
                            UPDATE {selected_table_name}
                            SET device_names = %s, rack_position = %s
                            WHERE port_id = %s;
                        """, (device_names,  rack_position,oob_agg_ports[port_index][0]))
                        port_index += 1

            # เงื่อนไขสำหรับ M&S Spine (Port 52)
            elif type_hw.lower() == 'm&s spine' and device_names.endswith('01'):
                cur.execute(f"""
                    UPDATE {selected_table_name}
                    SET device_names = %s, rack_position = %s
                    WHERE port_id = 52;
                """, (device_names, rack_position))

    conn.commit()
    print('def: create_oob_agg1()')
    print(f'{selected_table_name}')
    cur.close()
    conn.close()

def create_oob_agg_2(agg_names):
    selected_table_name = next(
        (table for table in agg_names if table.endswith("_oob_agg_2")), None)

    if not selected_table_name:
        print("No suitable table found.")
        return  # ออกจากฟังก์ชันถ้าไม่มีตารางที่ตรงกัน

    conn = psycopg2.connect(DATABASE_URL)
    cur = conn.cursor()

    cur.execute('SELECT type_hw FROM map_agg ORDER BY type_hw;')
    map_agg_rows = cur.fetchall()

    cur.execute(f'SELECT port_id, port FROM {selected_table_name} ORDER BY port_id;')
    oob_agg_ports = cur.fetchall() 
    port_index = 0

    port_dcgw_to_wafi_limit = 30
    port_oob_acc_start = 30
    port_oob_agg_start = 46

    # ขั้นแรก: อัปเดตข้อมูล DCGW, M&S Spine, SRV Spine
    for map_row in map_agg_rows:
        type_hw = map_row[0]

        if type_hw.lower() in ['dcgw', 'm&s spine', 'srv spine']:
            # ดึงข้อมูล device_names จากตาราง device_phycon ที่มี result_type ตรงกับ type_hw
            cur.execute("""
                SELECT device_names , rack_position
                FROM device_phycon 
                WHERE result_type = %s
            """, (type_hw,))
            device_phycon_rows = cur.fetchall()  # ดึงข้อมูลทุกแถวที่ตรงกัน
        
            for device_phycon_row in device_phycon_rows:
                device_names = device_phycon_row[0]
                rack_position = device_phycon_row[1]

                if port_index < port_dcgw_to_wafi_limit:
                    cur.execute(f"""
                        UPDATE {selected_table_name}
                        SET device_names = %s, rack_position = %s
                        WHERE port_id = %s;
                    """, (device_names, rack_position,oob_agg_ports[port_index][0]))
                    port_index += 1
        else:
            continue

    # ขั้นที่สอง: อัปเดตข้อมูล MAS SW, NPBSW
    for map_row in map_agg_rows:
        type_hw = map_row[0]

        # ข้ามประเภทที่ถูกอัปเดตไปแล้วในขั้นแรก
        if type_hw.lower() in ['dcgw', 'm&s spine', 'srv spine']:
            continue

        if type_hw.lower() in ['mas sw', 'npbsw']:
            cur.execute("""
                SELECT device_names , rack_position
                FROM device_phycon 
                WHERE result_type = %s
            """, (type_hw,))
            device_phycon_rows = cur.fetchall()

            for device_phycon_row in device_phycon_rows:
                device_names = device_phycon_row[0]
                rack_position = device_phycon_row[1]

                if port_index < port_dcgw_to_wafi_limit:
                    if device_names.endswith('02'):
                        cur.execute(f"""
                            UPDATE {selected_table_name}
                            SET device_names = %s, rack_position = %s
                            WHERE port_id = %s;
                        """, (device_names,rack_position, oob_agg_ports[port_index][0]))
                        port_index += 1

    # ขั้นที่สาม: อัปเดตข้อมูล FW-I, FW4, WAF-I
    for map_row in map_agg_rows:
        type_hw = map_row[0]

        # ข้ามประเภทที่ถูกอัปเดตไปแล้วในขั้นแรกและขั้นที่สอง
        if type_hw.lower() in ['dcgw', 'm&s spine', 'srv spine', 'mas sw', 'npbsw']:
            continue

        if type_hw.lower() in ['fw-i', 'fw4', 'waf-i']:
            cur.execute("""
                SELECT device_names , rack_position
                FROM device_phycon 
                WHERE result_type = %s
            """, (type_hw,))
            device_phycon_rows = cur.fetchall()

            for device_phycon_row in device_phycon_rows:
                device_names = device_phycon_row[0]
                rack_position = device_phycon_row[1]

                if type_hw.lower() == 'waf-i' and device_names.endswith('02'):
                    if port_index < port_dcgw_to_wafi_limit:
                        cur.execute(f"""
                            UPDATE {selected_table_name}
                            SET device_names = %s, rack_position = %s
                            WHERE port_id = %s;
                        """, (device_names,rack_position, oob_agg_ports[port_index][0]))
                        port_index += 1
                elif type_hw.lower() in ['fw-i', 'fw4']:
                    if port_index < port_dcgw_to_wafi_limit:
                        cur.execute(f"""
                            UPDATE {selected_table_name}
                            SET device_names = %s, rack_position = %s
                            WHERE port_id = %s;
                        """, (device_names,rack_position, oob_agg_ports[port_index][0]))
                        port_index += 1
# ขั้นที่สี่: อัปเดตข้อมูล OOB ACC, OOB AGG, M&S Spine
    for map_row in map_agg_rows:
        type_hw = map_row[0]

        # ข้ามประเภทที่ถูกอัปเดตไปแล้วในขั้นก่อนหน้า
        if type_hw.lower() in ['dcgw', 'srv spine', 'mas sw', 'npbsw', 'fw-i', 'fw4', 'waf-i']:
            continue

        cur.execute("""
            SELECT device_names , rack_position
            FROM device_phycon 
            WHERE result_type = %s
        """, (type_hw,))
        device_phycon_rows = cur.fetchall()

        for device_phycon_row in device_phycon_rows:
            device_names = device_phycon_row[0]
            rack_position = device_phycon_row[1]

            # เงื่อนไขสำหรับ OOB ACC (Port 31-46)
            if type_hw.lower() == 'oob acc':
                # กำหนดค่า port_index เริ่มจากพอร์ต 31
                port_index = max(port_oob_acc_start, port_index)
                if port_index < port_oob_agg_start:  # ตรวจสอบว่าไม่เกินพอร์ต 46
                    cur.execute(f"""
                        UPDATE {selected_table_name}
                        SET device_names = %s, rack_position = %s
                        WHERE port_id = %s;
                    """, (device_names,rack_position, oob_agg_ports[port_index][0]))
                    port_index += 1

            # เงื่อนไขสำหรับ OOB AGG (Port 47-51, เลือก device_names ที่ลงท้ายด้วย 02)
            elif type_hw.lower() == 'oob agg' and device_names.endswith('01'):
                # กำหนดค่า port_index เริ่มจากพอร์ต 47
                port_index = max(port_oob_agg_start, port_index)
                for _ in range(4):
                    if port_index <= 51:  # ตรวจสอบว่าไม่เกินพอร์ต 51
                        cur.execute(f"""
                            UPDATE {selected_table_name}
                            SET device_names = %s, rack_position = %s
                            WHERE port_id = %s;
                        """, (device_names, rack_position,oob_agg_ports[port_index][0]))
                        port_index += 1

            # เงื่อนไขสำหรับ M&S Spine (Port 52)
            elif type_hw.lower() == 'm&s spine' and device_names.endswith('02'):
                cur.execute(f"""
                    UPDATE {selected_table_name}
                    SET device_names = %s, rack_position = %s
                    WHERE port_id = 52;
                """, (device_names, rack_position))

    conn.commit()
    print('def: create_oob_agg2()')
    print(f'{selected_table_name}')
    cur.close()
    conn.close()

def create_oob_acc_tables():    
    conn = psycopg2.connect(DATABASE_URL)
    cur = conn.cursor()
    # ขั้นตอนที่ 1: ดึงข้อมูล result_type และ device_names จากตาราง device_phycon
    cur.execute("""
        SELECT result_type, device_names 
        FROM device_phycon 
        WHERE result_type LIKE 'OOB ACC%';
    """)
    oob_acc_data = cur.fetchall()  # ดึงข้อมูลทั้งหมด
    acc_names = []  # นับจำนวน oob_acc ที่มีอยู่

    # ขั้นตอนที่ 2: สร้างตารางตามจำนวนที่พบ พร้อม prefix
    for i, (result_type, device_name) in enumerate(oob_acc_data, 1):
        # ตรวจสอบ prefix จาก device_names
        if 'SNK' in device_name:
            prefix = 'snk'
        elif 'RST' in device_name:
            prefix = 'rst'
        elif 'TYB' in device_name:
            prefix = 'tyb'
        else:
            prefix = 'default'  # กรณีไม่มี prefix ที่กำหนด

        acc_table_name = f"{prefix}_oob_acc_{i}"
        acc_names.append(acc_table_name)
        cur.execute(f"""
            CREATE TABLE IF NOT EXISTS {acc_table_name} (
                port_id SERIAL PRIMARY KEY,
                port TEXT,
                device_names TEXT,
                rack_position TEXT
            );""")
        print('Created table:', acc_table_name)

    conn.commit()

    # ขั้นตอนที่ 3: เพิ่มข้อมูล 52 แถวในแต่ละตาราง
    for i, (result_type, device_name) in enumerate(oob_acc_data, 1):
        prefix = 'snk' if 'SNK' in device_name else 'rst' if 'RST' in device_name else 'tyb' if 'TYB' in device_name else 'default'
        acc_table_name = f"{prefix}_oob_acc_{i}"

        cur.execute(f"""
            DO $$
            BEGIN
                FOR i IN 1..52 LOOP
                    INSERT INTO {acc_table_name} (port) VALUES (NULL);
                END LOOP;
            END $$;
        """)

        cur.execute(f"""
            DO $$
            BEGIN
                FOR i IN 1..52 LOOP
                    UPDATE {acc_table_name}
                    SET port = '0/1/1/' || i
                    WHERE port_id = i;
                END LOOP;
            END $$;
        """)

    conn.commit() 
    cur.close()
    #print('def: create_oob_acc_tables')
    return acc_names



def insert_data_to_oob_acc(acc_names):
    conn = psycopg2.connect(DATABASE_URL)
    cur = conn.cursor()
    rack_tables = []

    # ค้นหา rack tables ตาม prefix
    for acc in acc_names:
        if 'snk' in acc:
            prefix = 'snk_r'
        elif 'rst' in acc:
            prefix = 'rst_r'
        elif 'tyb' in acc:
            prefix = 'tyb_r'
        else:
            continue

        cur.execute(f"""
            SELECT table_name 
            FROM information_schema.tables 
            WHERE table_name LIKE '{prefix}%'; """)
        tables = cur.fetchall()
        rack_tables.extend([table[0] for table in tables])
    rack_tables = sorted(set(rack_tables))

    port_index = 1  # เริ่มต้นที่พอร์ต 1
    acc_table_index = 0  # ตาราง OOB ACC แรก

    for rack_table in rack_tables:
        cur.execute(f"""
            SELECT device_names, units 
            FROM {rack_table}
            WHERE (units BETWEEN '01U' AND '15U') OR (units BETWEEN '22U' AND '34U')
            ORDER BY units;
        """)
        rack_devices = cur.fetchall()

        # แยกข้อมูลตามช่วง units และลบข้อมูลที่ไม่มีใน device[0]
        devices_01_15U = [device for device in rack_devices if '01U' <= str(device[1]) <= '15U' and device[0]]
        devices_22_34U = [device for device in rack_devices if '22U' <= str(device[1]) <= '34U' and device[0]]

        # เพิ่มข้อมูลพิเศษในช่วง 01U-15U
        additional_devices = [device for device in devices_01_15U 
                            if any(keyword in device[0] for keyword in ['CTRL', 'STORAGE'])]
        devices_01_15U.extend(additional_devices)

        # กรองข้อมูลในช่วง 22U-34U และลบข้อมูลที่มี keyword ไม่ต้องการ
        devices_22_34U = [device for device in devices_22_34U 
                        if not any(keyword in device[0] for keyword in ['ACC', 'FTIFW', 'FTFW4', 'FTWAF'])]
        # ตรวจสอบว่ามีตาราง OOB ACC ให้ใช้งานหรือไม่
        if acc_table_index >= len(acc_names):
            print("All OOB ACC tables are full.")
            break

        selected_table_name = acc_names[acc_table_index]

        # ใส่ข้อมูลจากช่วง 01U-15U ลงในตาราง OOB ACC
        remaining_ports = 35 - (port_index - 1)
        if len(devices_01_15U) <= remaining_ports:
            for device_name, unit in devices_01_15U:
                if device_name:
                    cur.execute(f"""
                        UPDATE {selected_table_name}
                        SET device_names = %s
                        WHERE port_id = %s;
                    """, (device_name, port_index))
                    port_index += 1
            # รีเซ็ตค่าเมื่อพอร์ตเต็มพอดี
            if port_index > 35:
                acc_table_index += 1
                port_index = 1
                if acc_table_index >= len(acc_names):
                    print("All OOB ACC tables are full.")
                    break
                selected_table_name = acc_names[acc_table_index]
        else:
            # ถ้าพอร์ตไม่พอ ให้ย้ายทั้งชุดไปยังตาราง OOB ACC ถัดไป
            acc_table_index += 1
            port_index = 1
            if acc_table_index >= len(acc_names):
                print("All OOB ACC tables are full.")
                break
            selected_table_name = acc_names[acc_table_index]

            for device_name, unit in devices_01_15U:
                if device_name:
                    cur.execute(f"""
                        UPDATE {selected_table_name}
                        SET device_names = %s
                        WHERE port_id = %s;
                    """, (device_name, port_index))
                    port_index += 1

        # ตรวจสอบพอร์ตสำหรับช่วง 22U-34U
        remaining_ports = 35 - (port_index - 1)
        if len(devices_22_34U) <= remaining_ports:
            for device_name, unit in devices_22_34U:
                if device_name:
                    cur.execute(f"""
                        UPDATE {selected_table_name}
                        SET device_names = %s
                        WHERE port_id = %s;
                    """, (device_name, port_index))
                    port_index += 1
            # รีเซ็ตค่าเมื่อพอร์ตเต็มพอดี
            if port_index > 35:
                acc_table_index += 1
                port_index = 1
                if acc_table_index >= len(acc_names):
                    print("All OOB ACC tables are full.")
                    break
                selected_table_name = acc_names[acc_table_index]
        else:
            # ถ้าพอร์ตไม่พอ ให้ย้ายทั้งชุดไปยังตาราง OOB ACC ถัดไป
            acc_table_index += 1
            port_index = 1
            if acc_table_index >= len(acc_names):
                print("All OOB ACC tables are full.")
                break
            selected_table_name = acc_names[acc_table_index]

            for device_name, unit in devices_22_34U:
                if device_name:
                    cur.execute(f"""
                        UPDATE {selected_table_name}
                        SET device_names = %s
                        WHERE port_id = %s;
                    """, (device_name, port_index))
                    port_index += 1

    



#llllllllllllllllllllllllllllllllllllllllllll
    zone_to_oob_acc = {}

    # ตรวจสอบข้อมูลใน acc_names เพื่อหาตารางที่มี zone เดียวกัน
    for selected_table_name in acc_names:
        # ดึงชื่อ device_names ค่าสุดท้ายจากตาราง oob_acc
        cur.execute(f"""
            SELECT device_names
            FROM {selected_table_name}
            WHERE device_names IS NOT NULL
            ORDER BY port_id DESC LIMIT 1;
        """)
        last_device_name = cur.fetchone()

        if last_device_name:
            last_device_name = last_device_name[0]
            #print(f"Last device name in {selected_table_name}: {last_device_name}")

            # หาค่าพยัญชนะตัวสุดท้ายที่บ่งบอก zone (เช่น 50M หมายถึง M)
            position_50 = last_device_name.find("50")
            if position_50 != -1 and position_50 + 2 < len(last_device_name):
                # ดึงตัวอักษรที่อยู่ถัดจาก "50"
                zone_letter = last_device_name[position_50 + 2]
                #print(f"Zone letter: {zone_letter}")

                # ถ้ามีตารางที่มี zone เดียวกัน เก็บไว้ใน zone_to_oob_acc
                if zone_letter in zone_to_oob_acc:
                    zone_to_oob_acc[zone_letter].append(selected_table_name)
                else:
                    zone_to_oob_acc[zone_letter] = [selected_table_name]

                #print(zone_to_oob_acc)

#RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR
    # สำหรับแต่ละ zone ที่มีตารางมากกว่า 1 ตาราง
    odd_devices = []
    even_devices = []
    for zone_letter, oob_acc_tables in zone_to_oob_acc.items():
        
        if len(oob_acc_tables) == 1:
            cur.execute("""
                SELECT device_names, result_type
                FROM device_phycon
                WHERE result_type = %s OR result_type = %s
                ;
            """, (f"M&S Leaf {zone_letter}", f"SRV Leaf {zone_letter}"))
           
            ms_srv_devices = cur.fetchall()
            m_s_leaf = []
            srv_leaf = []
            m_s_leaf_sort = []
            srv_leaf_sort = []

            for device_name, result_type in ms_srv_devices:
                if f'm&s leaf {zone_letter.lower()}' in result_type.lower():
                    m_s_leaf.append(device_name)
                    #m_s_leaf_sort.sort(reverse=True)
                    m_s_leaf_sort = sorted(m_s_leaf, key=lambda x: (x.split('-')[3], x.split('-')[-1]), reverse=True)  # เรียงตาม U และ M&S หมายเลข
                    #print('msleaf',m_s_leaf)
                    #print('m_s_leaf_sort',m_s_leaf_sort)
                    #print('ms',m_s_leaf_devices[0])
                
                elif f'srv leaf {zone_letter.lower()}' in result_type.lower():
                    srv_leaf.append(device_name)
                    #srv_leaf_sort.sort(reverse=True)
                    srv_leaf_sort = sorted(srv_leaf, key=lambda x: (x.split('-')[3], x.split('-')[-1]), reverse=True)  # เรียงตาม U และ SRV หมายเลข
                    #print('srv', srv_leaf_devices[0])
            port = 46
            for device_name in srv_leaf_sort + m_s_leaf_sort :
                if port < 41:
                    break  # ไม่ให้ต่ำกว่าพอร์ต 41
                oob_table_name = oob_acc_tables[0]
                cur.execute(f"""
                    UPDATE {oob_table_name}
                    SET device_names = %s
                    WHERE port_id = %s;
                """, (device_name, port))
                port -= 1




        elif len(oob_acc_tables) == 2:  # ถ้ามีสองตารางที่มีโซนเดียวกัน
            # รวบรวมผลลัพธ์ที่ตรงกันใน device_phycon จาก zone นี้
            cur.execute("""
                SELECT device_names, result_type
                FROM device_phycon
                WHERE result_type = 'OOB AGG' OR SUBSTRING(device_names FROM POSITION('50' IN device_names) + 2 FOR 1) = %s
                ;
            """, (zone_letter,))
            matching_devices = cur.fetchall()
            #print(matching_devices)
            m_s_leaf_devices = []
            srv_leaf_devices = []
            oob_agg_devices = []
            m_s_leaf_even = []
            m_s_leaf_odd = []
            srv_leaf_even = []
            srv_leaf_odd = []
            oob_agg_even = []
            oob_agg_odd = []

        # แยกอุปกรณ์เป็น odd_devices และ even_devices
            for device_name, result_type in matching_devices:
                if f'm&s leaf {zone_letter.lower()}' in result_type.lower():
                    m_s_leaf_devices.append(device_name)
                    #print('ms',m_s_leaf_devices[0])
                
                elif f'srv leaf {zone_letter.lower()}' in result_type.lower():
                    srv_leaf_devices.append(device_name)
                    #print('srv', srv_leaf_devices[0])

                elif f'oob agg' in result_type.lower():
                    oob_agg_devices.append(device_name)
                    #print('agg', oob_agg_devices[0])
                


                if int(device_name[-1]) % 2 == 0:  # เช็คตัวเลขสุดท้ายว่าเป็นคู่หรือคี่
                    even_devices.append(device_name)
                else:
                    odd_devices.append(device_name)

            
            m_s_leaf_devices.sort(reverse=True)
            #srv_leaf_devices.sort(reverse=True)
            
            
            # อัปเดตข้อมูลในตารางแรกด้วยเลขคี่
            first_table = oob_acc_tables[0]
            second_table = oob_acc_tables[1]

            # แยก m&s leaf และ srv leaf เป็นเลขคี่และเลขคู่
            odd_m_s_leaf_devices = [device_name for device_name in m_s_leaf_devices if int(device_name[-1]) % 2 != 0]
            even_m_s_leaf_devices = [device_name for device_name in m_s_leaf_devices if int(device_name[-1]) % 2 == 0]

            odd_srv_leaf_devices = [device_name for device_name in srv_leaf_devices if int(device_name[-1]) % 2 != 0]
            even_srv_leaf_devices = [device_name for device_name in srv_leaf_devices if int(device_name[-1]) % 2 == 0]

            # อัปเดต odd_m_s_leaf_devices และ odd_srv_leaf_devices ลงใน first_table
            port = 46
            for device_name in odd_srv_leaf_devices + odd_m_s_leaf_devices:
                if port < 41:
                    break  # ไม่ให้ต่ำกว่าพอร์ต 41
                cur.execute(f"""
                    UPDATE {first_table}
                    SET device_names = %s
                    WHERE port_id = %s;
                """, (device_name, port))
                port -= 1

            # อัปเดต even_m_s_leaf_devices และ even_srv_leaf_devices ลงใน second_table
            port = 46
            for device_name in even_srv_leaf_devices + even_m_s_leaf_devices:
                if port < 41:
                    break  # ไม่ให้ต่ำกว่าพอร์ต 41
                cur.execute(f"""
                    UPDATE {second_table}
                    SET device_names = %s
                    WHERE port_id = %s;
                """, (device_name, port))
                port -= 1


            # อัปเดต odd_devices ในตารางแรกเริ่มที่พอร์ต 41
            port = 47
            for table_name in acc_names:
                # ตรวจสอบว่าเป็นตาราง oob_acc หรือไม่
                if 'oob_acc' not in table_name:
                    continue
                
                # วนซ้ำเพื่อเพิ่มข้อมูลในพอร์ต 47 และ 48
                for device_name in oob_agg_devices:
                    if port < 47 or port > 48:
                        continue  # ทำเฉพาะพอร์ต 47 และ 48

                    # อัปเดตข้อมูลในตาราง oob_acc ที่กำหนดในพอร์ต 47 และ 48
                    cur.execute(f"""
                        UPDATE {table_name}
                        SET device_names = %s
                        WHERE port_id = %s;
                    """, (device_name, port))

                    # อัปเดตพอร์ตถัดไป
                    port += 1

            # หากครบพอร์ต 48 ให้วนกลับไปพอร์ต 47 สำหรับตารางถัดไป
                    if port > 48:
                        port = 47

            #print(f"Updated {first_table} with m&s leaf, srv leaf, odd devices, and oob agg.")
            #print(f"Updated {second_table} with even devices and oob agg.")


    # Commit การเปลี่ยนแปลงและปิดการเชื่อมต่อ
    conn.commit()
    print('Data inserted into OOB ACC tables.')
    cur.close()
    conn.close()


def update_rack_position_in_oob_acc(acc_names):
    conn = psycopg2.connect(DATABASE_URL)
    cur = conn.cursor()

    # ดึงข้อมูล device_names และ rack_position จาก device_phycon
    cur.execute("""
        SELECT device_names, rack_position
        FROM device_phycon;
    """)
    device_rack_data = cur.fetchall()

    # วนลูปผ่าน acc_names เพื่ออัปเดตค่า rack_position ในตาราง oob_acc แต่ละตาราง
    for table_name in acc_names:
        if 'oob_acc' in table_name:  # ตรวจสอบเฉพาะตาราง oob_acc
            for device_name, rack_position in device_rack_data:
                # อัปเดต rack_position สำหรับ device_names ที่ตรงกัน
                cur.execute(f"""
                    UPDATE {table_name}
                    SET rack_position = %s
                    WHERE device_names = %s;
                """, (rack_position, device_name))
    
    # Commit การเปลี่ยนแปลงและปิดการเชื่อมต่อ
    conn.commit()
    print("Rack positions updated in all OOB ACC tables.")
    cur.close()
    conn.close()










def create_leaf_tables():
    conn = psycopg2.connect(DATABASE_URL)
    cur = conn.cursor()

    # ขั้นตอนที่ 1: ดึงข้อมูล result_type และ device_names จากตาราง device_phycon ที่ตรงกับประเภท M&S และ SRV Leaf
    cur.execute("""
        SELECT result_type, device_names 
        FROM device_phycon 
        WHERE result_type IN (
            'M&S Leaf M', 'M&S Leaf S', 'M&S Leaf N01', 
            'SRV Leaf M', 'SRV Leaf S', 'SRV Leaf N01'
        );
    """)
    leaf_data = cur.fetchall()  # ดึงข้อมูลทั้งหมด
    leaf_names = []
    device_counters = {}

    # ขั้นตอนที่ 2: สร้างตารางตาม result_type และ device_names พร้อม prefix
    for result_type, device_name in leaf_data:
        if 'SNK' in device_name:
            prefix = 'snk'
        elif 'RST' in device_name:
            prefix = 'rst'
        elif 'TYB' in device_name:
            prefix = 'tyb'
        else:
            prefix = 'default'

        # แยกประเภท M&S และ SRV ตาม Leaf
        if 'M&S Leaf M' in result_type:
            suffix = 'm_ms'
        elif 'M&S Leaf S' in result_type:
            suffix = 's_ms'
        elif 'M&S Leaf N01' in result_type:
            suffix = 'n_ms'
        elif 'SRV Leaf M' in result_type:
            suffix = 'm_srv'
        elif 'SRV Leaf S' in result_type:
            suffix = 's_srv'
        elif 'SRV Leaf N01' in result_type:
            suffix = 'n_srv'
        else:
            suffix = 'default'

        # ตรวจสอบและเพิ่มตัวนับสำหรับแต่ละประเภท
        key = f"{prefix}_{suffix}"
        if key not in device_counters:
            device_counters[key] = 1
        else:
            device_counters[key] += 1

        # สร้างชื่อตารางตามตัวนับ
        table_name = f"{key}_leaf_{str(device_counters[key]).zfill(2)}"
        leaf_names.append(table_name)

        # สร้างตารางในฐานข้อมูล
        cur.execute(f"""
            CREATE TABLE IF NOT EXISTS {table_name} (
                port_id SERIAL PRIMARY KEY,
                port TEXT,
                device_names TEXT,
                rack_position TEXT,
                connections TEXT
            );
        """)
        print(f'Created table: {table_name}')

    conn.commit()

    # ขั้นตอนที่ 3: เพิ่มข้อมูล 52 แถวในแต่ละตาราง
    for table_name in leaf_names:
        # ลูปเพื่อแทรกข้อมูล 52 แถว
        for i in range(1, 57):  # Loop ตั้งแต่ 1 ถึง 52
            cur.execute(f"""
                INSERT INTO {table_name} (port) VALUES (NULL);
            """)

        # ลูปเพื่ออัปเดตข้อมูล port ในแต่ละแถว
        for i in range(1, 57):
            cur.execute(f"""
                UPDATE {table_name}
                SET port = '0/1/1/' || {i}
                WHERE port_id = {i};
            """)

    conn.commit()
    cur.close()
    print('def: create_leaf_tables')
    return leaf_names









def insert_data_to_ms_leaf(leaf_names):
    conn = psycopg2.connect(DATABASE_URL)
    cur = conn.cursor()
    
    m_for_ms = []
    m_for_srv = []

    # ตรวจสอบว่ามี `_ms` ใน leaf_names หรือไม่
    if any('_ms' in leaf_table for leaf_table in leaf_names):
        zone_letter = 'M'
        
        # ดึงข้อมูลจาก device_phycon ที่ตรงกับ zone_letter เพียงครั้งเดียว
        cur.execute("""
            SELECT device_names, result_type
            FROM device_phycon
            WHERE SUBSTRING(device_names FROM POSITION('50' IN device_names) + 2 FOR 1) = %s;
        """, (zone_letter,))
        m_devices = cur.fetchall()

        # ตรวจสอบทุกค่าใน m_devices เพียงครั้งเดียว
        for device_name, result_type in m_devices:
            # ตรวจสอบว่า result_type ตรงกับ type_hw ใน map_ms หรือไม่
            cur.execute("SELECT type_hw FROM map_ms WHERE type_hw = %s;", (result_type,))
            ms_match = cur.fetchone()
            
            # ถ้ามีการแมตช์ ให้เก็บข้อมูลใน m_for_ms
            if ms_match:
                m_for_ms.append((device_name, result_type))


    if any('_srv' in leaf_table for leaf_table in leaf_names):
        zone_letter = 'M'
        
        # ดึงข้อมูลจาก device_phycon ที่ตรงกับ zone_letter เพียงครั้งเดียว (ข้อมูลเดิมจาก m_devices)
        for device_name, result_type in m_devices:
            cur.execute("SELECT type_hw FROM map_srv WHERE type_hw = %s;", (result_type,))
            srv_match = cur.fetchone()
            if srv_match:
                m_for_srv.append((device_name, result_type))



    # แสดงผลลัพธ์ที่ได้
    print("M for MS Matches:", m_for_ms)
    print("M for SRV Matches:", m_for_srv)


    #print("M for MS Matche: ", m_for_ms)
    #print("M for SRV Matche: ", m_for_srv)




    # บันทึกการเปลี่ยนแปลง
    conn.commit()
    cur.close()

# ตัวอย่างการเรียกฟังก์ชัน insert_data_to_ms_leaf



  



    






#def create_oob_agg():  
    #create_oob_agg_1()
   # create_oob_agg2()

def export_to_excel():
    url = "http://127.0.0.1:5000/racklayout"
    table = pd.read_html(url)
    combined_table = pd.concat(table, ignore_index=True)
    
    # ส่งออกตารางทั้งหมดไปยังชีทเดียวในไฟล์ Excel
    combined_table.to_excel("SNK_LLD.xlsx", sheet_name="Combined", index=False)

    print("ส่งออกข้อมูลทุกตารางไปยังไฟล์ SNK_LLD.xlsx สำเร็จ")


#------------------------------------------------------------------------------------
@app.route('/', methods=['GET', 'POST'])
def homepage():
    check_inputfiles()
    mapping_data()
    hardware_each_rack () 
    #oob_agg
    agg_table_names = create_oob_agg_tables()
    print(agg_table_names)
    create_oob_agg_1(agg_table_names)
    create_oob_agg_2(agg_table_names)
    #oob_acc
    acc_table_names = create_oob_acc_tables()
    print(acc_table_names)
    insert_data_to_oob_acc(acc_table_names)
    update_rack_position_in_oob_acc(acc_table_names)
    #leaf
    create_leaf_tables()
    leaf_table_names = create_leaf_tables()
    insert_data_to_ms_leaf(leaf_table_names)
    return render_template('home.html')    

@app.route('/home')
def home():
    
    return render_template('home.html')

@app.route('/racklayout')
def racklayout():
    tables = get_created_tables()
    tables_data = {}
    for table in tables:
        data = get_table_data(table)
        if data['columns'] and data['rows']:
            tables_data[table] = data
    
    return render_template('racklayout.html', tables_data=tables_data)

@app.route('/export_excel')

def export_excel():
    tables = get_created_tables()
    tables_data = {'rack_swr': {}, 'oob_agg': {}}

    # ดึงข้อมูลจากฐานข้อมูลใส่ใน tables_data
    for table in tables:
        data = get_table_data(table)
        if data['columns'] and data['rows']:
            if '_r' in table or '_swr' in table:
                tables_data['rack_swr'][table] = data
            elif 'oob_agg' in table:
                tables_data['oob_agg'][table] = data

    output = io.BytesIO()
    with pd.ExcelWriter(output, engine='xlsxwriter') as writer:
        # กำหนดฟอร์แมตสำหรับเส้นขอบ
        border_format = writer.book.add_format({'border': 1})

        # เขียนข้อมูลลง Sheet ที่ 1 สำหรับตารางที่มี _r และ _swr โดยเรียงจากซ้ายไปขวา
        sheet1 = writer.book.add_worksheet('Rack and SWR')
        start_col = 0
        sorted_rack_swr = sorted(tables_data['rack_swr'].items(), key=lambda x: x[0])

        for table_name, data in sorted_rack_swr:
            df = pd.DataFrame(data['rows'], columns=data['columns'])

            # เขียนชื่อเทเบิลเป็นหัวข้อเหนือข้อมูล
            sheet1.write(0, start_col, table_name)

            # เขียนชื่อคอลัมน์พร้อมเส้นขอบ
            for col_num, column_name in enumerate(df.columns):
                sheet1.write(1, start_col + col_num, column_name, border_format)

            # เขียนข้อมูล DataFrame เริ่มที่แถวที่ 2 พร้อมเส้นขอบ
            for row_num, row in enumerate(df.values, start=2):
                for col_num, value in enumerate(row):
                    sheet1.write(row_num, start_col + col_num, value, border_format)

            # เพิ่มช่องว่างระหว่างตารางถัดไป
            start_col += len(df.columns) + 2

        # เขียนข้อมูลลง Sheet ที่ 2 สำหรับตารางที่มี oob_agg โดยเรียงจากซ้ายไปขวา
        sheet2 = writer.book.add_worksheet('OOB AGG')
        start_col = 0
        sorted_oob_agg = sorted(tables_data['oob_agg'].items(), key=lambda x: x[0])

        for table_name, data in sorted_oob_agg:
            df = pd.DataFrame(data['rows'], columns=data['columns'])

            # เขียนชื่อเทเบิลเป็นหัวข้อเหนือข้อมูล
            sheet2.write(0, start_col, table_name)

            # เขียนชื่อคอลัมน์พร้อมเส้นขอบ
            for col_num, column_name in enumerate(df.columns):
                sheet2.write(1, start_col + col_num, column_name, border_format)

            # เขียนข้อมูล DataFrame เริ่มที่แถวที่ 2 พร้อมเส้นขอบ
            for row_num, row in enumerate(df.values, start=2):
                for col_num, value in enumerate(row):
                    sheet2.write(row_num, start_col + col_num, value, border_format)

            # เพิ่มช่องว่างระหว่างตารางถัดไป
            start_col += len(df.columns) + 2

    output.seek(0)
    return send_file(output, as_attachment=True, download_name='rack_tables_with_borders.xlsx',
                     mimetype='application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')

#--------------------------------------------------------------------------------------
if __name__ == '__main__':
    if not os.path.exists(app.config['UPLOAD_FOLDER']):
        os.makedirs(app.config['UPLOAD_FOLDER'])
    app.run(debug=True)