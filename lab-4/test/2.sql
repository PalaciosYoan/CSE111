SELECT r_name, COUNT(s_name)
FROM supplier, nation, region
WHERE 
    r_regionkey = n_regionkey AND
    n_nationkey = s_nationkey 
GROUP BY
    r_name;