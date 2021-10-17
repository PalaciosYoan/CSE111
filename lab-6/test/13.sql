-- Find the nation(s) with the most developed industry, i.e., 
-- selling items totaling the largest amount of money (l_extendedprice) in 1994(l_shipdate).
SELECT n_name
FROM lineitem, 
      (
            SELECT n_name, SUM(l_extendedprice) as s
            FROM nation, supplier, lineitem
            WHERE 
                  n_nationkey = s_nationkey AND
                  s_suppkey = l_suppkey AND
                  l_shipdate LIKE '%1994%'
      )
GROUP BY n_name;