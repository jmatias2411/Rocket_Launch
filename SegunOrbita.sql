SELECT Payload_Orbit, Mission_Outcome, COUNT(*) AS Count
FROM dbo.lanzamientos
GROUP BY Payload_Orbit, Mission_Outcome;
