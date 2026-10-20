
-- Survival by class and sex together

select Pclass, Sex,
		count(*) as passengers,
        sum(Survived) as survivors,
        round(avg(Survived) *100,1) as survival_pct
from train
group by Pclass,sex
order by Pclass,sex desc;

select case 
	 when Age is null then 'Uknown'
     when Age  < 12 then 'Child'
     when Age < 20 then 'Teen'
     when  Age < 40 then 'Adult'
     when Age < 60 then 'Middle-aged'
     else 'Senior'
	end as age_group,
    count(*) as passengers,
    round(avg(Survived) * 100,1) as survival_pct

from train
group by age_group 
order by min(Age);

-- Missing-Value report

select count(*) - count(Age) as missing_age,
	   count(*) - count(Cabin) as missing_cabin,
       count(*) - count(Embarked) as missing_embarked
from train;

-- TOP 3 FARES
with ranked as (
	select Pclass,Name, Fare, 
         dense_rank() over (partition by Pclass order by Fare desc) as rnk
	from train
)
select Pclass,Name,Fare,rnk
from ranked
where rnk <= 3
order by Pclass ,rnk;

-- EACH FARE AGAINST ITS CLASS AVERAGE
select PassengerId,Pclass, Fare,
		round(avg(Fare) over(partition by Pclass), 2) as class_avg_fare,
        round(Fare -avg(Fare) over (partition by Pclass),2) as diff_from_avg
from train
order by diff_from_avg desc
limit 10;

-- oddities
select count(*) as zero_fares from train where Fare = 0;
select Name, count(*) as n from train group by Name having count(*)>1;

select * 
from train;

with five_oldest_survivors as (
		select Name, Age, Survived,
        dense_rank() over (order by Age desc)as rnk
       from train  
       where Survived = 1  
  )
  select Name, Age
  from five_oldest_survivors
  where rnk <= 5
  order by Age desc
  
  limit 5;
  
  -- Simpler Version
  select Name, Age
  from train
  where Survived = 1
  order by Age desc
  limit 5;
  
  -- Survival by family size
  select SibSp + Parch +1 as family_size,
		count(*) as passengers,
        round(avg(Survived) *100,1) as survival_pct
  from train
  group by family_size
  order by family_size;
  
  -- Survival by port of embarkation and class
  
  select Embarked,
	count(*) as passengers,
    round(avg(Pclass = 1) * 100,1) as pct_first_cls,
    round(avg(Survived) * 100,1)  as survival_pct
 from train
 where Embarked is not null
 group by Embarked
 order by Embarked;
 
 
 select Pclass, Embarked,
		count(*) as passengers,
        round(avg(Survived) * 100,1) as survival_pct
from train
where Embarked is not null
group by Pclass, Embarked
order by Pclass,Embarked;


-- Survival rate by class,port and Sex
select Pclass,Embarked,Sex,
		count(*) as passengers,
        round(avg(Survived) * 100,1) as survival_pct
from train
where Embarked is not null
group by Pclass,Embarked,Sex
order by Pclass,Embarked,Sex;


-- Third-class women: survival by port and family type
select Embarked,
		case
			when SibSp + Parch = 0 then 'alone'
			when SibSp + Parch <= 3 then 'small family'
			else 'large family'
		end as family_type,
		count(*) passenger,
		round(avg(Survived)* 100,1) as survival_pct
from train
where Pclass = 3 and Sex = 'female'  and Embarked is not null
group by Embarked,family_type
order by Embarked,family_type;