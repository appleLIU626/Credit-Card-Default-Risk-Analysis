USE finance_project;

SELECT 
    
    *, 
    
 
    CASE 
        WHEN EDUCATION = 1 THEN 'Graduate School'
        WHEN EDUCATION = 2 THEN 'University'
        WHEN EDUCATION = 3 THEN 'High School'
        ELSE 'Others' 
    END AS Education_Level,

   
    CASE 
        WHEN MARRIAGE = 1 THEN 'Married'
        WHEN MARRIAGE = 2 THEN 'Single'
        ELSE 'Others' 
    END AS Marital_Status,
    
    CASE 
        WHEN (BILL_AMT1 + BILL_AMT2 + BILL_AMT3 + BILL_AMT4 + BILL_AMT5 + BILL_AMT6) = 0 THEN 0
        ELSE ROUND(
            (PAY_AMT1 + PAY_AMT2 + PAY_AMT3 + PAY_AMT4 + PAY_AMT5 + PAY_AMT6) / 
            (BILL_AMT1 + BILL_AMT2 + BILL_AMT3 + BILL_AMT4 + BILL_AMT5 + BILL_AMT6) * 100, 
        2)
    END AS Repayment_Ratio_Pct

FROM credit_card_data;