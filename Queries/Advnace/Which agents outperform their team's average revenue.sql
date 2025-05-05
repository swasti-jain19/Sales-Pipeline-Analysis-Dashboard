-- Agent Performance vs. Team Average --

SELECT st.agent_id,
       st.sales_agent,
       st.team_name,
       SUM(sp.close_value) AS agent_revenue,
       (
         SELECT AVG(sp2.close_value)
         FROM sales_pipeline sp2
         JOIN sales_teams st2 ON sp2.agent_id = st2.agent_id
         WHERE st2.team_name = st.team_name
       ) AS team_avg_revenue
FROM sales_pipeline sp
JOIN sales_teams st ON sp.agent_id = st.agent_id
WHERE LOWER(sp.deal_stage) IN ('closed', 'won', 'closed won')
GROUP BY st.agent_id, st.sales_agent, st.team_name
HAVING SUM(sp.close_value) >
       (
         SELECT AVG(sp2.close_value)
         FROM sales_pipeline sp2
         JOIN sales_teams st2 ON sp2.agent_id = st2.agent_id
         WHERE st2.team_name = st.team_name
       );
