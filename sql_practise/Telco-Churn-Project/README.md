# Telco Customer Churn: Who Is Likely to Leave?

An end-to-end project: MySQL for import, cleaning and exploration, then a
scikit-learn model to predict churn and choose a contact threshold from the
costs of each kind of mistake.

## The question

Which customers are most likely to leave, how well can we predict it from
what we know about them, and how should the business set its contact
threshold?

## Headline results

- **Baseline** (always predict "stays"): 73.5% accuracy.
- **Logistic regression**, 5-fold cross-validation: 80.4% accuracy, **ROC AUC
  0.84**.
- **At the default threshold of 0.5**: the model catches 55% of customers who
  churn, with 66% of its flags correct.
- **At a threshold of 0.15** (chosen under one cost assumption): it catches
  90% of churners, with 43% of its contacts correct.
- **Main drivers:** tenure and contract type carry most of the signal. Two-year
  contracts push strongly against churn, and month-to-month contracts towards
  it.

## Data

- Source: Kaggle's
  [Telco Customer Churn](https://www.kaggle.com/datasets/blastchar/telco-customer-churn)
  dataset. It's IBM sample data, not a real company's records: 7,043
  customers, 21 columns.
- The CSV isn't included here. Download `WA_Fn-UseC_-Telco-Customer-Churn.csv`
  from the link above.

## Files

- `telco_setup.sql`: creates the database and table, and checks the import
  (row count, blank values, the `TotalCharges` cleanup).
- `telco_eda.sql`: the exploration queries, each with a comment on the
  question it answers.
- `churn_features.sql`: the feature view. Adds `AddCount`, the number of
  add-on services, and `Churned`, a 0/1 target.
- `telco_churn.ipynb`: the model, the threshold analysis and the write-up.

## How to reproduce

1. Download the CSV from the Kaggle link above and place it in this folder.
2. Run `telco_setup.sql` in MySQL Workbench, then import the CSV with the
   Table Data Import Wizard into the existing `customers` table. Check that
   each CSV column maps to the column with the same name, and that the table
   holds 7,043 rows.
3. Run `telco_eda.sql` to reproduce the exploration.
4. Run `churn_features.sql` to create the view, then export `churn_features`
   from the Result Grid as a comma-separated CSV named `churn_features.csv`
   in this folder.
5. Open `telco_churn.ipynb` and run it from top to bottom.

## Data problems caught along the way

- **Import mapping.** The first import failed with "column `DeviceProtection`
  specified twice", caused by a wrong column mapping in the wizard. Fixed by
  re-mapping, and checked by counting rows afterwards.
- **Blank text in a numeric column.** Eleven customers had a blank
  `TotalCharges`. MySQL stored it as text, so the column couldn't be numeric
  until those blanks became `NULL`.
- **Zeros from the export.** The CSV export wrote those 11 missing values as
  0. The pipeline would have treated them as real totals. The notebook
  converts them back to missing before any split.

## Threshold decision

Because AUC doesn't depend on the threshold, the choice is a business
decision. A missed churner costs the revenue lost from them; a wasted offer
costs the price of contacting someone who would have stayed.

The best threshold moves with the costs:

| Cost of missed churner | Cost of offer | Best threshold |
|---|---|---|
| 30 | 15 | about 0.30 |
| 74 | 15 | about 0.15 |
| 150 | 15 | about 0.10 |

No single threshold is best across reasonable assumptions. If a lost customer
is worth much more than an offer, set the threshold low and contact most
customers. If offers are expensive relative to the loss, set it higher and
contact fewer, more likely churners.

The 74 and 15 are illustrative assumptions, not measured costs. The thresholds
were chosen on the test split, so the reported costs are slightly optimistic.
A cleaner method would choose the threshold on cross-validation folds.

## What it shows, and what it doesn't

- Churn is concentrated in month-to-month customers and in the first year of
  tenure.
- Among fibre-optic customers, churn is higher than for DSL. Most of that gap
  comes from contract mix: fibre customers are mostly on month-to-month plans.
- Within a contract type, the cheaper and dearer fibre price halves churn at
  similar rates, so price isn't the main story.
- These are associations in one sample. They don't show that any feature
  causes churn.

## Tools

MySQL 8.0 and MySQL Workbench; Python with pandas, scikit-learn and Jupyter
in VS Code.

## Next steps

- Choose the threshold on cross-validation folds rather than the test split.
- Test whether a retention offer aimed at month-to-month customers in their
  first year changes their churn rate.
