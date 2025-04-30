-- =============================================
-- Author:		Nawfel HAMDI
-- Create date: 13/04/2025
-- Description:	Aggrigate Window Functions
-- Link : https://datawithbaraa.substack.com/p/your-guide-to-sql-window-functions - https://www.youtube.com/watch?v=Wvg4PjbMTO8
-- =============================================

-- COUNT()
-- Task : Find the number of orders
-- #USE CASE : Overal Analyses
USE Compylo_SQL_InterviewQuestions
GO
SELECT 
    COUNT(*) AS TotalOrders
FROM Orders

-- Task : Find the number of orders and provide details for OrderId, OrderDate
SELECT 
	OrderId,
	OrderDate,
    COUNT(*) OVER() AS TotalOrders
FROM Orders

-- Task : Find the number of orders for each customer and provide details for OrderId, OrderDate
-- #USE CASE : Group-wise analysis to understand pattern within deffirent categories

SELECT 
	OrderId,
	OrderDate,
	CustomerId,
	COUNT(*) OVER(PARTITION BY CustomerId) AS TotalOrdersByCustomer,
    COUNT(*) OVER() AS TotalOrders
FROM Orders
-- Task : Find  the total number of Customers and their total scores
-- #USE CASE : Data Quality check : detecting number of nulls by comparing to total number of rows

CREATE TABLE Customers (
CustomerId INT IDENTITY(1,1),
FistName VARCHAR(50) NULL,
LastName VARCHAR(50) NULL,
Country VARCHAR(50) NULL,
Score INT NULL
);

INSERT INTO Customers (FistName, LastName, Country, Score) VALUES
('John',     'Doe',       'USA',        85),
('Emily',    'Smith',     'Canada',     90),
('Liam',     'Johnson',   'UK',         78),
('Olivia',   'Brown',     'Australia',  88),
('Noah',     'Jones',     'USA',        92),
('Ava',      'Garcia',    'Mexico',     80),
('William',  'Miller',    'Canada',     75),
('Sophia',   'Davis',     'UK',         89),
('James',    NULL,  'Spain',      83),
('Isabella', 'Lopez',     'USA',        NULL);

SELECT *,
       COUNT(*) OVER() AS TotalCustomersWithStar,
	   COUNT(1) OVER() AS TotalCustomersWith1,
	   COUNT(Country) OVER() AS TotalCountries,
	   COUNT(Score) OVER() AS TotalScore -- TotalCountries <> TotalScore => row with null is missing
FROM Customers
 

 -- Task : Check if orders table contains any duplicates rows
 -- #USE CASE : Identify Duplicates
 SELECT * 
 FROM (
	 SELECT 
		OrderId,
		COUNT(*) OVER(PARTITION BY OrderId) AS CheckPK
	 FROM Orders
 ) AS T 
 WHERE CheckPK > 1

 -- SUM()
 -- #USE CASE : PART-TO-WHOLE : shows the contribution of each data point to the everall dataset
 -- Task : Find the percentage of each product sales to the total sales

 SELECT 
	 *,
	 SUM(Sales) OVER() AS TotalSales,
	 ROUND(CAST (Sales AS FLOAT) / SUM(Sales) OVER() * 100 , 2) AS PercentageOfProduct
 FROM Orders

 -- AVG()
 SELECT 
	 OrderId,
	 Sales,
	 AVG(Sales) OVER () AS AverageSales,
	 --SUM(Sales) OVER() / COUNT(*) OVER() AS AverageSales,
	 AVG(Sales) OVER (PARTITION BY ProductId) AS AverageByProduct
 FROM Orders

 -- Handle NULL with COALESCE

 SELECT *,
    COALESCE(Score, 0) AS CustomerScore,
	AVG(Score) OVER() AS AvgScores,
	AVG(COALESCE(Score, 0)) OVER() AS AvgScoresWithoutNull
 FROM Customers

 -- #USE CASE : COMPARE TO AVERGE
 -- Task : Find all orders where sales are higer than the average sales across the orders
 SELECT * FROM (
	 SELECT
		 OrderId,
		 Sales,
		AVG(Sales) OVER() AS AvgSales
	 FROM Orders
	 ) AS T 
 WHERE Sales > AvgSales

 -- MIN() / MAX()

 SELECT
	 OrderId,
	 OrderDate,
	 Sales,
	 ProductId,
	 MIN(Sales) OVER() MinSales,
	 MAX(Sales) OVER() MaxSales,
	 MIN(Sales) OVER(PARTITION BY ProductId) MinSalesByProduct,
	 MAX(Sales) OVER(PARTITION BY ProductId) MaxSalesByProduct
 FROM Orders

 -- #USE CASE : COMPARE TO EXTREME
 -- Task : Find the diviation of each sales from the minimum and maximum sales
  SELECT
	 OrderId,
	 Sales,
	 MIN(Sales) OVER() MinSales,
	 MAX(Sales) OVER() MaxSales,
	 Sales - MIN(Sales) OVER() AS DiviationFromMin,
	 ABS(Sales - MAX(Sales) OVER()) AS DiviationFromMax
 FROM Orders

 --#USE CASE : MOVING/ROLLING AVERAGE
 -- Task : Find moving average of sales for each product over time
 SELECT
	 OrderId,
	 OrderDate,
	 ProductId,
	 Sales,
	 AVG(Sales) OVER(PARTITION BY ProductId) AS MovingAverage,
	 AVG(Sales) OVER(PARTITION BY ProductId ORDER BY OrderDate) AS MovingAverage 
 FROM Orders

 -- Task : Find moving average of sales for each product over time, including only the next order
 SELECT
	 OrderId,
	 OrderDate,
	 ProductId,
	 Sales,
	 AVG(Sales) OVER(PARTITION BY ProductId) AS MovingAverage,
	 AVG(Sales) OVER(PARTITION BY ProductId ORDER BY OrderDate) AS MovingAverage ,
	 AVG(Sales) OVER(PARTITION BY ProductId ORDER BY OrderDate
	 ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS RollingAverage 
 FROM Orders