-- -- Find the distinct parts (p_name) ordered 
-- -- by customers from AMERICA that are supplied 
-- -- by exactly 3 suppliers from ASIA.

-- SELECT DISTINCT p_name
-- FROM 
--     customer, 
--     nation, 
--     orders, 
--     part, 
--     lineitem, 
--     region
-- WHERE
--     r_regionkey = n_regionkey AND
--     n_nationkey = c_nationkey AND
--     c_custkey = o_custkey AND
--     o_orderkey = l_orderkey AND
--     l_partkey = p_partkey AND
--     r_name = 'AMERICA' AND
--     p_name IN 
--     (
--         SELECT DISTINCT p_name
--         FROM part, partsupp, supplier, nation, region
--         WHERE
--             r_name = 'ASIA' AND
--             r_regionkey = n_regionkey AND
--             n_nationkey = s_nationkey AND
--             s_suppkey = ps_suppkey AND
--             ps_partkey = p_partkey
--         GROUP BY p_name
--         HAVING COUNT(DISTINCT s_suppkey) = 3
--     )
-- ORDER BY p_name
-- ORDER BY p_name
--     )

SELECT DISTINCT p1.p_name
FROM lineitem, part as p1,
    (
        SELECT p_partkey
        FROM 
            orders, 
            customer, 
            nation, 
            region, 
            lineitem, 
            part
        WHERE 
            c_custkey = o_custkey AND
            o_orderkey = l_orderkey  AND
            l_partkey = p_partkey AND
            c_nationkey = n_nationkey AND 
            n_regionkey = r_regionkey AND
            r_name = 'AMERICA'
    ) as t2,
    (
    SELECT p_partkey
    FROM 
        supplier, 
        nation, 
        region, 
        lineitem, 
        part
    WHERE 
        p_partkey = l_partkey AND
        l_suppkey = s_suppkey AND
        s_nationkey = n_nationkey  AND
        n_regionkey = r_regionkey  AND
        r_name = 'ASIA'
    GROUP BY p_partkey
    HAVING COUNT(*) = 3
    ) as t1
WHERE 
    l_partkey = t1.p_partkey AND
    l_partkey = t2.p_partkey AND
    l_partkey = p1.p_partkey;

