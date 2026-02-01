DROP TABLE IF EXISTS pizza_sales;

CREATE TABLE pizza_sales (
    pizza_id INT,
    order_id INTEGER,
    pizza_name_id VARCHAR(50),
    quantity SMALLINT,
    order_date DATE,
    order_time TIME,
    unit_price REAL,
    total_price REAL,
    pizza_size VARCHAR(50),
    pizza_category VARCHAR(50),
    pizza_ingredients  VARCHAR(200),
    pizza_name VARCHAR(50)
);
select*from pizza_sales;
 SELECT 
    (SUM(total_price), 2) AS total_revenue
FROM pizza_sales;

SELECT 
    SUM(total_price) / COUNT(DISTINCT order_id) AS avg_order_value
FROM pizza_sales;

SELECT 
    SUM(quantity) AS total_pizzas_sold
FROM pizza_sales;

SELECT 
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales;

SELECT 
    SUM(quantity)::numeric / COUNT(DISTINCT order_id) AS avg_pizzas_per_order
FROM pizza_sales;

-- CHARTS REQUIRMENTS QUERIES
SELECT 
    TO_CHAR(order_date, 'Day') AS order_day,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY order_day
ORDER BY total_orders DESC;

SELECT 
    TO_CHAR(order_date, 'Month') AS order_month,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY order_month
ORDER BY MIN(order_date);


SELECT 
    pizza_category,
    SUM(total_price) AS total_sales,
    SUM(total_price) * 100.0 /
        (SELECT SUM(total_price)
         FROM pizza_sales
         WHERE EXTRACT(MONTH FROM order_date) = 1) AS pct
FROM pizza_sales
WHERE EXTRACT(MONTH FROM order_date) = 1
GROUP BY pizza_category;



SELECT 
    pizza_size,
    CAST(SUM(total_price) AS DECIMAL(10,2)) AS total_sales,
    CAST(
        SUM(total_price) * 100.0 /
        (SELECT SUM(total_price)
         FROM pizza_sales
         WHERE EXTRACT(QUARTER FROM order_date) = 1)
        AS DECIMAL(10,2)
    ) AS pct
FROM pizza_sales
WHERE EXTRACT(QUARTER FROM order_date) = 1
GROUP BY pizza_size
ORDER BY pct DESC;


SELECT 
    pizza_name,
    SUM(quantity) AS total_pizzas_sold
FROM pizza_sales
WHERE EXTRACT(MONTH FROM order_date) = 8
GROUP BY pizza_name
ORDER BY total_pizzas_sold DESC
LIMIT 5;




SELECT 
    pizza_name,
    SUM(quantity) AS total_pizzas_sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_pizzas_sold ASC
LIMIT 5;


























 