create or replace view churn_features as
	select customerID,
		   gender, SeniorCitizen,Patner, Dependents, tenure,
           PhoneService, MultipleLines, InternetService,
           OnlineSecurity, OnlineBackup, DeviceProtection,
           TechSupport, StreamingTV, StreamingMovies,
           Contract, PaperlessBilling, PaymentMethod,
           MonthlyCharges, TotalCharges,
           (OnlineSecurity = 'Yes') + (OnlineBackup ='Yes') + (DeviceProtection = 'Yes')
           + (TechSupport = 'Yes') + (StreamingTV = 'Yes') + (StreamingMovies = 'Yes') as AddCount,
           (Churn = 'Yes') as Churned
		from customers;
        
        