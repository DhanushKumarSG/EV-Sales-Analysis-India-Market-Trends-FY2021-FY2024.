## Data Cleaning

# Checking Table structure
Describe ev_sales_by_State;
Select * from ev_sales_by_State;
Show columns from ev_sales_by_State ;

#Changing table name
Alter table `ev_sales_by_State`
rename to ev_sales_by_State; 

set sql_safe_updates = 0;

# Changing data type
UPDATE ev_sales_by_State 			
SET Date = STR_TO_DATE(Date, '%d-%m-%Y');

alter table ev_sales_by_State
MODIFY COLUMN Date DATE;

alter table ev_sales_by_State
modify column vehicle_category varchar(50);

#Checking date range
SELECT
MIN(Date),
MAX(Date)
FROM dim_date;

#Checking null values
Select * from ev_sales_by_State
where Date is null
or state is null
or vehicle_Category is null
or electric_vehicles_sold is null
or total_vehicles_sold is null;

#Checking blank values
Select * from ev_sales_by_State
where state = ' '
or vehicle_Category  = ' '
or electric_vehicles_sold  = ' '
or total_vehicles_sold = ' ';

# Removing spaces
update ev_sales_by_State
set state = trim(state),
vehicle_category = trim(vehicle_Category);

#Checking Invalid categories
SELECT DISTINCT vehicle_category
FROM ev_sales_by_State;

#Checking negative values
Select * from ev_sales_by_State
where electric_vehicles_sold <0 or
total_vehicles_sold <0;

#Finding Zero values
SELECT *
FROM ev_sales_by_State
WHERE electric_vehicles_sold = 0
OR total_vehicles_sold = 0;

#Droping unwanted columns
ALTER TABLE ev_sales_by_State
DROP COLUMN `Sl.No`;

# Define foreign keys
ALTER TABLE Ev_Sales_by_State
ADD CONSTRAINT fk_state_date
FOREIGN KEY (Date)
REFERENCES dim_date(Date);
