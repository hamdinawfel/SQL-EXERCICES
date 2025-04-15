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

--#USE CASE : TOP N ANALYSES
-- TASK : Find the top highest sales for each product

SELECT * FROM (
SELECT 
	OrderId,
	ProductId,
	Sales,
	ROW_NUMBER() OVER(PARTITION BY ProductId ORDER BY Sales DESC) RankSalesByProduct
FROM Orders
) AS T 
WHERE RankSalesByProduct = 1

--#USE CASE : BOTTOM N ANALYSES
-- TASK : Find the 2 lowest customers based on their total sales

SELECT * FROM (
SELECT 
	CustomerId,
	SUM(SALES) AS TotalSales,
	ROW_NUMBER() OVER(ORDER BY SUM(SALES)) AS RankCustomers
FROM Orders
GROUP BY CustomerId
) AS T WHERE RankCustomers <= 2


--#USE CASE : UNIQUE IDENTIIFER
-- TASK : assign unique ids for ArchiveOrders table
CREATE TABLE ArchiveOrders(
OrderId INT,
ArchivedDate DATE
)

INSERT INTO ArchiveOrders (OrderId, ArchivedDate) VALUES
(1, '2025-04-01'),
(2, '2025-04-02'),
(3, '2025-04-03'),
(1, '2025-04-01'),  -- Duplicate OrderId
(4, '2025-04-06'),
(2, '2025-04-07'),  -- Duplicate OrderId
(5, '2025-04-08'),
(6, '2025-04-09'),
(3, '2025-04-03'),  -- Duplicate OrderId
(7, '2025-04-11');

SELECT *,
	ROW_NUMBER() OVER(ORDER BY ArchivedDate) AS Id
FROM ArchiveOrders

-- USE CASE : Identify ducplucates 
SELECT * FROM (
SELECT *,
	ROW_NUMBER() OVER(PARTITION BY OrderId ORDER BY ArchivedDate) AS rn
FROM ArchiveOrders
) AS T WHERE rn = 1

--NTILE()
-- backet size = number of rows / number of backets | Larger group cam first
SELECT 
	OrderId,
	Sales,
	NTILE(4) OVER(ORDER BY Sales DESC) AS _4Backets,
	NTILE(3) OVER(ORDER BY Sales DESC) AS _3Backets,
	NTILE(3) OVER(ORDER BY Sales DESC) AS _2Backets,
	NTILE(1) OVER(ORDER BY Sales DESC) AS _1Backets
FROM Orders

-- #USE CASE : DATA SEGMENTATION
-- TASK : Segment order into 3 categories , hight, medium , low

SELECT *,
	CASE WHEN Backets = 1 THEN 'Hight'
	     WHEN Backets = 2 THEN 'Medium'
	     WHEN Backets = 3 THEN 'Low'
    END AS SalesSegmentations
FROM (
	SELECT 
		OrderId,
		Sales,
		NTILE(3) OVER(ORDER BY Sales DESC) AS Backets
	FROM Orders
) AS T

-- #USE CASE : LOED BALANCE
SELECT 
	OrderId,
	Sales,
	NTILE(2) OVER (ORDER BY OrderId) AS Batch
FROM Orders