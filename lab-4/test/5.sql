-- Find the number of orders posted by every customer from GERMANY in 1993.
SELECT c_name, COUNT(o_orderdate)
FROM customer, orders, nation
WHERE 
    c_custkey = o_custkey AND
    c_nationkey = n_nationkey AND
    strftime('%Y', o_orderdate) = '1993' AND
    n_name = 'GERMANY'
GROUP BY
    c_name;