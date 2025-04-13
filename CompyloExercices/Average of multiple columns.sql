-- =============================================
-- Author:		Nawfel HAMDI
-- Create date: 12/04/2025
-- Description:	Average of multiple columns
-- =============================================

SELECT Student_Name,
   (SELECT ROUND(AVG(c), 2) 
      FROM (VALUES(PC_Semester_1),
	               (PC_Semester_2),
				   (PC_Semester_3),
				   (PC_Semester_4),
				   (PC_Semester_5),
				   (PC_Semester_6)) AS T(c))
   AS [Average]
FROM Max_Value_From_Table_1


-- TVC: Table Value Constructor https://sqlskull.com/2020/11/24/table-value-constructor/
CREATE TABLE  dbo.ItemList (
Id INT IDENTITY(1,1),
ItemName VARCHAR(100),
ItemCode VARCHAR (100) NULL,
Amount NUMERIC(8,2) DEFAULT 1000
)

-- TVC: Inserting multiple records
INSERT INTO dbo.ItemList
(ItemName,ItemCode, Amount)
VALUES
('Pen Drive', 'PEN-D1', 4000),
('Furniture', 'FUR-LEX', 150000),
('Hard Disk', 'SEAG', 5000) ,
('White Paper', 'W-PP', 2500)

-- TVC : Inserting multiple rows with DEFAULT and NULL values 
INSERT INTO ItemList 
(ItemName,ItemCode, Amount)
VALUES
('A','XXX', 1000),
('B', NULL, 3000),
('C', NULL, DEFAULT)
SELECT * FROM ItemList
-- TVC: in SELECT statement

SELECT * FROM 
(VALUES (1,1), 
        (2,2)
) AS TBL(i,j)

-- TVC: in JOIN statement

SELECT IT.Id,
IT.ItemName,
IT.ItemCode,
IT.Amount,
T.[Description]
FROM ItemList AS IT 
JOIN 
( VALUES (5, 'A'),
         (6, 'B')
) AS T(Id, [Description])
ON IT.Id = T.Id

