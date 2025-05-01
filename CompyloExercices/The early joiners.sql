-- =============================================
-- Author:		Nawfel HAMDI
-- Create date: 01/05/2025
-- =============================================

-- =============================================
-- Early Joiners:	
-- =============================================

SELECT E.Emp_Name AS Emplyee, E.Date_Of_Joining,  M.Emp_Name AS Manager , E.*
FROM [dbo].[Employees_Joined_Earlier_Than_Manager] AS E
JOIN [dbo].[Employees_Joined_Earlier_Than_Manager]  AS M
ON E.Manager_ID = M.Emp_ID
WHERE E.Date_Of_Joining < M.Date_Of_Joining

-- =============================================
-- 	find record from N to M
-- =============================================
SELECT * FROM [dbo].[EmpDeptWiseSalary] AS E
ORDER BY E.EmpSalary
OFFSET 3 ROWS FETCH NEXT 4 ROWS ONLY

