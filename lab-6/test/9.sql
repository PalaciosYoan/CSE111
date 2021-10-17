-- Find the distinct parts (pname) ordered 
-- by customers from AMERICA that are supplied 
-- by exactly 3 suppliers from ASIA.

SELECT DISTINCT p_name
FROM customer, nation, orders, part, lineitem, region
WHERE
r_name = 'AMERICA' AND
r_regionkey = n_regionkey AND
n_nationkey = c_nationkey AND
c_custkey = o_custkey AND
o_orderkey = l_orderkey AND
l_partkey = p_partkey AND
p_name IN (SELECT DISTINCT p_name
FROM part, partsupp, supplier, nation, region
WHERE
r_name = 'ASIA' AND
r_regionkey = n_regionkey AND
n_nationkey = s_nationkey AND
s_suppkey = ps_suppkey AND
ps_partkey = p_partkey
GROUP BY p_name
HAVING COUNT(DISTINCT s_suppkey) == 3)
ORDER BY p_name