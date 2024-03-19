--- Calcula la desviación estándar de la masa de carga útil agrupada por el resultado de la misión
SELECT Mission_Outcome, STDEV(Payload_Mass_kg) AS StdDev_Mass
FROM dbo.lanzamientos
WHERE Payload_Mass_kg IS NOT NULL AND Mission_Outcome IS NOT NULL
GROUP BY Mission_Outcome;
