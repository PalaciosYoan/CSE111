SELECT SUM(customer.c_acctbal)
FROM customer
INNER JOIN nation on nation.n_nationkey = customer.c_nationkey
INNER JOIN region on region.r_regionkey = nation.n_regionkey
WHERE region.r_name = 'EUROPE' AND
customer.c_mktsegment = 'MACHINERY';