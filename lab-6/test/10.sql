-- Find the region where customers spend the smallest amount of
-- money (l_extendedprice) buying items from suppliers in the same region.

SELECT r_name
FROM 
    (
        SELECT r_name, MIN(money)
        FROM 
            (
                SELECT r_name, SUM (l_extendedprice) AS money
                FROM 
                    region, 
                    nation, 
                    customer, 
                    supplier, 
                    lineitem
                WHERE
                    s_nationkey = n_nationkey AND
                    n_nationkey = c_nationkey AND
                    r_regionkey = n_regionkey AND
                    l_suppkey = s_suppkey
                GROUP BY r_name
            )
    );
