-- Find the number of distinct orders completed in 1995
-- by the suppliers in every nation.  
-- An order status of F stands for complete.  
-- Print only those nations for which the number of orders is larger than 50.

SELECT t1.n_name, t1.cnt
FROM
    (
        SELECT n_name, COUNT(DISTINCT(l_orderkey)) as cnt
        FROM orders, supplier, nation, region, lineitem
        WHERE 
            s_nationkey = n_nationkey AND
            n_regionkey = r_regionkey AND
            l_suppkey = s_suppkey AND
            o_orderkey = l_orderkey AND
            o_orderstatus = 'F' AND
            strftime('%Y', o_orderdate) = '1995'
        GROUP BY n_name
    ) t1
WHERE
    t1.cnt > 50; 