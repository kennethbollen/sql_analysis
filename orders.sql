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
