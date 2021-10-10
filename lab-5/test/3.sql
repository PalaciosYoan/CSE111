--For  the  line  items  ordered  in October 1996(o_orderdate),  
--find  the  smallest  discount  that  is  larger than the average discount among all the orders.
SELECT MIN(l_discount)
FROM orders, lineitem,
      (
            SELECT AVG(l_discount) AS avg_discount
            FROM lineitem
      )avgDiscount
WHERE 
      l_orderkey = o_orderkey AND
      strftime('%Y-%m', o_orderdate) = '1996-10' AND
      avgDiscount.avg_discount < l_discount;