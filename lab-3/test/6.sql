SELECT DISTINCT nation.n_name
FROM customer 
INNER JOIN orders on orders.o_custkey = customer.c_custkey
INNER JOIN nation on customer.c_nationkey = nation.n_nationkey 
WHERE orders.o_orderdate >= '1996-09-10' AND  orders.o_orderdate <= '1996-09-12' 
ORDER BY nation.n_name DESC; 