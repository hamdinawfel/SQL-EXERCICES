
-- =============================================
-- Author:		Nawfel HAMDI
-- Create date: 12/04/2025
-- Description:	Low Salary Situation
-- =============================================

SELECT *   FROM EmpDeptWiseSalary
ORDER BY EmpSalary, DeptID DESC 

Select EmpID,EmpName,DeptId,EmpSalary
 From (
Select *
      , RowNum  = Row_Number() over (Partition By DeptId Order By EmpSalary Desc)
      , CountLogic = count(1) over (Partition By DeptId) --to check number of employees
 From  dbo.EmpDeptWiseSalary
      ) EDWS
 Where RowNum = case when CountLogic < 3 then CountLogic else 3 end
