-- CTE
use salesdb;
-- Step 1.) Find the total sales Per customer (Stand alone CTE)

with CTE_total_sales as (
SELECT customerid, sum(sales) AS totalsales
FROM salesdb.orders
group by customerid ),
-- Step 2.) Find the last ry order date per customer (Stand alone CTE)
cte_last_order as (
select customerid, max(orderdate) as last_order_date
from orders
group by customerid) 
-- Step 3 Rank customers based on total sales per customer
, CTE_Customer_rank as (
select * ,
rank() over (order by totalsales desc) as customerrank
from CTE_total_sales 
)
-- Step 4 segment customers based on their total sales
, CTE_Customer_segments as ( 
select * , 
case when TOTALSALES > 100 then 'High'
    when TOTALSALES > 80 then 'medium'
    else 'low'
 end customersegments
 from CTE_total_sales  
)

-- Main query
select c.customerid, firstname,lastname,cts.totalsales, clo.last_order_date , ccr.customerrank, ccs.customersegments
from customers c
left join CTE_total_sales cts on
cts.customerid = c.customerid
left join cte_last_order clo on
clo.customerid = c.customerid
left join cte_customer_rank ccr on ccr.customerid = c.customerid
left join cte_customer_segments ccs on ccs.customerid =  c.customerid;
-- Same in subquery
select *
from customers c
left join
(select customerid,sum(sales) as totalsales
from orders o
group by customerid ) cts 
on c.customerid = cts.customerid;

--- Nested CTE - CTE inside another CTE
-- A nested CTE uses the result of anoother CTE so it can't run independently.


