-- =============================================
-- Author:		Nawfel HAMDI
-- Create date: 12/05/2025
-- Description : Find the managers that live in the same location of its employee
-- Table :[dbo].[ProjectManagerTable] -- [dbo].[EmpTable]
-- =============================================

SELECT * FROM  [dbo].[EmpTable]
SELECT * FROM  [dbo].[ProjectManagerTable]


WITH CTE_MangersDetails AS 
(
  SELECT 
	  M.ProjectCode,
	  M.ManagerID,
	  E.EmpID,
	  E.Location,
	  E.EmpName AS ManagerName 
  FROM [dbo].[ProjectManagerTable] AS M
  JOIN [dbo].[EmpTable] AS E
  ON M.ManagerID = E.EmpID
)
SELECT * FROM [dbo].[EmpTable] AS E
JOIN CTE_MangersDetails AS M
ON E.ProjectCode = M.ProjectCode AND E.Location = M.Location
WHERE E.EmpID <> M.EmpID


SELECT * FROM  [dbo].[EmpTable]
SELECT * FROM  [dbo].[ProjectManagerTable]
