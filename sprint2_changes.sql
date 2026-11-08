-- Prices can be zero but not negative
ALTER TABLE Bicycle
ADD CONSTRAINT check_bicycle_listed_price
CHECK (ListedPrice >= 0);

ALTER TABLE SaleItem
ADD CONSTRAINT check_saleitem_price_paid
CHECK (PricePaid >= 0);

-- Electric bicycle's battery capacity must be positive
ALTER TABLE ElectricBicycleModel
ADD CONSTRAINT check_electric_battery_capacity
CHECK (BatteryCapacity > 0);

-- Prevent changes to a recorded sale price
CREATE TRIGGER prevent_price_paid_change
BEFORE UPDATE ON SaleItem
FOR EACH ROW
BEGIN
    IF NEW.PricePaid <> OLD.PricePaid THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Recorded sale prices cannot be changed';
    END IF;
END;

