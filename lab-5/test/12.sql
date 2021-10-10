-- What is the total supply cost (ps_supplycost) for parts less expensive 
-- than $1000 (p_retailprice) shipped in 1997(l_shipdate) by suppliers who did 
-- not supply any line item with an extended price less than 2000 in 1996?
SELECT total(ps_supplycost) --280519.91
FROM part, partsupp
WHERE 
      p_partkey = ps_partkey AND
      p_retailprice < 1000 AND
      p_partkey IN
            (
                  SELECT l_partkey 
                  FROM lineitem, partsupp 
                  WHERE 
                        ps_suppkey = l_suppkey AND
                        strftime('%Y', l_shipdate) = '1997'
            ) AND
      ps_suppkey NOT IN
            (
                  SELECT DISTINCT ps_suppkey 
                  FROM partsupp, lineitem, part 
                  WHERE 
                        ps_partkey = p_partkey AND
                        p_partkey = l_partkey  AND
                        ps_suppkey=  l_suppkey AND 
                        l_extendedprice < 2000 AND 
                        strftime('%Y', l_shipdate) = '1996');