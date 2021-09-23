SELECT strftime('%Y', orders.o_orderdate), COUNT(lineitem.l_partkey)
FROM orders
INNER JOIN lineitem on lineitem.l_orderkey = orders.o_orderkey
INNER JOIN supplier on supplier.s_suppkey = lineitem.l_suppkey
INNER JOIN nation on nation.n_nationkey = supplier.s_nationkey
WHERE nation.n_name = 'CANADA' AND
orders.o_orderpriority = '3-MEDIUM'
GROUP BY strftime('%Y', o_orderdate);