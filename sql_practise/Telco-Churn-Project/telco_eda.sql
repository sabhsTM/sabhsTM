use telco_churn;

select * 
from customers;

select tenure, count(Contract)
from customers
group by tenure;

select tenure,count(*) as customers
from customers
where TotalCharges is null
group by tenure;

-- churn by contract type
select Contract,
count(*) as customers,
 sum(Churn = 'Yes') as Churned,
 round(avg(Churn = 'Yes')*100,1) as Churn_rate
from customers
group by Contract;

select max(tenure)
from customers;
-- Churn by tenure
select 
	case 
		when tenure <= 12 then '0-12 months'
		when tenure <= 24 then  '13-24 months'
		when tenure <= 36 then '24-36 months'
		when tenure <= 48 then '35-48 months'
		when tenure <= 60 then  '49-60 months'
		else '61-72 months'
	end as tenure_band,
    count(*) as customers,
   sum(Churn = 'Yes') as Churned,
   round(avg(Churn = 'Yes')*100,1) as Churn_pct
   from customers
   group by tenure_band 
   order by min(tenure);
 
 -- Churn by internet service
select internetService,
	sum(Churn ='Yes') as Churned,
	round(avg(Churn = 'Yes')*100,1) as Churned_pct
	from customers
	group by internetService;
        
 --  Churn by payment method
select paymentMethod,
	sum(Churn = 'Yes') as Churned,
	round(avg(Churn = 'Yes')*100,1) as Churned_pct
	from customers
    group by paymentMethod;
    
-- Revenue at risk

select round(sum(case when Churn = 'Yes' then MonthlyCharges else 0 end),2) as Churned_monthly_revenue,
		round(sum(MonthlyCharges),2) as Total_Monthly_revenue,
        round(sum(case when Churn = 'Yes' then MonthlyCharges else 0 end)
					/sum(MonthlyCharges)*100,1) as pct_of_revenue
		from customers;

    
-- Importance of Support Services

select TechSupport,
 sum(Churn ='Yes') as Churned,
 round(avg(Churn = 'Yes')*100,1) as Churn_pct
 from customers
 group by TechSupport;
 
 select OnlineSecurity,
 sum(Churn ='Yes') as Churned,
 round(avg(Churn = 'Yes')*100,1) as Churn_pct
 from customers
 group by OnlineSecurity;
 
 -- COntract with tenure band
 
 select Contract, 
		case
			when tenure <= 12 then '0-12 months'
            when tenure <= 24 then '13- 24 months'
            when tenure <= 36 then '25-36 months'
            when tenure <= 48 then '37-48 months'
            when tenure <= 60 then '49-60 months'
			else '61-72 months'
            end as tenure_band,
		count(*) as customers,
        sum(Churn = 'Yes') as Churned,
        round(avg(Churn = 'Yes')*100,2) as Churn_rate
        from customers
        group by Contract,tenure_band
        order by min(tenure_band);
        
select TechSupport,
count(*)  as customers,
sum(Churn = 'Yes') as Churned,
round(avg(Churn = 'Yes')*100,2) as churn_pct
from customers
where InternetService <> 'No'
group by TechSupport;

select InternetService,Contract,
count(*) as customers,
sum(Churn = 'Yes') as Churned,
round(avg(Churn = 'Yes')*100,2) as churn_cpt
from customers
group by InternetService,Contract;


select InternetService ,
	count(*) as customers,
	round(count(*) /sum(count(*)) over () *100, 1) as pct_of_customers,
	round(sum(MonthlyCharges),2) as monthly_charges,
	round(sum(MonthlyCharges)/sum(sum(MonthlyCharges)) over ()*100, 2) as monthly_revenue_pct,
	round(avg(MonthlyCharges),2) as avg_monthly_charges,
	round(sum(case when Churn ='Yes' then MonthlyCharges else 0 end),2) as churn_revenue
from customers
group by InternetService
order by monthly_charges desc;

-- Split fiber prices
-- Calculating the median

