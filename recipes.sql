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
