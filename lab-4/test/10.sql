-- Find the minimum and 
-- maximum discount for every part having ECONOMY and COPPER in its type

SELECT DISTINCT p_type, min(l_discount), max(l_discount)
FROM part, lineitem
WHERE 
    p_partkey = l_partkey AND
    p_type LIKE '%ECONOMY %COPPER'
    
GROUP BY 
    p_type;