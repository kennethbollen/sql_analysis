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
ORDER BY cnt DESC

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
GROUP BY o.PaymentType

-- The average price paid by card processor monthly in 2015 ranked by the average price paid for the year

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
GROUP BY o.PaymentType

