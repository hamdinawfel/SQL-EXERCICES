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