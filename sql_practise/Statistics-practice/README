# Statistics Practice: Churn and Categorical Associations

Hypothesis tests on the Telco customer churn data, to check which
associations are real and how strong they are. Built after the churn model
project, as practice for statistical reasoning rather than prediction.

## What it covers

- **Confidence interval** for the month-to-month churn rate (95%, using the
  normal approximation for a proportion).
- **Chi-square test of independence** for churn against each categorical
  variable: contract, internet service, payment method, tech support and
  online security.
- **Cramér's V** as the effect size, so strength is read separately from the
  p-value.
- **Support-services check**: whether online security and tech support add
  anything once contract, tenure and internet type are in the model, using
  cross-validated AUC.

## Key results

- Contract type has the strongest association with churn (Cramér's V 0.41).
- Support services are associated with churn among customers with internet,
  mainly within month-to-month contracts (V 0.16 to 0.18).
- Removing the support services leaves cross-validated AUC unchanged (0.844
  either way), so they add nothing beyond contract, tenure and internet type.

## Data

Kaggle's Telco Customer Churn dataset (IBM sample data, 7,043 customers). The
CSV isn't included. Download `WA_Fn-UseC_-Telco-Customer-Churn.csv` from
[Kaggle](https://www.kaggle.com/datasets/blastchar/telco-customer-churn), or
export `churn_features` from the `telco-churn-project` folder as
`churn_features.csv`, and place it in this folder.

## Running it

1. Install the libraries: `pip install pandas numpy scipy scikit-learn`.
2. Open `statistics_practice.ipynb` and run it from top to bottom
   (Restart and Run All).

## Caveat

These tests show association, not causation. With 7,043 customers, weak
associations can produce very small p-values, so read Cramér's V for strength.

