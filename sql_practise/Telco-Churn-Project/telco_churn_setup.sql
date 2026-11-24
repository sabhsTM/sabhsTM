-- Telco customer churn: setup
-- Source: Kaggle "Telco Customer Churn" (WA_Fn-UseC_-Telco-Customer-Churn.csv)
-- 7,043 customers, 21 columns

create database if not exists telco_churn;
use telco_churn;


drop table if exists Customers;
create table Customers(
	customerID varchar(20) primary key,
    gender varchar(10),
    SeniorCitizen tinyint,
    Partner varchar(3),
    Dependents varchar(3),
    tenure int,
    PhoneService varchar(3),
    MultipleLines varchar(20),
    InternetService varchar(15),
    OnlineSecurity varchar(25),
    OnlineBackup varchar(25),
    DeviceProtection varchar(25),
    TechSupport varchar(25),
    StreamingTV varchar(25),
    StreamingMovies varchar(25),
    Contract varchar(20),
    PaperlessBilling varchar(3),
    PaymentMethod varchar(30),
    MonthlyCharges decimal(8,2),
    TotalCharges varchar(15),  -- text on purpose: 11 rows are blank
    Churn varchar(3)
    
);

-- IMPORT (not SQL): right-click customers > Table Data Import Wizard >
-- Use existing table. Check every CSV column maps to the same-named column.
use telco_churn;
describe customers;
select count(*) from customers;


-- Checks before cleaning
select count(*) as blank_total_charges
from customers
where trim(TotalCharges) = '';

select length(TotalCharges) as len, hex(TotalCharges)
from customers
where trim(TotalCharges) =''
group by length(TotalCharges), hex(TotalCharges);

select tenure,count(*)
 from customers
 where trim(TotalCharges)=''
 group by tenure;

-- Cleaning
use telco_churn;

select
	 
     sum(customerID is null or trim(customerID) = '') as CustomerID,
     sum(TotalCharges is null or trim(TotalCharges) ='') as TotalCharges
from customers;

set sql_safe_updates = 0;
update customers set TotalCharges = null where trim(TotalCharges) = '';

select 
	sum(TotalCharges is null or  trim(TotalCharges) = '') as TotalCharges
from customers;

select count(*) as total,
       count(TotalCharges) as tc_filled,
       sum(TotalCharges is null) as tc_null
from customers;

alter table customers modify TotalCharges decimal(10,2);

select count(*) as total,
		count(TotalCharges) as tc_filled,
        sum(TotalCharges is null) as tc_null,
        min(TotalCharges) as min_tc,
        max(TotalCharges) as max_tc
	from customers;
        

describe customers;



describe  customers;




