-- What is the gross margin of out stock

SELECT ROUND((sub.retail_value - sub.stock_value) / sub.retail_value, 2) * 100 AS margin
FROM
(SELECT SUM(p.QuantityOnHand * pv.WholesalePrice) AS stock_value, SUM(p.RetailPrice * p.QuantityOnHand) AS retail_value
FROM SalesOrdersExample.dbo.Products AS p
LEFT JOIN SalesOrdersExample.dbo.Product_Vendors AS pv
ON p.ProductNumber = pv.ProductNumber) AS sub

-- “List the engagement numbers that have a contract price greater than or equal to the overall average contract price.”

SELECT e.EngagementNumber
FROM EntertainmentAgencyExample.dbo.Engagements AS e
WHERE e.ContractPrice >= 
(SELECT AVG(e2.ContractPrice) AS avg_cont
FROM EntertainmentAgencyExample.dbo.Engagements AS e2)

-- “How many different products were ordered on order number 553, and what was the total cost of that order?”

SELECT COUNT(DISTINCT p.ProductName) AS prod_name, SUM(od.QuantityOrdered * od.QuotedPrice) AS total_cost
FROM SalesOrdersExample.dbo.Order_Details AS od
INNER JOIN SalesOrdersExample.dbo.Products AS p
ON od.ProductNumber = p.ProductNumber
WHERE od.OrderNumber = 553


