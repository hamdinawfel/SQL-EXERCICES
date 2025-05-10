-- =============================================
-- Author:		Nawfel HAMDI
-- Create date: 01/05/2025
-- =============================================
SELECT * FROM [dbo].[MagicTables]

CREATE TRIGGER OnMagicTablesTrigger
ON MagicTables
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
	 SELECT * FROM Inserted
	 SELECT * FROM Deleted
END
GO

INSERT INTO [dbo].[MagicTables] ([Floor Number], [Company Name])
  VALUES (12, 'XXXXX')

UPDATE [dbo].[MagicTables] SET [Company Name] = 'YYY' WHERE [Floor Number] = 12

DELETE [dbo].[MagicTables] WHERE [Floor Number] = 12

--Find the last day of the previous month
SELECT GETDATE()
SELECT DATEADD(MONTH, -1, GETDATE())
SELECT EOMONTH(DATEADD(MONTH, -1, GETDATE()))
SELECT CONVERT(VARCHAR(255), EOMONTH(DATEADD(MONTH, -1, GETDATE())), 103)
SELECT CONVERT(VARCHAR(255), EOMONTH(DATEADD(MONTH, -1, GETDATE())), 104)
SELECT CONVERT(VARCHAR(255), EOMONTH(DATEADD(MONTH, -1, GETDATE())), 105)
SELECT CONVERT(VARCHAR(255), EOMONTH(DATEADD(MONTH, -1, GETDATE())), 106)
SELECT CONVERT(VARCHAR(255), EOMONTH(DATEADD(MONTH, -1, GETDATE())), 107)

-- Find the number of working days

SELECT * FROM [dbo].[Interview_Calendar]
SELECT * FROM [dbo].[Holiday_Table]

DECLARE @StartDate DATE = '2023-01-01'
DECLARE @EndDate DATE = '2023-01-31'

SELECT * 
FROM [dbo].[Interview_Calendar] AS I
JOIN [dbo].[Holiday_Table] AS H
ON I.Cal_Date = H.Calendar_Date
WHERE I.Cal_Date BETWEEN @StartDate AND @EndDate
AND I.Working_Day = 'Y'