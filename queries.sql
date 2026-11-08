-- 1. Full bicycle purchase by which customer
SELECT
    Sale.SaleID,
    Customer.Name,
    Sale.SaleDate,
    Bicycle.BikeID,
    BicycleModel.Brand,
    BicycleModel.ModelName,
    SaleItem.PricePaid
FROM Sale
JOIN Customer ON Sale.CustomerID = Customer.CustomerID
JOIN SaleItem ON Sale.SaleID = SaleItem.SaleID
JOIN Bicycle ON SaleItem.BikeID = Bicycle.BikeID
JOIN BicycleModel ON Bicycle.ModelID = BicycleModel.ModelID;

-- 2. Show which bikes are avaliable
SELECT
    Bicycle.BikeID,
    BicycleModel.Brand,
    BicycleModel.ModelName,
    Bicycle.ListedPrice
FROM Bicycle
JOIN BicycleModel ON Bicycle.ModelID = BicycleModel.ModelID
LEFT JOIN SaleItem ON Bicycle.BikeID = SaleItem.BikeID
WHERE SaleItem.BikeID IS NULL;

-- 3. Calculate the total sale
SELECT
    SaleID,
    SUM(PricePaid) AS TotalPaid
FROM SaleItem
GROUP BY SaleID;


-- 4. Show maintenance history for the electric bicycle
SELECT
    Bicycle.BikeID,
    BicycleModel.Brand,
    BicycleModel.ModelName,
    ElectricBicycleModel.BatteryCapacity,
    MaintenanceRecord.RecordNumber,
    MaintenanceRecord.ServiceDate,
    MaintenanceRecord.Description,
    Technician.Name AS TechnicianName
FROM Bicycle
JOIN BicycleModel
    ON Bicycle.ModelID = BicycleModel.ModelID
JOIN ElectricBicycleModel
    ON BicycleModel.ModelID = ElectricBicycleModel.ModelID
JOIN MaintenanceRecord
    ON Bicycle.BikeID = MaintenanceRecord.BikeID
JOIN Technician
    ON MaintenanceRecord.TechnicianID = Technician.TechnicianID
WHERE BicycleModel.Brand = 'Demo Bike'
  AND BicycleModel.ModelName = 'Ventura Roadster'
ORDER BY Bicycle.BikeID, MaintenanceRecord.RecordNumber;

-- Sprint 2
-- 5. Check customer spending, including customers with no purchases
SELECT
    Customer.CustomerID,
    Customer.Name,
    COUNT(DISTINCT Sale.SaleID) AS NumberOfSales,
    COALESCE(SUM(SaleItem.PricePaid), 0) AS TotalSpent
FROM Customer
LEFT JOIN Sale ON Customer.CustomerID = Sale.CustomerID
LEFT JOIN SaleItem ON Sale.SaleID = SaleItem.SaleID
GROUP BY Customer.CustomerID
ORDER BY Customer.CustomerID;


-- 6. Which customers spent at least 2000 in November
SELECT
    Customer.CustomerID,
    Customer.Name,
    SUM(SaleItem.PricePaid) AS TotalSpent
FROM Customer
JOIN Sale ON Customer.CustomerID = Sale.CustomerID
JOIN SaleItem ON Sale.SaleID = SaleItem.SaleID
WHERE Sale.SaleDate >= '2026-11-01'
  AND Sale.SaleDate < '2026-12-01'
GROUP BY Customer.CustomerID
HAVING SUM(SaleItem.PricePaid) >= 2000
ORDER BY Customer.CustomerID;

