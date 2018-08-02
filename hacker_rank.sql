--Given the table schemas below, write a query to print the company_code, founder name, total number of lead managers, total number of senior managers, total number of managers, and total number of employees. Order your output by ascending company_code.
SELECT  c.company_code, c.founder, COUNT(DISTINCT lm.lead_manager_code) AS cnt_lm, COUNT(DISTINCT sm.senior_manager_code) AS cnt_sm, COUNT(DISTINCT m.manager_code) AS cnt_m, COUNT(DISTINCT e.employee_code)
FROM
(((company AS c
LEFT JOIN lead_manager AS lm
ON c.company_code = lm.company_code)
LEFT JOIN senior_manager AS sm
ON sm.lead_manager_code = lm.lead_manager_code)
LEFT JOIN manager AS m
ON m.senior_manager_code = sm.senior_manager_code)
LEFT JOIN employee AS e 
ON e.manager_code = m.manager_code
GROUP BY c.company_code, c.founder
ORDER BY c.company_code

