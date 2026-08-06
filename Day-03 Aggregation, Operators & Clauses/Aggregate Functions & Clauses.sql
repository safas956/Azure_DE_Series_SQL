SELECT * FROM ECOMMERCE


--AGGREGATE FUNCTIONS
--SUM()
--Calculates the total of a numeric column.
--Adds all values in a specified numeric column.
--Commonly used to calculate total sales, profit, revenue, or quantity.
--Ignores NULL values.

-- Find the total sales for each category.

SELECT SUM(SALES) AS TOTAL_SALES FROM ECOMMERCE
--AVG()
--Calculates the average (mean) value of a numeric column. Adds all values and divides by the number of non-NULL values.
--Useful for finding average sales, profit, or discount. 
Ignores NULL values.

SELECT AVG(SALES) AS TOTAL_SALES FROM ECOMMERCE

-- MAX()
-- Returns the largest value in a column. Works with numbers, dates, and text.
-- Used to find the highest sales, latest order date, or maximum profit. Ignores NULL values.

SELECT MAX(SALES) AS TOTAL_SALES FROM ECOMMERCE

--MIN()
--Returns the smallest value in a column. Works with numbers, dates, and text. 
--Useful for finding the earliest date, lowest sales, or minimum profit.  Ignores NULL values.

SELECT MIN(SALES) AS TOTAL_SALES FROM ECOMMERCE

--COUNT
-- Counts rows or non-NULL values. There are three common variations:
--a. Counts every row, including those containing NULL values.
--b. Counts only rows where the mentioned column is not NULL.
--c. Counts the number of unique values.

SELECT COUNT(*) AS TOTAL_COUNT  FROM ECOMMERCE
SELECT COUNT(PAYMENT_METHOD) AS TOTAL_COUNT  FROM ECOMMERCE

--DISTINCT
--It is often combined with aggregate functions.It removes the duplicate rows

--WHERE- It is used to filter rows based on a specified condition. Only the records that satisfy the condition are returned.

I am revising my SQL and Azure data engineering concepts. As part of it, today is day 3 . 

I learned and practiced about SQL operators: AND, OR, NOT, LIKE, BETWEEN, IN  and SQL Aggregate functions like SUM, AVG, MAX, MIN, COUNT, DISTINCT and SQL clauses like SELECT, WHERE, GROUP BY, ORDER BY, HAVING, DISTINCT, TOP. 



To work in real time, I connected the Azure SQL database with SSMS on local machine like day 2. I uploaded the E-Commerce dataset this time and practiced the SQL operators, aggregation functions and SQL clauses. In this way, I incorporated theory and practice. Connected SSMS with Azure SQL DB and practiced it real time. 



So I want you to create carousel of my SQL practice with slides 20 slides explaining each topic 3-4 lines to post it on linkedin and attract my linkedin community. Utilize the empty spaces in slides and use the exact code that I have used. I have uploaded a reference file. Please create carousel on the same format and it should be attracted by recruiters. You are a recruiter and please create in such a way.



* Canvas size: 1080 × 1350 px (ideal for LinkedIn carousels).

* Colors: Azure blue, white, and dark gray for a clean, professional look.

* Typography: One heading font (e.g., Poppins) and one body font (e.g., Inter).

* Consistency: Repeat the same header, footer, and color palette across every carousel.





Use the exact code snippets that I have pasted below



This is the reference code for SQL Operators



--AND

--This operator combines multiple conditions. All conditions must be TRUE for a row to be returned



-- Find customers who purchased sarees and made payment using card

SELECT CUSTOMER_ID, CUSTOMER_NAME, [SUB-CATEGORY],PAYMENT_METHOD FROM ECOMMERCE

WHERE [SUB-CATEGORY]='SAREES' AND PAYMENT_METHOD='CARD'

--OR

--This operator combines multiple conditions. A row is returned if at least one condition is TRUE. It broadens the search results.



-- Find customers belonging who belongs to the cities Bengaluru or Chennai

SELECT CUSTOMER_ID, CUSTOMER_NAME, CITY FROM ECOMMERCE

WHERE CITY='BENGALURU' OR CITY='CHENNAI'

--NOT

--This is used to exclude rows that satisfy a condition. It returns the opposite (negation) of the specified condition.



--Display customers who are only from the South region.

SELECT ORDER_ID, CUSTOMER_NAME, REGION, CITY FROM ECOMMERCE

WHERE REGION NOT IN ('SOUTH','EAST','NORTH')

-- IN 

--This operator is used to filter rows by checking whether a value exists in a list of specified values. It is a shorter and cleaner alternative to using multiple OR conditions.



--Find the customers who made the payment using card and cod from south region

SELECT CUSTOMER_ID, CUSTOMER_NAME,PAYMENT_METHOD,CITY

FROM ECOMMERCE

WHERE PAYMENT_METHOD IN ('COD', 'Card') AND REGION='SOUTH'



--BETWEEN

-- This operator filters values within a specified range. It includes both the starting and ending values (inclusive). 

--It can be used with numbers, dates, and text.



