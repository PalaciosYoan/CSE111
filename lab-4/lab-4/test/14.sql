-- List the maximum total price  of an order 
-- between any two regions,  i.e.,  the suppliers 
-- are from one region and the customers are 
-- from the other region.

SELECT  t1.r_name, t2.r_name, MAX(o_totalprice)
FROM 
(
    SELECT *
    FROM supplier, region, nation, lineitem
    WHERE 
        s_suppkey = l_suppkey AND
        s_nationkey = n_nationkey AND
        n_regionkey = r_regionkey
) t1,
(
    SELECT *
    FROM orders, customer, region, nation
    WHERE 
        n_regionkey = r_regionkey AND
        c_nationkey = n_nationkey AND
        o_custkey = c_custkey
) t2
WHERE
    o_orderkey = l_orderkey
GROUP BY 
    t1.r_name, t2.r_name

