-- =============================================
-- Author:		Nawfel HAMDI
-- Create date: 13/04/2025
-- Description:	Window Functions
-- Link : https://datawithbaraa.substack.com/p/your-guide-to-sql-window-functions - https://www.youtube.com/watch?v=Wvg4PjbMTO8
-- =============================================

SELECT * FROM EmpDeptWiseSalary
Select 
	DeptID,
	SUM(EmpSalary) AS TotalSalary
from dbo.EmpDeptWiseSalary
GROUP BY DeptID

SELECT 
    EmpName,
	DeptID,
	SUM(EmpSalary) OVER(PARTITION BY DeptID)
FROM EmpDeptWiseSalary


