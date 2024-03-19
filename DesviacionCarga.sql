--- Calcula la desviaci�n est�ndar de la masa de carga �til agrupada por el resultado de la misi�n
SELECT Mission_Outcome, STDEV(Payload_Mass_kg) AS StdDev_Mass
FROM dbo.lanzamientos
WHERE Payload_Mass_kg IS NOT NULL AND Mission_Outcome IS NOT NULL
GROUP BY Mission_Outcome;
