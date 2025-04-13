-- =============================================
-- Author:		Nawfel HAMDI
-- Create date: 12/04/2025
-- Description:	Percentage Probleme
-- =============================================
SELECT Records FROM (
SELECT TOP 20 PERCENT Records FROM Top_Bottom_20_pc ORDER BY Records DESC
) AS T1
UNION
SELECT Records FROM (
SELECT TOP 20 PERCENT Records FROM Top_Bottom_20_pc ORDER BY Records ASC
) AS T2
ORDER BY Records DESC


