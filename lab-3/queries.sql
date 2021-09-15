SELECT c_name, c_phone, c_address, c_acctbal 
FROM customer 
WHERE c_name='Customer#000000010';


SELECT min(c_acctbal) FROM customer;

SELECT l_receiptdate, l_returnflag, l_extendedprice, l_tax 
FROM lineitem 
WHERE l_returnflag='R' 
intersect 
SELECT l_receiptdate, l_returnflag, l_extendedprice, l_tax 
FROM lineitem 
WHERE l_receiptdate='1993-08-22';