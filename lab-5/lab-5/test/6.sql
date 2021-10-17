-- Based on the available quantity of items, 
-- who is the manufacturer pmfgr of the most popular item
-- (the more popular an item is, the less available it is inpsavailqty) 
-- fromSupplier#000000010?
SELECT p_mfgr
FROM 
      (
            SELECT p_mfgr, MIN(ps_availqty) 
            FROM  supplier, part, partsupp 
            WHERE 
                  s_name = 'Supplier#000000010' AND
                  p_partkey = ps_partkey AND
                  ps_suppkey = s_suppkey
      );
