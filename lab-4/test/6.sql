-- How many unique parts produced 
-- by every supplier in CANADA are ordered at every priority?  
-- Print thesupplier name, the order priority, and the number of parts.
SELECT s_name, o_orderpriority, count(DISTINCT p_name)
FROM supplier, orders, part, partsupp, nation, lineitem
WHERE n_nationkey = s_nationkey AND
    s_suppkey = ps_suppkey AND
    ps_partkey = p_partkey AND
    p_partkey = l_partkey AND
    l_orderkey = o_orderkey AND
    l_suppkey = ps_suppkey AND
    n_name = 'CANADA' 
GROUP BY s_name, o_orderpriority