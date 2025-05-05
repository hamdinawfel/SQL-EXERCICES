-- =============================================
-- Author:		Nawfel HAMDI
-- Create date: 01/05/2025
-- Description:	CTE exercices
-- Link : https://www.youtube.com/watch?v=5x1uodxEIaM
-- =============================================

-- Find the total sales per Customer

--SELECT 
--*,
--SUM(Sales) OVER(PARTITION BY CustomerId) AS TotalSalesPerCustomer
--FROM Orders

--CREATE TABLE Customer (
--Id INT IDENTITY (1,1),
--FirstName VARCHAR(255),
--LastName VARCHAR(255)
--)

--INSERT INTO Customer (FirstName, LastName)
--VALUES
--('Alice', 'Dupont'),
--('Bob', 'Martin'),
--('Claire', 'Durand'),
--('David', 'Lemoine'),
--('Emma', 'Bernard');

--SATANDALONE CTE
WITH 
CTE_TOTAL_SALES AS (
	SELECT CustomerId, SUM(Sales) AS TotalSalesPerCustomer
	FROM Orders
	GROUP BY CustomerId
),
CTE_LAST_ORDER_DATE_PERCUSTOMER AS (
   SELECT 
		CustomerId,
		MAX(OrderDate) as LastOrderDate
   FROM Orders
   GROUP BY CustomerId
),
CTE_RANK_CUSTOMER AS (
  SELECT 
		CustomerId,
		RANK() OVER(ORDER BY TotalSalesPerCustomer DESC) AS RankCustomer
   FROM CTE_TOTAL_SALES
),
CTE_CUSTOMER_SEGMENT AS (
  SELECT 
		CustomerId,
		CASE WHEN TotalSalesPerCustomer > 100 THEN 'HIGHT'
		      WHEN TotalSalesPerCustomer > 50 AND  TotalSalesPerCustomer < 100  THEN 'MEDIUM'
			  ELSE 'LOW'
			  END AS Segement
   FROM CTE_TOTAL_SALES
)

SELECT *
FROM Customer AS C 
LEFT JOIN CTE_TOTAL_SALES AS CTE 
ON CTE.CustomerId = C.Id
LEFT JOIN CTE_LAST_ORDER_DATE_PERCUSTOMER AS CL
ON CL.CustomerId = C.Id
LEFT JOIN CTE_RANK_CUSTOMER AS CTER
ON CTER.CustomerId = C.Id
LEFT JOIN CTE_CUSTOMER_SEGMENT AS CTES
ON CTES.CustomerId = C.Id


--Recursive CTE
-- Generate a Sequence of Numbers from 1 to 20

WITH CTE AS (
   SELECT 1 AS Num
   UNION ALL 
   --Recursive QUERY
   SELECT Num + 1
   FROM CTE
   WHERE Num < 105
)

SELECT * FROM CTE