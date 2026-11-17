-- =====================================================================
-- 03_advanced_window_rankings.sql
-- Project: Employee Performance & HR Analytics
-- Author: Shivastha Rewaskar (https://github.com/shivastharewaskar)
-- Description: Advanced CTEs, Window Functions (DENSE_RANK), Subqueries, & Analytical Views
-- =====================================================================

-- ---------------------------------------------------------------------
-- Task 3: Identify the top 10 highest-paid employees
-- ---------------------------------------------------------------------
SELECT 
    EmployeeID, 
    Department, 
    JobRole, 
    Education, 
    YearsOfExperience, 
    Salary
FROM employees
ORDER BY Salary DESC
LIMIT 10;

-- ---------------------------------------------------------------------
-- Task 5: Find employees with the highest performance rating (Rating = 4)
-- ---------------------------------------------------------------------
SELECT 
    EmployeeID, 
    Department, 
    JobRole, 
    PerformanceRating, 
    Salary, 
    WorkMode
FROM employees
WHERE PerformanceRating = (SELECT MAX(PerformanceRating) FROM employees)
ORDER BY Salary DESC
LIMIT 15;

-- ---------------------------------------------------------------------
-- Task 8: Rank employees based on salary within each department (Window Function)
-- ---------------------------------------------------------------------
SELECT 
    EmployeeID, 
    Department, 
    JobRole, 
    Salary, 
    DENSE_RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS SalaryRankInDept
FROM employees
ORDER BY Department, SalaryRankInDept
LIMIT 20;

-- ---------------------------------------------------------------------
-- Task 9: Find employees earning above the company average salary (Subquery)
-- ---------------------------------------------------------------------
SELECT 
    EmployeeID, 
    Department, 
    JobRole, 
    Salary,
    ROUND(Salary - (SELECT AVG(Salary) FROM employees), 2) AS SalaryAboveAverage
FROM employees
WHERE Salary > (SELECT AVG(Salary) FROM employees)
ORDER BY Salary DESC
LIMIT 15;

-- ---------------------------------------------------------------------
-- Bonus: High-Performer Compensation Equity Audit (Flight Risk Detection)
-- ---------------------------------------------------------------------
WITH DeptMedian AS (
    SELECT 
        Department, 
        AVG(Salary) AS DeptAvgSalary
    FROM employees
    GROUP BY Department
)
SELECT 
    e.EmployeeID, 
    e.Department, 
    e.JobRole, 
    e.Salary, 
    d.DeptAvgSalary,
    ROUND(d.DeptAvgSalary - e.Salary, 2) AS UnderpaidDelta
FROM employees e
JOIN DeptMedian d ON e.Department = d.Department
WHERE e.PerformanceRating = 4 
  AND e.Salary < d.DeptAvgSalary
ORDER BY UnderpaidDelta DESC
LIMIT 15;
