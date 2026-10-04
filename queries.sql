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
