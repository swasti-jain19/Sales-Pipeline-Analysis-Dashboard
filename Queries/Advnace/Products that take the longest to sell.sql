--  Longest Sales Cycles by Product --

SELECT p.product_name,
       ROUND(AVG(close_date - engage_date),2) AS avg_sales_cycle_days
FROM sales_pipeline sp
JOIN products p ON sp.product_id = p.product_id
WHERE close_date IS NOT NULL
GROUP BY p.product_name
ORDER BY avg_sales_cycle_days DESC
LIMIT 5;