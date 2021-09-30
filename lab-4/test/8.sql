-- Find the number of distinct orders completed in 1995
-- by the suppliers in every nation.  
-- An order status of F stands for complete.  
-- Print only those nations for which the number of orders is larger than 50.

-- SELECT n_name, COUNT(DISTINCT o_orderkey)
-- FROM orders, nation, supplier, customer
-- WHERE 
--     n_nationkey = s_nationkey AND
--     s_nationkey = c_nationkey AND
--     c_custkey = o_custkey AND 
--     strftime('%Y', o_orderdate) = '1995' AND
--     o_orderstatus = 'F'
-- GROUP BY
--     n_name, s_name; 

