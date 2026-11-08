
-- Run tests individually after loading sample_data.sql.
-- Expected results are noted beside each test.
-- Run the transaction test in order, including ROLLBACK to reset it.
-- Related tests use sample BikeID 4 and TechnicianID 1.

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



-- Sprint 2:

-- Expected: Recorded sale prices cannot be changed
UPDATE SaleItem
SET PricePaid = PricePaid + 1
WHERE BikeID = 1;

-- Test a valid new sale item without keeping the test data
START TRANSACTION;

-- Bike 2 is unsold in the current sample data
INSERT INTO SaleItem (BikeID, SaleID, PricePaid)
VALUES (2, 1, 9000.00);

-- Expected: one row with PricePaid 9000.00
SELECT *
FROM SaleItem
WHERE BikeID = 2;

-- Undo the test insert
ROLLBACK;

-- Expected: no rows after rollback
SELECT *
FROM SaleItem
WHERE BikeID = 2;


-- Client Feedback
-- Negative listed price should be rejected
-- Expected: Check constraint 'check_bicycle_listed_price' is violated
UPDATE Bicycle
SET ListedPrice = -1
WHERE BikeID = 1;

-- Negative sale price should be rejected
-- Uses an unsold bike so the price check is tested
-- Expected: Check constraint 'check_saleitem_price_paid' is violated
INSERT INTO SaleItem (BikeID, SaleID, PricePaid)
VALUES (2, 1, -1);

-- Zero battery capacity should be rejected
-- Expected: Check constraint 'check_electric_battery_capacity' is violated
UPDATE ElectricBicycleModel
SET BatteryCapacity = 0
WHERE ModelID = (
    SELECT ModelID
    FROM BicycleModel
    WHERE Brand = 'Demo Bike'
      AND ModelName = 'Ventura Roadster'
);
