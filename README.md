# EV Sales Analysis: India Market Trends (FY2022–FY2024)

SQL-driven analysis of India's electric vehicle market, covering maker-wise and state-wise EV sales, market penetration rates, and market share across fiscal years 2022 to 2024. Built end-to-end in MySQL, from raw data cleaning to business-question-driven analysis using CTEs and window functions.

## Overview

This project analyzes EV sales data across two dimensions, vehicle makers and states, alongside a total vehicle sales baseline used to calculate EV penetration rate. The goal was to answer real business questions a market analyst or strategy team would actually ask: who's winning, where, and how fast is EV adoption growing relative to overall vehicle sales.

## Dataset

- **Time range:** FY2022 – FY2024
- **Granularity:** Daily sales records, aggregated to monthly/quarterly/yearly views
- **Tables:**
  - `ev_sales_by_makers` — EV sales by maker and vehicle category (2-Wheelers, 4-Wheelers)
  - `ev_sales_by_state` — EV sales and total vehicle sales by state and vehicle category
  - `dim_date` — date dimension table with fiscal year and quarter mapping

## Tech Stack

- **MySQL** — data cleaning, exploratory analysis, and business-question queries
- **SQL techniques used:** CTEs (single and multiple), window functions (ROW_NUMBER, RANK), conditional aggregation (CASE WHEN), NULLIF for safe division, multi-table joins, subqueries
- 
## Process

**1. Data Cleaning** (`01`–`03`)
Standardized table and column names, fixed data types (dates, categorical fields), handled NULL and blank values, removed leading/trailing whitespace, checked for negative and zero-value anomalies, and established foreign key relationships to a shared date dimension table.

**2. Exploratory Data Analysis** (`04`)
Baseline checks: record counts, date range coverage, distinct category values, descriptive statistics (min/max/average sales), and sales aggregated by month, quarter, and year across both makers and states.

**3. Business Questions** (`05`)
Eleven analytical queries answering specific business questions, including:
- Top 3 and bottom 3 EV makers by fiscal year (2-Wheelers)
- Top 5 states by EV penetration rate (FY2024)
- Quarterly sales trends for the top 5 four-wheeler EV makers
- Tata Motors' market share in the 4-Wheeler segment (FY2024)
- States with consistent EV sales activity across all three fiscal years
- Head-to-head sales comparison: Tata Motors vs. MG Motor vs. Mahindra (4-Wheelers)
  
## How to Run

Run the SQL files in numerical order (01 through 05) against a MySQL instance. Files 01–03 set up and clean the schema; 04 explores the data; 05 answers the core business questions.

## What This Project Demonstrates

- Structuring a multi-table analytical schema with a shared date dimension
- Real-world data cleaning: type conversion, NULL handling, deduplication, whitespace and casing issues
- Translating open-ended business questions into layered SQL logic using CTEs and window functions
- Safe division handling (NULLIF) to avoid divide-by-zero errors in penetration rate calculations
- Fiscal-year and quarter-based time analysis
