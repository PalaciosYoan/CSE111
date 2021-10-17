-- Compute the change in the economic exchange for every country between 1994 and 1996.  
-- There shouldbe two columns in the output for every country: 1995 and 1996.  
-- Hint:  use CASE to select the valuesin the result.

select t1.name1, (change95-change94), (change96-change95)

FROM
    (
        SELECT name1, (cont1 - cont2) as change94
        FROM (
            SELECT n_name AS name1, count(l_extendedprice) AS cont1
            FROM customer, orders, lineitem, supplier, nation
            WHERE 
                c_custkey = o_custkey AND
                l_suppkey = s_suppkey AND
                l_orderkey = o_orderkey  AND
                s_nationkey = n_nationkey AND
                c_nationkey != s_nationkey  AND
                strftime('%Y', l_shipdate) = '1994'
            GROUP BY n_name), 
            (
                SELECT n_name AS name2, count(l_extendedprice) AS cont2
                FROM customer, orders, lineitem, supplier, nation
                WHERE 
                    c_custkey = o_custkey and
                    c_nationkey = n_nationkey and
                    l_suppkey = s_suppkey and
                    l_orderkey = o_orderkey  and
                    s_nationkey != c_nationkey and
                    strftime('%Y', l_shipdate) = '1994'
                GROUP BY n_name)
        WHERE name1 = name2
    ) as t1,
    (
        SELECT name1, (cont1 - cont2) as change95
        FROM (
            SELECT n_name AS name1, count(l_extendedprice) AS cont1
            FROM customer, orders, lineitem, supplier, nation
            WHERE 
                c_custkey = o_custkey AND
                l_suppkey = s_suppkey AND
                l_orderkey = o_orderkey  AND
                s_nationkey = n_nationkey AND
                c_nationkey != s_nationkey  AND
                strftime('%Y', l_shipdate) = '1995'
            GROUP BY n_name), 
            (
                SELECT n_name AS name2, count(l_extendedprice) AS cont2
                FROM customer, orders, lineitem, supplier, nation
                WHERE 
                    c_custkey = o_custkey and
                    c_nationkey = n_nationkey and
                    l_suppkey = s_suppkey and
                    l_orderkey = o_orderkey  and
                    s_nationkey != c_nationkey and
                    strftime('%Y', l_shipdate) = '1995'
                GROUP BY n_name)
        WHERE name1 = name2
    ) as t2,
    (
        SELECT name1, (cont1 - cont2) as change96
        FROM (
            SELECT n_name AS name1, count(l_extendedprice) AS cont1
            FROM customer, orders, lineitem, supplier, nation
            WHERE 
                c_custkey = o_custkey AND
                l_suppkey = s_suppkey AND
                l_orderkey = o_orderkey  AND
                s_nationkey = n_nationkey AND
                c_nationkey != s_nationkey  AND
                strftime('%Y', l_shipdate) = '1996'
            GROUP BY n_name), 
            (
                SELECT n_name AS name2, count(l_extendedprice) AS cont2
                FROM customer, orders, lineitem, supplier, nation
                WHERE 
                    c_custkey = o_custkey and
                    c_nationkey = n_nationkey and
                    l_suppkey = s_suppkey and
                    l_orderkey = o_orderkey  and
                    s_nationkey != c_nationkey and
                    strftime('%Y', l_shipdate) = '1996'
                GROUP BY n_name)
        WHERE name1 = name2
    ) as t3
WHERE 
    t1.name1 = t2.name1 AND
    t2.name1 = t3.name1;