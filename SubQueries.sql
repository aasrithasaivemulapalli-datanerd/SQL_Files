
-- Sub-Queries

/* Subquery in where clause */

-- Find products that have a price higher than the average price of all products

select productid,product, price 
from products
where price > (select avg(price) from products );

/* Subquery in IN Operator
-- Show the details of orders made by customers in Germany */

select * from orders
where customerid in (select customerid from customers
                     where country = 'Germany')
                     
-- Show the details of orders for customers who are not from Germany
select * from orders
where customerid not in (select customerid from customers
                          Where country = 'Germany')

                          
/* SubQuery in ANY operator
 * FIND female employees whose salaries are greater than the salaries of "any" male employees */

  select employeeid, firstname, salary
  from employees
  where gender = 'F'
  and salary > any 
  (select salary
  from employees
  where gender = 'M')

  
-- Correlated subqueries using Operator EXISTS
  
  -- Show details of orders made by the customers in Germany.
  
  select * 
  from orders o
  where exists
  (select * from customers c
  where country  = 'Germany' and o.customerid = c.customerid )
  
  