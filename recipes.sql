-- “I need all the recipe types, and then all the recipe names and preparation instructions, and then any matching ingredient step numbers, ingredient quantities, and ingredient measurements, and finally all ingredient names from my recipes database, sorted in recipe title and step number sequence.”
-- recipe_class left join with recipes to get all the recipe types
-- recipes left join with recipe ingredients to bridge to ingredients
-- inner join ingredients with measurements to get the matching ingredients with their measurements

SELECT rc.RecipeClassDescription, r.RecipeTitle, r.Preparation, ri.RecipeSeqNo, ri.Amount, m.MeasurementDescription, i.IngredientName
FROM 
(((RecipesExample.dbo.Recipe_Classes AS rc
LEFT JOIN RecipesExample.dbo.Recipes AS r
ON rc.RecipeClassID = r.RecipeClassID)
LEFT JOIN RecipesExample.dbo.Recipe_Ingredients AS ri
ON ri.RecipeID = r.RecipeID)
INNER JOIN RecipesExample.dbo.Ingredients AS i
ON i.IngredientID = ri.IngredientID)
INNER JOIN RecipesExample.dbo.Measurements AS m
ON m.MeasureAmountID = i.MeasureAmountID
ORDER BY r.RecipeTitle
