SELECT c_name, SUM(o_totalprice)
FROM orders, customer, nation
WHERE 
    customer.c_custkey = orders.o_custkey AND 
    customer.c_nationkey = nation.n_nationkey AND
    strftime('%Y', o_orderdate) = '1995' AND
    n_name = 'FRANCE'
GROUP BY
    c_name;
