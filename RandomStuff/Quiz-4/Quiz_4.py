import sqlite3
from sqlite3 import Error


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


def createPriceRange(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create PriceRange")
    try:
        q = """
            create view IF NOT EXISTS PriceRange(maker, type, minPrice, maxPrice) as
            SELECT maker, pd.type, min(PC.price) as minPrice, max(PC.price) as maxPrice
            FROM Product as pd, PC
            WHERE
                pd.model = PC.model
            GROUP BY maker
            UNION
            SELECT maker, pd.type, min(pt.price), max(pt.price)
            FROM Product as pd, Printer pt
            WHERE
                pd.model = pt.model
            GROUP BY maker
            UNION
            SELECT maker, pd.type, min(lp.price), max(lp.price)
            FROM Product as pd, Laptop lp
            WHERE
                pd.model = lp.model
            GROUP BY maker;
            """
        #cur = _conn.cursor()
        _conn.execute(q)
        _conn.commit()
        
    except Error as e:
        _conn.rollback()
        print(e)
    print("++++++++++++++++++++++++++++++++++")


def printPriceRange(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Print PriceRange")
    try:
        l = '{:<10} {:<20} {:>20} {:>20}'.format("maker", "product", "minPrice", "maxPrice")
        q = """
            SELECT maker, type, minPrice, maxPrice
            FROM PriceRange
            order by maker ASC, type ASC;
            """
        cur = _conn.cursor()
        cur.execute(q)
        rows = cur.fetchall()
        print(l)
        for row in rows:
            l = '{:<10} {:<20} {:>20} {:>20}'.format(row[0], row[1], row[2], row[3])
            print(l)
    except Error as e:
        _conn.rollback()
        print(e)

    print("++++++++++++++++++++++++++++++++++")


def insertPC(_conn, _maker, _model, _speed, _ram, _hd, _price):
    print("++++++++++++++++++++++++++++++++++")
    l = 'Insert PC ({}, {}, {}, {}, {}, {})'.format(_maker, _model, _speed, _ram, _hd, _price)
    print(l)
    l = "Insert INTO PC VALUES({}, {}, {}, {}, {})".format(_model, _speed, _ram, _hd, _price)
    p = "Insert INTO Product VALUES('{}', {}, '{}')".format(_maker, _model, 'pc')
    
    
    try:
        _conn.execute(l)
        _conn.execute(p)
        _conn.commit()
    except Error as e:
        _conn.rollback()
        print(e)
    print("++++++++++++++++++++++++++++++++++")


def updatePrinter(_conn, _model, _price):
    print("++++++++++++++++++++++++++++++++++")
    l = 'Update Printer ({}, {})'.format(_model, _price)
    print(l)
    q = """
        UPDATE Printer
        SET price={}
        WHERE model = {}
    """.format(_price, _model)
    try:
        # cur = _conn.cursor()
        _conn.execute(q)
        _conn.commit()
    except Error as e:
        _conn.rollback()
        print(e)
    print("++++++++++++++++++++++++++++++++++")


def deleteLaptop(_conn, _model):
    print("++++++++++++++++++++++++++++++++++")
    l = 'Delete Laptop ({})'.format(_model)
    print(l)
    q = """
        DELETE FROM Laptop
        WHERE
            model = {}
        """.format(_model)
    q2 = """
        DELETE FROM Product
        WHERE
            model = {}
        """.format(_model)
    try:
        _conn.execute(q)
        _conn.execute(q2)
        _conn.commit()
    except Error as e:
        _conn.rollback()
        print(e)
    print("++++++++++++++++++++++++++++++++++")


def main():
    database = r"data.sqlite"

    # create a database connection
    conn = openConnection(database)
    with conn:
        createPriceRange(conn)
        printPriceRange(conn)

        file = open('input.in', 'r')
        lines = file.readlines()
        for line in lines:
            print(line.strip())

            tok = line.strip().split(' ')
            if tok[0] == 'I':
                insertPC(conn, tok[2], tok[3], tok[4], tok[5], tok[6], tok[7])
            elif tok[0] == 'U':
                updatePrinter(conn, tok[2], tok[3])
            elif tok[0] == 'D':
                deleteLaptop(conn, tok[2])

            printPriceRange(conn)

        file.close()

    closeConnection(conn, database)


if __name__ == '__main__':
    main()
