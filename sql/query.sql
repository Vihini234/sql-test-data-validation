
-- SQL Test Data Validation Queries
-- Each query simulates a real QA data-validation check.

-- 1. Find customers missing an email address (data quality check)
SELECT customer_id, name
FROM customers
WHERE email IS NULL;

-- 2. Find orders where total_amount doesn't match the sum of line items
SELECT o.order_id, o.total_amount, SUM(oi.price * oi.quantity) AS calculated_total
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY o.order_id
HAVING o.total_amount != calculated_total;

-- 3. Find orders referencing a customer that doesn't exist (orphaned record)
SELECT o.order_id, o.customer_id
FROM orders o
LEFT JOIN customers c ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

-- 4. Count of orders per customer
SELECT c.name, COUNT(o.order_id) AS order_count
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.name;

-- 5. Customers with zero orders
SELECT c.customer_id, c.name
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- 6. Average order value across all orders
SELECT AVG(total_amount) AS average_order_value
FROM orders;

-- 7. Highest-value order per customer
SELECT customer_id, MAX(total_amount) AS highest_order
FROM orders
GROUP BY customer_id;

-- 8. Products ordered more than once (repeat items across orders)
SELECT product_name, COUNT(*) AS times_ordered
FROM order_items
GROUP BY product_name
HAVING COUNT(*) > 1;

-- 9. Total revenue per product
SELECT product_name, SUM(price * quantity) AS total_revenue
FROM order_items
GROUP BY product_name
ORDER BY total_revenue DESC;

-- 10. Orders with no line items at all (data completeness check)
SELECT o.order_id
FROM orders o
LEFT JOIN order_items oi ON o.order_id = oi.order_id
WHERE oi.item_id IS NULL;

-- 11. Customers whose total spend exceeds a threshold (e.g. 50)
SELECT c.name, SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.name
HAVING SUM(o.total_amount) > 50;

-- 12. Full order detail view (join across all three tables)
SELECT c.name, o.order_id, o.order_date, oi.product_name, oi.price, oi.quantity
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
ORDER BY o.order_id;
