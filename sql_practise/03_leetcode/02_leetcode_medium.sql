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