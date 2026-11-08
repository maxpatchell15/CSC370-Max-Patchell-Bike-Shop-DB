-- Temporary copy for the index experiment
CREATE TEMPORARY TABLE SaleIndexDemo LIKE Sale;

-- Generate 10000 sales spread across 365 dates
INSERT INTO SaleIndexDemo (CustomerID, SaleDate)
WITH Digits AS (
    SELECT 0 AS n UNION ALL SELECT 1 UNION ALL SELECT 2
    UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5
    UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8
    UNION ALL SELECT 9
)
SELECT
    1,
    DATE_ADD(
        '2026-01-01',
        INTERVAL MOD(
            a.n + 10 * b.n + 100 * c.n + 1000 * d.n,
            365
        ) DAY
    )
FROM Digits AS a
CROSS JOIN Digits AS b
CROSS JOIN Digits AS c
CROSS JOIN Digits AS d;

-- Expected: 10000 rows, dates from 2026-01-01 to 2026-12-31
SELECT
    COUNT(*) AS NumberOfSales,
    MIN(SaleDate) AS FirstDate,
    MAX(SaleDate) AS LastDate
FROM SaleIndexDemo;

-- Expected: 27
SELECT COUNT(*) AS MatchingSales
FROM SaleIndexDemo
WHERE SaleDate = '2026-11-01';

-- Record the execution plan and actual timing before indexing
EXPLAIN ANALYZE
SELECT COUNT(*) AS MatchingSales
FROM SaleIndexDemo
WHERE SaleDate = '2026-11-01';


CREATE INDEX idx_demo_sale_date
ON SaleIndexDemo (SaleDate);

-- Expected: still 27
SELECT COUNT(*) AS MatchingSales
FROM SaleIndexDemo
WHERE SaleDate = '2026-11-01';

-- Record the execution plan and actual timing after indexing
EXPLAIN ANALYZE
SELECT COUNT(*) AS MatchingSales
FROM SaleIndexDemo
WHERE SaleDate = '2026-11-01';


-- Results:
-- Before indexing: table scan of 10000 rows, 4.03 ms.
-- After indexing: covering index lookup of 27 entries, 0.0567 ms.
-- Both versions counted 27 matching sales.
-- Above timings are from one run and may vary.

-- The date index helped this query on the larger test dataset.
-- I would use it if the shop regularly searched a large sales history by date.
-- It's not a high enough priority to add to the small main Sale table yet.