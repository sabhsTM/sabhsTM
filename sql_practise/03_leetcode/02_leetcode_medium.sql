-- 176. Second Highest Salary
-- Write a solution to find the second highest distinct salary from the Employee table. If there is no second highest salary, return null (return None in Pandas).
-- The result format is in the following example.
-- Example 1:
-- Input: 
-- Employee table:
-- +----+--------+
-- | id | salary |
-- +----+--------+
-- | 1  | 100    |
-- | 2  | 200    |
-- | 3  | 300    |
-- +----+--------+
-- Output: 
-- +---------------------+
-- | SecondHighestSalary |
-- +---------------------+
-- | 200                 |
-- +---------------------+
-- Example 2:

-- Input: 
-- Employee table:
-- +----+--------+
-- | id | salary |
-- +----+--------+
-- | 1  | 100    |-- 
 
 with ranked_salary as
 (
 select salary,
	dense_rank() over(order by salary desc) as rank_num
    from Employee
 )
 select max(salary) as SecondHighestSalary
 from ranked_salary
 where rank_num = 2;
 
 -- USING THE FROM SUBQUERY (DERIVED TABLE)
 select max(salary) as SecondHighestSalary
 from
 (
 select salary,
	dense_rank() over(order by salary desc) as rank_num
from employee
)ranked
where rank_num = 2;

-- Using LIMIT AND OFFSET
select
(
select distinct salary
from Employee
order by salary
limit 1 offset 1 
) as SecondHighestSalary;

-- USING MAX
select max(salary) as SecondHighestSalary 
from Employee
 where salary < (select max(salary) from Employee);
 
 
-- 177. Nth Highest Salary
-- Write a solution to find the nth highest distinct salary from the Employee table. If there are less than n distinct salaries, return null.
-- The result format is in the following example.
-- Example 1:
-- Input: 
-- Employee table:
-- +----+--------+
-- | id | salary |
-- +----+--------+
-- | 1  | 100    |
-- | 2  | 200    |
-- | 3  | 300    |
-- +----+--------+
-- n = 2
-- Output: 
-- +------------------------+
-- | getNthHighestSalary(2) |
-- +------------------------+
-- | 200                    |
-- +------------------------+
-- Example 2:

-- Input: 
-- Employee table:
-- +----+--------+
-- | id | salary |
-- +----+--------+
-- | 1  | 100    |
-- +----+--------+
-- n = 2
-- Output: 
-- +------------------------+
-- | getNthHighestSalary(2) |
-- +------------------------+
-- | null                   |
-- +------------------------+

create function getNthHighestSalary(N int)
returns int
begin
	return(
    with n_th as (
    select distinct salary ,
		dense_rank() over (order by salary desc) as rank_num
	from Employee
    )
    select salary 
    from n_th
    where rank_num = N
	);
    end;
    
    -- using LIMIT & OFFSET
    select
    (
    select distinct salary 
    from Employee
    order by salary 
    limit 1 offset 1
    ) as N ;
  
--   178. Rank Scores
-- Write a solution to find the rank of the scores. The ranking should be calculated according to the following rules:
-- The scores should be ranked from the highest to the lowest.
-- If there is a tie between two scores, both should have the same ranking.
-- After a tie, the next ranking number should be the next consecutive integer value. In other words, there should be no holes between ranks.
-- Return the result table ordered by score in descending order.
-- The result format is in the following example.
-- Example 1:
-- Input: 
-- Scores table:
-- +----+-------+
-- | id | score |
-- +----+-------+
-- | 1  | 3.50  |
-- | 2  | 3.65  |
-- | 3  | 4.00  |
-- | 4  | 3.85  |
-- | 5  | 4.00  |
-- | 6  | 3.65  |
-- +----+-------+
-- Output: 
-- +-------+------+
-- | score | rank |
-- +-------+------+
-- | 4.00  | 1    |
-- | 4.00  | 1    |
-- | 3.85  | 2    |
-- | 3.65  | 3    |
-- | 3.65  | 3    |
-- | 3.50  | 4    |
-- +-------+------+

select score ,
	dense_rank() over(order by score desc) as `rank`
	from Scores
order by score desc;

-- 180. Consecutive Numbers
-- Find all numbers that appear at least three times consecutively.
-- Return the result table in any order.
-- The result format is in the following example.
-- Example 1:
-- Input: 
-- Logs table:
-- +----+-----+
-- | id | num |
-- +----+-----+
-- | 1  | 1   |
-- | 2  | 1   |
-- | 3  | 1   |
-- | 4  | 2   |
-- | 5  | 1   |
-- | 6  | 2   |
-- | 7  | 2   |
-- +----+-----+
-- Output: 
-- +-----------------+
-- | ConsecutiveNums |
-- +-----------------+
-- | 1               |
-- +-----------------+
-- Explanation: 1 is the only number that appears consecutively for at least three times.

