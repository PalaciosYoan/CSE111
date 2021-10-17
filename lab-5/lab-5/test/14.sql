-- For any two regions, find the gross discounted revenue (lextendedprice*(1-ldiscount)) derivedfrom  
-- line  items  in  which  parts  are  shipped  from  a  supplier  in  the  first  region  
-- to  a  customer  in  thesecond region in1996and1997.  List the supplier region, the customer region, 
-- the year (lshipdate),and the revenue from shipments that took place in that year.
SELECT 
      r2.r_name, 
      r1.r_name, 
      SUBSTR(l_shipdate,1,4), 
      SUM(l_extendedprice*(1-l_discount)) 
FROM 
      lineitem, 
      orders, 
      customer, 
      nation n1, 
      region r1, 
      supplier, 
      nation n2, 
      region r2 
WHERE 
      l_orderkey = o_orderkey AND
      o_custkey = c_custkey AND
      c_nationkey = n1.n_nationkey AND
      l_suppkey = s_suppkey AND
      s_nationkey = n2.n_nationkey AND
      n2.n_regionkey = r2.r_regionkey AND
      n1.n_regionkey = r1.r_regionkey AND
      strftime('%Y', l_shipdate) IN ('1996','1997') 
GROUP BY r2.r_name, r1.r_name, strftime('%Y', l_shipdate) 
ORDER BY r2.r_name, r1.r_name, strftime('%Y', l_shipdate);