--Find  how  many  suppliers  have  less  than  50  distinct  orders  from  customers  in
-- GERMANY and FRANCE together.

SELECT COUNT(l_suppkey)
FROM 
    (
        SELECT l_suppkey, COUNT(DISTINCT o_orderkey) AS cnt
            FROM orders, lineitem, nation, customer

            WHERE 
                n_nationkey = c_nationkey AND
                c_custkey = o_custkey AND
                o_orderkey = l_orderkey AND
                (n_name = 'GERMANY' OR n_name = 'FRANCE')
            GROUP BY l_suppkey
    )
WHERE cnt < 50;