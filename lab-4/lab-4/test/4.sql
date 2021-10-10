--   How  many  parts  with  size  below 20 
-- does  every  supplier  from CANADA offer?   
-- Print  the  name  of  the supplier and the number of parts.

SELECT s_name, COUNT(p_name)
FROM part, supplier, nation, partsupp
WHERE 
    p_partkey = ps_partkey AND
    ps_suppkey = s_suppkey AND 
    s_nationkey = n_nationkey AND
    p_size < 20 AND
    n_name = 'CANADA'
GROUP BY
    s_name;
