-- BASIC
-- retrieve the total number of orders placed.

SELECT 
    COUNT(order_id)
FROM
    orders;

-- calculate the total revenue generated from pizza sales.

SELECT 
    ROUND(SUM(od.quantity * p.price), 2) AS revenue
FROM
    order_details AS od
        JOIN
    pizzas AS p ON od.pizza_id = p.pizza_id
ORDER BY revenue;

-- identify the highest-price pizza.

SELECT 
    pt.name, p.price
FROM
    pizza_types AS pt
        JOIN
    pizzas AS p ON pt.pizza_type_id = p.pizza_type_id
ORDER BY p.price DESC
LIMIT 1;

-- identify the most common pizza size ordered.

SELECT 
    p.size, SUM(od.quantity) AS ordered
FROM
    order_details AS od
        JOIN
    pizzas AS p ON od.pizza_id = p.pizza_id
GROUP BY p.size
ORDER BY ordered DESC;

-- list the top 5 most ordered pizza types along with their quantities.

SELECT 
    pt.name, SUM(od.quantity) AS most_pizza_ordered
FROM
    pizza_types AS pt
        JOIN
    pizzas AS p ON pt.pizza_type_id = p.pizza_type_id
        JOIN
    order_details AS od ON p.pizza_id = od.pizza_id
GROUP BY pt.name
ORDER BY most_pizza_ordered DESC
LIMIT 5;

-- INTERMEDIATE:

-- join the necessary tables to find the total quantity of each pizza category ordered.

SELECT 
    pt.category, SUM(od.quantity) AS category
FROM
    pizza_types AS pt
        JOIN
    pizzas AS p ON pt.pizza_type_id = p.pizza_type_id
        JOIN
    order_details AS od ON p.pizza_id = od.pizza_id
GROUP BY pt.category
ORDER BY category DESC;

-- determine the distribution of orders by hour of the day.

select count(order_id) as ordered,order_time from orders
group by order_time order by ordered desc;

-- join relevant tables to find the category-wise distribution of pizzas.

SELECT 
    category, COUNT(name) AS orders
FROM
    pizza_types
GROUP BY category
ORDER BY orders DESC;

-- group the order by date and calculate the avereage number of pizzas ordered per day.

SELECT 
    ROUND(AVG(orders), 0) as average
FROM
    (SELECT 
        SUM(od.quantity) AS orders, o.order_date
    FROM
        order_details AS od
    JOIN orders AS o ON od.order_id = o.order_id
    GROUP BY o.order_date) AS quantity;

-- determine the top 3 most ordered pizza types based on revenue.

SELECT 
    pt.name, SUM(od.quantity * p.price) AS revenue
FROM
    pizza_types AS pt
        JOIN
    pizzas AS p ON pt.pizza_type_id = p.pizza_type_id
        JOIN
    order_details AS od ON p.pizza_id = od.pizza_id
GROUP BY pt.name
ORDER BY revenue DESC
LIMIT 3;

-- ADVANCED:

-- calculate the precentage contribution of each pizza to total revenue.

SELECT 
    pt.category, SUM(od.quantity * p.price) AS presentage
FROM
    pizza_types AS pt
        JOIN
    pizzas AS p ON pt.pizza_type_id = p.pizza_type_id
        JOIN
    order_details AS od ON p.pizza_id = od.pizza_id
GROUP BY pt.category
ORDER BY presentage DESC;

-- analyze the cumulative revenue generate over time.

select order_date,revenue,
sum(revenue) over (order by order_date) as sm from
(select o.order_date,sum(od.quantity*p.price)as revenue from orders as o
join order_details as od
on o.order_id=od.order_id
join pizzas as p
on od.pizza_id=p.pizza_id
group by o.order_date order by revenue) ascumulative;

-- determine the top 3 most ordered pizza types based on revenue for each pizza category.
select name,revenue from
(select name,category,revenue,
rank() over(partition by category order by revenue desc) as rnk from
(select pt.name,pt.category,round(sum(od.quantity*p.price),0) as revenue from pizza_types as pt
join pizzas as p
on pt.pizza_type_id=p.pizza_type_id
join order_details as od
on p.pizza_id=od.pizza_id
group by pt.category,pt.name order by revenue desc) as sales) as pawan
where rnk<=3;

