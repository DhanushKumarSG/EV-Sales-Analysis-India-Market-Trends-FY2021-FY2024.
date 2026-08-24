
Create database EV_Sales;
show databases; 

use EV_Sales;

## Data Cleaning
# Checking Table structure
Describe Ev_Sales_by_Makers;
Select * from Ev_Sales_by_Makers;
Show columns from Ev_Sales_by_Makers;

# Changing table Names

ALTER TABLE `ev_sales_by makers` 
rename to Ev_Sales_by_Makers;

# Changing Column Names
ALTER TABLE Ev_Sales_by_Makers
RENAME COLUMN `ï»¿Sl.No` TO `Sl.No`,
RENAME COLUMN electric_vehicles_sold TO Electric_vehicles_sold,
RENAME COLUMN maker to Maker,
RENAME COLUMN vehicle_category to Vehicle_category;

# Changing Data type
Alter table Ev_Sales_by_Makers
modify vehicle_category varchar(50),
modify maker varchar(50),
MODIFY COLUMN Date DATE;

# Checking Null values in every column

Select * from Ev_Sales_by_Makers
where vehicle_category is null
or maker is null
or electric_vehicles_sold is null
or Date is null;

# Counting Null values in every column
Select Sum(vehicle_category is null) as Vehicle_Category_null,
Sum(maker is null) as maker_null,
Sum(electric_vehicles_sold is null) as electric_vehicles_sold,
Sum(Date is null) as Date_Null
from Ev_Sales_by_Makers;

# Replacing Null Values
Update Ev_Sales_by_Makers
set vehicle_category = "Unknown"
where vehicle_category is null;

# Findig Blank values and null values togather
Select * from Ev_Sales_by_Makers
WHERE TRIM(vehicle_category) = ''
OR vehicle_category IS NULL;

# Removing Leading and Trailing Spaces
update Ev_Sales_by_Makers
set vehicle_category = trim(vehicle_category),
maker = trim(maker),
electric_vehicles_sold = trim(electric_vehicles_sold);

# Change text cases
update Ev_Sales_by_Makers
set vehicle_category = upper(vehicle_category);

select lower(vehicle_category) from Ev_Sales_by_Makers;

# Checking negative values
SELECT *
FROM Ev_Sales_by_Makers
WHERE electric_vehicles_sold < 0;

#Finding Zero values
SELECT *
FROM Ev_Sales_by_Makers
WHERE electric_vehicles_sold = 0 ;

# Dropping unwanted columns
ALTER TABLE Ev_Sales_by_Makers
DROP COLUMN `Sl.No`;

# Adding Primary key 
ALTER TABLE Ev_Sales_by_Makers
ADD CONSTRAINT fk_makers_date
FOREIGN KEY (Date)
REFERENCES dim_date(Date);

SELECT
MIN(Date),
MAX(Date)
FROM dim_date;


