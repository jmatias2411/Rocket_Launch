WITH RankedPayloads AS (
    SELECT Payload_Mass_kg,
           ROW_NUMBER() OVER (ORDER BY Payload_Mass_kg) AS RowAsc,
           ROW_NUMBER() OVER (ORDER BY Payload_Mass_kg DESC) AS RowDesc
    FROM  Space.dbo.lanzamientos
)

SELECT AVG(Payload_Mass_kg) AS Median
FROM RankedPayloads
WHERE RowAsc = RowDesc OR RowAsc + 1 = RowDesc OR RowAsc = RowDesc + 1;
