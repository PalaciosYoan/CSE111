--Find the supplier-customer pair(s) with the least expensive (o_totalprice) 
-- order(s) completed (F in o_orderstatus).  
-- Print the supplier name, the customer name, and the total price.

SELECT s_name, c_name, o_totalprice
FROM 
    supplier, 
    customer, 
    orders, 
    lineitem
WHERE 
    o_orderkey = l_orderkey AND
    l_suppkey = s_suppkey AND
    c_custkey = o_custkey AND
    o_orderstatus = 'F' AND
    o_totalprice in (
                SELECT min(o_totalprice)
                FROM orders
                WHERE o_orderstatus = 'F');
