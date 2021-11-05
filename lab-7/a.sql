-- SQLite
-- SELECT *
-- FROM
--     (
--         SELECT n_name, COUNT(c_name) as num_cust
--         FROM supplier, nation, customer, lineitem, orders
--         WHERE 
--             s_suppkey = l_suppkey AND
--             l_orderkey = o_orderkey AND
--             o_custkey = c_custkey AND
--             c_nationkey = n_nationkey AND
--             s_name = 'Supplier#000000041'
--         GROUP BY n_name
--         ORDER BY num_cust DESC
--     )
-- LIMIT 2;

-- SELECT n_name, SUM(c_name) as total_size
--     FROM supplier, nation, customer, lineitem, orders, part
--     WHERE 
--         s_suppkey = l_suppkey AND
--         l_orderkey = o_orderkey AND
--         o_custkey = c_custkey AND
--         c_nationkey = n_nationkey
--     GROUP BY n_name
--     ORDER BY num_cust DESC

--In order to determine the capacity of a
-- warehouse, you have to compute the total size of the parts (p size) supplied by the supplier to the
-- customers in a nation.

SELECT n_name, TOTAL(p_size)
FROM part, nation, customer, orders, lineitem, supplier
WHERE
    s_suppkey = l_suppkey AND
    p_partkey = l_partkey AND
    l_orderkey = o_orderkey AND
    o_custkey = c_custkey AND
    c_nationkey = n_nationkey AND
    s_name = 'Supplier#000000001'
GROUP BY n_name