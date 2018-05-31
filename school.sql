-- “List the faculty members not teaching a class.”

SELECT s.StaffID, s.StfFirstName, s.StfLastname
FROM SchoolSchedulingExample.dbo.Staff AS s
LEFT JOIN SchoolSchedulingExample.dbo.Faculty_Classes AS fc
ON s.StaffID = fc.StaffID
WHERE fc.ClassID IS NULL
