-- 197 RISING TEMPERATURE
# Write your MySQL query statement below

-- The task, in short: 
-- you get a Weather table with id, recordDate and temperature.
--  Return the id of every day whose temperature was higher than the day before it. 
with higher_temp as
(
    select id ,temperature,recordDate ,
    lag(temperature) over(order by recordDate) as prev_temp,
    lag(recordDate) over (order by recordDate) as prev_date
    from weather
    
)

select id
from higher_temp
where  temperature > prev_temp
 and datediff(recordDate,prev_date) =1;
 
 --  181. Employees Earning More Than Their Managers

-- Write a solution to find the employees who earn more than their managers.
-- Return the result table in any order.
-- The result format is in the following example.
-- Example 1:

-- Input: 
-- Employee table:
-- +----+-------+--------+-----------+
-- | id | name  | salary | managerId |
-- +----+-------+--------+-----------+
-- | 1  | Joe   | 70000  | 3         |
-- | 2  | Henry | 80000  | 4         |
-- | 3  | Sam   | 60000  | Null      |
-- | 4  | Max   | 90000  | Null      |

select emp.name as Employee
from Employee emp
join Employee mgr
    on emp.managerId = mgr.id
where emp.salary > mgr.salary;

-- 182. Duplicate Emails
-- Write a solution to report all the duplicate emails.
--  Note that it's guaranteed that the email field is not NULL.
-- Return the result table in any order.
-- The result format is in the following example.
-- Example 1:

-- Input: 
-- Person table:
-- +----+---------+
-- | id | email   |
-- +----+---------+
-- | 1  | a@b.com |
-- | 2  | c@d.com |
-- | 3  | a@b.com |
-- +----+---------+
-- Output: 
-- +---------+
-- | Email   |
-- +---------+
-- | a@b.com |

select email
from Person  
group by email
having count(email) > 1;

create table Customer (id int,name varchar(255));
create table Orders (id int, CustomerId int);

insert into Customer values (1,'Joe'),(2,'Henry'),(3,'Sam'),(4,'Max');
insert into  Orders values(1,3),(2,1) ;


-- 183 Customers Who Never Order 
-- Write a solution to find all customers who never order anything.
-- Return the result table in any order.
-- The result format is in the following example.
-- Example 1:
-- Input: 
-- Customers table:
-- +----+-------+
-- | id | name  |
-- +----+-------+
-- | 1  | Joe   |
-- | 2  | Henry |
-- | 3  | Sam   |
-- | 4  | Max   |
-- +----+-------+
-- Orders table:
-- +----+------------+
-- | id | customerId |
-- +----+------------+
-- | 1  | 3          |
-- | 2  | 1          |
-- +----+------------+

-- Using  a Subquery
select cust.name as Customers
from Customers cust
where cust.id  not in 
( select CustomerId
    from Orders);
    
-- Using A left Join
select cust.name as Customers
from Customers cust
left join Orders ords
	on cust.id = ords.customerId
where ords.customerId is null;

-- 584. Find Customer Referee
-- Find the names of the customer that are either:
-- referred by any customer with id != 2.
-- not referred by any customer.
-- Return the result table in any order.
-- The result format is in the following example.
-- Example 1:
-- Input: 
-- Customer table:
-- +----+------+------------+
-- | id | name | referee_id |
-- +----+------+------------+
-- | 1  | Will | null       |
-- | 2  | Jane | null       |
-- | 3  | Alex | 2          |
-- | 4  | Bill | null       |
-- | 5  | Zack | 1          |
-- | 6  | Mark | 2          |
-- +----+------+------------+
-- Output: 
-- +------+
-- | name |
-- +------+
-- | Will |
-- | Jane |
-- | Bill |
-- | Zack |
-- +------+

-- 1st Approach using the is null ,or
select name
from Customers 
where referee_id is null
	or referee_id !=2;
    
-- 2nd Approach using ifnull 
select name
from Customers
where ifnull(referee_id,0) != 2