with RankedData as (
	select InternetService, MonthlyCharges,
    row_number() over(partition by InternetService order by MonthlyCharges) as row_num,
    count(*) over (partition by InternetService) as total_count
    from customers
 )
 select InternetService,
 avg(MonthlyCharges) as Monthly_charges_median
 from RankedData
 where
	row_num in (floor((total_count +1)/2), ceil((total_count + 1)/2)) 
group by InternetService;

with Ranked as (
    select 
	   InternetService ,
		MonthlyCharges,
		row_number() over (partition by InternetService order by MonthlyCharges) as row_num,
		count(*) over(partition by InternetService) as total_count
	from customers    
),Median as(
select InternetService ,
avg(MonthlyCharges) as Monthly_median
from Ranked
where row_num in (floor((total_count+ 1)/2) ,ceil((total_count+1)/2))
group by InternetService
) select Monthly_median as fiber_median
from Median
Where InternetService = 'Fiber optic' ;

-- cross-check table
select sum(MonthlyCharges < 91.675000) as below, sum(MonthlyCharges > 91.675000) as above
from customers
where InternetService = 'Fiber optic';

with banded as (
	select Churn,MonthlyCharges,
		ntile(2) over(order by MonthlyCharges) as price_half
	from customers
    where InternetService = 'Fiber optic'
)
select price_half,
	   count(*) as customers,
       min(MonthlyCharges) as min_charge,
       max(MonthlyCharges) as max_charge,
       sum(Churn = 'Yes') as churned,
       round(avg(Churn = 'Yes') * 100, 1) as churn_pct
from banded
group by price_half
order by price_half; 

-- Testng addons
select addons,
		count(*)as customers,
        sum(Churn = 'Yes') as churned,
        round(avg(Churn ='Yes')*100,1) as churn_pct
from(
		select Churn,
			(OnlineSecurity ='Yes') +(OnlineBackup ='Yes') +(DeviceProtection ='Yes')
            + (TechSupport ='Yes') +(StreamingTV ='Yes') + (StreamingMovies ='Yes') as addons
		from customers
        where InternetService = 'Fiber optic'
) x
group by addons
order by addons;


select DeviceProtection, count(*) from customers group by DeviceProtection;

with banded as (
	select Churn,Contract, MonthlyCharges,
		(OnlineSecurity= 'Yes')+ (OnlineBackup= 'Yes') + (DeviceProtection='Yes')
		+ (TechSupport ='Yes')+ (StreamingTV ='Yes')+ (StreamingMovies ='Yes') as addons,
		ntile(2) over (order by MonthlyCharges) as price_half
	from customers
    where InternetService = 'Fiber optic'
    )
    select price_half,
		count(*) as customers,
        round(avg(addons),2) as avg_addons,
        round(avg(Contract = 'Month-to-month')* 100,1) as month_to_month,
        round(avg(Churn ='Yes')*100,1) as churn_cpt
	from banded
    group by price_half
    order by price_half;
    
    select Contract,
		case
			 when addons <= 1 then '0-1'
             when addons <= 3 then '2-3'
             else '4-6' end as addon_band,
	count(*) as customers,
    sum(Churn = 'Yes') as churned,
    round(avg(Churn = 'Yes') * 100,1) as churn_pct

from (
	select Contract, Churn,
		(OnlineSecurity = 'Yes') +(OnlineBackup ='Yes') + (DeviceProtection ='Yes')
        + (TechSupport ='Yes') +(StreamingTV ='Yes') +(StreamingMovies ='Yes') as addons
	from customers
    where InternetService ='Fiber optic'
    
    )x
    group by Contract, addon_band
    order by Contract,min(addons);
    
with banded as  (
	select Churn, Contract, MonthlyCharges,
		ntile(2) over (order by MonthlyCharges) as price_half
    from customers
    where InternetService = 'Fiber optic'
)
 select Contract, price_half,
	count(*) as customers,
    sum(Churn = 'Yes') as churned,
    round(avg(Churn ='Yes')* 100, 1) as churn_pct
from banded
group by Contract,price_half
order by Contract, price_half;







        
            
    




    