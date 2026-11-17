"""
generate_data.py
================
Generates benchmark raw and cleaned datasets for Employee Performance & HR Analytics.
Outputs:
- data/employee_data_raw.csv (with duplicates and nulls)
- data/employee_data_cleaned.csv (1,200 unique, validated records)
"""

import numpy as np
import pandas as pd
import random
import os

np.random.seed(42)
random.seed(42)

n_samples = 1200

departments = ['Technology', 'Sales', 'Research & Development', 'Human Resources', 'Finance']
dept_weights = [0.30, 0.25, 0.25, 0.10, 0.10]

roles_by_dept = {
    'Technology': ['Software Engineer', 'Data Analyst', 'Cloud Architect', 'DevOps Specialist', 'QA Engineer'],
    'Sales': ['Sales Executive', 'Account Manager', 'Sales Manager', 'Business Development Rep'],
    'Research & Development': ['Research Scientist', 'Lab Technician', 'R&D Director', 'Product Researcher'],
    'Human Resources': ['HR Generalist', 'Recruiter', 'HR Manager', 'Talent Lead'],
    'Finance': ['Financial Analyst', 'Accountant', 'Finance Manager', 'Payroll Specialist']
}

education_levels = ['High School', "Bachelor's", "Master's", 'Doctorate']
edu_weights = [0.10, 0.50, 0.32, 0.08]

work_modes = ['Remote', 'Hybrid', 'Office']
mode_weights = [0.35, 0.45, 0.20]

genders = ['Male', 'Female']
gender_weights = [0.55, 0.45]

data = []
for i in range(1, n_samples + 1):
    emp_id = f"EMP{i:04d}"
    gender = random.choices(genders, weights=gender_weights)[0]
    dept = random.choices(departments, weights=dept_weights)[0]
    role = random.choice(roles_by_dept[dept])
    edu = random.choices(education_levels, weights=edu_weights)[0]
    
    # Experience & Age
    exp = int(np.clip(np.random.exponential(scale=6) + 1, 1, 35))
    age = int(np.clip(21 + exp + np.random.randint(0, 8), 22, 60))
    years_at_company = int(min(exp, np.random.randint(0, exp + 1)))
    
    # Salary calculation based on dept, role, edu, and exp
    base_salaries = {'Technology': 650000, 'Sales': 550000, 'Research & Development': 680000, 'Human Resources': 500000, 'Finance': 620000}
    edu_mult = {'High School': 0.85, "Bachelor's": 1.0, "Master's": 1.25, 'Doctorate': 1.55}
    
    salary = int(base_salaries[dept] * edu_mult[edu] + exp * 65000 + np.random.normal(0, 50000))
    salary = max(380000, round(salary, -3))
    
    work_mode = random.choices(work_modes, weights=mode_weights)[0]
    
    # Performance Rating: 1 to 4
    perf = random.choices([1, 2, 3, 4], weights=[0.08, 0.22, 0.50, 0.20])[0]
    
    # Job Satisfaction (1-4), Work-Life Balance (1-4)
    sat = random.choices([1, 2, 3, 4], weights=[0.15, 0.25, 0.40, 0.20])[0]
    wlb = random.choices([1, 2, 3, 4], weights=[0.15, 0.30, 0.40, 0.15])[0]
    
    # Attrition probability
    attr_prob = 0.08
    if sat <= 2: attr_prob += 0.12
    if wlb <= 2: attr_prob += 0.10
    if exp < 3: attr_prob += 0.08
    if salary < base_salaries[dept]: attr_prob += 0.08
    attrition = 'Yes' if random.random() < min(attr_prob, 0.85) else 'No'
    
    data.append({
        'EmployeeID': emp_id,
        'Age': age,
        'Gender': gender,
        'Department': dept,
        'JobRole': role,
        'Education': edu,
        'YearsOfExperience': exp,
        'YearsAtCompany': years_at_company,
        'Salary': salary,
        'WorkMode': work_mode,
        'PerformanceRating': perf,
        'JobSatisfaction': sat,
        'WorkLifeBalance': wlb,
        'Attrition': attrition
    })

df_clean = pd.DataFrame(data)

# Create raw dataframe with duplicates and missing values
df_raw = df_clean.copy()
duplicates = df_raw.sample(20, random_state=42)
df_raw = pd.concat([df_raw, duplicates], ignore_index=True)

missing_sal_idx = np.random.choice(df_raw.index[:n_samples], 15, replace=False)
df_raw.loc[missing_sal_idx, 'Salary'] = np.nan

missing_mode_idx = np.random.choice(df_raw.index[:n_samples], 10, replace=False)
df_raw.loc[missing_mode_idx, 'WorkMode'] = np.nan

base_dir = os.path.dirname(os.path.abspath(__file__))
df_raw.to_csv(os.path.join(base_dir, 'employee_data_raw.csv'), index=False)
df_clean.to_csv(os.path.join(base_dir, 'employee_data_cleaned.csv'), index=False)

print('Generated data successfully!')
