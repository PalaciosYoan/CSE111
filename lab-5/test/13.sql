--Count the number of orders made in 
--the fourth quarter of 1997 in which at least one 
--line item was received  by  a  customer  earlier  than  its  commit  date.   
--List  the  count  of  such  orders  for  every  order priority.

SELECT o_orderpriority, COUNT(*) 
FROM orders 
WHERE 
      strftime('%Y-%m', o_orderdate) >= '1997-10' AND
      strftime('%Y-%m', o_orderdate) <= '1997-12' AND 
      EXISTS 
            (
                  SELECT * 
                  FROM lineitem 
                  WHERE 
                        l_orderkey = o_orderkey AND
                        l_receiptdate < l_commitdate
            )
GROUP BY o_orderpriority
ORDER BY o_orderpriority;