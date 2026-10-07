-- CTE`s (Common Table Expressions) :WITH keyword

with cte_example (gender,avg_salary,max_salary,min_salary,count_salary)as
	(
    select gender,avg(salary) ,max(salary) ,min(salary) , count(salary) 
    from parks_and_recreation.employee_demographics dem
    join parks_and_recreation.employee_salary as sal
		on dem.employee_id = sal.employee_id
	group by gender
    )
    
    select *
    from cte_example;
    
    
    -- joining two cte
    with cte_ex1 as
    (
    select employee_id,gender,birth_date
    from parks_and_recreation.employee_demographics
    where birth_date > '1985-01-01'
    ),
	cte_ex2 as
    (
    select employee_id,salary
    from parks_and_recreation.employee_salary
    where salary > 50000
    )
    select * 
    from cte_ex1
    join cte_ex2
		on cte_ex1.employee_id = cte_ex2.employee_id;
        
        
-- TEMPORARY TABLES

create temporary table	temp_table
(first_name varchar(50),
last_name varchar(50),
favorite_movie varchar(100)
);

select *
from temp_table;

insert into temp_table
values('Alex','Freberg','Lord of the Rings: The Two Towers');

select *
from temp_table;


create temporary table salary_over_50k
select * 
from parks_and_recreation.employee_salary
where salary >= 50000;

select *
from salary_over_50k;