-- Find orders placed between January 1, 2022 and December 31, 2022.

SELECT ORDER_ID,ORDER_DATE

FROM ECOMMERCE

WHERE ORDER_DATE BETWEEN '05-05-2022' AND '07-29-2022'

SELECT * FROM ECOMMERCE



--LIKE

--This operator searches for a pattern in text values.

--Common wildcards:

--% → Represents zero or more characters.

--_ → Represents exactly one character.



--Display all products whose name starts with the letter 'neha'.

SELECT CUSTOMER_NAME FROM ECOMMERCE

WHERE CUSTOMER_NAME LIKE 'NEHA%'



--Display all customers whose city name end with the letter 'bad'.

SELECT CUSTOMER_NAME,CITY FROM ECOMMERCE

WHERE CITY LIKE '%BAD'



This is the reference code for Aggregate functions and SQL clauses



-- Display all orders where Sales is greater than 500.

SELECT ORDER_ID, REVENUE FROM ECOMMERCE

WHERE REVENUE > 2000

ORDER BY REVENUE ASC



-- Find all customers from south region.

SELECT ORDER_ID,CUSTOMER_ID,REGION,CITY

FROM ECOMMERCE

WHERE REGION='SOUTH' AND CITY='CHENNAI'



-- Retrieve orders where Discount is greater than 20%.

SELECT ORDER_ID, CATEGORY,[SUB-CATEGORY],DISCOUNT

FROM ECOMMERCE

WHERE DISCOUNT > 0.20





-- Find the average sales value

SELECT ROUND(AVG(SALES),3) AS TOTAL_SALES FROM ECOMMERCE

SELECT COUNT(*) AS TOTAL_COUNT  FROM ECOMMERCE



-- Find the total sales value

SELECT SUM(SALES) AS TOTAL_SALES FROM ECOMMERCE



-- Find the unique/different cities  

SELECT DISTINCT(CATEGORY) AS TOTAL_CUSTOMERS  FROM ECOMMERCE

SELECT * FROM ECOMMERCE



--Find the total sales for each sub-category

SELECT [SUB-CATEGORY], SUM(SALES) AS TOTAL_SALES

FROM ORDERS

GROUP BY [SUB-CATEGORY]



--Display the top 5 cities with the highest total revenue.

SELECT CITY, SUM(REVENUE) AS TOTAL_REVENUE

FROM ECOMMERCE

GROUP BY CITY

ORDER BY TOTAL_REVENUE DESC



SELECT TOP 5 CITY, SUM(REVENUE) AS TOTAL_REVENUE

FROM ECOMMERCE

GROUP BY CITY

ORDER BY TOTAL_REVENUE DESC



--Find the average customer rating for each payment method.

SELECT PAYMENT_METHOD,ROUND(AVG(CUSTOMER_RATING),2) AS AVG_CUSTOMER_RATING

FROM ECOMMERCE

GROUP BY PAYMENT_METHOD



-- List all categories whose total sales exceed 300,000.

SELECT CATEGORY, SUM(SALES) AS TOTAL_SALES 

FROM ECOMMERCE

GROUP BY CATEGORY

HAVING SUM(SALES) > 300000

ORDER BY SUM(SALES) DESC



-- List all categories whose total sales in south region exceed 300,000.

SELECT CATEGORY, SUM(SALES) AS TOTAL_SALES_IN_SOUTH 

FROM ECOMMERCE

WHERE REGION='SOUTH' 

GROUP BY CATEGORY

HAVING SUM(SALES) > 300000

ORDER BY SUM(SALES) DESC



--Show sub-categories having more than 100 orders.

SELECT COUNT(*) FROM ECOMMERCE

SELECT [SUB-CATEGORY],COUNT(*) AS TOTAL_ORDERS

FROM ORDERS

GROUP BY [SUB-CATEGORY]

HAVING COUNT(*) > 100



--Find the average sales for each city and display the cities in descending order.

SELECT CITY, ROUND(AVG(SALES),2) AS AVG_SALES

FROM ECOMMERCE

GROUP BY CITY

ORDER BY AVG_SALES DESC



--Which payment methods generated more than ₹100,000 in revenue?

SELECT SUM(REVENUE) FROM ECOMMERCE

SELECT PAYMENT_METHOD,SUM(REVENUE) AS TOTAL_REVENUE

FROM ECOMMERCE

GROUP BY PAYMENT_METHOD

HAVING SUM(REVENUE) > 100000

ORDER BY SUM(REVENUE) DESC



--Display the top 3 categories with the highest average profit.

SELECT TOP 3 CATEGORY, ROUND(AVG(SALES),2) AS AVG_SALES

FROM ECOMMERCE

GROUP BY CATEGORY

ORDER BY AVG(SALES) DESC



--Find the number of orders placed in each region and city.

SELECT REGION,CITY,COUNT(*) AS TOTAL_ORDERS

FROM ECOMMERCE

GROUP BY REGION,CITY

ORDER BY CITY ASC,TOTAL_ORDERS DESC