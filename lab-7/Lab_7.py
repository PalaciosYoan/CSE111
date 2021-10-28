
import sqlite3
from sqlite3 import Error
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
        df = pd.DataFrame()
        for row in _conn.execute(query):
            query = """SELECT *
                        FROM
                            (
                                SELECT n_name, COUNT(c_name) as num_cust
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
            for r in _conn.execute(query, [row[0]]):
                l.append(f"{row[0]}___{r[0]}")
        df['wName'] = l
        
            
                
    except Error as e:
        _conn.rollback()
        print(e)
    print("++++++++++++++++++++++++++++++++++")


def Q1(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q1")
    print("++++++++++++++++++++++++++++++++++")


def Q2(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q2")

    print("++++++++++++++++++++++++++++++++++")


def Q3(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q3")

    print("++++++++++++++++++++++++++++++++++")


def Q4(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q4")

    print("++++++++++++++++++++++++++++++++++")


def Q5(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q5")

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
