--For every order priority, count the number of parts ordered in 1997
-- and received later (lreceiptdate)than the commit date (lcommitdate).
SELECT o_orderpriority, COUNT(l_partkey) 
FROM orders, lineitem
WHERE 
      o_orderkey = l_orderkey and
      l_commitdate < l_receiptdate AND
      strftime('%Y', o_orderdate) = '1997'
GROUP BY o_orderpriority;