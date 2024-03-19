--- Calcula la desviación estándar de la masa de carga útil agrupada por el resultado de la misión
SELECT Mission_Outcome, STDEV(Payload_Mass_kg) AS StdDev_Mass
FROM Space.dbo.lanzamientos
WHERE Payload_Mass_kg IS NOT NULL AND Mission_Outcome IS NOT NULL
GROUP BY Mission_Outcome;

--- Tipo Aterrizaje
SELECT Landing_Type, Landing_Outcome, COUNT(*) AS Count
FROM Space.dbo.lanzamientos
GROUP BY Landing_Type, Landing_Outcome;

--- Segun Orbita 
SELECT Payload_Orbit, Mission_Outcome, COUNT(*) AS Count
FROM Space.dbo.lanzamientos
GROUP BY Payload_Orbit, Mission_Outcome;

--- Relacion Carga y Exito 
SELECT Payload_Mass_kg, Mission_Outcome
FROM Space.dbo.lanzamientos
WHERE Payload_Mass_kg IS NOT NULL
  AND Mission_Outcome IS NOT NULL; 

--- Clientes con Mayores Lanzamientos
SELECT Customer_Name, COUNT(*) AS Launch_Count
FROM Space.dbo.lanzamientos
GROUP BY Customer_Name
ORDER BY Launch_Count DESC;

--- Examina la relación entre los tipos de aterrizaje y sus resultados.
SELECT Landing_Type, Landing_Outcome, COUNT(*) AS Count
FROM Space.dbo.lanzamientos
GROUP BY Landing_Type, Landing_Outcome;

--- Misiones Exitosas
SELECT *
FROM Space.dbo.lanzamientos
WHERE Mission_Outcome = 'Success';

--- Misiones Fallidas
SELECT Flight_Number, Failure_Reason
FROM Space.dbo.lanzamientos
WHERE Mission_Outcome = 'Failure';

--- Paises
SELECT Customer_Country, COUNT(*) AS Count
FROM Space.dbo.lanzamientos
GROUP BY Customer_Country;

--- Tipo de Cliente por Lanzamiento 
SELECT Customer_Type, COUNT(*) AS Count
FROM Space.dbo.lanzamientos
GROUP BY Customer_Type;


--- Segun Orbita
SELECT Payload_Orbit, Mission_Outcome, COUNT(*) AS Count
FROM Space.dbo.lanzamientos
GROUP BY Payload_Orbit, Mission_Outcome;



---Análisis detallado de las misiones espaciales para cada cliente
WITH FailureAnalysis AS (
    SELECT
        Customer_Name,
        COUNT(*) AS Total_Missions,
        SUM(CASE WHEN Mission_Outcome = 'Failure' THEN 1 ELSE 0 END) AS Failed_Missions,
        CAST(SUM(CASE WHEN Mission_Outcome = 'Failure' THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*) AS Failure_Rate
    FROM Space.dbo.lanzamientos
    GROUP BY Customer_Name
)

SELECT
    FT.Customer_Name,
    FT.Vehicle_Type,
    FA.Total_Missions,
    FA.Failed_Missions,
    FA.Failure_Rate
FROM Space.dbo.lanzamientos FT
JOIN FailureAnalysis FA ON FT.Customer_Name = FA.Customer_Name
WHERE FT.Mission_Outcome IS NOT NULL
    AND FT.Vehicle_Type IS NOT NULL
    AND FT.Customer_Name IS NOT NULL
ORDER BY FA.Failure_Rate DESC;


---
WITH RankedPayloads AS (
    SELECT Payload_Mass_kg,
           ROW_NUMBER() OVER (ORDER BY Payload_Mass_kg) AS RowAsc,
           ROW_NUMBER() OVER (ORDER BY Payload_Mass_kg DESC) AS RowDesc
    FROM  Space.dbo.lanzamientos
)

SELECT AVG(Payload_Mass_kg) AS Median
FROM RankedPayloads
WHERE RowAsc = RowDesc OR RowAsc + 1 = RowDesc OR RowAsc = RowDesc + 1;
