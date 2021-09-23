SELECT COUNT(orders.o_orderpriority)
FROM orders
INNER JOIN customer on customer.c_custkey = orders.o_custkey
INNER JOIN nation on nation.n_nationkey = customer.c_nationkey
WHERE nation.n_name = 'BRAZIL' AND 
orders.o_orderpriority = '1-URGENT' AND
strftime('%Y', o_orderdate) BETWEEN '1994' AND '1997';