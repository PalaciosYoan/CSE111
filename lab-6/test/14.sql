-- Compute, for every country, the value of economic exchange, i.e., 
-- the difference between the numberof items from suppliers 
-- in that country sold to customers in other countries and 
-- the number of itemsbought by local customers from foreign suppliers in1994(lshipdate).

SELECT name1, (cont1 - cont2)
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
WHERE name1 = name2;