-- EXISTs
select customerID
from customers c
where exists(
	select 1
    from customers x
    where x.customerID =c.customerID
    and x.OnlineSecurity = 'Yes'
);

select distinct c.customerID
from customers c
join customers x
 on x.customerID = c.customerID
where x.OnlineSecurity = 'Yes';

select c.customerID ,x.OnlineSecurity
from customers c
join customers x on x.customerID = c.customerID
limit 5;

select customerID
from customers c
where exists (
 select 1
 from customers x
 where x.customerID = c.customerID
	and x.OnlineSecurity ='Yes'
    );
    
-- Explain and indexes

explain select customerID from customers where Contract = 'Month-to-month';

create index idx_contract on customers (Contract);
explain select customerID from customers where Contract = 'Month-to-month';

-- coalesce : returns the first value that isn't null
select customerID ,
	coalesce(TotalCharges,MonthlyCharges * tenure, 0) as spend_estimate
    -- use TotalCharges if present, otherwise MonthlyCharges * tenure, otherwise 0
from customers
limit 5;

select OnlineSecurity, count(*) from customers group by OnlineSecurity;

select customerID,
	coalesce(OnlineSecurity,TechSupport,Null) as first_available
from customers
limit 5;

select customerID,
		coalesce(TotalCharges, 'unknown') as total_or_unknown
        from customers
        where TotalCharges is null;
 - -- COALESCE returns the first non-null value; fallbacks fire only on NULL, not on text such as 'No'.
        
-- with bucketed as (
--    select ntile(3) over (order by tenure) as bucket
--    from customers
--    )
-- select bucket,count(*) as customers
-- from bucketed
-- group by bucket
-- order by bucket;