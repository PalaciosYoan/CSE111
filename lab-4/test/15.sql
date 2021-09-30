-- How  many  distinct  orders  are  
-- between  customers  with  
-- positive  account  balance  
-- and  suppliers  with negative account balance?

SELECT COUNT( DISTINCT orders.o_orderkey) 
FROM orders, lineitem,
    (
        SELECT c_custkey
        FROM customer
        WHERE
            c_acctbal > 0

    ) t1,
    (
        SELECT s_suppkey
        FROM supplier
        WHERE
            s_acctbal < 0
    ) t2
WHERE
    l_orderkey = o_orderkey AND 
    t2.s_suppkey = l_suppkey AND
    o_custkey = t1.c_custkey;