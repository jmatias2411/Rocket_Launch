SELECT Payload_Mass_kg, Mission_Outcome
FROM dbo.lanzamientos
WHERE Payload_Mass_kg IS NOT NULL
  AND Mission_Outcome IS NOT NULL;
