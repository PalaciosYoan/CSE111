-- What is the maximum account balance for the suppliers 
-- in every nation?  
-- Print only those nations for which the maximum balance 
-- is larger than 9000.

SELECT n_name, max(s_acctbal)
FROM nation, supplier
WHERE
    n_nationkey = s_nationkey 
GROUP BY
    n_name
HAVING MAX(s_acctbal) > 9000;