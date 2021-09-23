SELECT region.r_name, count(o_orderstatus)
FROM region
INNER JOIN nation on nation.n_regionkey = region.r_regionkey
INNER JOIN customer on customer.c_nationkey = nation.n_nationkey
INNER JOIN orders on orders.o_custkey = customer.c_custkey
WHERE orders.o_orderstatus = 'F'
GROUP BY region.r_name;