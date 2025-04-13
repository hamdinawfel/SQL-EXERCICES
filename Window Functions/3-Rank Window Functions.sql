-- =============================================
-- Author:		Nawfel HAMDI
-- Create date: 13/04/2025
-- Description:	Rank Window Functions
-- Link : https://www.youtube.com/watch?v=Wvg4PjbMTO8
-- =============================================

-- ROW_NUMBER() | RANK() | DENSE_RANK()
-- Task : Rank the orders based on their sales from the highest to lowest

UPDATE Orders SET Sales = 200 WHERE Sales = 199
SELECT 
	OrderId,
	Sales,
	ROW_NUMBER() OVER(ORDER BY Sales DESC) AS RankedSales_Row, -- unique ranks
	RANK()       OVER(ORDER BY Sales DESC) AS RankedSales_Rank, -- shared ranks / gap (skip)
	DENSE_RANK() OVER(ORDER BY Sales DESC) AS RankedSales_Dense -- shared ranks / no gap (not skip)
FROM Orders
