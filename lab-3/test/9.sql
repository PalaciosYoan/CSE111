SELECT nation.n_name, COUNT(supplier.s_name), MAX(supplier.s_acctbal)
FROM supplier
INNER JOIN nation on nation.n_nationkey = supplier.s_nationkey
GROUP BY nation.n_name
HAVING COUNT(supplier.s_name) > 5;