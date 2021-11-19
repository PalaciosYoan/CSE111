
WITH t1 AS
    (
        SELECT region.r_name as name, SUM(w_capacity) as sumCap
        FROM region, nation as n1, warehouse, nation as n2, supplier
        WHERE 
            w_nationkey = n1.n_nationkey AND
            s_suppkey = w_suppkey AND
            s_nationkey = n2.n_nationkey AND
            n1.n_regionkey = region.r_regionkey AND
            n2.n_name = 'UNITED STATES' 
        GROUP BY region.r_name
    )
SELECT region.r_name, 
    CASE 
        WHEN t1.sumCap > 0 THEN t1.sumCap 
        ELSE 0 
    END
FROM region
LEFT JOIN t1 ON r_name = t1.name
GROUP BY region.r_name
ORDER BY region.r_name ASC