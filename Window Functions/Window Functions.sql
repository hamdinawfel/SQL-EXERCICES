-- =============================================
-- Author:		Nawfel HAMDI
-- Create date: 13/04/2025
-- Description:	Window Functions
-- Link : https://datawithbaraa.substack.com/p/your-guide-to-sql-window-functions - https://www.youtube.com/watch?v=Wvg4PjbMTO8
-- =============================================

CREATE TABLE Orders (
OrderId INT IDENTITY(1,1),
OrderDate DATE,
ProductId INT,
Sales DECIMAL(5,2)
)

INSERT INTO Orders (OrderDate, ProductId, Sales) VALUES 
('2025-04-01', 101, 150),
('2025-04-02', 102, 200),
('2025-04-03', 103, 320),
('2025-04-04', 104, 180),
('2025-04-05', 101, 250),
('2025-04-06', 102, 300),
('2025-04-07', 103, 275),
('2025-04-08', 104, 199),
('2025-04-09', 101, 450),
('2025-04-10', 102, 380);

--  Task : Find the total Sales accros all orders and provide detail such OrderId, OrderDate

SELECT 
	OrderId,
	OrderDate,
	SUM(Sales) OVER() AS TotalSales
FROM Orders

--  Task : Find the total Sales for each Product and provide detail such OrderId, OrderDate

SELECT 
    OrderId,
	OrderDate,
	ProductId,
	SUM(Sales) OVER(PARTITION BY ProductId) AS TotalSales
FROM Orders

-- Task : Find the total Sales for each combination ProductId and OrderStatus and provide detail such OrderId, OrderDate

ALTER TABLE Orders ADD OrderStatus VARCHAR(20) 
SELECT * FROM Orders
UPDATE Orders SET OrderStatus = 'Dilevered' WHERE OrderId IN (1, 3, 5, 7, 9)
UPDATE Orders SET OrderStatus = 'Shipped' WHERE OrderId IN (2, 4, 6, 8, 10)

SELECT 
    OrderId,
	OrderDate,
	ProductId,
	Sales,
	OrderStatus,
	SUM(Sales) OVER() AS TotalSales,
	SUM(Sales) OVER(PARTITION BY ProductId) AS SalesByProduct,
	SUM(Sales) OVER(PARTITION BY ProductId, OrderStatus) SalesByProductAndOrderStatus
FROM Orders

-- Task : Rank each order based on their sales from highest to lowest and provide details such OrderId, OrderDate

SELECT 
    OrderId,
	OrderDate,
	Sales,
	RANK() OVER(ORDER BY Sales DESC) AS RankSales
FROM Orders

-- Frame ? see README
    -- Frame clause can be only used togther with order by clause
	-- Lower value must be before the hier vales
	-- Order by is always use a default hidden frame (ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROWS)

SELECT 
    OrderId,
	OrderDate,
	Sales,
	OrderStatus,
	SUM(Sales) OVER(PARTITION BY OrderStatus ORDER BY Sales
	ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLlOWING ) AS TotalSales
FROM Orders

-- #RULE 1 : Window Function is only used in the SELECT AND ORDER BY clauses (it don't work in the where caluse for exp)
-- #RULE 2 : Nesting  Window Functions is not allowed
SELECT 
    OrderId,
	OrderDate,
	SUM(SUM(Sales) OVER(PARTITION BY OrderStatus ORDER BY Sales)) OVER(PARTITION BY OrderStatus ORDER BY Sales) AS TotalSales
FROM Orders --> Windowed functions cannot be used in the context of another windowed function or aggregate.

-- #RULE 3 : SQL execute Window Functions AFTER the WHERE clause
SELECT 
    OrderId,
	OrderDate,
	SUM(Sales) OVER(PARTITION BY OrderStatus ORDER BY Sales) AS TotalSales
FROM Orders
WHERE ProductId IN (101, 102)

-- #RULE 4 : Window Fuction can be use togther with group by clause in the same query only is the same columns is used
-- Task : Rank Customers based on their sales

ALTER TABLE Orders ADD CustomerId INT
UPDATE Orders SET CustomerId = 1 WHERE OrderId IN (1, 2, 3)
UPDATE Orders SET CustomerId = 2 WHERE OrderId IN (4, 5, 6)
UPDATE Orders SET CustomerId = 3 WHERE OrderId IN (7, 8)
UPDATE Orders SET CustomerId = 4 WHERE OrderId IN (9, 10)
SELECT * FROM Orders

SELECT 
	CustomerId,
	SUM(Sales) AS TotalSales,
	RANK() OVER(ORDER BY SUM(Sales) DESC) AS RankCustomer
FROM Orders
GROUP BY CustomerId