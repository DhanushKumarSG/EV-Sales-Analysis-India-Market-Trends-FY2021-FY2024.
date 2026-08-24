-- EV MARKET ANALYSIS PORTFOLIO PROJECT (FY 2022 - 2024)

-- Q1: Top 3 and Bottom 3 makers for fiscal years 2023 and 2024 (2-Wheelers)

WITH YearlySales AS (
    SELECT 
        d.fiscal_year, 
        s.maker,
        SUM(s.electric_vehicles_sold) AS Total_EV_Sold
    FROM ev_sales_by_makers s
    JOIN dim_date d ON s.date = d.date
    WHERE d.fiscal_year IN (2023, 2024) 
      AND s.vehicle_category = '2-Wheelers'
    GROUP BY d.fiscal_year, s.maker
),
RankedSales AS (
    SELECT 
        fiscal_year,
        maker,
        Total_EV_Sold,
        ROW_NUMBER() OVER (PARTITION BY fiscal_year ORDER BY Total_EV_Sold DESC) AS Top_Rank,
        ROW_NUMBER() OVER (PARTITION BY fiscal_year ORDER BY Total_EV_Sold ASC) AS Bottom_Rank
    FROM YearlySales
)
SELECT fiscal_year, maker, Total_EV_Sold, 'Top' AS Category FROM RankedSales WHERE Top_Rank <= 3
UNION ALL
SELECT fiscal_year, maker, Total_EV_Sold, 'Bottom' AS Category FROM RankedSales WHERE Bottom_Rank <= 3
ORDER BY fiscal_year ASC, Category DESC, Total_EV_Sold DESC;

-- Q2 Top 5 states with highest EV penetration rate in FY 2024

WITH RankedPenetration AS ( 
    SELECT 
        d.fiscal_year AS Year, 
        s.state, 
        s.vehicle_category, 
        ROUND((SUM(s.electric_vehicles_sold) * 100.0) / NULLIF(SUM(s.total_vehicles_sold), 0), 2) AS Penetration_Rate, 
        ROW_NUMBER() OVER (
            PARTITION BY s.vehicle_category 
            ORDER BY (SUM(s.electric_vehicles_sold) * 100.0) / NULLIF(SUM(s.total_vehicles_sold), 0) DESC
        ) as sales_rank -- Changed 'Rank' to 'sales_rank' to avoid reserved keyword error
    FROM ev_sales_by_state s 
    JOIN dim_date d ON s.date = d.date 
    WHERE d.fiscal_year = 2024 
      AND s.vehicle_category IN ('2-Wheelers', '4-Wheelers') 
    GROUP BY d.fiscal_year, s.state, s.vehicle_category 
) 
SELECT Year, state, vehicle_category, Penetration_Rate 
FROM RankedPenetration 
WHERE sales_rank <= 5 -- Updated filter reference
ORDER BY vehicle_category, Penetration_Rate DESC;

-- Q3: Quarterly trends based on sales volume for the top 5 EV makers (4-Wheelers)

WITH Top_5_Makers AS (
    SELECT s.maker
    FROM ev_sales_by_makers s
    JOIN dim_date d ON s.date = d.date
    WHERE d.fiscal_year BETWEEN 2022 AND 2024 
      AND s.vehicle_category = '4-Wheelers'
    GROUP BY s.maker
    ORDER BY SUM(s.electric_vehicles_sold) DESC
    LIMIT 5
)
SELECT 
    d.fiscal_year, 
    d.quarter, 
    s.maker, 
    SUM(s.electric_vehicles_sold) AS EV_Sales
FROM ev_sales_by_makers s
JOIN dim_date d ON s.date = d.date
WHERE d.fiscal_year BETWEEN 2022 AND 2024 
  AND s.vehicle_category = '4-Wheelers'
  AND s.maker IN (SELECT maker FROM Top_5_Makers)
GROUP BY d.fiscal_year, d.quarter, s.maker
ORDER BY d.fiscal_year ASC, d.quarter ASC, EV_Sales DESC;

