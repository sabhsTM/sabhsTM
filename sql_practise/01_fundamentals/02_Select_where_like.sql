SELECT *
FROM parks_and_recreation.employee_demographics;

SELECT first_name,
	   last_name,
       birth_date,
       age,
       (age + 10)* 10 + 10
       #PEMDAS : Parenthesis,Exponent,Multiplication,Dvision,Addition,Subtraction
FROM parks_and_recreation.employee_demographics;

SELECT DISTINCT gender
FROM parks_and_recreation.employee_demographics;

-- WHERE Clause
SELECT *
FROM parks_and_recreation.employee_salary
-- WHERE first_name = 'Leslie'; 
WHERE salary >= 50000;

SELECT *
FROM parks_and_recreation.employee_demographics
-- WHERE gender != 'Female';
WHERE birth_date > '1985-05-16';

-- LOGICAL OPERATORS
 -- AND OR NOT
 SELECT *
FROM parks_and_recreation.employee_demographics
-- WHERE gender != 'Female';
WHERE birth_date > '1985-05-16'
AND  gender = 'Female';


 SELECT *
FROM parks_and_recreation.employee_demographics
-- WHERE gender != 'Female';
WHERE birth_date > '1985-05-16'
OR  gender = 'Male';

 SELECT *
FROM parks_and_recreation.employee_demographics
-- WHERE gender != 'Female';
WHERE birth_date > '1985-05-16'
AND  gender = 'Female';

 SELECT *
FROM parks_and_recreation.employee_demographics
-- WHERE gender != 'Female';
WHERE birth_date > '1985-05-16'
OR NOT  gender = 'Female';

 SELECT *
FROM parks_and_recreation.employee_demographics
WHERE (first_name ='Leslie' AND age =44) OR age > 55;

--  LIKE STATEMENT
SELECT *
FROM parks_and_recreation.employee_demographics
-- WHERE first_name LIKE 'Jer%'
-- WHERE first_name LIKE '%er%'
-- WHERE first_name LIKE 'a%'-- starting with a

-- WHERE first_name LIKE 'a__' -- number of underscores denote the number of characters coming after the a 

-- WHERE first_name LIKE 'a__%';
WHERE birth_date LIKE '1989%';





 