drop table world_layoffs.layoffs;

CREATE TABLE world_layoffs.layoffs (
    company VARCHAR(255),
    location VARCHAR(255),
    industry VARCHAR(255),
    total_laid_off INT NULL,
    percentage_laid_off DECIMAL(5,4) NULL,
    `date` DATE NULL,
    stage VARCHAR(100),
    country VARCHAR(100),
    funds_raised_millions DECIMAL(10,2) NULL
);

select *
from world_layoffs.layoffs;

-- 1. Removing Duplicates
-- 2 . Standardize the data
-- 3. Null Values or blank values
-- 4. Remove any columns

create table layoffs_staging
like layoffs;

select*
from layoffs_staging;

insert layoffs_staging
select *
from layoffs;

with duplicate_cte as
(
select *,
row_number() over(
partition by company,location,
industry, total_laid_off,percentage_laid_off,`date`,stage,
country,funds_raised_millions) as row_num
from layoffs_staging
)
 select * 
 from duplicate_cte
 -- where row_num > 1-- 
 where company ='Casper';
 
 
 
 
 
 
 
 CREATE TABLE `layoffs_staging2` (
  `company` varchar(255) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `industry` varchar(255) DEFAULT NULL,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` decimal(5,4) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `stage` varchar(100) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `funds_raised_millions` decimal(10,2) DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select *
from layoffs_staging2
where row_num > 1;

insert into layoffs_staging2
select *,
row_number() over(
partition by company,location,
industry, total_laid_off,percentage_laid_off,`date`,stage,
country,funds_raised_millions) as row_num
from layoffs_staging;

delete  
from layoffs_staging2
where row_num > 1;

select *
from layoffs_staging2;

--  Standardizing data -finding issues in your data and fixing them

select  company ,trim(company)
from layoffs_staging2;

update layoffs_staging2
set company = trim(company);

select  distinct industry
from layoffs_staging2
where industry like 'Crypto%';

update layoffs_staging2
set industry = 'Crypto'
where industry like 'Crypto%';


select distinct country ,trim(trailing '.' from country)
from layoffs_staging2
where country like '%States%';

update layoffs_staging2
set country = trim(trailing '.' from country)
where country like '%States';

select  *
from layoffs_staging2;

-- Changing thedate data type
select  `date`,
str_to_date(`date`, '%m/%d/%Y')
-- date_to_str('%m/%d/%Y',`date`)
from layoffs_staging2;

update layoffs_staging2
set `date` = date_to_str('%m/%d/%Y',`date`);

alter table layoffs_staging2 add column date_text  text;

update layoffs_staging2
set date_text = date_format(date_text, '%m/%d/%Y');

select date_text
from layoffs_staging2;

update layoffs_staging2
set date_text = str_to_date(date_text, '%m/%d/%Y');

alter table layoffs_staging2
modify column date_text date;

alter table layoffs_staging2 drop column date_text;

-- DEALING  WIHT NULLS

select *
from layoffs_staging2
where total_laid_off is null and percentage_laid_off is null;

update layoffs_staging2
set industry = null 
where industry = '';

select *
from layoffs_staging2
where industry is null
or industry = '';

select *
from layoffs_staging2
where company like  'Bally%';

select t1.industry, t2.industry 
from layoffs_staging2 t1
join layoffs_staging2 t2
	on t1.company = t2.company
where (t1.industry is null  or t1.industry='')
and t2.industry is not null;

update  layoffs_staging2 t1
join layoffs_staging2 t2
	on t1.company = t2.company
	set t1.industry = t2.industry
where (t1.industry is null  )
and t2.industry is not null;

select *
from layoffs_staging2
where total_laid_off is null 
and percentage_laid_off is null;

delete 
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

select * 
from layoffs_staging2;

alter  table layoffs_staging2
drop column row_num;
















