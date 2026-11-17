"""
verify_sql.py
=============
Automated test suite verifying SQL scripts against SQLite in-memory engine.
"""

import sqlite3
import pandas as pd
import os
import re

def main():
    print("=" * 60)
    print("  VERIFYING SQL SCRIPTS FOR REPOSITORY INTEGRATION")
    print("=" * 60)
    
    base_dir = os.path.dirname(os.path.abspath(__file__))
    data_file = os.path.join(base_dir, "data", "employee_data_cleaned.csv")
    
    if not os.path.exists(data_file):
        raise FileNotFoundError(f"Cleaned data file not found at {data_file}")
        
    df = pd.read_csv(data_file)
    conn = sqlite3.connect(":memory:")
    df.to_sql("employees", conn, index=False, if_exists="replace")
    
    cursor = conn.cursor()
    print(f"Loaded {len(df)} records into in-memory SQLite 'employees' table.")
    
    sql_files = [
        "02_workforce_metrics_and_attrition.sql",
        "03_advanced_window_rankings.sql"
    ]
    
    for fname in sql_files:
        fpath = os.path.join(base_dir, "sql", fname)
        print(f"\nVerifying queries in {fname}...")
        with open(fpath, "r", encoding="utf-8") as f:
            content = f.read()
            
        # Split into statements
        statements = [s.strip() for s in content.split(";") if s.strip() and not s.strip().startswith("--")]
        for idx, stmt in enumerate(statements, 1):
            # Clean statement of leading comments
            clean_stmt = "\n".join([line for line in stmt.splitlines() if not line.strip().startswith("--")])
            if not clean_stmt.strip():
                continue
            try:
                res = pd.read_sql(clean_stmt, conn)
                print(f"  [OK] Statement {idx} executed successfully: {len(res)} rows returned.")
            except Exception as e:
                print(f"  [FAIL] Statement {idx} failed: {e}")
                raise e
                
    conn.close()
    print("\n" + "=" * 60)
    print("  ALL SQL QUERIES VERIFIED SUCCESSFULLY WITH 100% PASS RATE!")
    print("=" * 60)

if __name__ == "__main__":
    main()
