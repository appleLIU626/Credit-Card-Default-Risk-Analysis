SELECT 
    -- 1. 将学历代码转换为可读标签
    CASE 
        WHEN EDUCATION = 1 THEN 'Graduate School'
        WHEN EDUCATION = 2 THEN 'University'
        WHEN EDUCATION = 3 THEN 'High School'
        ELSE 'Others' 
    END AS Education_Level,

    -- 2. 将婚姻状况代码转换为可读标签
    CASE 
        WHEN MARRIAGE = 1 THEN 'Married'
        WHEN MARRIAGE = 2 THEN 'Single'
        ELSE 'Others' 
    END AS Marital_Status,

    -- 3. 统计总人数
    COUNT(*) AS Total_Clients,

    -- 4. 统计违约人数 (使用反引号包裹带有特殊字符的列名)
    SUM(`default.payment.next.month`) AS Default_Count,

    -- 5. 计算违约率 (转换成百分比，保留两位小数)
    ROUND(CAST(SUM(`default.payment.next.month`) AS FLOAT) / COUNT(*) * 100, 2) AS Default_Rate_Percentage

FROM credit_card_data
GROUP BY 
    -- 必须按转换后的维度进行分组
    CASE 
        WHEN EDUCATION = 1 THEN 'Graduate School'
        WHEN EDUCATION = 2 THEN 'University'
        WHEN EDUCATION = 3 THEN 'High School'
        ELSE 'Others' 
    END,
    CASE 
        WHEN MARRIAGE = 1 THEN 'Married'
        WHEN MARRIAGE = 2 THEN 'Single'
        ELSE 'Others' 
    END
ORDER BY Default_Rate_Percentage DESC;