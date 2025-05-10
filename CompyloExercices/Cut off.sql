-- =============================================
-- Author:		Nawfel HAMDI
-- Create date: 10/05/2025
-- Description : Find the student name that have total marks less than 120
-- =============================================


SELECT * FROM [dbo].[CutOff_S_MARKS]
SELECT * FROM [dbo].[CutOff_STUDENTS]

-- SOLUTION 1
WITH CTE AS (
SELECT 
*,
SUM(Marks) OVER (PARTITION BY SId) AS TotalMarksPerStudent
FROM [dbo].[CutOff_S_MARKS]
)

SELECT DISTINCT S.SName FROM [dbo].[CutOff_STUDENTS] AS S
JOIN CTE
ON CTE.SId = S.SId
WHERE TotalMarksPerStudent < 120

-- SOLUTION 2

SELECT * FROM [dbo].[CutOff_STUDENTS] AS S
WHERE S.SId IN (
	SELECT SId FROM [dbo].[CutOff_S_MARKS] AS M
	GROUP BY SId
	HAVING SUM(M.Marks)  < 120
)

-- S3
SELECT DISTINCT S.SName 
FROM [dbo].[CutOff_STUDENTS] AS S
JOIN [dbo].[CutOff_S_MARKS] AS M
ON S.SId = M.SId 
WHERE S.SId IN (
	SELECT SId FROM [dbo].[CutOff_S_MARKS] AS M
	GROUP BY SId
	HAVING SUM(M.Marks) < 120
)