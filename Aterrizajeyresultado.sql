--- Examina la relación entre los tipos de aterrizaje y sus resultados.
SELECT Landing_Type, Landing_Outcome, COUNT(*) AS Count
FROM dbo.lanzamientos
GROUP BY Landing_Type, Landing_Outcome;
