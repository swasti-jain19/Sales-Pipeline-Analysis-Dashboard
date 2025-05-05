-- Agent Specialization by Sector --

SELECT a.sector,
       st.sales_agent,
       COUNT(*) AS deals_closed
FROM sales_pipeline sp
JOIN accounts a ON sp.account_id = a.account_id
JOIN sales_teams st ON sp.agent_id = st.agent_id
WHERE LOWER(deal_stage) IN ('closed', 'won', 'closed won')
GROUP BY a.sector, st.sales_agent
HAVING COUNT(*) = (
  SELECT MAX(cnt)
  FROM (
    SELECT COUNT(*) AS cnt
    FROM sales_pipeline sp2
    JOIN accounts a2 ON sp2.account_id = a2.account_id
    WHERE a2.sector = a.sector
      AND LOWER(sp2.deal_stage) IN ('closed', 'won', 'closed won')
    GROUP BY sp2.agent_id
  ) sub
)
ORDER BY sector;