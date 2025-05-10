-- =============================================
-- Author:		Nawfel HAMDI
-- Create date: 05/05/2025
-- =============================================

-- TASK : FIND DISTINCT WITHOUT  DISTINCT

SELECT * FROM [dbo].[Distinct_Without_Distinct]
--DISTINCT
SELECT DISTINCT ID, Name FROM [dbo].[Distinct_Without_Distinct]
--GROUP BY
SELECT ID, Name FROM [dbo].[Distinct_Without_Distinct] GROUP BY  ID, Name
--UNION
SELECT * FROM [dbo].[Distinct_Without_Distinct] 
UNION 
SELECT * FROM [dbo].[Distinct_Without_Distinct] 
-- INTERSECT
SELECT * FROM [dbo].[Distinct_Without_Distinct] 
INTERSECT 
SELECT * FROM [dbo].[Distinct_Without_Distinct] 

