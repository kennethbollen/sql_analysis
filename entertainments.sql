-- “List entertainers who have never been booked.”
-- left join entertainers to the engagement table
-- filter where engagement number is NULL

SELECT ent.EntStageName
FROM
EntertainmentAgencyExample.dbo.Entertainers AS ent
LEFT JOIN EntertainmentAgencyExample.dbo.Engagements AS eng
ON ent.EntertainerID = eng.EntertainerID
WHERE eng.EngagementNumber IS NULL

-- “Show me all musical styles and the customers who prefer those styles.”
-- left join musical style with musical preferances
-- left join musical preferences with customers

SELECT ms.StyleName, c.CustFirstName, c.CustLastName
FROM
(EntertainmentAgencyExample.dbo.Musical_Styles AS ms
LEFT JOIN EntertainmentAgencyExample.dbo.Musical_Preferences AS mp
ON ms.StyleID = mp.StyleID)
LEFT JOIN EntertainmentAgencyExample.dbo.Customers AS c
ON c.CustomerID = mp.CustomerID
ORDER BY ms.StyleName
