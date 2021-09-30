-- How  many  line  items  are  supplied  
-- by  suppliers  in AFRICA for  orders  made  
-- by  customers  in UNITEDSTATES?

SELECT COUNT(l_orderkey)
FROM lineitem, supplier, nation, region, orders
WHERE 
    s_suppkey = l_suppkey AND
    s_nationkey = n_nationkey AND
    n_regionkey = r_regionkey AND
    o