-- USING LAG
with num_checker as (
select num,
 lag(num,1) over (order by id ) as prev1,
 lag(num,2)  over (order by id) as prev2
 from Logs
)
select distinct num as ConsecutiveNums
from num_checker 
where num = prev1 and num = prev2;


-- USING JOIN
select distinct .num as ConsecutiveNumbers
from Logs l1
join Logs l2
 on l2.id = l1.id +1
join Logs l3
 on l3.id = l1.id + 2
where l1.num = l2.num and l1.num = l3.num ;


-- 184. Department Highest Salary
-- Write a solution to find employees who have the highest salary in each of the departments.
-- Return the result table in any order.
-- The result format is in the following example.
-- Example 1:
-- Input: 
-- Employee table:
-- +----+-------+--------+--------------+
-- | id | name  | salary | departmentId |
-- +----+-------+--------+--------------+
-- | 1  | Joe   | 70000  | 1            |
-- | 2  | Jim   | 90000  | 1            |
-- | 3  | Henry | 80000  | 2            |
-- | 4  | Sam   | 60000  | 2            |
-- | 5  | Max   | 90000  | 1            |
-- +----+-------+--------+--------------+
-- Department table:
-- +----+-------+
-- | id | name  |
-- +----+-------+
-- | 1  | IT    |
-- | 2  | Sales |
-- +----+-------+
-- Output: 
-- +------------+----------+--------+
-- | Department | Employee | Salary |
-- +------------+----------+--------+
-- | IT         | Jim      | 90000  |
-- | Sales      | Henry    | 80000  |
-- | IT         | Max      | 90000  |
-- +------------+----------+--------+
-- Explanation: Max and Jim both have the highest salary in the IT department and Henry has the highest salary in the Sales department.-- USING A CTE
with sal_ranked as
( select dept.name as Department,
		 emp.name as Employee,
         emp.salary as Salary,
  dense_rank() over(partition by emp.departmentId order by emp.salary desc) as rank_num
  from Employee emp
  join Department dept
	on emp.departmentId = dept.id
)
select Department,Employee,Salary
from sal_ranked 
where rank_num = 1;

-- USING A max(),group by & IN
select dept.name as Department,
		emp.name as Employee,
        emp.salary as Salary 
  From Employee emp
  join Department dept
	on emp.departmentId = dept.id
where (emp.departmentId ,emp.salary) in (select departmentId,max(Salary)
 from employee
 group by departmentId);
 


-- 550. Game Play Analysis IV
-- Write a solution to report the fraction of players that logged in again on the day after the day they first logged in, rounded to 2 decimal places. In other words, you need to determine the number of players who logged in on the day immediately following their initial login, and divide it by the number of total players.
-- The result format is in the following example.
-- Example 1:
-- Input: 
-- Activity table:
-- +-----------+-----------+------------+--------------+
-- | player_id | device_id | event_date | games_played |
-- +-----------+-----------+------------+--------------+
-- | 1         | 2         | 2016-03-01 | 5            |
-- | 1         | 2         | 2016-03-02 | 6            |
-- | 2         | 3         | 2017-06-25 | 1            |
-- | 3         | 1         | 2016-03-02 | 0            |
-- | 3         | 4         | 2018-07-03 | 5            |
-- +-----------+-----------+------------+--------------+
-- Output: 
-- +-----------+
-- | fraction  |
-- +-----------+
-- | 0.33      |
-- +-----------+
-- Explanation: 
-- Only the player with id 1 logged back in after the first day he had logged in so the answer is 1/3 = 0.33

-- First Approach
with first_login as(
select player_id, min(event_date) as first_date
from Activity
group by player_id
)

select round (
	count(a.player_id) / count(f.player_id),2
) as fraction

from first_login f
left join Activity a
	on  a.player_id = f.player_id
    and a.event_date = date_add(f.first_date, interval 1 day);
    
-- USING CTE
with ranked as (
 select player_id,event_date ,
 row_number() over (partition by player_id order by event_date) as rn,
 lead(event_date) over(partition by player_id order by event_date) as next_event
 from Activity
)

select round(
count(case when datediff(next_event, event_date)= 1 then 1 end)/ count(*) ,2
)as fraction
from ranked
where rn = 1;

-- 570. Managers with at Least 5 Direct Reports

-- Write a solution to find managers with at least five direct reports.
-- Return the result table in any order.
-- The result format is in the following example.
-- Example 1:
-- Input: 
-- Employee table:
-- +-----+-------+------------+-----------+
-- | id  | name  | department | managerId |
-- +-----+-------+------------+-----------+
-- | 101 | John  | A          | null      |
-- | 102 | Dan   | A          | 101       |
-- | 103 | James | A          | 101       |
-- | 104 | Amy   | A          | 101       |
-- | 105 | Anne  | A          | 101       |
-- | 106 | Ron   | B          | 101       |
-- +-----+-------+------------+-----------+
-- Output: 
-- +------+
-- | name |
-- +------+
-- | John |
-- +------+
select e.name 
from Employee e
join(
select managerId 
from Employee 
group by managerId
having count(*) >= 5
) m
	on e.id = m.managerId;
    
