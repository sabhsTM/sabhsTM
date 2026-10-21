 -- 185. Department Top Three Salaries-- 
-- A company's executives are interested in seeing who earns the most money in each of the company's departments. A high earner in a department is an employee who has a salary in the top three unique salaries for that department.
-- Write a solution to find the employees who are high earners in each of the departments.
-- Return the result table in any order.
-- The result format is in the following example.
-- Example 1:
-- Input: 
-- Employee table:
-- +----+-------+--------+--------------+
-- | id | name  | salary | departmentId |
-- +----+-------+--------+--------------+
-- | 1  | Joe   | 85000  | 1            |
-- | 2  | Henry | 80000  | 2            |
-- | 3  | Sam   | 60000  | 2            |
-- | 4  | Max   | 90000  | 1            |
-- | 5  | Janet | 69000  | 1            |
-- | 6  | Randy | 85000  | 1            |
-- | 7  | Will  | 70000  | 1            |
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
-- | IT         | Max      | 90000  |
-- | IT         | Joe      | 85000  |
-- | IT         | Randy    | 85000  |
-- | IT         | Will     | 70000  |
-- | Sales      | Henry    | 80000  |
-- | Sales      | Sam      | 60000  |
-- +------------+---------
-- 	

with rank_sal as
(
  select dept.name as Department,
		 emp.name as Employee,
         emp.salary as Salary,
	dense_rank() over (partition by emp.departmentId order by emp.salary desc)  as ranked_num
    from Employee emp
    join Department dept 
		on emp.departmentId = dept.id
	)
select Department,employee,Salary
from rank_sal
where ranked_num <= 3;

-- SUBQUERY 
  select dept.name as Department,
           emp1.name as Employee,
           emp1.salary as Salary
    from Employee emp1
    join Department dept
        on emp1.departmentId = dept.id
where (
	select count(distinct emp2.salary)
    from Employee emp2
    where emp2.departmentId = emp1.departmentId and
    emp2.salary >emp1.salary
) < 3;


-- 601.Human Traffic of Stadium

with filtered as (
    select id, visit_date, people,
           id - row_number() over (order by id) as grp
    from Stadium
    where people >= 100
),
sized as (
    select *,
           count(*) over (partition by grp) as cnt
    from filtered
)
select id, visit_date, people
from sized
where cnt >= 3
order by visit_date;


-- 262 Trips and Users

select t.request_at as Day,
	round(avg(status != 'completed'),2) as 'Cancellation Rate'
 from Trips t
 join Users c
	on t.client_id = c.users_id
join Users d
	on t.drivers_id = d.users_id
where c.banned = 'No'
 and  d.banned = 'No'
 and t.request  between '2013-10-01' and '2013-10-03'
group by t.request_at
order by Day asc;

-- APPROACH 2 using case
select t.request_at as Day,
    round(
        sum(case when t.status != 'completed' then 1 else 0 end)/count(*),2
        ) as 'Cancellation Rate'
from Trips t
join Users c
    on t.client_id = c.users_id
join Users d
    on t.driver_id = d.users_id
where c.banned = 'No'
 and d.banned = 'No'
 and t.request_at between '2013-10-01' and '2013-10-03'
 group by t.request_at
 order by Day asc
