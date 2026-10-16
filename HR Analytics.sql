-- Q1. Overall Attrition rate?
SELECT 
    COUNT(*) AS total_employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count,
    ROUND((SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)::NUMERIC / COUNT(*)) * 100, 2) AS attrition_rate_pct
FROM hr_attrition;

-- Q2. Which Department and Job Role has more Attrition?
SELECT 
    department,
    jobrole,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count,
    ROUND((SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)::NUMERIC / COUNT(*)) * 100, 2) AS attrition_rate_pct
FROM hr_attrition
GROUP BY department, jobrole
ORDER BY attrition_rate_pct DESC;

-- Q3. Attritioon in OverTime Employess?
SELECT 
    overtime,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count,
    ROUND((SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)::NUMERIC / COUNT(*)) * 100, 2) AS attrition_rate_pct
FROM hr_attrition
GROUP BY overtime;

-- Q4. Average Salary Compansation.
SELECT 
    jobrole,
    ROUND(AVG(CASE WHEN attrition = 'Yes' THEN monthlyincome END), 2) AS avg_salary_left,
    ROUND(AVG(CASE WHEN attrition = 'No' THEN monthlyincome END), 2) AS avg_salary_stayed
FROM hr_attrition
GROUP BY jobrole;

--Q5. Impact of  
SELECT 
    CASE 
        WHEN distancefromhome <= 5 THEN '1. Near (0-5 km)'
        WHEN distancefromhome <= 15 THEN '2. Moderate (6-15 km)'
        ELSE '3. Far (15+ km)'
    END AS distance_band,
    COUNT(*) AS total_employees,
    ROUND((SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END)::NUMERIC / COUNT(*)) * 100, 2) AS attrition_rate_pct
FROM hr_attrition
GROUP BY distance_band
ORDER BY distance_band;