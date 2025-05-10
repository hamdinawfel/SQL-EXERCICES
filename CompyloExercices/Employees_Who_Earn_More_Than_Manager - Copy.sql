-- =============================================
-- Author:		Nawfel HAMDI
-- Create date: 05/05/2025
-- =============================================
SELECT * FROM [dbo].[Employees_Who_Earn_More_Than_Manager] AS E

SELECT * FROM [dbo].[Employees_Who_Earn_More_Than_Manager] AS E
INNER JOIN [dbo].[Employees_Who_Earn_More_Than_Manager] AS M
ON E.Manager_ID = M.EmpID
WHERE E.EmpSalary > M.EmpSalary