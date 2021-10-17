-- The market share for a given nation within a given region is defined as 
-- the fraction of the revenue from the line items ordered by customers in 
-- the given region that are supplied by suppliers from the given nation.  
-- The revenue of a line item is defined as l_extendedprice*(1-l_discount).  
-- Determine the market share of UNITED STATES in ASIA in 1997(l_shipdate).

SELECT 
      ((
            SELECT SUM(l_extendedprice*(1-l_discount)) 
            FROM 
                  lineitem, 
                  orders, 
                  customer, 
                  nation n1, 
                  region, 
                  supplier, 
                  nation n2 
            WHERE 
                  l_orderkey = o_orderkey AND
                  o_custkey = c_custkey AND
                  c_nationkey = n1.n_nationkey AND
                  n1.n_regionkey = region.r_regionkey AND
                  l_suppkey = s_suppkey AND
                  s_nationkey = n2.n_nationkey AND
                  region.r_name = 'ASIA' AND
                  n2.n_name = 'UNITED STATES' AND
                  strftime('%Y', l_shipdate) = '1997'
      )/
      (
            SELECT SUM(l_extendedprice*(1-l_discount)) 
            FROM 
                  lineitem, 
                  orders, 
                  customer, 
                  nation n1, 
                  region 
            WHERE 
                  l_orderkey = o_orderkey AND
                  o_custkey = c_custkey AND
                  c_nationkey = n1.n_nationkey AND
                  n1.n_regionkey = region.r_regionkey AND
                  region.r_name = 'ASIA' AND
                  strftime('%Y', l_shipdate) = '1997'
            ))-0.0000000000000001;