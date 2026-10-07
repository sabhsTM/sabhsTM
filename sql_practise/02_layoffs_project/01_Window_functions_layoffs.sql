-- LAG
with monthly_totals as 
(
select substring(`date`,1,7) as `month`,
sum(total_laid_off) as total_off
from layoffs_staging2
where substring(`date`,1,7)  is not null and total_laid_off is not null
group by `month`
)
select `month`, total_off,
	lag(total_off) over(order by `month` ) as prev_month,
	total_off - lag(total_off) over(order by `month` ) as change_amt
from monthly_totals;

-- LEAD
with monthly_totals as 
(
	select substring(`date`,1,7) as `month`,
    sum(total_laid_off) as total_off
    from layoffs_staging2
    where substring(`date`,1,7) is not null and total_laid_off is not null
    group by `month`
)
select `month`,total_off,
	lead(total_off) over(order by (`month`)) as next_month,
	lead(total_off) over(order by (`month`)) - total_off as change_to_next,
    avg(total_off) over (order by `month` rows between 2 preceding and current row)  as moving_avg_3m
from monthly_totals;

    
