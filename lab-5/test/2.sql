--How many suppliers in every region have less balance in their 
--account than the average account balance of their own region?
SELECT r_name, COUNT(s_acctbal)
FROM region , nation , supplier,
      (
      SELECT r_name as region_name, AVG(s_acctbal) AS r_avgacctbal
      FROM 
            region, nation, supplier
      WHERE 
            s_nationkey = n_nationkey AND
            r_regionkey = n_regionkey
            
      GROUP BY 
            r_name
      ) regionAvg

WHERE 
      r_name = regionAvg.region_name AND
      r_regionkey = n_regionkey AND
      s_nationkey = n_nationkey AND
      s_acctbal < regionAvg.r_avgacctbal
GROUP BY 
      r_name;