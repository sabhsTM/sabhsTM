-- SUBQUERIES :Query wthin  a query
select *
from parks_and_recreation.employee_demographics
where employee_id in 
					(select employee_id
                    from parks_and_recreation.employee_salary
                    where dept_id = 1
                    );
                    
select first_name,salary,
(SELECT avg(salary) 
from parks_and_recreation.employee_salary
) as avg_salary
from parks_and_recreation.employee_salary;


select gender, avg(age), max(age),min(age),count(age)
from parks_and_recreation.employee_demographics
group by gender; 

select avg(`max(age)`)
from(
	select gender, avg(age), max(age),min(age),count(age)
	from parks_and_recreation.employee_demographics
	group by gender
	) as agg_table;
    
-- WINDOW FUNCTION
-- Native  
select gender, avg(salary) as avg_sal
from parks_and_recreation.employee_demographics dem
join parks_and_recreation.employee_salary sal
	on dem.employee_id = sal.employee_id
group by gender;

-- window function
select dem.first_name,dem.last_name,gender, avg(salary) over(partition by gender)
from parks_and_recreation.employee_demographics dem
join parks_and_recreation.employee_salary sal
	on dem.employee_id = sal.employee_id;
    
select dem.first_name,dem.last_name,gender,
 sum(salary) over(partition by gender)
from parks_and_recreation.employee_demographics dem
join parks_and_recreation.employee_salary sal
	on dem.employee_id = sal.employee_id;
    
select dem.first_name,dem.last_name,gender,salary,
 sum(salary) over(partition by gender order by dem.employee_id) as Rolling_Total
from parks_and_recreation.employee_demographics dem
join parks_and_recreation.employee_salary sal
	on dem.employee_id = sal.employee_id;
    
select dem.employee_id,dem.first_name,dem.last_name,gender,salary,
 row_number() over(partition by gender order by salary desc) as row_num,
 dense_rank() over(partition by gender order by salary desc) as rank_num,
 rank() over(partition by gender order by salary desc) as rank_num
from parks_and_recreation.employee_demographics dem
join parks_and_recreation.employee_salary sal
	on dem.employee_id = sal.employee_id;
    