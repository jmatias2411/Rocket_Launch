--- Tipo de Cliente por Lanzamiento 

SELECT Customer_Type, COUNT(*) AS Count
FROM dbo.lanzamientos
GROUP BY Customer_Type;
