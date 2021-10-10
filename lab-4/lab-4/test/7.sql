-- How  many  orders  do  customers  in  
-- every  nation  in AMERICA have  in  every  status?  
-- Print  the  nationname, the order status, and the count.

SELECT n_name, o_orderstatus, COUNT(o_orderstatus)
FROM nation, orders, customer, region
WHERE
    n_nationkey = c_nationkey AND
    c_custkey = o_custkey AND 
    n_regionkey = r_regionkey AND
    r_name = 'AMERICA'
GROUP BY
    n_name, o_orderstatus;