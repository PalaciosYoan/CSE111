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


def create_View1(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create V1")
    try:
        q = """
            create view IF NOT EXISTS V1(c_custkey, c_name, c_address, c_phone, c_acctbal, c_mktsegment, c_comment, c_nation, c_region) as
            select c_custkey, c_name, c_address, c_phone, c_acctbal, c_mktsegment, c_comment, n_name, r_name
            from customer, nation, region
            where
                n_regionkey = r_regionkey and
                n_nationkey = c_nationkey
            group by c_name;
            """
        _conn.execute(q)
        _conn.commit()
    except Error as e:
        _conn.rollback()
        print(e)
    print("++++++++++++++++++++++++++++++++++")


def create_View2(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create V2")
    try:
        q = """
            create view IF NOT EXISTS V2(s_suppkey, s_name, s_address, s_phone, s_acctbal, s_comment, s_nation, s_region) as
            select s_suppkey, s_name, s_address, s_phone, s_acctbal, s_comment, n_name, r_name
            from supplier, nation, region
            where s_nationkey = n_nationkey
                and n_regionkey = r_regionkey
            ;
            """
        _conn.execute(q)
        _conn.commit()
    except Error as e:
        _conn.rollback()
        print(e)
    print("++++++++++++++++++++++++++++++++++")


def create_View5(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create V5")
    try:
        q = """
            create view IF NOT EXISTS V5(o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderyear, o_orderpriority, o_clerk, o_shippriority, o_comment) as
            SELECT 
                o_orderkey, o_custkey, 
                o_orderstatus, o_totalprice, 
                strftime('%Y', o_orderdate) as o_orderyear, 
                o_orderpriority, o_clerk,
                o_shippriority, o_comment
            FROM orders;
            """
        _conn.execute(q)
        _conn.commit()
    except Error as e:
        _conn.rollback()
        print(e)
    print("++++++++++++++++++++++++++++++++++")


def create_View10(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create V10")
    try:
        q = """
            create view IF NOT EXISTS V10(p_type, min_discount, max_discount) as
            select p_type, min(l_discount), max(l_discount)
            from lineitem, part
            where l_partkey = p_partkey
            group by p_type;
            """
        _conn.execute(q)
        _conn.commit()
    except Error as e:
        _conn.rollback()
        print(e)
    print("++++++++++++++++++++++++++++++++++")


def create_View151(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create V151")
    try:
        q = """
            create view IF NOT EXISTS V151(c_custkey, c_name, c_nationkey, c_acctbal)  as
            select c_custkey, c_name, c_nationkey, c_acctbal
            from customer
            where 
                c_acctbal > 0;
            """
        _conn.execute(q)
        _conn.commit()
    except Error as e:
        _conn.rollback()
        print(e)
    print("++++++++++++++++++++++++++++++++++")


def create_View152(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Create V152")
    try:
        q = """
            create view IF NOT EXISTS V152(s_suppkey, s_name, s_nationkey,s_acctbal)   as
            select s_suppkey, s_name, s_nationkey, s_acctbal
            from supplier
            WHERE
                s_acctbal < 0;
            """
        _conn.execute(q)
        _conn.commit()
    except Error as e:
        _conn.rollback()
        print(e)
    print("++++++++++++++++++++++++++++++++++")


def Q1(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q1")
    try:
        q = """
            select c_name, sum(o_totalprice)
            from orders, V1
            where o_custkey = c_custkey AND
                o_orderdate like '1995-__-__' AND
                c_nation = 'FRANCE'
            Group by c_name;
            """
        cur = _conn.cursor()
        cur.execute(q)
        rows = cur.fetchall()
        with open('./output/1.out', 'w+') as f:
            for row in rows:
                l = '{:<10}|{}\n'.format(row[0], round(row[1], 2))
                print(l, end="")
                f.write(l)
    except Error as e:
        _conn.rollback()
        print(e)
    print("++++++++++++++++++++++++++++++++++")


def Q2(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q2")
    try:
        q = """
                select s_region, count(*)
                from V2
                group by s_region;
                """
        cur = _conn.cursor()
        cur.execute(q)
        rows = cur.fetchall()
        with open('./output/2.out', 'w+') as f:
            for row in rows:
                l = '{}|{}\n'.format(row[0], row[1])
                print(l, end="")
                f.write(l)
    except Error as e:
        _conn.rollback()
        print(e)
    print("++++++++++++++++++++++++++++++++++")


def Q3(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q3")
    try:
        q ="""
            select c_nation, count(*)
            from V1, orders
            where
                c_region='AMERICA'
                And o_custkey = c_custkey
            group by c_nation;
        """
        cur = _conn.cursor()
        cur.execute(q)
        rows = cur.fetchall()
        with open('./output/3.out', 'w+') as f:
            for row in rows:
                l = '{}|{}\n'.format(row[0], row[1])
                print(l, end="")
                f.write(l)
    except Error as e:
        _conn.rollback()
        print(e)
    print("++++++++++++++++++++++++++++++++++")


def Q4(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q4")
    try:
        q ="""
            select s_name, count(ps_partkey)
            from partsupp, part, V2
            where p_partkey = ps_partkey
                and ps_suppkey = s_suppkey
                and s_nation = 'CANADA'
                and p_size < 20
            group by s_name;
        """
        cur = _conn.cursor()
        cur.execute(q)
        rows = cur.fetchall()
        with open('./output/4.out', 'w+') as f:
            for row in rows:
                l = '{}|{}\n'.format(row[0], row[1])
                print(l, end="")
                f.write(l)
    except Error as e:
        _conn.rollback()
        print(e)
    print("++++++++++++++++++++++++++++++++++")


def Q5(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q5")
    try:
        q ="""
            select c_name, count(*)
            from V5, V1
            where o_custkey = c_custkey
                and c_nation = 'GERMANY'
                and o_orderyear like '1993'
            group by c_name;
        """
        cur = _conn.cursor()
        cur.execute(q)
        rows = cur.fetchall()
        with open('./output/5.out', 'w+') as f:
            for row in rows:
                l = '{}|{}\n'.format(row[0], row[1])
                print(l, end="")
                f.write(l)
    except Error as e:
        _conn.rollback()
        print(e)
    print("++++++++++++++++++++++++++++++++++")


def Q6(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q6")
    try:
        q ="""
            select s_name, o_orderpriority, count(distinct ps_partkey)
            from partsupp, V5, lineitem, supplier, nation
            where l_orderkey = o_orderkey
                and l_partkey = ps_partkey
                and l_suppkey = ps_suppkey
                and ps_suppkey = s_suppkey
                and s_nationkey = n_nationkey
                and n_name = 'CANADA'
            group by s_name, o_orderpriority;
        """
        cur = _conn.cursor()
        cur.execute(q)
        rows = cur.fetchall()
        with open('./output/6.out', 'w+') as f:
            for row in rows:
                l = '{}|{}|{}\n'.format(row[0], row[1], row[2])
                print(l, end="")
                f.write(l)
    except Error as e:
        _conn.rollback()
        print(e)
    print("++++++++++++++++++++++++++++++++++")


def Q7(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q7")
    try:
        q ="""
            select c_nation, o_orderstatus, count(*)
            from V5, V1
            where o_custkey = c_custkey
                and c_region='AMERICA'
            group by c_nation, o_orderstatus;
        """
        cur = _conn.cursor()
        cur.execute(q)
        rows = cur.fetchall()
        with open('./output/7.out', 'w+') as f:
            for row in rows:
                l = '{}|{}|{}\n'.format(row[0], row[1], row[2])
                print(l, end="")
                f.write(l)
    except Error as e:
        _conn.rollback()
        print(e)
    print("++++++++++++++++++++++++++++++++++")


def Q8(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q8")
    try:
        q ="""
            select s_nation, count(distinct l_orderkey) as co
            from V5, V2, lineitem
            where o_orderkey = l_orderkey
                and l_suppkey = s_suppkey
                and o_orderstatus = 'F'
                and o_orderyear like '1995'
            group by s_nation
            having co > 50;
        """
        cur = _conn.cursor()
        cur.execute(q)
        rows = cur.fetchall()
        with open('./output/8.out', 'w+') as f:
            for row in rows:
                l = '{}|{}\n'.format(row[0], row[1])
                print(l, end="")
                f.write(l)
    except Error as e:
        _conn.rollback()
        print(e)
    print("++++++++++++++++++++++++++++++++++")


def Q9(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q9")
    try:
        q ="""
            select count(distinct o_clerk)
            from V5, V2, lineitem
            where o_orderkey = l_orderkey
                and l_suppkey = s_suppkey
                and s_nation = 'UNITED STATES';
        """
        cur = _conn.cursor()
        cur.execute(q)
        rows = cur.fetchall()
        with open('./output/9.out', 'w+') as f:
            for row in rows:
                l = '{}\n'.format(row[0])
                print(l, end="")
                f.write(l)
    except Error as e:
        _conn.rollback()
        print(e)
    print("++++++++++++++++++++++++++++++++++")


def Q10(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q10")
    try:
        q ="""
            select p_type, min_discount, max_discount
            from V10
            where 
                p_type like '%ECONOMY%'
                and p_type like '%COPPER%'
            group by p_type;
        """
        cur = _conn.cursor()
        cur.execute(q)
        rows = cur.fetchall()
        with open('./output/10.out', 'w+') as f:
            for row in rows:
                l = '{}|{}|{}\n'.format(row[0], row[1],row[2])
                print(l, end="")
                f.write(l)
    except Error as e:
        _conn.rollback()
        print(e)
    print("++++++++++++++++++++++++++++++++++")


def Q11(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q11")
    try:
        q ="""
            select s_region, s_name, s_acctbal
            from V2 s
            where 
                    s.s_acctbal = (select max(s1.s_acctbal)
                                        from V2 s1
                                        where
                                            s.s_region = s1.s_region
                                    );
        """
        cur = _conn.cursor()
        cur.execute(q)
        rows = cur.fetchall()
        with open('./output/11.out', 'w+') as f:
            for row in rows:
                l = '{}|{}|{}\n'.format(row[0], row[1], round(row[2], 2))
                print(l, end="")
                f.write(l)
    except Error as e:
        _conn.rollback()
        print(e)
    print("++++++++++++++++++++++++++++++++++")


def Q12(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q12")
    try:
        q ="""
            select s_nation, max(s_acctbal) as mb
            from V2
            group by s_nation
            having mb > 9000;
        """
        cur = _conn.cursor()
        cur.execute(q)
        rows = cur.fetchall()
        with open('./output/12.out', 'w+') as f:
            for row in rows:
                l = '{}|{}\n'.format(row[0], round(row[1], 2))
                print(l, end="")
                f.write(l)
    except Error as e:
        _conn.rollback()
        print(e)
    print("++++++++++++++++++++++++++++++++++")


def Q13(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q13")
    try:
        q ="""
            select count(*)
            from orders, lineitem, V1, V2
            where o_orderkey = l_orderkey
                and o_custkey = c_custkey
                and l_suppkey = s_suppkey
                and s_region = 'AFRICA'
                and c_nation = 'UNITED STATES';
        """
        cur = _conn.cursor()
        cur.execute(q)
        rows = cur.fetchall()
        with open('./output/13.out', 'w+') as f:
            for row in rows:
                l = '{}\n'.format(row[0])
                print(l, end="")
                f.write(l)
    except Error as e:
        _conn.rollback()
        print(e)
    print("++++++++++++++++++++++++++++++++++")


def Q14(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q14")
    try:
        q ="""
            select s_region as suppRegion, c_region as custRegion, max(o_totalprice)
            from lineitem, V2, orders, V1
            where l_suppkey = s_suppkey
                and l_orderkey = o_orderkey
                and o_custkey = c_custkey
            group by s_region, c_region;
        """
        cur = _conn.cursor()
        cur.execute(q)
        rows = cur.fetchall()
        with open('./output/14.out', 'w+') as f:
            for row in rows:
                l = '{}|{}|{}\n'.format(row[0],row[1], round(row[2], 2))
                print(l, end="")
                f.write(l)
    except Error as e:
        _conn.rollback()
        print(e)
    print("++++++++++++++++++++++++++++++++++")


def Q15(_conn):
    print("++++++++++++++++++++++++++++++++++")
    print("Q15")
    try:
        q ="""
            select count(distinct l_orderkey)
            from lineitem, V152, orders, V151
            where l_suppkey = s_suppkey
                and l_orderkey = o_orderkey
                and o_custkey = c_custkey;
        """
        cur = _conn.cursor()
        cur.execute(q)
        rows = cur.fetchall()
        with open('./output/15.out', 'w+') as f:
            for row in rows:
                l = '{}\n'.format(row[0])
                print(l, end="")
                f.write(l)
    except Error as e:
        _conn.rollback()
        print(e)
    print("++++++++++++++++++++++++++++++++++")


def main():
    database = r"tpch.sqlite"

    # create a database connection
    conn = openConnection(database)
    with conn:
        create_View1(conn)
        Q1(conn)

        create_View2(conn)
        Q2(conn)

        Q3(conn)
        Q4(conn)

        create_View5(conn)
        Q5(conn)

        Q6(conn)
        Q7(conn)
        Q8(conn)
        Q9(conn)

        create_View10(conn)
        Q10(conn)

        Q11(conn)
        Q12(conn)
        Q13(conn)
        Q14(conn)

        create_View151(conn)
        create_View152(conn)
        Q15(conn)

    closeConnection(conn, database)


if __name__ == '__main__':
    main()
