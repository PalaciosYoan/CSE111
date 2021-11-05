-- Q5 determines the total capacity of the warehouses belonging 
-- to suppliers from a given nation in every
-- region. The suppliers’ nation is a parameter stored 
-- in the file input/5.in. If there are no warehouses
-- in a region, then value 0 is printed for that region. 
-- Q5 prints the region and the capacity sorted
-- alphabetically by region. (3 points)
-- UNITED STATES



SELECT r_name as region, IFNULL(SUM(t1.w_capacity)/2, 0) capacity
FROM region, warehouse w1, nation as t2,
    (
        SELECT w_warehousekey,
            CASE
                WHEN n_name = 'UNITED STATES' THEN w_capacity
                ELSE 0
            END w_capacity
        FROM supplier, nation, warehouse
        WHERE
            s_nationkey = n_nationkey AND
            s_suppkey = w_suppkey 
    ) t1
WHERE 
    w_nationkey = t2.n_nationkey AND
    t2.n_regionkey = r_regionkey AND
    t1.w_warehousekey = w1.w_warehousekey
GROUP BY r_name;
