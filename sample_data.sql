INSERT INTO Customer (CustomerID, Name, Email, Phone)
VALUES
    (1, 'Lily Frazer', 'lfrazer@gmail.com', '250-600-0001'),
    (2, 'Big Ed', 'edders@outlook.com', '250-800-0002');

INSERT INTO BicycleModel (ModelID, Brand, ModelName)
VALUES
    (1, 'Cannondale', 'SL3'),
    (2, 'Van Rysel', 'RC520');

INSERT INTO Bicycle (BikeID, ModelID, ListedPrice)
VALUES
    (1, 1, 10000.36),
    (2, 1, 10000.36),
    (3, 2, 8475.44);

INSERT INTO Sale (SaleID, CustomerID, SaleDate)
VALUES
    (1, 1, '2026-10-01');

INSERT INTO SaleItem (BikeID, SaleID, PricePaid)
VALUES
    (1, 1, 10000.36),
    (3, 1, 8475.44);

-- test eletrical model
INSERT INTO BicycleModel (Brand, ModelName)
VALUES ('Demo Bike', 'Ventura Roadster');

SET @electric_model_id = LAST_INSERT_ID();

INSERT INTO ElectricBicycleModel (ModelID, BatteryCapacity)
VALUES (@electric_model_id, 500);

-- individual bicycle of that model
INSERT INTO Bicycle (ModelID, ListedPrice)
VALUES (@electric_model_id, 2500.00);

SET @electric_bike_id = LAST_INSERT_ID();

-- technician
INSERT INTO Technician (Name)
VALUES ('Grace Smith');

SET @technician_id = LAST_INSERT_ID();

-- two maintenance records for this bicycle
INSERT INTO MaintenanceRecord
    (BikeID, RecordNumber, TechnicianID, ServiceDate, Description)
VALUES
    (@electric_bike_id, 1, @technician_id, '2026-10-18',
     'Checked brakes and adjusted cables'),
    (@electric_bike_id, 2, @technician_id, '2026-10-19',
     'Checked battery and tire pressure');

