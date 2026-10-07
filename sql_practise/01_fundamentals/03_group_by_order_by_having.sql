-- Group by
 SELECT gender ,AVG(age),MAX(age),MIN(age),COUNT(age) 
 FROM parks_and_recreation.employee_demographics
 GROUP BY gender;
 
 SELECT occupation ,salary
 FROM parks_and_recreation.employee_salary
 GROUP BY occupation,salary;
 
 -- ORDER BY
 SELECT *
 FROM parks_and_recreation.employee_demographics
 -- ORDER BY first_name ASC;
 -- ORDER BY first_name DESC;
 -- ORDER BY gender,age DESC
 ORDER BY 5,4 DESC;
 
 -- Having vs Where
SELECT gender,AVG(age)
FROM parks_and_recreation.employee_demographics
group by gender
having avg(age) > 40;

select occupation,avg(salary)
from parks_and_recreation.employee_salary
where occupation like '%manager%'
group by occupation
having avg(salary)> 75000;

-- LIMIT AND ALIASING

select *
from parks_and_recreation.employee_demographics
order by age desc
-- limit 3
limit 2,1;

-- ALIASING 
select gender ,avg(age) as avg_age
from parks_and_recreation.employee_demographics
group by gender
having avg_age > 40;