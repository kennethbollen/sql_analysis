-- What is the gross margin of out stock

SELECT ROUND((sub.retail_value - sub.stock_value) / sub.retail_value, 2) * 100 AS margin
FROM
(SELECT SUM(p.QuantityOnHand * pv.WholesalePrice) AS stock_value, SUM(p.RetailPrice * p.QuantityOnHand) AS retail_value
FROM SalesOrdersExample.dbo.Products AS p
LEFT JOIN SalesOrdersExample.dbo.Product_Vendors AS pv
ON p.ProductNumber = pv.ProductNumber) AS sub
