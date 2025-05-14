-- =============================================
-- Author:		Nawfel HAMDI
-- Create date: 12/05/2025
-- Description:	find employees that have Most recent address
-- Table : [dbo].[Most_Recent_Address]
-- =============================================

SELECT * FROM [dbo].[Most_Recent_Address]

SELECT * FROM (
	SELECT *,
		MAX(Date_of_Update) OVER(PARTITION BY Employee_ID) AS MostRecentDate
   
	FROM [dbo].[Most_Recent_Address]
	--WHERE T.Employee_Name = 'Ronak'
) AS T
WHERE T.Date_of_Update = MostRecentDate
--AND T.Employee_Name = 'Ronak'



-- SOL 2 WITH LAG
SELECT *,
	   LAG(Address) OVER(PARTITION BY Employee_ID ORDER BY Date_of_Update DESC) AS PreviousAddress
	   INTO #temp
FROM [dbo].[Most_Recent_Address]

SELECT 
	T.Employee_Name,
	T.Date_of_Update,
	COALESCE(T.Address, T.PreviousAddress) AS PreviousAddress
FROM #temp AS T

DROP TABLE #temp