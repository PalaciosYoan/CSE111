-- What is the total supply cost (ps_supplycost) for parts less expensive 
-- than $1000 (p_retailprice) shipped in 1997(l_shipdate) by suppliers who did 
-- not supply any line item with an extended price less than 2000 in 1996?
SELECT total(ps_supplycost) --280519.91
FROM part, partsupp, supplier as s1, lineitem
WHERE 
      p_partkey = ps_partkey AND
      ps_suppkey = s_suppkey AND
      l_partkey = p_partkey AND
      p_retailprice < 1000 AND
      l_shipdate  IN
            (
                  SELECT l_shipdate  
                  FROM lineitem, partsupp 
                  WHERE 
                        ps_suppkey = l_suppkey AND
                        strftime('%Y', l_shipdate) = '1997'
            ) AND
      NOT EXISTS
            (
                  SELECT *
                  FROM supplier as s2, lineitem 
                  WHERE l_suppkey = s2.s_suppkey 
                        AND s2.s_name = s1.s_name
                        AND l_extendedprice < 2000
                        AND strftime('%Y', l_shipdate) = '1996'
            );