# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `p1_retail_db`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `p1_retail_db`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
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
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
SELECT COUNT(*) FROM retail_sales;
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;

select *
 from retail_sales 
 where transactions_id IS NULL
 or sale_date is NULL
 OR sale_time IS NULL
 OR gender IS NULL
 OR CATEGORY IS NULL
 OR quantiy IS NULL
 OR COGS IS NULL
 OR total_sale IS NULL;;

DELETE FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
```

### 3.DATA ANALYSIS & BUSINESS KEY PROBLEM & ANSWERS

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
SELECT *
FROM retail_sales
WHERE SALE_DATE IN ('2022-11-05');
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:
```sql
SELECT *
FROM retail_sales
WHERE category='CLOTHING'
AND MONTH(SALE_DATE)=11 AND YEAR(SALE_DATE)=2022 AND quantiy>=4
GROUP BY CATEGORY ;
```

3. **WRITE A SQL QUERY THE TOTAL SALES FOR EACH CATEGORY.**
```sql
SELECT CATEGORY,SUM(TOTAL_SALE) AS TOTAL_SALES, COUNT(*) AS TOTAL_ORDERS
FROM RETAIL_SALES
GROUP BY CATEGORY;
```

4. **WRITE A SQL QUERY TO FIND THE AVERAGE AGE OF CUSTIMERS WHO PURCHASED ITEMS FROM THE 'BEAUTY' CATEGORY.**:
```sql
SELECT AVG(AGE)
FROM retail_sales
WHERE category='BEAUTY';
```

5. **WRITE A SQL QUERY TO FIND ALL THE TRANSACTIONS WHERE THE TOTAL SALES IS GREATER THAN 1000.**:
```sql
SELECT *
FROM retail_sales
WHERE total_sale>1000;
```

6. **WRITE A SQL QUERY TO FIND THE TOTAL NUMBER OF TRANSACTIONS(TRANSACTION_ID) MADE BY EACH GENDER IN EACH CATEGORY.**:
```sql
SELECT CATEGORY,
GENDER,COUNT(*) AS TOTAL_TRANS
FROM retail_sales
GROUP BY CATEGORY,GENDER;
```

7. **WRITE A SQL QUERY TO CALCULATE THE AVERAGE SALE FOR EACH MONTH. FIND OUT BEST SELLING MONTH IN EACH YEAR.**:
```sql
SELECT 
       YEAR,
       MONTH,
    AVG_SALE
FROM 
(    
SELECT 
    YEAR(SALE_DATE) AS YEAR,
    MONTH(SALE_DATE) AS MONTH,
    AVG(TOTAL_SALE) AS AVG_SALE,
    RANK() OVER(PARTITION BY YEAR(SALE_DATE) ORDER BY AVG(TOTAL_SALE) DESC) AS RANK
FROM RETAIL_SALES
GROUP BY 1, 2
) AS T1
WHERE RANK = 1
```

8. **WRITE THE SQL QUERY TO FIND THE TOP 5 CUSTOMERS BASED ON THE HIGHEST TOTAL SALES.**:
```sql
SELECT TOP 5 CUSTOMER_ID,SUM(TOTAL_SALE) AS TOTAL_SALES
FROM RETAIL_SALES
GROUP BY CUSTOMER_ID
ORDER BY SUM(TOTAL_SALE) DESC
```

9. **WRITE A SQL QUERY TO FIND THE NUMBER OF UNIQUE CUSTOMERS WHO PURCHASED ITEMS FROM EACH CATEGORY.**:
```sql
SELECT category,
COUNT(DISTINCT(CUSTOMER_ID)) COUNT_OF_UNIQUE_CUST
FROM RETAIL_SALES
GROUP BY CATEGORY
```

10. **WRITE A SQL QUERY TO CREATE EACH SHIFT AND NUMBER OF ORDERS(EXAMPLE MORNING<= 12, AFTERNOON IS BETWEEN 12 AND 17 AND AFTERNOON>=17**:
```sql
 WITH HOURLY_SALE
 AS
 (
 
 SELECT *,
	CASE
		WHEN DATEPART(HOUR,SALE_TIME) <12 THEN 'MORNING' 
		WHEN DATEPART(HOUR,SALE_TIME) BETWEEN 12 AND 17 THEN 'AFTERNOON'
		ELSE 'EVENING'
	END AS SHIFT
 from RETAIL_SALES
 )
 SELECT SHIFT,COUNT(*) AS TOTAL_ORDERS
 FROM HOURLY_SALE
 GROUP BY SHIFT
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

## How to Use

1. **Clone the Repository**: Clone this project repository from GitHub.
2. **Set Up the Database**: Run the SQL scripts provided in the `database_setup.sql` file to create and populate the database.
3. **Run the Queries**: Use the SQL queries provided in the `analysis_queries.sql` file to perform your analysis.
4. **Explore and Modify**: Feel free to modify the queries to explore different aspects of the dataset or answer additional business questions.


