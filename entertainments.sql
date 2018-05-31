-- “List entertainers who have never been booked.”
-- left join entertainers to the engagement table
-- filter where engagement number is NULL

SELECT ent.EntStageName
FROM
EntertainmentAgencyExample.dbo.Entertainers AS ent
LEFT JOIN EntertainmentAgencyExample.dbo.Engagements AS eng
ON ent.EntertainerID = eng.EntertainerID
WHERE eng.EngagementNumber IS NULL
