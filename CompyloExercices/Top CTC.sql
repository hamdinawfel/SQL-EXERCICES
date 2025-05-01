-- =============================================
-- Author:		Nawfel HAMDI
-- Create date: 30/04/2025
-- Description:	CTC : reduce the sallary  to 75 % of top 3 earners for each departmement
-- =============================================

SELECT * FROM (
	SELECT *,
			RANK() OVER (PARTITION BY DeptID ORDER BY EmpSalary DESC) AS RankedSallary
	FROM [dbo].[Department_Wise_Top_3_Salaries] 
	) AS T1
WHERE RankedSallary <= 3

--SELECT * FROM [dbo].[Department_Wise_Top_3_Salaries] ORDER BY DeptID, EmpSalary
--SELECT * FROM [dbo].[Dept_Wise_Top_3_Salaries_DeptDetails]
--SELECT * FROM [dbo].[Dept_Wise_Top_3_Salaries_EmpDetails]

SELECT * FROM (
	SELECT  ED.EmpID,
		 RANK() OVER (PARTITION BY DeptID ORDER BY EmpSalary DESC) AS RankedSallary
		FROM [dbo].[Dept_Wise_Top_3_Salaries_EmpDetails] AS ED
		JOIN [dbo].[Dept_Wise_Top_3_Salaries_DeptDetails] AS DD
		ON ED.EmpID = DD.EmpID
	) AS T2
WHERE RankedSallary <= 3

