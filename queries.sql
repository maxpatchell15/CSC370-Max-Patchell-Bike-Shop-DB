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