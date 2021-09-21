SELECT strftime('%m', lineitem.l_receiptdate) as "Month", 
COUNT(lineitem.l_receiptdate)
FROM customer
INNER JOIN orders on orders.o_custkey = customer.c_custkey
INNER JOIN lineitem on lineitem.l_orderkey = orders.o_orderkey
WHERE customer.c_name = 'Customer#000000010' AND
strftime('%Y', lineitem.l_receiptdate) = '1993'
GROUP BY strftime('%m', lineitem.l_receiptdate);
