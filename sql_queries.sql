
-- Amazon Sales Data Analysis SQL Queries
-- Dataset: amazon_sales_4500_rows.csv

-- 1. Overall Business Performance
SELECT
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM amazon_sales;

-- 2. Monthly Sales and Profit Trend
SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM amazon_sales
GROUP BY month
ORDER BY month;

-- 3. Top 5 Revenue Generating Products
SELECT
    product_name,
    ROUND(SUM(sales), 2) AS total_sales
FROM amazon_sales
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 5;

-- 4. Category-wise Sales and Profit
SELECT
    category,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM amazon_sales
GROUP BY category
ORDER BY total_profit DESC;

-- 5. Discount Impact on Profitability
SELECT
    CASE
        WHEN discount / sales < 0.10 THEN 'Low Discount'
        WHEN discount / sales BETWEEN 0.10 AND 0.20 THEN 'Medium Discount'
        ELSE 'High Discount'
    END AS discount_bucket,
    ROUND(SUM(profit), 2) AS total_profit
FROM amazon_sales
GROUP BY discount_bucket;

-- 6. State-wise Sales Performance
SELECT
    state,
    ROUND(SUM(sales), 2) AS total_sales
FROM amazon_sales
GROUP BY state
ORDER BY total_sales DESC;

-- 7. Region-wise Profit Contribution
SELECT
    region,
    ROUND(SUM(profit), 2) AS total_profit
FROM amazon_sales
GROUP BY region
ORDER BY total_profit DESC;

-- 8. Repeat Customers Analysis
SELECT
    customer_id,
    COUNT(order_id) AS total_orders
FROM amazon_sales
GROUP BY customer_id
HAVING COUNT(order_id) > 1
ORDER BY total_orders DESC;

-- 9. Shipping Mode Efficiency
SELECT
    shipping_mode,
    ROUND(AVG(DATEDIFF(ship_date, order_date)), 2) AS avg_delivery_days
FROM amazon_sales
GROUP BY shipping_mode;

-- 10. Loss Making Orders
SELECT
    order_id,
    sales,
    profit
FROM amazon_sales
WHERE profit < 0;
