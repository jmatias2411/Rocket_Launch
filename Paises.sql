--- Paises

SELECT Customer_Country, COUNT(*) AS Count
FROM dbo.lanzamientos
GROUP BY Customer_Country;
