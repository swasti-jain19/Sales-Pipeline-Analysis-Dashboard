-- 1. Total number of opportunities

SELECT 
	COUNT(*) 
	FROM sales_pipeline;

-- 2. Total revenue from closed deals

SELECT 
	SUM(close_value) AS total_revenue 
	FROM sales_pipeline 
	WHERE deal_stage = 'Won';

-- 3. Number of won vs lost deals

SELECT 
	deal_stage, 
	COUNT(*) 
	FROM sales_pipeline 
	GROUP BY deal_stage;

-- 4. Opportunities per product

SELECT 
	product_id, 
	COUNT(*) 
	FROM sales_pipeline 
	GROUP BY product_id;

-- 5. Revenue by product

SELECT 
	product_id, 
	SUM(close_value) AS revenue 
	FROM sales_pipeline 
	GROUP BY product_id;

-- 6. Average deal value by agent

SELECT 
	agent_id, 
	ROUND(AVG(close_value),2) AS avg_value 
	FROM sales_pipeline 
	GROUP BY agent_id;

-- 7. Top 5 agents by revenue

SELECT 
	agent_id, 
	SUM(close_value) AS revenue 
	FROM sales_pipeline 
GROUP BY agent_id 
ORDER BY revenue DESC 
LIMIT 5;

-- 8. Count of opportunities engaged per year

SELECT 
	EXTRACT(YEAR FROM engage_date) AS year, 
	COUNT(*) 
FROM sales_pipeline 
GROUP BY EXTRACT(YEAR FROM engage_date);

-- 9. Number of active opportunities (not closed)

SELECT 
COUNT(*) AS active_opportunities 
FROM sales_pipeline 
WHERE deal_stage != 'Closed';
