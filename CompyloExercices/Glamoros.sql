-- =============================================
-- Author:		Nawfel HAMDI
-- Create date: 01/05/2025
-- =============================================

-- =============================================
-- Print string vertically
-- =============================================

DECLARE @String VARCHAR(255) = 'NAWFEL'
DECLARE @Count INT = 0

WHILE @Count < LEN(@String)
BEGIN
  SET @Count = @Count + 1
  PRINT SUBSTRING(@String, @Count, 1)
END

-- =============================================
-- PALANDROM
-- =============================================


DECLARE @input VARCHAR(255) = 'awa'
DECLARE @result VARCHAR(1) = 'Y'
DECLARE @i INT = 0

WHILE (@result = 'Y' AND @i <= (LEN(@input) / 2) + 1)
BEGIN
	PRINT SUBSTRING(@input, LEN(@input) - @i, 1)
	PRINT '---'
	PRINT SUBSTRING(@input, @i + 1, 1)
   IF SUBSTRING(@input, @i +1 , 1) <> SUBSTRING(@input, LEN(@input) - @i, 1)
   BEGIN 
     SET @result = 'N'
   END
   SET @i = @i + 1
END

PRINT @result


----CORRECTION
DECLARE @s VARCHAR(255) = 'awax'

SELECT 
	CASE WHEN @s = REVERSE(@s) THEN 'IS PALANDROM'
    ELSE 'NOT PALANDROM'
	END
