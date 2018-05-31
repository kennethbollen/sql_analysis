-- “I need all the recipe types, and then all the recipe names and preparation instructions, and then any matching ingredient step numbers, 
-- ingredient quantities, and ingredient measurements, and finally all ingredient names from my recipes database, 
-- sorted in recipe title 
-- and step number sequence.”
-- because we need all the recipe types and all the recipe names we need a full outer join with recipe type with recipes
-- we keep all the recipes names and do a left join with recipe inregients
-- we're looking for the matching ingredient measurements, so we do an inner join between recipe ingredients with measurements
-- lastly we're looking for all the ingredient names but need to keep all the recipe types and recipe names so we need another full outer join

SELECT rc.RecipeClassDescription, r.RecipeTitle, r.Preparation, ri.Amount, ri.RecipeSeqNo, m.MeasurementDescription, i.IngredientName
FROM
(((RecipesExample.dbo.Recipe_Classes AS rc
FULL JOIN RecipesExample.dbo.Recipes AS r
ON rc.RecipeClassID = r.RecipeClassID)
LEFT JOIN RecipesExample.dbo.Recipe_Ingredients AS ri
ON ri.RecipeID = r.RecipeID)
INNER JOIN RecipesExample.dbo.Measurements AS m
ON m.MeasureAmountID = ri.MeasureAmountID)
FULL JOIN RecipesExample.dbo.Ingredients AS i
ON i.MeasureAmountID = m.MeasureAmountID
ORDER BY r.RecipeTitle

-- “What products have never been ordered?”

SELECT p.ProductName, od.QuantityOrdered
FROM SalesOrdersExample.dbo.Products AS p
LEFT JOIN SalesOrdersExample.dbo.Order_Details AS od
ON p.ProductNumber = od.ProductNumber
WHERE od.QuantityOrdered IS NULL

-- “Display all customers and any orders for bicycles.”

SELECT c.CustLastName, SUM(RD.rev) AS cust_val
FROM SalesOrdersExample.dbo.Customers AS c
LEFT JOIN
(SELECT o.CustomerID, p.ProductName, p.RetailPrice, od.QuantityOrdered, (p.RetailPrice * od.QuantityOrdered) AS rev
FROM
((SalesOrdersExample.dbo.Orders AS o
INNER JOIN SalesOrdersExample.dbo.Order_Details AS od
ON o.OrderNumber = od.OrderNumber)
INNER JOIN SalesOrdersExample.dbo.Products AS p
ON p.ProductNumber = od.ProductNumber)
INNER JOIN SalesOrdersExample.dbo.Categories AS c
ON c.CategoryID = p.CategoryID
WHERE c.CategoryID = 2) AS RD
ON c.CustomerID = RD.CustomerID
GROUP BY c.CustLastName
ORDER BY cust_val DESC

-- FULL OUTER JOIN on Non-Key Values

-- “Show me all the students and all the teachers and list together those who have the same first name."
-- full outer join students and staff on first names

SELECT s.StudFirstName, s.StudLastName, st.StfFirstName, st.StfLastname
FROM
SchoolSchedulingExample.dbo.Students AS s
FULL JOIN SchoolSchedulingExample.dbo.Staff AS st
ON s.StudFirstName = st.StfFirstName
ORDER BY s.StudFirstName, st.StfFirstName


