--Find how many suppliers from UNITED STATES supply more than 40 different parts.
SELECT COUNT(*)
FROM 
    (
        SELECT COUNT(s_suppkey)
        FROM partsupp, supplier, nation
        WHERE 
            ps_suppkey = s_suppkey AND
            n_nationkey = s_nationkey AND
            n_name = 'UNITED STATES'
        GROUP BY s_suppkey
        HAVING COUNT(ps_partkey) > 40
    );