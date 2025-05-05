-- 1. Total number of agents

SELECT COUNT(*) FROM sales_teams;

-- 2. Number of deals per agent

SELECT agent_id, 
	COUNT(*) AS deals
FROM sales_pipeline
GROUP BY agent_id;

-- 3. Revenue generated per agent

SELECT agent_id, 
	SUM(close_value) AS revenue
FROM sales_pipeline
GROUP BY agent_id
ORDER BY revenue DESC;

-- 4. Deals per regional office

SELECT st.regional_office, 
	COUNT(sp.opportunity_id) AS deals
FROM sales_pipeline sp
JOIN sales_teams st ON sp.agent_id = st.agent_id
GROUP BY st.regional_office;

-- 5. Revenue per regional office

SELECT st.regional_office, 
	SUM(sp.close_value) AS revenue
FROM sales_pipeline sp
JOIN sales_teams st ON sp.agent_id = st.agent_id
GROUP BY st.regional_office;

-- 6. Number of agents per manager

SELECT manager, 
	COUNT(*) AS agent_count
FROM sales_teams
GROUP BY manager;

-- 7. Total revenue per manager

SELECT st.manager, 
	SUM(sp.close_value) AS revenue
FROM sales_pipeline sp
JOIN sales_teams st ON sp.agent_id = st.agent_id
GROUP BY st.manager;

-- 8. Regional office with highest average deal size

SELECT st.regional_office, 
	ROUND(AVG(sp.close_value),2) AS avg_deal
FROM sales_pipeline sp
JOIN sales_teams st ON sp.agent_id = st.agent_id
GROUP BY st.regional_office
ORDER BY avg_deal DESC
LIMIT 1;

-- 9. Agent with most deals

SELECT agent_id, COUNT(*) AS deal_count
FROM sales_pipeline
GROUP BY agent_id
ORDER BY deal_count DESC
LIMIT 1;

-- 10. Agents handling opportunities with > $10k close value

SELECT DISTINCT st.sales_agent
FROM sales_pipeline sp
JOIN sales_teams st ON sp.agent_id = st.agent_id
WHERE sp.close_value > 10000;
