-- JOIN - allows you to join columns together
select employee_demographics 
from parks_and_recreation.employee_demographics;

select employee_salary 
from parks_and_recreation.employee_salary;

select dem.employee_id,age,occupation
from parks_and_recreation.employee_demographics as dem
inner join parks_and_recreation.employee_salary as sal
	on dem.employee_id = sal.employee_id;

-- OUTER JOINTS
select *
from parks_and_recreation.employee_demographics as dem
-- left join parks_and_recreation.employee_salary as sal
right join parks_and_recreation.employee_salary as sal
	on dem.employee_id = sal.employee_id;
    
-- SELF JOIN

select emp1.employee_id as emp_santa,
emp1.first_name as first_name_santa,
emp1.last_name as last_name_santa,
emp2.employee_id as emp_name,
emp2.first_name as first_name_emp,
emp2.last_name as last_name_emp

from parks_and_recreation.employee_salary emp1
join parks_and_recreation.employee_salary emp2
	on emp1.employee_id + 1 = emp2.employee_id;
    
--  JOINIGN MULTIPLE TABLES
select *
from parks_and_recreation.employee_demographics;

select*
from parks_and_recreation.employee_salary;

select *
from parks_and_recreation.parks_departments;

select *
from parks_and_recreation.employee_demographics as dem
join parks_and_recreation.employee_salary as sal
	on dem.employee_id = sal.employee_id
join parks_and_recreation.parks_departments as dept
	on sal.dept_id = dept.department_id;

-- UNION - Allows you to join rows together
select first_name,last_name
from parks_and_recreation.employee_demographics
-- union distinct
union all
select first_name,last_name
from parks_and_recreation.employee_salary;

-- UNION USE CASE
select first_name,last_name, 'Old Man' as Label
from parks_and_recreation.employee_demographics
where age >40 and gender = 'male' 
union
select first_name,last_name, 'Old Lady' as Label
from parks_and_recreation.employee_demographics
where age > 40 and gender = 'Female'
union
select first_name,last_name,'Highly Paid' as Label
from parks_and_recreation.employee_salary
where salary > 70000
order by first_name,last_name;