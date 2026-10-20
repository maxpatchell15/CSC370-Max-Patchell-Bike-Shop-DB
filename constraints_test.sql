
-- Run tests individually after loading sample_data.sql.
-- Each test below is expected to produce the stated error.
-- Tests use sample BikeID 4 and TechnicianID 1.

-- uniqueness test
INSERT INTO BicycleModel (Brand, ModelName)
SELECT Brand, ModelName
FROM BicycleModel
ORDER BY ModelID
LIMIT 1;

-- Test: reject a duplicate maintenance record
-- Expected: duplicate primary-key error
INSERT INTO MaintenanceRecord
    (BikeID, RecordNumber, TechnicianID, ServiceDate, Description)
SELECT
    BikeID, RecordNumber, TechnicianID, ServiceDate, Description
FROM MaintenanceRecord
WHERE BikeID = 4 AND RecordNumber = 1;

-- Test: maintenance record referencing a nonexistent technician
-- Expected: foreign-key error
INSERT INTO MaintenanceRecord
    (BikeID, RecordNumber, TechnicianID, ServiceDate, Description)
VALUES
    (4, 3, -1, '2026-10-20', 'Invalid technician test');


-- Test: prevent deleting a technician with maintenance records
-- Expected: foreign-key error 1451
DELETE FROM Technician
WHERE TechnicianID = 1;

-- Test: reject a second sale-item entry for an already sold bike
-- Expected: duplicate primary-key error 1062
INSERT INTO SaleItem (BikeID, SaleID, PricePaid)
VALUES (1, 1, 10000.36);
