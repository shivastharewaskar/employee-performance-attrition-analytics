# Power BI DAX Measures & Metrics Catalog

## Project: Employee Performance & HR Analytics
**Author:** [Shivastha Rewaskar](https://github.com/shivastharewaskar)  
**Data Model:** Star Schema / Normalized Ingestion (`employees` fact table)

---

## 1. Core Executive KPI Measures

### Total Workforce Headcount
```dax
Total Employees = COUNTROWS(employees)
```

### Average Annual Salary (INR)
```dax
Average Salary = AVERAGE(employees[Salary])
```

### Maximum Base Salary
```dax
Highest Salary = MAX(employees[Salary])
```

### Average Professional Experience (Years)
```dax
Average Experience = AVERAGE(employees[YearsOfExperience])
```

### Corporate Attrition Rate (%)
```dax
Attrition Count = CALCULATE(COUNTROWS(employees), employees[Attrition] = "Yes")

Total Headcount = COUNTROWS(employees)

Attrition Rate = 
DIVIDE(
    [Attrition Count],
    [Total Headcount],
    0
)
```

### Average Performance Rating (1.0 to 4.0 Scale)
```dax
Average Performance Rating = AVERAGE(employees[PerformanceRating])
```

---

## 2. Advanced Risk & Talent Protection Measures

### Top Performer Count (Rating 4 Outstanding)
```dax
High Performers Count = 
CALCULATE(
    COUNTROWS(employees),
    employees[PerformanceRating] = 4
)
```

### Flight Risk: Underpaid High Performers
Identifies top-tier performers paid below their departmental average salary.
```dax
High Performers Underpaid = 
CALCULATE(
    COUNTROWS(employees),
    employees[PerformanceRating] = 4,
    employees[Salary] < [Average Salary]
)
```

### Retention Rate (%)
```dax
Retention Rate = 1 - [Attrition Rate]
```

### Dynamic Slicer Header
```dax
Selected Filter Title = 
"Workforce Intelligence Dashboard | Active Scope: " & 
SELECTEDVALUE(employees[Department], "All Departments") & 
" (" & FORMAT([Total Employees], "#,##0") & " Employees)"
```
