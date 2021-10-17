-- Count the number of distinct suppliers that supply parts whose 
-- type contains POLISHED and have size equal to any of 3, 23, 36, and 49.

SELECT COUNT(DISTINCT s_name)
FROM part, partsupp, supplier 
WHERE 
      p_type LIKE '%POLISHED%' AND
      s_suppkey = ps_suppkey AND
      ps_partkey = p_partkey AND
      p_size IN (3, 23, 36, 49);