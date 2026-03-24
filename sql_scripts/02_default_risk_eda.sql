SELECT 
    ID AS Client_ID, 
    LIMIT_BAL AS Credit_Limit,
    BILL_AMT1 AS Recent_Bill_Amount,
    
    -- 计算最近一个月的额度使用率 (转换为百分比)
    ROUND((BILL_AMT1 / LIMIT_BAL) * 100, 2) AS Credit_Utilization_Pct,
    
    PAY_0 AS Delay_Month_1, 
    PAY_2 AS Delay_Month_2, 
    PAY_3 AS Delay_Month_3,
    
    `default.payment.next.month` AS Will_Default_Next_Month

FROM credit_card_data
WHERE 
    -- 条件 1: 最近一个月账单占总额度 80% 以上
    (BILL_AMT1 / LIMIT_BAL) > 0.8
    
    -- 条件 2: 最近连续三个月都有逾期 (大于 0 代表逾期)
    AND PAY_0 > 0 
    AND PAY_2 > 0 
    AND PAY_3 > 0;