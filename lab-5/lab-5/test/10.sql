
--   How many customers from every region have 
--   never placed an order and have less than the average account balance?
SELECT r_name, COUNT(DISTINCT c_name)
FROM customer, nation, region, orders,
    (
        SELECT c_custkey AS c_key
        FROM customer
        EXCEPT
        SELECT o_custkey
        FROM orders
    ) t1
WHERE
    c_custkey = t1.c_key AND
    c_nationkey = n_nationkey AND
    n_regionkey = r_regionkey AND

    c_acctbal < 
        (
            SELECT AVG(c_acctbal) 
            FROM customer
        ) 
GROUP BY r_name;