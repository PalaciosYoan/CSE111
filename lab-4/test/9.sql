-- How many different order clerks did the suppliers in UNITED STATES work with?
SELECT COUNT(DISTINCT o_clerk)
FROM orders, supplier, nation, lineitem
WHERE 
    s_nationkey = n_nationkey AND
    s_suppkey = l_suppkey AND
    l_orderkey = o_orderkey AND
    n_name = 'UNITED STATES';
