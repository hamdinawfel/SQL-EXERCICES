-- =============================================
-- Author:		Nawfel HAMDI
-- Create date: 12/05/2025
-- Description : Write a stored procedure to add order records daily to the historical table
-- Table : [dbo].[SalesInfo] | DailySalesHistory
-- =============================================

SELECT * FROM [dbo].[SalesInfo]
UPDATE [dbo].[SalesInfo] SET InsertDate = '2025-05-12 14:00:00.000' WHERE SalesOrderID = '71776'
SELECT * INTO [dbo].[DailySalesHistory] FROM [dbo].[SalesInfo] WHERE 1 <> 1

SELECT * FROM [dbo].[DailySalesHistory]

-- MINE S
CREATE OR ALTER PROCEDURE [dbo].[DailyLogOrderHistory] AS
BEGIN 
	INSERT INTO  [dbo].[DailySalesHistory]
	SELECT * FROM [dbo].[SalesInfo] 
    WHERE CAST(InsertDate AS DATE)= CAST(GETDATE() AS DATE)
END

EXEC [dbo].[DailyLogOrderHistory] 

-- CORRECTION
CREATE TABLE [dbo].[SalesInfoHistory](          --create table with another name because this table is already present
	[SalesOrderID] [int] NOT NULL,
	[OrderQty] [smallint] NOT NULL,
	[TotalLineTotal] [money] NOT NULL,
	[SalesDate] [datetime] NULL)

	SELECT * FROM [dbo].[SalesInfoHistory]

CREATE OR ALTER PROCEDURE [dbo].[DailyLogOrderHistory] (@Date DATETIME)AS
BEGIN
   INSERT INTO [dbo].[SalesInfoHistory]
   SELECT [SalesOrderID], SUM([OrderQty]), SUM([TotalAmount]), @Date
   FROM [dbo].[SalesInfo]
   GROUP BY [SalesOrderID], [InsertDate]
   HAVING CAST([InsertDate] AS DATE) = CAST(@Date AS DATE)
END