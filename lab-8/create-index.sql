CREATE INDEX customer_idx_c_name ON customer(c_name);-- Q1
CREATE INDEX supplier_idx_s_nationkey_s_acctbal ON supplier(s_nationkey, s_acctbal);-- Q2
CREATE INDEX lineitem_idx_l_returnflag_l_receiptdate ON lineitem(l_returnflag, l_receiptdate);-- Q3
-- Q4
CREATE INDEX customer_idx_c_mktsegment ON customer(c_mktsegment);-- Q5
CREATE INDEX nation_idx_n_nationkey_n_name ON nation(n_nationkey, n_name);-- Q6
CREATE INDEX customer_idx_c_custkey ON customer(c_custkey);-- Q6
CREATE INDEX orders_idx_o_orderdate ON orders(o_orderdate);-- Q6
CREATE INDEX lineitem_idx_l_orderkey ON lineitem(l_orderkey);-- Q7
CREATE INDEX orders_idx_o_custkey_o_orderkey ON orders(o_custkey, o_orderkey);-- Q7
CREATE INDEX customer_idx_c_name_c_custkey ON customer(c_name, c_custkey);-- Q7
CREATE INDEX region_idx_r_name_r_regionkey ON region(r_name, r_regionkey);-- Q8
CREATE INDEX nation_idx_n_name ON nation(n_name);-- Q9
CREATE INDEX orders_idx_o_custkey_o_orderdate ON orders(o_custkey, o_orderdate);-- Q10
CREATE INDEX customer_idx_c_nationkey_c_custkey ON customer(c_nationkey, c_custkey);-- Q10
CREATE INDEX orders_idx_o_orderkey ON orders(o_orderkey);-- Q11
CREATE INDEX lineitem_idx_l_discount ON lineitem(l_discount);-- Q11
CREATE INDEX region_idx_r_regionkey_r_name ON region(r_regionkey, r_name);-- Q12
CREATE INDEX orders_idx_o_orderstatus ON orders(o_orderstatus);-- Q12
CREATE INDEX nation_idx_n_regionkey_n_nationkey ON nation(n_regionkey, n_nationkey);-- Q13 
CREATE INDEX orders_idx_o_orderpriority_o_orderdate ON orders(o_orderpriority, o_orderdate);-- Q14
CREATE INDEX lineitem_idx_l_orderkey_l_suppkey ON lineitem(l_orderkey, l_suppkey);-- Q15
CREATE INDEX supplier_idx_s_nationkey_s_suppkey ON supplier(s_nationkey, s_suppkey);-- Q15
CREATE INDEX orders_idx_o_orderpriority_o_orderkey ON orders(o_orderpriority, o_orderkey);-- Q15