# SQL Practice

My journey learning SQL for data analytics and machine learning, using MySQL.
It covers the fundamentals, a data cleaning and analysis project, and LeetCode
practice.

## What's inside

- **01_fundamentals/**: notes and queries covering SELECT, GROUP BY, joins,
  subqueries, CTEs, window functions, temp tables, stored procedures, triggers
  and events. Based on the Parks and Recreation database from [name of the
  course or instructor].
- **Layoffs project**: data cleaning and exploratory analysis on a layoffs
  dataset (source: [link to dataset]).
- **LeetCode**: Easy and Medium SQL problems, each with a short note on
  what tripped me up.

## Layoffs project

**Cleaning steps**
- Removed duplicates using `ROW_NUMBER()` in a CTE
- Standardized text fields (trimmed spaces, fixed inconsistent names)
- Handled nulls and blanks
- Converted the date column to a proper DATE type

**Analysis**
- Rolling monthly totals of layoffs
- Month-over-month change with `LAG`, next-month change with `LEAD`
- 3-month moving average with a window frame
- Top companies per year ranked with `DENSE_RANK`

**Findings:** [add 2 or 3 things you actually found in the data]

## LeetCode progress

Easy: 175/181/182/183/584/595/197 [list the ones you've finished]
Medium: 176, 177, 178, 180 [add more as you go]

Approaches I compared: `DENSE_RANK` vs `LIMIT/OFFSET` vs `MAX` for the
second highest salary, and `LAG` vs self join for consecutive numbers.

## Tools

MySQL, MySQL Workbench

## About me

Telecommunications engineering graduate moving into data analytics and
machine learning. See my ML notebooks: [ML_restored](https://github.com/sabhsTM/ML_restored)
