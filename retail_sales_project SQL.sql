-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
-- My Analysis & Findings

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05--

SELECT 
    *
FROM
    `sql - retail sales analysis_utf`
WHERE
    sale_date = '2022-11-05';


-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022

select ï»¿transactions_id from `sql - retail sales analysis_utf`
where category = 'clothing' and
quantiy >10 and
extract(month from sale_date)as month = 11
and extract(year from sale_date) as year=2022;

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT 
    category, SUM(total_sale) AS total
FROM
    `sql - retail sales analysis_utf`
GROUP BY category
ORDER BY total DESC;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT 
    AVG(age)
FROM
    `sql - retail sales analysis_utf`
WHERE
    category = 'beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT 
    ï»¿transactions_id, total_sale
FROM
 `sql - retail sales analysis_utf`
WHERE
    total_sale > 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT 
    category, gender, COUNT(age) AS transactions
FROM
    `sql - retail sales analysis_utf`
GROUP BY category , gender;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

SELECT 
    customer_id, SUM(total_sale) AS highest
FROM
    `sql - retail sales analysis_utf`
GROUP BY customer_id
ORDER BY highest DESC
LIMIT 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT 
    category, COUNT(DISTINCT customer_id) AS uniqu
FROM
    `sql - retail sales analysis_utf`
GROUP BY category
ORDER BY uniqu DESC;
   
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
-- My Analysis & Findings
