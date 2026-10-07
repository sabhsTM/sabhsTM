-- STRING FUNCTIONS

select first_name,length(first_name)
from parks_and_recreation.employee_demographics
order by 2;

select first_name,upper(first_name)
from parks_and_recreation.employee_demographics;

select trim('	Sabhs	');
select rtrim('	Sabhs	');
select ltrim('	Sabhs	');

select first_name,
left(first_name,4),
right(last_name,4),
substring(first_name,3,2),
birth_date,
substring(birth_date,6,5) as birth_date
from parks_and_recreation.employee_demographics;

select first_name, replace(first_name, 'a','z')
from parks_and_recreation.employee_demographics;

select locate('x','Alexander');

select first_name, locate('An',first_name)
from parks_and_recreation.employee_demographics;

select first_name, last_name,
concat(first_name,' ',last_name)
from parks_and_recreation.employee_demographics;

-- CASE STATEMENTS
select first_name,
last_name,
age,
case
	when age < 50 then 'Young'
    when age between 31 and 50 then 'Old'
    when age >= 50 then 'On Your 60`s Journey' 
end as Age_bracket
from parks_and_recreation.employee_demographics; 

-- CASE 2
select first_name,
last_name,
salary,
case 
	when salary < 50000  then salary * 1.05
    when salary > 50000  then salary * 1.07
end as New_salary,
case
	when dept_id = 6 then salary * .10
end as bonus
from parks_and_recreation.employee_salary;
