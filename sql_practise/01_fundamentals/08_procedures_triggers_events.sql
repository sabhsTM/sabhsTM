--  STORED PROCEDURES

create procedure large_salaries()
select * 
from parks_and_recreation.employee_salary
where salary >= 50000;

call large_salaries();

delimiter $$
create procedure large_salaries2()
begin
	select *
	from parks_and_recreation.employee_salary
	where salary >=50000 ;
	select *
	from parks_and_recreation.employee_salary
	where salary >= 70000;
end $$
delimiter ;
call large_salaries2()

-- PARAMETERS IN PROCEDURES

delimiter $$
create procedure large_salaries4(p_employee_id int)
begin
	select salary
	from employee_salary 
	where employee_id = p_employee_id;
end $$
delimiter ;

call large_salaries4(1);

-- Triggers and Events
-- Trigger are block of code that executes automatically when an event takes place in a specific table  

delimiter $$
create trigger employee_insert
	after insert on employee_salary
    for each row
begin
	insert into employee_demographics (employee_id,first_name,last_name)
    values (new.employee_id,new.first_name,new.last_name);
end $$
delimiter ;


insert into employee_salary(employee_id,first_name,last_name,occupation,salary,dept_id)
values(13,'Jean_Ralphio','Saperstein','Entertainment 720 CEO',13000000,null) ;

select *
from employee_salary;

select *
from employee_demographics;

-- EVENTS - takes place when scheduled .. it's a schedule automator

delimiter $$
create event delete_retiree
on schedule every 30 second
do 
begin 
	delete 
    from employee_demographics
    where age >= 60;
end $$
delimiter ;

show variables like 'event%'
-- 