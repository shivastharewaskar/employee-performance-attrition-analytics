# Power BI Dashboard Architecture & Blueprint

## Project: Employee Performance & HR Analytics
**Author:** [Shivastha Rewaskar](https://github.com/shivastharewaskar)  
**Target Audience:** Chief Human Resources Officer (CHRO), VP of Talent, Department Leads  

---

## 1. Visual Layout & Screen Architecture (7 Pages)

### Page 1: Enterprise Workforce Overview
- **Top Header Strip:** 6 Live DAX KPI Cards
  - Total Employees (1,200)
  - Average Salary (₹11.02L)
  - Highest Salary (₹30.07L)
  - Avg Experience (6.5 Yrs)
  - Attrition Rate (18.9%)
  - Avg Performance (2.84 / 4.0)
- **Visual 1 (Donut Chart):** Headcount by Department (Sales: 324, R&D: 321, Tech: 317, HR: 127, Finance: 111).
- **Visual 2 (Stacked Bar):** Job Role Headcount nested within Departments.
- **Visual 3 (Gauge Visual):** Enterprise Attrition Rate versus 15.0% Board Target.

### Page 2: Compensation & Pay Parity Dashboard
- **Visual 1 (Histogram):** Distribution of Salaries across ₹4L-₹8L, ₹8L-₹12L, ₹12L-₹16L, and >₹20L buckets.
- **Visual 2 (Clustered Bar):** Average Annual Salary comparison across all 5 Departments.
- **Visual 3 (Scatter Plot):** Years of Experience (X) vs Salary (Y) with Linear Regression fit line (r = 0.92).
- **Visual 4 (Heatmap Matrix):** Average Salary broken down by Department vs Education Level.

### Page 3: Department Performance & Attrition Diagnostic
- **Visual 1 (Horizontal Bar):** Attrition Rate % by Department (Red alert condition for Sales at 24.1%).
- **Visual 2 (Clustered Column):** Average Performance Rating across Departments.
- **Visual 3 (Decomposition Tree):** Root-cause breakdown of Attrition: Department -> Job Role -> Work Mode -> Salary Tier.

### Page 4: Talent Review & Promotion Matrix
- **Visual 1 (Scatter Quadrant):** Performance Rating vs Job Satisfaction with reference lines at medians.
- **Visual 2 (Filtered Table):** Top 20 Candidates for Senior Fast-Track Promotion (Rating 4, Experience > 5 yrs).
- **Visual 3 (KPI Card):** Flight Risk Alert (92 High Performers currently underpaid below departmental mean).

### Page 5: Modern Work Mode Analytics (Remote vs Hybrid vs Office)
- **Visual 1 (100% Stacked Bar):** Work Mode distribution across Departments (Hybrid 42.3%, Remote 37.2%, Office 20.5%).
- **Visual 2 (Clustered Column):** Average Satisfaction Score by Work Mode (Hybrid leads with 2.62/4).
- **Visual 3 (Bar Chart):** Performance Rating Parity across Work Modes (validating zero productivity penalty in remote/hybrid).

### Page 6: Educational Attainment & ROI Analysis
- **Visual 1 (Tree Map):** Workforce Headcount by Education (Bachelor's 50%, Master's 32%, High School 10%, Doctorate 8%).
- **Visual 2 (Bar Chart):** Salary Premium by Education (Doctorates at ₹13.70L vs Bachelor's at ₹10.22L).

### Page 7: Diversity, Equity & Inclusion (DEI) Audit
- **Visual 1 (Donut Chart):** Gender Split (56.3% Male, 43.8% Female).
- **Visual 2 (Paired Column):** Gender Distribution by Department and Seniority Level.
- **Visual 3 (KPI Metric):** Pay Disparity Delta (< 0.4% difference, validating corporate equity).

---

## 2. Interactive Slicers & Palette Specifications
- **Global Slicers:** Department, Work Mode, Gender, Performance Rating.
- **Color Palette Hex Tokens:**
  - Dark Slate Surface: `#0F172A` / `#1E293B`
  - Primary Accent Blue: `#38BDF8`
  - Emerald Retention: `#34D399`
  - Coral Attrition Alert: `#EF4444`
  - Amber Warning: `#FBBF24`
