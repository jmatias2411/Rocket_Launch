--- Misiones Exitosas

SELECT *
FROM dbo.lanzamientos
WHERE Mission_Outcome = 'Success';

--- Misiones Fallidas

SELECT Flight_Number, Failure_Reason
FROM dbo.lanzamientos
WHERE Mission_Outcome = 'Failure';
