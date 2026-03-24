SELECT 
    ID AS Client_ID,
    
    -- 计算 6 个月的总账单金额
    (BILL_AMT1 + BILL_AMT2 + BILL_AMT3 + BILL_AMT4 + BILL_AMT5 + BILL_AMT6) AS Total_Billed_6M,
    
    -- 计算 6 个月的总还款金额
    (PAY_AMT1 + PAY_AMT2 + PAY_AMT3 + PAY_AMT4 + PAY_AMT5 + PAY_AMT6) AS Total_Paid_6M,
    
    -- 计算平均还款率，避免除以 0 的报错
    CASE 
        WHEN (BILL_AMT1 + BILL_AMT2 + BILL_AMT3 + BILL_AMT4 + BILL_AMT5 + BILL_AMT6) = 0 THEN 0
        ELSE ROUND(
            (PAY_AMT1 + PAY_AMT2 + PAY_AMT3 + PAY_AMT4 + PAY_AMT5 + PAY_AMT6) / 
            (BILL_AMT1 + BILL_AMT2 + BILL_AMT3 + BILL_AMT4 + BILL_AMT5 + BILL_AMT6) * 100, 
        2)
    END AS Repayment_Ratio_Pct,
    
    `default.payment.next.month` AS Is_Default

FROM credit_card_data
-- 为了方便查看，我们按照还款率从低到高排序，看看那些还钱最少的人
ORDER BY Repayment_Ratio_Pct ASC
-- LIMIT 100; -- 先看前 100 个结果