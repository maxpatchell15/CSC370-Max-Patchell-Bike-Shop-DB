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

-- To reset sales items for demo
DELETE FROM SaleItem;
DELETE FROM Sale;