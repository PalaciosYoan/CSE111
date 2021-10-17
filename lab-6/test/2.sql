--Find the number of customers who had at least three orders in November 1995(o_orderdate).
SELECT COUNT(*)
FROM (SELECT COUNT(DISTINCT(o_custkey))
        FROM orders
        WHERE 
            strftime('%Y', o_orderdate) = '1995' AND
            strftime('%m', o_orderdate) = '11'
        GROUP BY o_custkey
        HAVING COUNT(o_custkey) >2);


