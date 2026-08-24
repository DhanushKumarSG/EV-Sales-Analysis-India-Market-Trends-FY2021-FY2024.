# Checking Table structure
Describe ev_sales.dim_date;
SELECT * FROM dim_date;

# Changing data type
update ev_sales.dim_date
set date = str_to_date(Date, '%d-%m-%Y');

Alter table ev_sales.dim_date
modify Date Date;

# Adding Primary key
Alter table ev_sales.dim_date
add primary key(Date);

#Checking date range
SELECT
MIN(Date),
MAX(Date)
FROM dim_date;

select distinct date from dim_date;