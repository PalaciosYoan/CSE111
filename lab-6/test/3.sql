--Find how many parts are supplied by exactly two suppliers from UNITED STATES.
SELECT COUNT(*)
FROM 
    (
        SELECT COUNT(ps_partkey)
        FROM partsupp, supplier, nation
        WHERE 
            s_suppkey = ps_suppkey AND 
            s_nationkey = n_nationkey AND
            n_name = 'UNITED STATES'
        GROUP BY ps_partkey
        HAVING COUNT(s_suppkey) = 2
    );
