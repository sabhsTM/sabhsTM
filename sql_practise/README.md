# SQL and Data Analytics Practice

My journey learning SQL and Python for data analytics and machine learning.
It covers MySQL fundamentals, two data projects (layoffs and Titanic), and
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
- **titanic-project/**: SQL cleaning and exploration of the Kaggle Titanic
  data, plus a scikit-learn model in a notebook.
- **setup/**: the script that creates the practice database.

## Titanic project

An end-to-end project: MySQL for import, cleaning and exploration, then Python
for modelling. Details and results in [titanic-project/](titanic-project/).

- **SQL:** imported the CSV, cleaned blanks into NULLs, explored survival by
  class, sex, age, family size and port, and built a feature view (`Title`,
  `FamilySize`, `IsAlone`, `HasCabin`).
- **Model:** logistic regression in a scikit-learn pipeline reached about 82%
  accuracy in 5-fold cross-validation, against a 61.5% baseline that always
  predicts "did not survive". A random forest and a title-based age fill did
  not improve on it.
- **Data problems caught along the way:** a silent row loss during import (714
  rows loaded instead of 891), and an export that turned missing ages into
  zeros. Both were found by checking counts after each step.
- **Finding:** survival differed by port of embarkation, but class, sex and
  family size explained much of that gap.

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

## LeetCode progress

- **Easy:** 175, 181, 182, 183, 197, 584, 595
- **Medium:** 176, 177, 178, 180, 184, 550, 570, 626, 1164, 1204, 1321
- **Hard:** 185, 601,262

Approaches I compared: `DENSE_RANK` vs `LIMIT/OFFSET` vs `MAX` for the
second highest salary, `LAG` vs self join for consecutive numbers,
`DENSE_RANK` vs a correlated subquery for the top three salaries, and
gaps and islands (`id - ROW_NUMBER()`) vs a self join for consecutive rows.

## Tools

MySQL, MySQL Workbench, Python (pandas, scikit-learn), Jupyter notebooks in
VS Code

## About me

Telecommunications engineering graduate moving into data analytics and
machine
