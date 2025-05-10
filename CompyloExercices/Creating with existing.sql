-- =============================================
-- Author:		Nawfel HAMDI
-- Create date: 10/05/2025
-- Description : create with existings
-- Table : [dbo].[Food_Web]
-- =============================================

SELECT * FROM [dbo].[Food_Web]

SELECT * INTO  [dbo].[Food_Web_Copy] FROM [dbo].[Food_Web]
SELECT * FROM [dbo].[Food_Web_Copy]

SELECT * INTO  [dbo].[Food_Web_Copy2] FROM [dbo].[Food_Web]
WHERE 1 <> 1 -- 1 = 2 (false cdt)

SELECT * FROM [dbo].[Food_Web_Copy2]

SELECT * INTO  [dbo].[Food_Web_Copy3] FROM [dbo].[Food_Web]
WHERE 1 = 1 
SELECT * FROM [dbo].[Food_Web_Copy3]

SELECT TOP(0) * INTO [dbo].[Food_Web_Copy4] FROM [dbo].[Food_Web]
SELECT * FROM [dbo].[Food_Web_Copy4]

