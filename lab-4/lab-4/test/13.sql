-- How  many  line  items  are  supplied  
-- by  suppliers  in AFRICA for  orders  made  
-- by  customers  in UNITED STATES ?

SELECT COUNT( l_orderkey)
FROM 
    orders, lineitem,
    (   SELECT s_suppkey
        FROM 
            supplier, nation, region
        WHERE r_regionkey = n_regionkey
            AND n_nationkey = s_nationkey
            AND r_name = 'AFRICA'
    ) supp_africa,
    (
        SELECT c_custkey
        FROM 
            customer, nation
        WHERE
            n_nationkey = c_nationkey AND 
            n_name = 'UNITED STATES'
    ) cust_usa
WHERE o_orderkey = l_orderkey
      AND supp_africa.s_suppkey = l_suppkey
      AND cust_usa.c_custkey = o_custkey;