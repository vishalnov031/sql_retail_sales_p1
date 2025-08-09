-- SQL Retail sales analysis
-- Create the table

Create table retail_sales(
	transactions_id	int Primary Key,
	sale_date date,
	sale_time time,	
	customer_id	int,
	gender varchar(8),
	age int,	
	category varchar(15), 
	quantiy int,
	price_per_unit float,
	cogs float,
	total_sale float
	)
select count( *)
from retail_sales
 ;

 select *
 from retail_sales 
 where transactions_id is Null;

  select *
 from retail_sales 
 where sale_time is Null;
 --DATA CLEANING
 select *
 from retail_sales 
 where transactions_id IS NULL
 or sale_date is NULL
 OR sale_time IS NULL
 OR gender IS NULL
 OR CATEGORY IS NULL
 OR quantiy IS NULL
 OR COGS IS NULL
 OR total_sale IS NULL;

 DELETE FROM  RETAIL_SALES
 where transactions_id IS NULL
 or sale_date is NULL
 OR sale_time IS NULL
 OR gender IS NULL
 OR CATEGORY IS NULL
 OR quantiy IS NULL
 OR COGS IS NULL
 OR total_sale IS NULL;
 SELECT COUNT(*)
 FROM retail_sales;

 --DATA EXPLORATION 

 --HOW MANY SALES WE HAVE

 SELECT COUNT(*) AS TOTAL_SALES
 FROM retail_sales

 --HOW MANY CUSTOMERS WE HAVE

 SELECT COUNT(DISTINCT(CUSTOMER_ID)) AS TOTAL_CUSTOMER
 FROM RETAIL_SALES;

--HOW MANY CATEGORY WE HAVE

 SELECT COUNT(DISTINCT(category)) AS TOTAL_CUSTOMER
 FROM RETAIL_SALES;

 SELECT DISTINCT CATEGORY AS TOTAL_CATEGORY FROM retail_sales;


 -- DATA ANALYSIS & BUSINESS KEY PROBLEM & ANSWERS

 SELECT *
 FROM retail_sales
 WHERE SALE_DATE IN ('2022-11-05');


 SELECT *
 FROM retail_sales
 WHERE category='CLOTHING'
 AND MONTH(SALE_DATE)=11 AND YEAR(SALE_DATE)=2022 AND quantiy>=4
 GROUP BY CATEGORY ;
 

 -- WRITE A SQL QUERY THE TOTAL SALES FOR EACH CATEGORY
 SELECT CATEGORY,SUM(TOTAL_SALE) AS TOTAL_SALES, COUNT(*) AS TOTAL_ORDERS
 FROM retail_sales
 GROUP BY CATEGORY;


 --WRITE A SQL QUERY TO FIND THE AVERAGE AGE OF CUSTIMERS WHO PURCHASED ITEMS FROM THE 'BEAUTY' CATEGORY
 SELECT AVG(AGE)
 FROM retail_sales
 WHERE category='BEAUTY';


 -- WRITE A SQL QUERY TO FIND ALL THE TRANSACTIONS WHERE THE TOTAL SALES IS GREATER THAN 1000.
 SELECT *
 FROM retail_sales
 WHERE total_sale>1000;


 --WRITE A SQL QUERY TO FIND THE TOTAL NUMBER OF TRANSACTIONS(TRANSACTION_ID) MADE BY EACH GENDER IN EACH CATEGORY


 SELECT CATEGORY,
 GENDER,COUNT(*) AS TOTAL_TRANS
 FROM retail_sales
 GROUP BY CATEGORY,GENDER;


 --WRITE A SQL QUERY TO CALCULATE THE AVERAGE SALE FOR EACH MONTH. FIND OUT BEST SELLING MONTH IN EACH YEAR.
 
 SELECT 
 YEAR(SALE_DATE) AS YEAR_NUM ,MONTH(SALE_DATE) AS MONTH_NUM,
 AVG(TOTAL_SALE) AS AVG_SALE,
 RANK() OVER(PARTITION BY EXTRACT(YEAR FROM SALE_DATE) ORDER BY AVG(TOTAL_SALE) DESC)
 FROM retail_sales
 GROUP BY YEAR(SALE_DATE) ,MONTH(SALE_DATE)
 ORDER BY YEAR(SALE_DATE) ,AVG(total_sale) DESC



 -- WRITE THE SQL QUERY TO FIND THE TOP 5 CUSTOMERS BASED ON THE HIGHEST TOTAL SALES.
 SELECT TOP 5 customer_id,SUM(TOTAL_SALE) AS TOTAL_SALES
 FROM RETAIL_SALES
 GROUP BY customer_id
 ORDER BY SUM(TOTAL_sALE) DESC


 --WRITE A SQL QUERY TO FIND THE NUMBER OF UNIQUE CUSTOMERS WHO PURCHASED ITEMS FROM EACH CATEGORY.


 SELECT category,
 Count(Distinct(customer_id)) count_of_unique_customer
 FROM retail_sales
 GROUP BY category


 -- write a sql query to create each shift and number of orders(Example Morning<=12, Afternoon Between 12 & 17, Evening>17)
 WITH HOURLY_SALE
 AS
 (
 
 select *,
	case
		when DATEPART(HOUR,sale_time) <12 THEN 'MORNING' 
		WHEN DATEPART(HOUR,SALE_TIME) BETWEEN 12 AND 17 THEN 'AFTERNOON'
		ELSE 'EVENING'
	END AS SHIFT
 from retail_sales
 )
 SELECT SHIFT,COUNT(*) AS TOTAL_ORDERS
 FROM HOURLY_SALE
 GROUP BY SHIFT



 --END OF PROJECT