-- 7. Average November spending among November purchasers 
-- who bought at least one bike for 1000 or more that month
-- Expected with current sample data: 2250.00
SELECT AVG(CustomerTotals.TotalSpent) AS AverageNovemberSpending
FROM (
    SELECT
        Customer.CustomerID,
        SUM(SaleItem.PricePaid) AS TotalSpent
    FROM Customer
    JOIN Sale ON Customer.CustomerID = Sale.CustomerID
    JOIN SaleItem ON Sale.SaleID = SaleItem.SaleID
    WHERE Sale.SaleDate >= '2026-11-01'
      AND Sale.SaleDate < '2026-12-01'
      AND EXISTS (
          SELECT 1
          FROM Sale AS QualifyingSale
          JOIN SaleItem AS QualifyingItem
              ON QualifyingSale.SaleID = QualifyingItem.SaleID
          WHERE QualifyingSale.CustomerID = Customer.CustomerID
            AND QualifyingSale.SaleDate >= '2026-11-01'
            AND QualifyingSale.SaleDate < '2026-12-01'
            AND QualifyingItem.PricePaid >= 1000
      )
    GROUP BY Customer.CustomerID
) AS CustomerTotals;

-- 8. Show how NULL affect comparisons and filtering
SELECT
    Name,
    Email,
    Phone,
    Email = 'tenille@example.com' AS EmailMatches,
    NOT (Email = 'tenille@example.com') AS EmailDoesNotMatch,
    Email IS NULL AS MissingEmail
FROM Customer
ORDER BY CustomerID;

-- 9. Customers whose email differ from Tenille's
-- Expected: Lily Frazer and Big Ed
-- Missing emails are excluded, due to where only keeping true
SELECT Name, Email
FROM Customer
WHERE Email <> 'tenille@example.com'
ORDER BY CustomerID;

-- 10. Conditional inserts and deletes using disposable data
-- Create an empty temporary table with customer's structure
CREATE TEMPORARY TABLE Sprint2CustomerDemo LIKE Customer;

-- Copy only customers who bought a bicycle in November
-- Expected: 2 rows inserted — Tenille and Gordon
INSERT INTO Sprint2CustomerDemo (CustomerID, Name, Email, Phone)
SELECT CustomerID, Name, Email, Phone
FROM Customer
WHERE EXISTS (
    SELECT 1
    FROM Sale
    JOIN SaleItem ON Sale.SaleID = SaleItem.SaleID
    WHERE Sale.CustomerID = Customer.CustomerID
      AND Sale.SaleDate >= '2026-11-01'
      AND Sale.SaleDate < '2026-12-01'
);

-- Check the copied customers
SELECT *
FROM Sprint2CustomerDemo
ORDER BY CustomerID;

-- Remove copied customers whose November spending was below 2000
-- Expected: 1 row deleted — Gordon
DELETE FROM Sprint2CustomerDemo
WHERE CustomerID IN (
    SELECT Sale.CustomerID
    FROM Sale
    JOIN SaleItem ON Sale.SaleID = SaleItem.SaleID
    WHERE Sale.SaleDate >= '2026-11-01'
      AND Sale.SaleDate < '2026-12-01'
    GROUP BY Sale.CustomerID
    HAVING SUM(SaleItem.PricePaid) < 2000
);

-- Expected: only Tenille remains
SELECT *
FROM Sprint2CustomerDemo
ORDER BY CustomerID;

-- Remove the temporary table
DROP TEMPORARY TABLE Sprint2CustomerDemo;

-- 11a. November purchasers using a subquery
-- Expected: Tenille and Gordon
SELECT Customer.CustomerID, Customer.Name
FROM Customer
WHERE EXISTS (
    SELECT 1
    FROM Sale
    JOIN SaleItem ON Sale.SaleID = SaleItem.SaleID
    WHERE Sale.CustomerID = Customer.CustomerID
      AND Sale.SaleDate >= '2026-11-01'
      AND Sale.SaleDate < '2026-12-01'
)
ORDER BY Customer.CustomerID;


-- 11b. November purchasers using joins
-- Expected: same result as 11a
SELECT DISTINCT Customer.CustomerID, Customer.Name
FROM Customer
JOIN Sale ON Customer.CustomerID = Sale.CustomerID
JOIN SaleItem ON Sale.SaleID = SaleItem.SaleID
WHERE Sale.SaleDate >= '2026-11-01'
  AND Sale.SaleDate < '2026-12-01'
ORDER BY Customer.CustomerID;

