-- Find the number of customers that received a discount of at least10%
-- for one of the line items on theirorders.  
-- Count every customer exactly once even 
-- if they have multiple discounted line items.

SELECT COUNT(DISTINCT customer.c_name)
FROM customer
INNER JOIN orders on orders.o_custkey = customer.c_custkey
INNER JOIN lineitem on lineitem.l_orderkey = orders.o_orderkey
WHERE lineitem.l_discount >= 0.01
ORDER BY customer.c_name;
 
--  SELECT l_discount
--  FROM lineitem
--  WHERE l_discount != 0;