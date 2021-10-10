-- Find the supplier with the largest account balance in every region.  
-- Print the region name, the suppliername, and the account balance

SELECT r_name, s_name, max(s_acctbal)
FROM region, supplier, nation
WHERE 
    n_regionkey = r_regionkey AND 
    s_nationkey = n_nationkey 
GROUP BY
    r_name;