-- Key Questions --
-- Q:1 Coffee Consumers Count --
-- How many people in each city are estimated to consume coffee, given that 25% of the population does?

-- Q2: Total Revenue from Coffee Sales --
-- What is the total revenue generated from coffee sales across all cities in the last quarter of 2023?

-- Q3: Sales Count for Each Product --
-- How many units of each coffee product have been sold?

-- Q4: Average Sales Amount per City --
-- What is the average sales amount per customer in each city?

-- Q5:City Population and Coffee Consumers --
-- Provide a list of cities along with their populations and estimated coffee consumers.

-- Q6:Top Selling Products by City --
-- What are the top 3 selling products in each city based on sales volume?

-- Q7:Customer Segmentation by City --
-- How many unique customers are there in each city who have purchased coffee products?

-- Q8:Average Sale vs Rent --
-- Find each city and their average sale per customer and avg rent per customer

-- Q9:Monthly Sales Growth --
-- Sales growth rate: Calculate the percentage growth (or decline) in sales over different time periods (monthly).

-- Q10:Market Potential Analysis
-- Identify top 3 city based on highest sales, return city name, total sale, total rent, total customers, estimated coffee consumer

-- SOLVE BUSINESS PROBLEMS WITH SQL --

-- Q:1 Coffee Consumers Count --
-- How many people in each city are estimated to consume coffee, given that 25% of the population does?

with pawan as(
select * from products
join sales
on products.product_id=sales.product_id)
select c.city_name,count( distinct cus.customer_id) from city as c
join customers as cus
on c.city_id=cus.city_id
join pawan as p
on cus.customer_id=p.customer_id
where p.product_name like '%coffee%'
group by c.city_name;

-- Q2: Total Revenue from Coffee Sales --
-- What is the total revenue generated from coffee sales across all cities in the last quarter of 2023?

SELECT 
    c.city_name, SUM(s.total) AS total
FROM
    city AS c
        JOIN
    customers AS cs ON c.city_id = cs.city_id
        JOIN
    sales AS s ON cs.customer_id = s.customer_id
WHERE
    EXTRACT(YEAR FROM sale_date) = 2023
        AND EXTRACT(QUARTER FROM s.sale_date) = 4
GROUP BY c.city_name
ORDER BY total DESC;

-- Q3: Sales Count for Each Product --
-- How many units of each coffee product have been sold?

SELECT 
    p.product_name, COUNT(s.sale_id) AS units
FROM
    products AS p
        JOIN
    sales AS s ON p.product_id = s.product_id
GROUP BY p.product_name
ORDER BY units DESC;

-- Q4: Average Sales Amount per City --
-- What is the average sales amount per customer in each city?

SELECT 
    c.city_name,
    COUNT(DISTINCT s.customer_id) AS counts,
    ROUND(SUM(s.total), 2) AS avgerage
FROM
    city AS c
        JOIN
    customers AS cs ON c.city_id = cs.city_id
        JOIN
    sales AS s ON cs.customer_id = s.customer_id
GROUP BY c.city_name
ORDER BY avgerage DESC;

-- Q5:City Population and Coffee Consumers --
-- Provide a list of cities along with their populations and estimated coffee consumers.

select c.city_name,count(s.customer_id) as consumers from city as c
join customers as cs
on c.city_id=cs.city_id
join sales as s
on cs.customer_id=s.customer_id
group by c.city_name;

-- Q6:Top Selling Products by City --
-- What are the top 3 selling products in each city based on sales volume?
with pawan as(
select c.city_name,p.product_name,count(s.sale_id),
row_number()over(partition by c.city_name order by count(s.sale_id) desc) as rn
from city as c
join customers as cs on c.city_id=cs.city_id
join sales as s on cs.customer_id=s.customer_id
join products as p on s.product_id=p.product_id
group by c.city_name,p.product_name) 
select * from pawan
where rn in (1,2,3);

-- Q8:Average Sale vs Rent --
-- Find each city and their average sale per customer and avg rent per customer

SELECT 
    c.city_name, COUNT(DISTINCT s.customer_id) AS rent
FROM
    city AS c
        JOIN
    customers ON c.city_id = customers.city_id
        JOIN
    sales AS s ON customers.customer_id = s.customer_id
GROUP BY c.city_name
ORDER BY rent DESC;

-- Q9:Monthly Sales Growth --
-- Sales growth rate: Calculate the percentage growth (or decline) in sales over different time periods (monthly).

-- Q10:Market Potential Analysis
-- Identify top 3 city based on highest sales, return city name, total sale, total rent, total customers, estimated coffee consumer

SELECT 
    c.city_name,
    SUM(s.total) AS sales,
    COUNT(DISTINCT s.customer_id) AS customers
FROM
    city AS c
        JOIN
    customers AS cs ON c.city_id = cs.city_id
        JOIN
    sales AS s ON cs.customer_id = s.customer_id
GROUP BY c.city_name
ORDER BY sales DESC
LIMIT 3;

