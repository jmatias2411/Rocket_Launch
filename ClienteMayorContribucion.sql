SELECT Customer_Name, COUNT(*) AS Launch_Count
FROM dbo.lanzamientos
GROUP BY Customer_Name
ORDER BY Launch_Count DESC;