-- using a CTE

with big_managers as (
select managerId 
from Employee 
group by managerId
having count(*)>= 5
)

select e.name
from employee e
join big_managers b
	on e.id = b.managerId ;
 
 -- inner join 
select mgr.name
from Employee emp
join Employee mgr 
    on emp.managerId = mgr.id
group by mgr.id
having count(*) >= 5;

-- 1321. Restaurant Growth
-- You are the restaurant owner and you want to analyze a possible expansion (there will be at least one customer every day).
-- Compute the moving average of how much the customer paid in a seven days window (i.e., current day + 6 days before). average_amount should be rounded to two decimal places.
-- Return the result table ordered by visited_on in ascending order.
-- The result format is in the following example.
-- Example 1:
-- Input: 
-- Customer table:
-- +-------------+--------------+--------------+-------------+
-- | customer_id | name         | visited_on   | amount      |
-- +-------------+--------------+--------------+-------------+
-- | 1           | Jhon         | 2019-01-01   | 100         |
-- | 2           | Daniel       | 2019-01-02   | 110         |
-- | 3           | Jade         | 2019-01-03   | 120         |
-- | 4           | Khaled       | 2019-01-04   | 130         |
-- | 5           | Winston      | 2019-01-05   | 110         | 
-- | 6           | Elvis        | 2019-01-06   | 140         | 
-- | 7           | Anna         | 2019-01-07   | 150         |
-- | 8           | Maria        | 2019-01-08   | 80          |
-- | 9           | Jaze         | 2019-01-09   | 110         | 
-- | 1           | Jhon         | 2019-01-10   | 130         | 
-- | 3           | Jade         | 2019-01-10   | 150         | 
-- +-------------+--------------+--------------+-------------+
-- Output: 
-- +--------------+--------------+----------------+
-- | visited_on   | amount       | average_amount |
-- +--------------+--------------+----------------+
-- | 2019-01-07   | 860          | 122.86         |
-- | 2019-01-08   | 840          | 120            |
-- | 2019-01-09   | 840          | 120            |
-- | 2019-01-10   | 1000         | 142.86         |
-- +--------------+--------------+----------------+
-- Explanation: 
-- 1st moving average from 2019-01-01 to 2019-01-07 has an average_amount of (100 + 110 + 120 + 130 + 110 + 140 + 150)/7 = 122.86
-- 2nd moving average from 2019-01-02 to 2019-01-08 has an average_amount of (110 + 120 + 130 + 110 + 140 + 150 + 80)/7 = 120
-- 3rd moving average from 2019-01-03 to 2019-01-09 has an average_amount of (120 + 130 + 110 + 140 + 150 + 80 + 110)/7 = 120
-- 4th moving average from 2019-01-04 to 2019-01-10 has an average_amount of (130 + 110 + 140 + 150 + 80 + 110 + 130 + 150)/7 = 142.86
with daily_sum as (
select sum(amount) as amount,visited_on
from Customer
group by visited_on
),
windowed as (
	select  visited_on,
    sum(amount) over( order by visited_on rows between 6 preceding and current row ) as amount,
    round(avg(amount) over( order by visited_on rows between 6 preceding and current row),2 )as average_amount
    from daily_sum
    )
select visited_on,amount, average_amount
from windowed
where visited_on >=( select min(visited_on) + interval 6 day from daily_sum)
order by visited_on;

-- 1164 Product Price at a Given Date.
-- Initially, all products have price 10.
-- Write a solution to find the prices of all products on the date 2019-08-16.
-- Return the result table in any order.
-- The result format is in the following example.
-- Example 1:
-- Input: 
-- Products table:
-- +------------+-----------+-------------+
-- | product_id | new_price | change_date |
-- +------------+-----------+-------------+
-- | 1          | 20        | 2019-08-14  |
-- | 2          | 50        | 2019-08-14  |
-- | 1          | 30        | 2019-08-15  |
-- | 1          | 35        | 2019-08-16  |
-- | 2          | 65        | 2019-08-17  |
-- | 3          | 20        | 2019-08-18  |
-- +------------+-----------+-------------+
-- Output: 
-- +------------+-------+
-- | product_id | price |
-- +------------+-------+
-- | 2          | 50    |
-- | 1          | 35    |
-- | 3          | 10    |
-- +------------+-------+

with all_products as (
	select distinct product_Id
    from products
),
 latest as (
	select product_id,new_price,
    row_number() over(partition by product_id order by change_date desc) as rn
    from Products
    where change_date <= '2019-08-16'
 )
 
 select p.product_id ,
	ifnull(l.new_price,10) as price
from all_products p
left join latest l
 on l.product_id = p.product_id
and l.rn = 1;




