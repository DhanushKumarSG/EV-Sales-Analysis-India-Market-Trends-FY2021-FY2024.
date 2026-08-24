## Exploratory Data Analysis (EDA)

# Total records
Select count(*) as Total_Records
from ev_sales_by_makers;

Select count(*) as Total_Records
from ev_sales_by_state;

# Total vehicle categories
Select distinct vehicle_category
from ev_sales_by_makers;

Select distinct vehicle_category
from ev_sales_by_state;

# Total Sales categories
Select Vehicle_category , Sum(Electric_vehicles_sold) as Total_Sales
from ev_sales_by_makers
Group by Vehicle_category;

Select Vehicle_category , Sum(Electric_vehicles_sold) as Total_Sales
from ev_sales_by_State
Group by Vehicle_category;

SELECT
SUM(total_vehicles_sold) as Total_Sales
FROM ev_sales_by_state;

# Date range
Select min(date),
max(date) from	ev_sales_by_makers;

Select min(date),
max(date) from ev_sales_by_state;

# Total EV Vehicles sold
select sum(Electric_vehicles_sold) as Total_EV_Sales
from ev_sales_by_makers;

select sum(Electric_vehicles_sold) as Total_EV_Sales
from ev_sales_by_state;

# Descriptive Statistics
# Highest Sales
Select Max(Electric_vehicles_sold) as Maximum_Sales_By_Maker
from ev_sales_by_makers;

Select Max(Electric_vehicles_sold) as Maximum_Sales_By_State
from ev_sales_by_state;

# Lowest sales
Select Min(Electric_vehicles_sold) as Minimum_Sales_By_Maker
from ev_sales_by_makers;

Select Min(Electric_vehicles_sold) as Minimum_Sales_by_state
from ev_sales_by_state;

# Average sales
Select avg(Electric_vehicles_sold) as Average_sales_by_state
from ev_sales_by_state;

Select avg(Electric_vehicles_sold) as Average_sales_by_makers
from ev_sales_by_makers;

# Most and Least Sales by Maker
Select Maker, Sum(Electric_vehicles_sold) as Total_Sales
from ev_sales_by_makers
group by Maker
order by Total_Sales desc
limit 1;

Select Maker, Sum(Electric_vehicles_sold) as Total_Sales
from ev_sales_by_makers
group by Maker
order by Total_Sales asc
limit 1;

# Most and Least Sales by State
Select State, Sum(Electric_vehicles_sold) as Total_Sales
from ev_sales_by_state
group by State
order by Total_Sales Desc
limit 1;

Select State, Sum(Electric_vehicles_sold) as Total_Sales
from ev_sales_by_state
group by State
order by Total_Sales Asc
limit 1;	

# Monthly Sales by makers
Select Year(Date) as Sale_Year,
Monthname(Date) as Sale_Month, Maker,
Sum(Electric_vehicles_sold) as Total_Monthly_Sales
from ev_sales_by_makers
group by year(Date), Month(Date), monthname(Date), Maker
order by year(Date), Month(Date);

# Monthly Sales by State
Select Year(date) as Sale_year,
monthname(Date) as Sale_Month, State,
Sum(Electric_vehicles_sold) as Total_Monthly_Sales
from ev_sales_by_State
group by year(Date), Month(Date), monthname(Date), State
order by year(Date), Month(Date);

# Yearly Sales by makers
Select Year(Date), Maker,
Sum(Electric_vehicles_sold) as Total_Yearly_Sales
from ev_sales_by_Makers
Group by Year(Date), Maker
Order By Year(Date);

# Yearly Sales by Sates
Select Year(date) as Sale_Year, State,
Sum(Electric_vehicles_sold) as Total_Yearly_Sales
from ev_sales_by_State
group by year(Date), State
order by year(Date);

# Quarterly Sales by Makers
Select Year(Date), quarter(Date), Maker,
Sum(Electric_vehicles_sold) as Total_quarterly_Sales
from ev_sales_by_Makers
Group by Year(Date), quarter(Date), Maker
Order By Year(Date);

# Quarterly Sales by State
Select Year(Date), quarter(Date), State,
Sum(Electric_vehicles_sold) as Total_quarterly_Sales
from ev_sales_by_State
Group by Year(Date), quarter(Date), State
Order By Year(Date);

