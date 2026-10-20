-- create database if not exists titanic_projects;
-- use titanic_projects;

-- create table train (
-- PassengerId int primary key,
-- Survived tinyint ,
-- Pclass tinyint,
-- Name varchar(150),
-- Sex varchar(10),
-- Age varchar(10),
-- SibSp tinyint,
-- Parch tinyint,
-- Ticket varchar(30),
-- Fare decimal(10,4),
-- Cabin varchar(20),
-- Embarked varchar(5)
-- );

-- CSV import happens through the Table Data Import Wizard 
select count(*) from train;

set sql_safe_updates = 0;
update train set Age = null where trim(Age) = '';
update train set Cabin = null where trim(Cabin) = '';
update train set Embarked = null where trim(Embarked) = '';

select PassengerId,Age from train where Age like  '0.%';
alter table train modify Age decimal(5,2);

select 
	count(*) as total,
    count(Age) as age_filled,
    sum(Cabin is null)  as cabin_null,
    sum(Cabin = '') as cabin_blank,
    sum(Embarked is null) as embarked_null,
    sum(Embarked = '') as embarked_blank
from train;


    
  
