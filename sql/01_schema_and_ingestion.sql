-- =====================================================================
-- 01_schema_and_ingestion.sql
-- Project: Employee Performance & HR Analytics
-- Author: Shivastha Rewaskar (https://github.com/shivastharewaskar)
-- Engine: MySQL 8.0+ / SQLite Compatible
-- =====================================================================

CREATE DATABASE IF NOT EXISTS HR_Analytics_DB;
USE HR_Analytics_DB;

DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
    EmployeeID VARCHAR(10) PRIMARY KEY,
    Age INT NOT NULL,
    Gender VARCHAR(10) NOT NULL,
    Department VARCHAR(50) NOT NULL,
    JobRole VARCHAR(50) NOT NULL,
    Education VARCHAR(50) NOT NULL,
    YearsOfExperience INT NOT NULL,
    YearsAtCompany INT NOT NULL,
    Salary DECIMAL(12, 2) NOT NULL,
    WorkMode VARCHAR(20) NOT NULL,
    PerformanceRating INT NOT NULL,
    JobSatisfaction INT NOT NULL,
    WorkLifeBalance INT NOT NULL,
    Attrition VARCHAR(5) NOT NULL
);

-- Optimization Indexes
CREATE INDEX idx_emp_dept ON employees(Department);
CREATE INDEX idx_emp_salary ON employees(Salary);
CREATE INDEX idx_emp_workmode ON employees(WorkMode);
CREATE INDEX idx_emp_attrition ON employees(Attrition);
