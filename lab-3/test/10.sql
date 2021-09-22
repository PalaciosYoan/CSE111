SELECT SUM(orders.o_totalprice)
FROM orders
INNER JOIN customer on customer.c_custkey = orders.o_custkey
INNER JOIN nation on nation.n_nationkey = customer.c_nationkey
INNER JOIN region on region.r_regionkey = nation.n_regionkey
WHERE region.r_name = 'AMERICA' AND 
    strftime('%Y', orders.o_orderdate) = '1996';

