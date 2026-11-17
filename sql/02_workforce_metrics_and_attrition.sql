-- =====================================================================
-- 02_workforce_metrics_and_attrition.sql
-- Project: Employee Performance & HR Analytics
-- Author: Shivastha Rewaskar (https://github.com/shivastharewaskar)
-- Description: Core Departmental Headcount, Salary Benchmarks, Work Mode, & Attrition
-- =====================================================================

-- ---------------------------------------------------------------------
-- Task 1: Retrieve total number of employees in each department
-- ---------------------------------------------------------------------
SELECT 
    Department, 
    COUNT(*) AS TotalEmployees,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM employees), 2) AS WorkforcePercentage
FROM employees
GROUP BY Department
ORDER BY TotalEmployees DESC;

-- ---------------------------------------------------------------------
-- Task 2: Find the average salary department-wise
-- ---------------------------------------------------------------------
SELECT 
    Department, 
    ROUND(AVG(Salary), 2) AS AverageSalary,
    ROUND(MIN(Salary), 2) AS MinSalary,
    ROUND(MAX(Salary), 2) AS MaxSalary
FROM employees
GROUP BY Department
ORDER BY AverageSalary DESC;

-- ---------------------------------------------------------------------
-- Task 4: Calculate the average years of experience by department
-- ---------------------------------------------------------------------
SELECT 
    Department, 
    ROUND(AVG(YearsOfExperience), 2) AS AvgExperienceYears,
    ROUND(AVG(YearsAtCompany), 2) AS AvgTenureAtCompany
FROM employees
GROUP BY Department
ORDER BY AvgExperienceYears DESC;

-- ---------------------------------------------------------------------
-- Task 6: Count employees based on work mode (Remote, Hybrid, Office)
-- ---------------------------------------------------------------------
SELECT 
    WorkMode, 
    COUNT(*) AS EmployeeCount,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM employees), 2) AS AdoptionPercentage
FROM employees
GROUP BY WorkMode
ORDER BY EmployeeCount DESC;

-- ---------------------------------------------------------------------
-- Task 7: Identify departments with the highest employee attrition
-- ---------------------------------------------------------------------
SELECT 
    Department, 
    COUNT(*) AS TotalEmployees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS AttritionExits,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS AttritionRatePercent
FROM employees
GROUP BY Department
ORDER BY AttritionRatePercent DESC;

-- ---------------------------------------------------------------------
-- Task 10: Calculate gender-wise employee distribution
-- ---------------------------------------------------------------------
SELECT 
    Gender, 
    COUNT(*) AS EmployeeCount,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM employees), 2) AS DistributionPercentage,
    ROUND(AVG(Salary), 2) AS AvgSalaryByGender
FROM employees
GROUP BY Gender
ORDER BY EmployeeCount DESC;
