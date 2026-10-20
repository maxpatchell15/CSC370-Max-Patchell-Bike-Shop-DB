CREATE TABLE Customer (
	CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100),
    Phone VARCHAR(30)
);

CREATE TABLE BicycleModel (
    ModelID INT AUTO_INCREMENT PRIMARY KEY,
    Brand VARCHAR(100) NOT NULL,
    ModelName VARCHAR(100) NOT NULL,
    
    CONSTRAINT uq_bicyclemodel_brand_model
		UNIQUE (Brand, ModelName)
);

CREATE TABLE Bicycle (
    BikeID INT AUTO_INCREMENT PRIMARY KEY,
    ModelID INT NOT NULL,
    ListedPrice DECIMAL(10, 2) NOT NULL,

    FOREIGN KEY (ModelID)
        REFERENCES BicycleModel(ModelID)
);

CREATE TABLE Sale (
    SaleID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT NOT NULL,
    SaleDate DATE NOT NULL,

    FOREIGN KEY (CustomerID)
        REFERENCES Customer(CustomerID)
);

CREATE TABLE SaleItem (
    BikeID INT PRIMARY KEY,
    SaleID INT NOT NULL,
    PricePaid DECIMAL(10, 2) NOT NULL,

    FOREIGN KEY (BikeID)
        REFERENCES Bicycle(BikeID),

    FOREIGN KEY (SaleID)
        REFERENCES Sale(SaleID)
);

CREATE TABLE ElectricBicycleModel (
    ModelID INT PRIMARY KEY,
    BatteryCapacity INT NOT NULL,

    FOREIGN KEY (ModelID)
        REFERENCES BicycleModel(ModelID)
        ON DELETE CASCADE
);

CREATE TABLE Technician (
    TechnicianID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL
);

CREATE TABLE MaintenanceRecord (
    BikeID INT NOT NULL,
    RecordNumber INT NOT NULL,
    TechnicianID INT NOT NULL,
    ServiceDate DATE NOT NULL,
    Description VARCHAR(500) NOT NULL,

    PRIMARY KEY (BikeID, RecordNumber),

    FOREIGN KEY (BikeID)
        REFERENCES Bicycle(BikeID)
        ON DELETE RESTRICT,

    FOREIGN KEY (TechnicianID)
        REFERENCES Technician(TechnicianID)
        ON DELETE RESTRICT
);




