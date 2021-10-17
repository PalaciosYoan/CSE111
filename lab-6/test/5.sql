--Find how many suppliers supply the most expensive part (p_retailprice).
  
SELECT COUNT(s_suppkey) 
FROM partsupp, part, supplier
WHERE 
    s_suppkey = ps_suppkey  AND
    p_partkey = ps_partkey AND
    p_retailprice IN (
                    SELECT MAX(p_retailprice)
                    FROM part
                    );