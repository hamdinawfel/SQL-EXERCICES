-- =============================================
-- Author:		Nawfel HAMDI
-- Create date: 10/05/2025
-- Description : Find Customer for the same city => delevery location should be same
-- Table : [dbo].[Active_Customers_From_Same_City]
-- =============================================




SELECT DISTINCT *
FROM  [dbo].[Active_Customers_From_Same_City] AS A1
JOIN [dbo].[Active_Customers_From_Same_City] AS A2
ON A1.Delivery_Location = A2.Delivery_Location AND A1.Customer_ID <> A2.Customer_ID
WHERE A1.Order_Status = 'Active'


-- COORECTION
SELECT A1.Customer_Name
FROM  [dbo].[Active_Customers_From_Same_City] AS A1
WHERE EXISTS (
	SELECT * 
	FROM  [dbo].[Active_Customers_From_Same_City] AS A2
	WHERE 
		A1.Delivery_Location = A2.Delivery_Location 
		AND A1.Customer_ID <> A2.Customer_ID
	)
AND A1.Order_Status = 'Active'