-- Q4: Total number of 4-Wheeler EVs sold in FY 2024 across India

SELECT 
    d.fiscal_year, 
    SUM(s.electric_vehicles_sold) AS Total_4_Wheeler_EVs_Sold
FROM ev_sales_by_makers s
JOIN dim_date d ON s.date = d.date
WHERE d.fiscal_year = 2024 
  AND s.vehicle_category = '4-Wheelers'
GROUP BY d.fiscal_year;

-- Q5: Highest 4-Wheeler sales maker in FY 2023

SELECT 
    m.maker, 
    SUM(m.electric_vehicles_sold) AS Total_4_Wheeler_EVs_Sold
FROM ev_sales_by_makers m
JOIN dim_date d ON m.date = d.date
WHERE d.fiscal_year = 2023 
  AND m.vehicle_category = '4-Wheelers'
GROUP BY m.maker
ORDER BY Total_4_Wheeler_EVs_Sold DESC
LIMIT 1;

-- Q6: Tata Motors Market Share Percentage in FY 2024 (4-Wheelers)

SELECT 
    ROUND((SUM(CASE WHEN m.maker = 'Tata Motors' THEN m.electric_vehicles_sold ELSE 0 END) * 100.0) /
    SUM(m.electric_vehicles_sold), 2) AS Tata_Motors_Market_Share
FROM ev_sales_by_makers m
JOIN dim_date d ON m.date = d.date
WHERE d.fiscal_year = 2024 
  AND m.vehicle_category = '4-Wheelers';

-- Q7: Quarter-wise sales of 2-Wheelers during FY 2024

SELECT 
    d.fiscal_year, 
    d.quarter, 
    s.vehicle_category, 
    SUM(s.electric_vehicles_sold) AS Total_EV_Vehicles_Sold
FROM ev_sales_by_state s
JOIN dim_date d ON s.date = d.date
WHERE d.fiscal_year = 2024 
  AND s.vehicle_category = '2-Wheelers'
GROUP BY d.fiscal_year, d.quarter, s.vehicle_category
ORDER BY d.quarter ASC;

-- Q8: Compare total sales of 2-Wheelers and 4-Wheelers for each fiscal year

SELECT 
    d.fiscal_year, 
    s.vehicle_category, 
    SUM(s.electric_vehicles_sold) AS Total_EV_Sales
FROM ev_sales_by_state s
JOIN dim_date d ON s.date = d.date
GROUP BY d.fiscal_year, s.vehicle_category
ORDER BY d.fiscal_year ASC, s.vehicle_category ASC;

-- Q9: Quarter with the highest EV sales across all categories

SELECT 
    d.fiscal_year, 
    d.quarter,
    SUM(s.electric_vehicles_sold) AS Max_Quarterly_EV_Sales
FROM ev_sales_by_state s
JOIN dim_date d ON s.date = d.date
GROUP BY d.fiscal_year, d.quarter
ORDER BY Max_Quarterly_EV_Sales DESC
LIMIT 1;

-- Q10: States that recorded EV sales in every single fiscal year from 2022 to 2024

SELECT s.state                    
FROM ev_sales_by_state s
JOIN dim_date d ON s.date = d.date
WHERE d.fiscal_year IN (2022, 2023, 2024)
GROUP BY s.state
HAVING COUNT(DISTINCT d.fiscal_year) = 3
ORDER BY s.state ASC;

-- Q11: Total 4-Wheeler sales comparison (Tata Motors vs MG Motor vs Mahindra)

SELECT 
    m.maker, 
    SUM(m.electric_vehicles_sold) AS Total_Sales
FROM ev_sales_by_makers m
JOIN dim_date d ON m.date = d.date
WHERE d.fiscal_year IN (2022, 2023, 2024) 
  AND m.vehicle_category = '4-Wheelers'
  AND (m.maker IN ('Tata Motors', 'MG Motor') OR m.maker LIKE 'Mahindra%')
GROUP BY m.maker
ORDER BY Total_Sales DESC;
