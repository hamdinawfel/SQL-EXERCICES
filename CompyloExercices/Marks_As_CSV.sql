-- =============================================
-- Author:		Nawfel HAMDI
-- Create date: 05/05/2025
-- =============================================
SELECT * FROM Marks_As_CSV
-- Find the sum of marks for each student
---- S1
SELECT Student_ID, Student_Name,  SUM(CONVERT(INT, Value)) AS TotalMarks FROM (
	SELECT 
		M.Student_ID, 
		M.Student_Name,
		Value
	FROM Marks_As_CSV AS M
	CROSS APPLY STRING_SPLIT(M.Marks, ',')
) AS T
GROUP BY  Student_ID, Student_Name

-- S2

SELECT Student_ID, Student_Name, TotalMarks
FROM Marks_As_CSV 
	CROSS APPLY (
	SELECT TotalMarks = SUM(CAST(Value AS INT)) FROM STRING_SPLIT(Marks, ',') 
) AS T
