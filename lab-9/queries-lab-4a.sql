-- SQLite

-- select c_name, sum(o_totalprice)
-- from orders, V1
-- where o_custkey = c_custkey AND
--     o_orderdate like '1995-__-__'
-- Group by c_name;

-- select c_name
-- from customer, nation
-- where
-- 	n_nationkey = c_nationkey
-- group by c_name;

-- --1
-- select c_name, sum(o_totalprice)
-- from orders, customer, nation
-- where o_custkey = c_custkey and
-- 	n_nationkey = c_nationkey and
-- 	n_name = 'FRANCE' AND
-- 	o_orderdate like '1995-__-__'
-- group by c_name;

select s_suppkey, s_name, s_address, s_phone, s_acctbal, s_comment, n_name, r_name
from supplier, nation, region
where s_nationkey = n_nationkey
    and n_regionkey = r_regionkey
group by r_name;

--2
select s_region, count(*)
from V2
group by s_region;

--3
select c_nation, count(*)
from V1, orders
where
    c_region='AMERICA'
    And o_custkey = c_custkey
group by c_nation;
SELECT * from V1;


--4
select s_name, count(ps_partkey)
from partsupp, part, V2
where p_partkey = ps_partkey
    and ps_suppkey = s_suppkey
    and s_nation = 'CANADA'
    and p_size < 20
group by s_name;

SELECT 
    o_orderkey, o_custkey, 
    o_orderstatus, o_totalprice, 
    strftime('%Y', o_orderdate) as o_orderyear, 
    o_orderpriority, o_clerk,
    o_shippriority, o_comment
FROM orders;

--5
select c_name, count(*)
from V5, V1
where o_custkey = c_custkey
    and c_nation = 'GERMANY'
    and o_orderyear like '1993'
group by c_name;

--6
select s_name, o_orderpriority, count(distinct ps_partkey)
from partsupp, V5, lineitem, supplier, nation
where l_orderkey = o_orderkey
    and l_partkey = ps_partkey
    and l_suppkey = ps_suppkey
    and ps_suppkey = s_suppkey
    and s_nationkey = n_nationkey
    and n_name = 'CANADA'
group by s_name, o_orderpriority;

--7
select c_nation, o_orderstatus, count(*)
from V5, V1
where o_custkey = c_custkey
    and c_region='AMERICA'
group by c_nation, o_orderstatus;

--8
select s_nation, count(distinct l_orderkey) as co
from V5, V2, lineitem
where o_orderkey = l_orderkey
    and l_suppkey = s_suppkey
    and o_orderstatus = 'F'
    and o_orderyear like '1995'
group by s_nation
having co > 50;

--9
select count(distinct o_clerk)
from V5, V2, lineitem
where o_orderkey = l_orderkey
    and l_suppkey = s_suppkey
    and s_nation = 'UNITED STATES';

--p_type, min_discount, max_discount

--10
select p_type, min(l_discount), max(l_discount)
from lineitem, part
where l_partkey = p_partkey
group by p_type;

select p_type, min_discount, max_discount
from V10
where 
    p_type like '%ECONOMY%'
    and p_type like '%COPPER%'
group by p_type;

--11
select s_region, s_name, s_acctbal
from V2 s
where 
        s.s_acctbal = (select max(s1.s_acctbal)
							from V2 s1
							where
								s.s_region = s1.s_region
						);

--12
select s_nation, max(s_acctbal) as mb
from V2
group by s_nation
having mb > 9000;

--13
select count(*)
from orders, lineitem, V1, V2
where o_orderkey = l_orderkey
    and o_custkey = c_custkey
    and l_suppkey = s_suppkey
    and s_region = 'AFRICA'
    and c_nation = 'UNITED STATES';

--14
select s_region as suppRegion, s_region as custRegion, max(o_totalprice)
from lineitem, V2, orders, V1
where l_suppkey = s_suppkey
    and l_orderkey = o_orderkey
    and o_custkey = c_custkey
group by s_region, c_region;

--15
select *
from lineitem, supplier, orders, customer
where l_suppkey = s_suppkey
    and l_orderkey = o_orderkey
    and o_custkey = c_custkey
    and c_acctbal > 0
    ;

select c_custkey, c_name, c_nationkey, c_acctbal
from customer
where 
    c_acctbal > 0;