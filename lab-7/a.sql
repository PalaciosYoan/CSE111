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

SELECT n_name, COUNT(c_name) as num_cust
        FROM supplier, nation, customer, lineitem, orders
        WHERE 
            s_suppkey = l_suppkey AND
            l_orderkey = o_orderkey AND
            o_custkey = c_custkey AND
            c_nationkey = n_nationkey AND
            s_name = 'Supplier#000000041'
        GROUP BY n_name
        ORDER BY num_cust DESC, n_name ASC