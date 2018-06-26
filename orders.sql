--Number of orders with each code
--Number of orders whose price is in the range $0–$10, $10–$100, $100–$1,000, and over $1,000
--Total revenue for each code

SELECT o.PaymentType,
SUM(CASE WHEN 0 <= o.TotalPrice AND o.TotalPrice < 10 THEN 1 ELSE 0 END) AS price_0_10,
SUM(CASE WHEN 10 <= o.TotalPrice AND o.TotalPrice < 100 THEN 1 ELSE 0 END) AS price_10_100,
SUM(CASE WHEN 100 <= o.TotalPrice AND o.TotalPrice < 1000 THEN 1 ELSE 0 END) AS price_100_1000,
SUM(CASE WHEN o.TotalPrice >= 1000 THEN 1 ELSE 0 END) AS price_over_1000,
COUNT(*) AS cnt,
SUM(o.TotalPrice) AS rev
FROM SQLBook.dbo.Orders AS o
GROUP BY o.PaymentType
ORDER BY cnt DESC;

-- How do the number of purchases vary by month for different payment types in 2015?

SELECT ROW_NUMBER() OVER(ORDER BY COUNT(*) DESC) AS ranking_by_cnt,
o.PaymentType,
SUM(CASE WHEN MONTH(o.OrderDate) = 1 THEN 1 ELSE 0 END) AS jan,
SUM(CASE WHEN MONTH(o.OrderDate) = 2 THEN 1 ELSE 0 END) AS feb,
SUM(CASE WHEN MONTH(o.OrderDate) = 3 THEN 1 ELSE 0 END) AS mar,
SUM(CASE WHEN MONTH(o.OrderDate) = 4 THEN 1 ELSE 0 END) AS apr,
SUM(CASE WHEN MONTH(o.OrderDate) = 5 THEN 1 ELSE 0 END) AS may,
SUM(CASE WHEN MONTH(o.OrderDate) = 6 THEN 1 ELSE 0 END) AS jun,
SUM(CASE WHEN MONTH(o.OrderDate) = 7 THEN 1 ELSE 0 END) AS jul,
SUM(CASE WHEN MONTH(o.OrderDate) = 8 THEN 1 ELSE 0 END) AS aug,
SUM(CASE WHEN MONTH(o.OrderDate) = 9 THEN 1 ELSE 0 END) AS sep,
SUM(CASE WHEN MONTH(o.OrderDate) = 10 THEN 1 ELSE 0 END) AS oct,
SUM(CASE WHEN MONTH(o.OrderDate) = 11 THEN 1 ELSE 0 END) AS nov,
SUM(CASE WHEN MONTH(o.OrderDate) = 12 THEN 1 ELSE 0 END) AS december
FROM SQLBook.dbo.Orders AS o
WHERE YEAR(o.OrderDate) = 2015
GROUP BY o.PaymentType;

-- The average price paid by card processor monthly in 2015 ranked by the average price paid for the year
-- This CASE has no ELSE clause because the default is NULL which works for AVG

SELECT 
ROW_NUMBER() OVER(ORDER BY AVG(o.TotalPrice) DESC) AS ranking,
o.PaymentType AS ccard,
AVG(CASE WHEN MONTH(o.OrderDate) = 1 THEN o.TotalPrice END) AS jan,
AVG(CASE WHEN MONTH(o.OrderDate) = 2 THEN o.TotalPrice END) AS feb,
AVG(CASE WHEN MONTH(o.OrderDate) = 3 THEN o.TotalPrice END) AS mar,
AVG(CASE WHEN MONTH(o.OrderDate) = 4 THEN o.TotalPrice END) AS apr,
AVG(CASE WHEN MONTH(o.OrderDate) = 5 THEN o.TotalPrice END) AS may,
AVG(CASE WHEN MONTH(o.OrderDate) = 6 THEN o.TotalPrice END) AS jun,
AVG(CASE WHEN MONTH(o.OrderDate) = 7 THEN o.TotalPrice END) AS jul,
AVG(CASE WHEN MONTH(o.OrderDate) = 8 THEN o.TotalPrice END) AS aug,
AVG(CASE WHEN MONTH(o.OrderDate) = 9 THEN o.TotalPrice END) AS sep,
AVG(CASE WHEN MONTH(o.OrderDate) = 10 THEN o.TotalPrice END) AS oct,
AVG(CASE WHEN MONTH(o.OrderDate) = 11 THEN o.TotalPrice END) AS nov,
AVG(CASE WHEN MONTH(o.OrderDate) = 12 THEN o.TotalPrice END) AS decb
FROM SQLBook.dbo.Orders AS o
WHERE YEAR(o.OrderDate) = 2015
GROUP BY o.PaymentType;

-- What is the distribution of orders by state and how is this related to the state’s population?
-- The first subquery counts the number of orders and the second calculates the population.
-- These are combined using UNION ALL, to ensure that all states that occur in either table are included in the final result.

SELECT State, SUM(num_orders) AS orders, SUM(pop) AS tot_pop
FROM
((SELECT o.State, COUNT(*) AS num_orders, 0 AS pop
FROM
SQLBook.dbo.Orders AS o
GROUP BY o.State)
UNION ALL
(SELECT z.Stab, 0 AS num_orders, SUM(z.TotPop) AS pop
FROM
SQLBook.dbo.ZipCensus AS z
GROUP BY z.Stab)) summary
GROUP BY State
ORDER BY orders DESC;

-- What is the distribution of orders by state, for states that have more than 2% of the orders?
SELECT
(CASE WHEN bystate.cnt >= 0.02 * total.cnt THEN bystate.State ELSE 'OTHER' END) AS state,
SUM(bystate.cnt) AS cnt
FROM
-- First subquery calculates the total orders by each state
(SELECT o.State, COUNT(*) AS cnt
FROM SQLBook.dbo.Orders AS o
GROUP BY o.State) bystate
CROSS JOIN
-- Second subquery calculates the total orders because this only produces one row, we need to use a CROSS JOIN
(SELECT COUNT(*) AS cnt
FROM SQLBook.dbo.Orders) total
GROUP BY (CASE WHEN bystate.cnt >= 0.02 * total.cnt THEN bystate.State ELSE 'OTHER' END)
ORDER BY cnt DESC;

-- What is the distribution of the number of orders in the 20 states that have the largest number of orders?

SELECT
(CASE WHEN sub.seq_num <= 20 THEN sub.State ELSE 'OTHER' END) AS state,
SUM(sub.cnt) AS num_orders
FROM
(SELECT o.State, COUNT(*) AS cnt,
ROW_NUMBER() OVER(ORDER BY COUNT(*) DESC) AS seq_num
FROM SQLBook.dbo.Orders AS o
GROUP BY o.State) sub
GROUP BY (CASE WHEN sub.seq_num <= 20 THEN sub.State ELSE 'OTHER' END)
ORDER BY num_orders DESC;

