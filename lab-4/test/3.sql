SELECT n_name, COUNT(o_orderkey)
FROM orders, nation, customer, region
WHERE 
    r_regionkey = n_regionkey AND
    n_nationkey = c_nationkey AND
    c_custkey = o_custkey AND 
    r_name = 'AMERICA'
GROUP BY
    n_name;