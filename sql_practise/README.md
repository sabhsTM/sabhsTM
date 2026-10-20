# SQL Practice

My journey learning SQL for data analytics and machine learning, using MySQL.
It covers the fundamentals, two data projects (layoffs and Titanic), and
LeetCode practice.

## What's inside

- **01_fundamentals/**: notes and queries covering SELECT, GROUP BY, joins,
  subqueries, CTEs, window functions, temp tables, stored procedures, triggers
  and events. Based on the Parks and Recreation database from [course name and
  instructor].
- **02_layoffs_project/**: data cleaning and exploratory analysis on a layoffs
  dataset (source: [link to dataset]).
- **03_leetcode/**: Easy, Medium and Hard SQL problems, each with a short note
  on what tripped me up.
- **titanic-project/**: SQL cleaning and exploratory analysis of the Kaggle
  Titanic data, with a machine learning model to follow.
- **setup/**: the script that creates the practice database.

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

**Findings:** [2 or 3 specific results from your own output, such as the year
with the most layoffs and the top industry]

## Titanic project

SQL import, cleaning and exploration of the Kaggle Titanic dataset (891
passengers). Highlights: caught a silent row loss during import (714 rows
loaded instead of 891), and found that survival differences by port were
partly explained by class, sex and family size. Details in
[titanic-project/](titanic-project/).

## LeetCode progress

- **Easy:** 175, 181, 182, 183, 197, 584, 595
- **Medium:** 176, 177, 178, 180, 184, 550, 570, 626, 1164, 1204, 1321
- **Hard:** 185, 601

Approaches I compared: `DENSE_RANK` vs `LIMIT/OFFSET` vs `MAX` for the
second highest salary, `LAG` vs self join for consecutive numbers,
`DENSE_RANK` vs a correlated subquery for the top three salaries, and
gaps and islands (`id - ROW_NUMBER()`) vs a self join for consecutive rows.

## Tools

MySQL, MySQL Workbench

## About me

Telecommunications engineering graduate moving into data analytics and
machine learning. See my ML notebooks: [ML_restored](https://github.com/sabhsTM/ML_restored)
