--Find the nation(s) with the smallest number of customers.

SELECT n_name
FROM customer, nation
WHERE c_nationkey = n_nationkey
GROUP BY n_name HAVING COUNT(*) = (
                                SELECT MIN(largeCust)
                                FROM (SELECT COUNT(c_custkey) AS largeCust
                                        FROM customer, nation
                                        WHERE c_nationkey = n_nationkey
                                        GROUP BY n_name));