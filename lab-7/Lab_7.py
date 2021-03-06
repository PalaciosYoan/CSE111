
import sqlite3
from sqlite3 import Error
from tabulate import tabulate
import pandas as pd
'''
    sql_query = 'SELECT * FROM x where name = ?'
    todo a query we need too do cur = _conn.cursor() => cur.execute(sql_query, [optional arguements])
    then we do 
    l = '{:10} {:10}'.format('column_name', 'column_name')
    rows = cur.fetchall()
    for row in rows:
        l = '{:10} {:10}'.format(row[0], row[1])
        print(l)
        
    dynamic variables 
    sql = 'select *, {}.prince as price from product, {} where product.model = {} and maker = ?'.format(var1, var2, var3)
    '''



def openConnection(_dbFile):
    print("++++++++++++++++++++++++++++++++++")
    print("Open database: ", _dbFile)

    conn = None
    try:
        conn = sqlite3.connect(_dbFile)
        print("success")
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")

    return conn

def closeConnection(_conn, _dbFile):
    print("++++++++++++++++++++++++++++++++++")
    print("Close database: ", _dbFile)

    try:
        _conn.close()
        print("success")
    except Error as e:
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def createTable(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create table")
    table = '''CREATE TABLE IF NOT EXISTS warehouse (
                    w_warehousekey decimal(9,0) not null,
                    w_name char(100) not null,
                    w_capacity decimal(6,0) not null,
                    w_suppkey decimal(9,0) not null,
                    w_nationkey decimal(2,0) not null
                                    ); '''
    _conn.execute(table)
    print("++++++++++++++++++++++++++++++++++")


def dropTable(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Drop tables")
    table = '''DROP TABLE IF EXISTS warehouse; '''
    _conn.execute(table)
    print("++++++++++++++++++++++++++++++++++")


def populateTable(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Populate table")
    try:
        
        # query = "INSERT INTO warehouse(w_warehousekey, w_name, w_suppkey, w_capacity, w_address, w_nationkey) VALUES (?, ?, ?, ?, ?, ?)"
        #_conn.execute(query, [1,2,3,4,5,6])
        query = "SELECT DISTINCT s_name FROM supplier;"
        l = []
        cap_size = []
        nation_id = []
        index = []
        sId = []
        count = 1
        df = pd.DataFrame()
        for row in _conn.execute(query):
            query = """SELECT *
                        FROM
                            (
                                SELECT n_name, COUNT(c_name) as num_cust, n_nationkey
                                FROM supplier, nation, customer, lineitem, orders
                                WHERE 
                                    s_suppkey = l_suppkey AND
                                    l_orderkey = o_orderkey AND
                                    o_custkey = c_custkey AND
                                    c_nationkey = n_nationkey AND
                                    s_name = ?
                                GROUP BY n_name
                                ORDER BY num_cust DESC, n_name ASC
                            )
                        LIMIT 2;"""
            capSize = """
                    SELECT max(totalSize) * 2 as doubleMaxPartSize
                    FROM
                        (
                            SELECT n_name, s_name, SUM(p_size) as totalSize
                            FROM supplier, nation, customer, lineitem, orders, part
                            WHERE 
                                s_suppkey = l_suppkey AND
                                l_orderkey = o_orderkey AND
                                o_custkey = c_custkey AND
                                c_nationkey = n_nationkey AND
                                l_partkey = p_partkey AND
                                s_name = ?
                            GROUP BY n_name, s_name
                        );
                    """
            for r in _conn.execute(query, [row[0]]):
                l.append(f"{row[0]}___{r[0]}")
                nation_id.append(r[2])
                index.append(count)
            
            for r in _conn.execute(capSize, [row[0]]):
                cap_size.append(f"{r[0]}")
                cap_size.append(f"{r[0]}")
                sId.append(count)
                sId.append(count)
            
            count += 1
        index = []
        for i in range(1, len(nation_id)+1):
            index.append(i)
        df['wId'] = index
        df['wName'] = l
        df['wCap'] = cap_size
        df['sId'] = sId
        df['nId'] = nation_id
        df.columns = ['w_warehousekey', 'w_name', 'w_capacity', 'w_suppkey', 'w_nationkey']
        df.to_sql(name='warehouse', con=_conn, if_exists='append', index=False)
    except Error as e:
        _conn.rollback()
        print(e)
    print("++++++++++++++++++++++++++++++++++")


def Q1(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q1")

    query = 'SELECT * FROM warehouse;'
    try:
        df = pd.read_sql_query(query, _conn)
        df = df.rename(columns={'w_warehousekey':'wId', 'w_name':'wName', 'w_capacity':'wCap', 'w_suppkey':'sId', 'w_nationkey':'nId'})
        # df = df.style.set_properties(**{'text-align': 'left'})
        #df = tabulate(df, showindex=False, headers=df.columns)
        with open('./output/1.out', 'w') as f:
            f.write(df.to_string(index=False, col_space=20))
    except Error as e:
        _conn.rollback()
        print(e)
    print("++++++++++++++++++++++++++++++++++")


def Q2(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q2")
    query = """SELECT n_name as nation, count(w_name) as numW, SUM(w_capacity) as totCap
                FROM warehouse, nation
                WHERE 
                    w_nationkey = n_nationkey
                GROUP BY n_name
                ORDER BY numW DESC, totCap DESC;"""
    try:
        cur = _conn.cursor()
        cur.execute(query)
        header = '{:<40} {:>10} {:>10}\n'.format(
                "nation", "numW", "totCap")
        
        with open('./output/2.out', 'w') as f:
            f.write(header)
            rows = cur.fetchall()
            for row in rows:
                data = '{:<40} {:>10} {:>10}\n'.format(
                    row[0], row[1], row[2])
                f.write(data)
    except Error as e:
        _conn.rollback()
        print(e)
    print("++++++++++++++++++++++++++++++++++")


def Q3(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q3")
    nations = []
    with open('./input/3.in', 'r') as f:
        nations_temp  = f.readlines()
        for i in range(len(nations_temp)):
            temp = nations_temp[i].replace('\n', '')
            if len(temp) > 0:
                nations.append(temp)
    try:
        f = open('./output/3.out', 'w')
        header = '{:<20} {:<20} {:<40}\n'.format(
                'supplier', 'nation', 'warehouse')
        f.write(header)
        for n in nations:        
            nationkeys = []
            nationkey = """SELECT n_nationkey
                            FROM nation
                            WHERE n_name = '{}';""".format(n)
            for r in _conn.execute(nationkey):
                nationkeys.append(r[0])
            for key in nationkeys:
                query = """
                        SELECT s_name as supplier, n_name as nation, w_name as warehouse
                        FROM warehouse, nation, supplier
                        WHERE 
                            s_nationkey = n_nationkey AND
                            s_suppkey = w_suppkey AND
                            w_nationkey = {}
                        GROUP BY s_name;""".format(key)
                
                cursor = _conn.cursor()
                cursor.execute(query)
                for row in cursor.fetchall():
                    data = '{:<20} {:<20} {:<40}\n'.format(
                        row[0], row[1], row[2])
                    f.write(data)
    except Error as e:
        _conn.rollback()
        print(e)
    print("++++++++++++++++++++++++++++++++++")


def Q4(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q4")
    d = {'region':None, 'capacity':None}
    with open('./input/4.in', 'r') as f:
        lines = f.readlines()
        d['region'] = lines[0].replace('\n', '')
        d['capacity'] = lines[1].replace('\n', '')
    query = """SELECT w_name as warehouse, w_capacity as capacity
                FROM warehouse, nation, region
                WHERE 
                    w_nationkey = n_nationkey AND
                    n_regionkey = r_regionkey AND
                    r_name = '{}'
                GROUP BY w_capacity
                HAVING w_capacity > {}
                ORDER BY w_capacity DESC;""".format(d['region'], d['capacity'])
    header = '{:<40} {:>10}\n'.format(
            'warehouse', 'capacity',)
    try:
        with open('./output/4.out', 'w') as f:
            f.write(header)
            cursor = _conn.cursor()
            cursor.execute(query)
            for row in cursor.fetchall():
                data = '{:<40} {:<10}\n'.format(
                    row[0], row[1])
                f.write(data)
    except Error as e:
        _conn.rollback()
        print(e)
    print("++++++++++++++++++++++++++++++++++")


def Q5(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q5")
    l = None
    with open('./input/5.in', 'r') as f:
        l = f.read().splitlines()

    query = """
        WITH t1 AS
            (
                SELECT region.r_name as name, SUM(w_capacity) as sumCap
                FROM region, nation as n1, warehouse, nation as n2, supplier
                WHERE 
                    w_nationkey = n1.n_nationkey AND
                    s_suppkey = w_suppkey AND
                    s_nationkey = n2.n_nationkey AND
                    n1.n_regionkey = region.r_regionkey AND
                    n2.n_name = '{}'
                GROUP BY region.r_name
            )
        SELECT region.r_name, 
            CASE 
                WHEN t1.sumCap > 0 THEN t1.sumCap 
                ELSE 0 
            END
        FROM region
        LEFT JOIN t1 ON r_name = t1.name
        GROUP BY region.r_name
        ORDER BY region.r_name ASC;
            """.format(l[0])
    header = '{:<20} {:>20}\n'.format(
            'region', 'capacity',)
    try:
        with open('./output/5.out', 'w') as f:
            f.write(header)
            cursor = _conn.cursor()
            cursor.execute(query)
            for row in cursor.fetchall():
                data = '{:<20} {:>20}\n'.format(
                    row[0], row[1])
                f.write(data)
    except Error as e:
        _conn.rollback()
        print(e)
    print("++++++++++++++++++++++++++++++++++")


def main():
    database = r"tpch.sqlite"

    # create a database connection
    conn = openConnection(database)
    with conn:
        dropTable(conn)
        createTable(conn)
        populateTable(conn)

        Q1(conn)
        Q2(conn)
        Q3(conn)
        Q4(conn)
        Q5(conn)

    closeConnection(conn, database)


if __name__ == '__main__':
    main()
