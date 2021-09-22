SELECT supplier.s_name, supplier.s_acctbal
FROM supplier
INNER JOIN nation on nation.n_nationkey = supplier.s_nationkey
WHERE (nation.n_name = 'UNITED STATES' OR
    nation.n_name = 'BRAZIL' OR
    nation.n_name = 'CANADA' OR
    nation.n_name = 'PERU'   OR
    nation.n_name = 'ARGENTINA') AND
    supplier.s_acctbal > 5000;



