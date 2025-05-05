-- Revenue Contribution per Product (as % of Total) --

SELECT p.product_name,
       SUM(sp.close_value) AS revenue,
       ROUND(100.0 * SUM(sp.close_value) / 
         (SELECT SUM(close_value) FROM sales_pipeline WHERE LOWER(deal_stage) IN ('closed', 'won', 'closed won')), 2
       )  AS percent_of_total
FROM sales_pipeline sp
JOIN products p ON sp.product_id = p.product_id
WHERE LOWER(sp.deal_stage) IN ('closed', 'won', 'closed won')
GROUP BY p.product_name
ORDER BY percent_of_total DESC;