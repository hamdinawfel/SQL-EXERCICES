
---------------------------------------------------------------
--1: Average of multiple columns
---------------------------------------------------------------
SELECT Student_Name,
   (SELECT ROUND(AVG(c), 2) 
      FROM (VALUES(PC_Semester_1),
	               (PC_Semester_2),
				   (PC_Semester_3),
				   (PC_Semester_4),
				   (PC_Semester_5),
				   (PC_Semester_6)) AS T(c))
   AS [Average]
FROM Max_Value_From_Table_1