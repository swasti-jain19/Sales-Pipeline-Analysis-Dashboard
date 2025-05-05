--  1. List all products with their sales count --

SELECT p.product_id, 
	p.product_name, 
	COUNT(sp.opportunity_id) AS total_sales
FROM products p
LEFT JOIN sales_pipeline sp ON p.product_id = sp.product_id
GROUP BY p.product_id, p.product_name;

-- 2. Average sale price of each product series --

SELECT series, 
	AVG(sales_price) AS avg_price 
	FROM products GROUP BY series;

-- 3. Revenue generated per product --

SELECT p.product_name, 
	SUM(sp.close_value) AS total_revenue
FROM products p
JOIN sales_pipeline sp ON p.product_id = sp.product_id
GROUP BY p.product_name;

-- 4. Most popular product by opportunity count --

SELECT p.product_name, 
	COUNT(sp.opportunity_id) AS count
FROM products p
JOIN sales_pipeline sp ON p.product_id = sp.product_id
GROUP BY p.product_name
ORDER BY count DESC
LIMIT 1;

-- 5. Revenue by sector --

SELECT a.sector, 
	SUM(sp.close_value) AS revenue
FROM accounts a
JOIN sales_pipeline sp ON a.account_id = sp.account_id
GROUP BY a.sector;

-- 6. Top 3 sectors by opportunity count --

SELECT a.sector, 
	COUNT(*) AS opps
FROM accounts a
JOIN sales_pipeline sp ON a.account_id = sp.account_id
GROUP BY a.sector
ORDER BY opps DESC
LIMIT 3;

-- 7. Average deal size by sector --

SELECT a.sector, 
	ROUND(AVG(sp.close_value),2) AS avg_deal
FROM accounts a
JOIN sales_pipeline sp ON a.account_id = sp.account_id
GROUP BY a.sector;

-- 8. Opportunities by account age (before/after year 2000) --

SELECT 
    CASE WHEN a.year_established < 2000 THEN 'Before 2000' ELSE '2000 and After' END AS era,
    COUNT(*) 
FROM accounts a
JOIN sales_pipeline sp ON a.account_id = sp.account_id
GROUP BY era;

-- 9. Total revenue from accounts with subsidiaries --

SELECT SUM(sp.close_value) Total_Subsidiaries_revenue
FROM accounts a
JOIN sales_pipeline sp ON a.account_id = sp.account_id
WHERE a.subsidiary_of IS NOT NULL;

-- 10. Product revenue by sector --

SELECT a.sector, 
	p.product_name, 
	SUM(sp.close_value) AS revenue
FROM sales_pipeline sp
JOIN products p ON sp.product_id = p.product_id
JOIN accounts a ON sp.account_id = a.account_id
GROUP BY a.sector, p.product_name;
