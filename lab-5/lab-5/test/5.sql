--For parts whose type contains STEEL, 
-- return the name of the supplier 
-- from ASIA that can supply the mat minimum cost (pssupplycost), 
-- for every part size.  Print the supplier name together with the partsize and the minimum cost.
SELECT s_name, p_size , MIN(ps_supplycost)
FROM part, supplier, partsupp, nation, region 
WHERE 
      p_partkey = ps_partkey AND
      s_suppkey = ps_suppkey AND
      n_nationkey = s_nationkey AND
      n_regionkey = r_regionkey AND
      p_type LIKE '%STEEL%' AND
      r_name = 'ASIA'

GROUP BY p_size;
