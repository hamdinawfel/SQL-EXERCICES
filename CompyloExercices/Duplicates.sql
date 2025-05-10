-- =============================================
-- Author:		Nawfel HAMDI
-- Create date: 10/05/2025
-- Description : Find Duplicates records
-- Table : [dbo].[hundred_Duplicate_few_common]
-- =============================================
SELECT * FROM  [dbo].[hundred_Duplicate_few_common] AS D

SELECT D.hundred_Duplicate, COUNT(hundred_Duplicate) AS DuplcationNumber
FROM  [dbo].[hundred_Duplicate_few_common] AS D
GROUP BY D.hundred_Duplicate
HAVING COUNT(hundred_Duplicate) > 1 --> 32 ROWS : This returns one row per duplicated value of hundred_Duplicate


SELECT *
FROM (
    SELECT *,
           COUNT(*) OVER (PARTITION BY hundred_Duplicate) AS DuplicationNumber
    FROM [dbo].[hundred_Duplicate_few_common]
) AS T
WHERE T.DuplicationNumber > 1; --> 98 ROWS : This returns every row that is part of a duplicated group.


-- Find Max and Min rows number left join with table with 10 rows form 1 to 10, and table with 100 rows with duplicates

SELECT * FROM [dbo].[ten_unique]
SELECT * FROM [dbo].[hundred_Duplicate_all_common]
SELECT * FROM [dbo].[hundred_Duplicate_few_common]
SELECT * FROM [dbo].[hundred_Duplicate_no_common]
SELECT * FROM [dbo].[hundred_Duplicate_one_common]

SELECT * FROM [dbo].[ten_unique] AS T1
LEFT JOIN [dbo].[hundred_Duplicate_all_common] AS T2
ON T1.ten_Unique = T2.hundred_duplicate_all_common

SELECT * FROM [dbo].[ten_unique] AS T1
LEFT JOIN [dbo].[hundred_Duplicate_few_common] AS T2
ON T1.ten_Unique = T2.hundred_Duplicate

SELECT * FROM [dbo].[ten_unique] AS T1
LEFT JOIN [dbo].[hundred_Duplicate_no_common] AS T2
ON T1.ten_Unique = T2.hundred_duplicate_no_common


SELECT * FROM [dbo].[ten_unique] AS T1
LEFT JOIN [dbo].[hundred_Duplicate_one_common] AS T2
ON T1.ten_Unique = T2.hundred_Duplicate_one_common

--Min rows 10, Max rows 109