--  Print the name of the parts supplied 
--  by suppliers from UNITED STATES that have total 
--  value in the top 1% total values across all the supplied parts.  
--  The total value is ps_supplycost*ps_availqty.  Hint:Use theLIMITkeyword.
SELECT p_name
FROM part, nation, supplier, partsupp
WHERE 
      s_nationkey = n_nationkey AND
      p_partkey = ps_partkey AND
      s_suppkey = ps_suppkey AND
      n_name = 'UNITED STATES' AND 
      ps_supplycost * ps_availqty IN 
            (
                  SELECT ps_supplycost * ps_availqty 
                  FROM partsupp
                  ORDER BY ps_supplycost * ps_availqty 
                  DESC LIMIT 
                        (
                              SELECT 0.01 * COUNT(*)
                              FROM partsupp
                        )
            );