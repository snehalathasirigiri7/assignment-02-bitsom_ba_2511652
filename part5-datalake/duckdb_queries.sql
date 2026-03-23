
-- Q1: List all customers along with the total number of orders they have placed
SELECT
    c.customer_id,
    c.name,
    COUNT(o.order_id) AS total_orders
FROM read_csv_auto('customers.csv') AS c
LEFT JOIN read_json_auto('orders.json') AS o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_orders DESC;

-- Q2: Find the top 3 customers by total order value
SELECT
    c.customer_id,
    c.name,
    SUM(o.total_amount) AS total_order_value
FROM read_csv_auto('customers.csv') AS c
JOIN read_json_auto('orders.json') AS o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_order_value DESC
LIMIT 3;

-- Q3: List all products purchased by customers from Bangalore
SELECT DISTINCT
    p.product_id,
    p.product_name
FROM read_csv_auto('customers.csv') AS c
JOIN read_json_auto('orders.json') AS o
    ON c.customer_id = o.customer_id
JOIN read_parquet('products.parquet') AS p
    ON p.product_id = UNNEST(o.items).product_id
WHERE c.city = 'Bangalore';

-- Q4: Join all three files
SELECT
    c.name AS customer_name,
    o.order_date,
    p.product_name,
    i.quantity
FROM read_csv_auto('customers.csv') AS c
JOIN read_json_auto('orders.json') AS o
    ON c.customer_id = o.customer_id
JOIN UNNEST(o.items) AS i(product_id, quantity)
    ON TRUE
JOIN read_parquet('products.parquet') AS p
    ON p.product_id = i.product_id
ORDER BY c.name, o.order_date;
