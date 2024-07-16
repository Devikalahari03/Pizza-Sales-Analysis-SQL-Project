### BASIC QUERIES ###

---- retrieve the total number of orders placed?

SELECT 
    COUNT(order_id) AS total_orders
FROM
    pizzahut.orders;

----calculate the total revenue generated from pizza sales?

SELECT 
    ROUND(SUM(p.price * o.quantity), 2) AS revenue
FROM
    pizzahut.pizzas AS p
        INNER JOIN
    pizzahut.order_details o ON p.pizza_id = o.pizza_id;

-----Identify the highest-priced pizza.----

SELECT 
    p2.name, p1.price
FROM
    pizzahut.pizza_types AS p2
        INNER JOIN
    pizzahut.pizzas p1 ON p1.pizza_type_id = p2.pizza_type_id
ORDER BY p1.price DESC
LIMIT 1;

---- Identify the most common pizza size ordered??

SELECT 
    COUNT(o.order_details_id) AS cnt, p.size
FROM
    pizzahut.pizzas AS p
        INNER JOIN
    pizzahut.order_details o ON p.pizza_id = o.pizza_id
GROUP BY p.size
LIMIT 1;
 
 ---List the top 5 most ordered pizza types along with their quantities.??
 
 SELECT 
    p.pizza_type_id, sum(o.quantity) AS qty
FROM
    pizzahut.pizzas AS p
        INNER JOIN
    order_details o ON p.pizza_id = o.pizza_id
GROUP BY p.pizza_type_id
ORDER BY qty DESC
LIMIT 5;
 
 ### INTERMEDIATE LEVEL ###
 
 ---- Join the necessary tables to find the total quantity of each pizza category ordered.??
 
 SELECT 
    p1.category, SUM(o.quantity) AS qty
FROM
    pizzahut.pizza_types AS p1
        JOIN
    pizzahut.pizzas p2 ON p1.pizza_type_id = p2.pizza_type_id
        JOIN
    pizzahut.order_details o ON o.pizza_id = p2.pizza_id
GROUP BY p1.category
ORDER BY qty DESC;
 
 ----Determine the distribution of orders by hour of the day.

SELECT 
    COUNT(order_id) AS total_orders, HOUR(order_time) AS hrs
FROM
    pizzahut.orders
GROUP BY hrs;
 
 -------Join relevant tables to find the category-wise distribution of pizzas.??
 
SELECT 
    COUNT(name) AS pizza, category
FROM
    pizzahut.pizza_types
GROUP BY category;

-----Group the orders by date and calculate the average number of pizzas ordered per day.??

SELECT 
    ROUND(AVG(a.qty), 0)
FROM
    (SELECT 
        o1.order_date, SUM(o2.quantity) AS qty
    FROM
        orders AS o1
    JOIN order_details o2 ON o1.order_id = o2.order_id
    GROUP BY o1.order_date) a



------Determine the top 3 most ordered pizza types based on revenue.??

SELECT 
    p.name, (p1.price * o.quantity) AS revenue
FROM
    pizzas AS p1
        JOIN
    pizzahut.order_details o ON p1.pizza_id = o.pizza_id
        JOIN
    pizzahut.pizza_types p ON p.pizza_type_id = p1.pizza_type_id
ORDER BY revenue DESC
LIMIT 3;


#### Advance Level ####

------Calculate the percentage contribution of each pizza type to total revenue.


select p2.category ,round(sum(p.price*o.quantity) / (SELECT 
    ROUND(SUM(p.price * o.quantity),2) as total_sales FROM
    pizzahut.order_details AS o INNER JOIN
    pizzahut.pizzas p ON p.pizza_id = o.pizza_id)*100,2) as revenue_p
from pizzahut.pizza_types as p2
join pizzahut.pizzas p on p2.pizza_type_id = p.pizza_type_id 
join pizzahut.order_details o on o.pizza_id = p.pizza_id
group by p2.category
order by revenue_p desc;



--------Determine the top 3 most ordered pizza types based on revenue for each pizza category.

select name, revenue, rnk from 
(select category, name, revenue, rank() over(partition by category order by revenue desc ) as rnk from
(select pt.category, pt.name, round(sum(p.price*o.quantity),0) as revenue from order_details as o
join pizzas p on o.pizza_id = p.pizza_id
join pizza_types pt on p.pizza_type_id = pt.pizza_type_id
group by pt.category, pt.name) a) b
where rnk <= 3;

------ Analyse the cumulative revenue generated over time??

select order_date, sum(total_sales) over (order by order_date) as cum_revenue from 
(SELECT o1.order_date,
    ROUND(SUM(p.price * o.quantity),2) as total_sales FROM
    pizzahut.order_details AS o INNER JOIN
    pizzahut.pizzas p ON p.pizza_id = o.pizza_id
    inner join pizzahut.orders o1 on o1.order_id = o.order_id
    group by o1.order_date) as sales
