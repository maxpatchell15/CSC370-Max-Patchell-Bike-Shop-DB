# Relational Schema

Primary keys are shown in bold.

- Customer(**CustomerID**, Name, Email, Phone)
- BicycleModel(**ModelID**, Brand, ModelName)
- Bicycle(**BikeID**, ModelID, ListedPrice)
- Sale(**SaleID**, CustomerID, SaleDate)
- SaleItem(**BikeID**, SaleID, PricePaid)
- ElectricBicycleModel(**ModelID**, BatteryCapacity)
- Technician(**TechnicianID**, Name)
- MaintenanceRecord(**BikeID, RecordNumber**, TechnicianID, ServiceDate, Description)

## Foreign Keys and Deletion Rules

| Foreign key | References | ON DELETE |
|---|---|---|
| Bicycle.ModelID | BicycleModel.ModelID | RESTRICT |
| Sale.CustomerID | Customer.CustomerID | RESTRICT |
| SaleItem.BikeID | Bicycle.BikeID | RESTRICT |
| SaleItem.SaleID | Sale.SaleID | RESTRICT |
| ElectricBicycleModel.ModelID | BicycleModel.ModelID | CASCADE |
| MaintenanceRecord.BikeID | Bicycle.BikeID | RESTRICT |
| MaintenanceRecord.TechnicianID | Technician.TechnicianID | RESTRICT |

Restrict is used to prevent deleting a record while another record references it.
This protects the links between sales and maintenance history.

Cascade removes the electric-model details when the parent model is
deleted. A model cannot be deleted while bicycles still reference it.

## ERD

- Customer, BicycleModel, Bicycle, Sale, and Technician become tables.
- Places is represented by CustomerID in Sale.
- Describes is represented by ModelID in Bicycle.
- Includes becomes SaleItem, which stores PricePaid.
- Performs is represented by TechnicianID in MaintenanceRecord.

SaleItem uses BikeID as its primary key because each bicycle can be
sold at most once. SaleID can repeat because a sale can include
multiple bicycles.

ElectricBicycleModel is a subtype of BicycleModel. Its ModelID is both
its primary key and a foreign key to BicycleModel. Shared attributes
remain in BicycleModel.

MaintenanceRecord is a weak entity owned by Bicycle. RecordNumber
identifies a record within one bicycle, so its full primary key is
(BikeID, RecordNumber). The same record number can be used for
different bicycles.

## Constraints

- The combination (Brand, ModelName) is UNIQUE.
- All foreign-key columns are NOT NULL.
- Each bicycle belongs to exactly one model.
- Each sale belongs to exactly one customer.
- Each maintenance record belongs to exactly one bicycle and has
  exactly one technician.
- Bicycles and technicians can have zero or many maintenance records.
- Customers can have no sales, and models can have no bicycles.
- Customer email addresses and phone numbers are optional.
- A sale should contain at least one bicycle, but this minimum is
  not enforced by the current SQL constraints.

## Pricing

ListedPrice belongs to each individual bicycle because condition and
wear can affect its price. Using an update statement the price for 
multiple bicycles can still be changed at once. 

A shared model base price was considered with an adjustments for each
bicycle, but keeping individual prices allows the current design to remain 
simple.

PricePaid records the actual sale price and is not changed when
listed prices change.
