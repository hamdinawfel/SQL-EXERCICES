-- =============================================
-- Author:		Nawfel HAMDI
-- Create date: 01/05/2025
-- Description : Display oll the subject conctinated with , for every rows
-- Table : [dbo].[Multiple_To_1_Line_String_Agg]
-- =============================================

SELECT * FROM  [dbo].[Multiple_To_1_Line_String_Agg]

SELECT 
	T.Student_ID,
	T.Student_Name,
    String_Agg(T.Subject, ',') AS Subjects
FROM  [dbo].[Multiple_To_1_Line_String_Agg] AS T
GROUP BY T.Student_ID, T.Student_Name

