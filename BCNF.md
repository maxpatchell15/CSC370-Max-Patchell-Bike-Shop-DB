# Functional Dependencies and BCNF

## Assumptions
- Documented under constrains in relational_schema.md 

## Functional Dependencies

Customer:
CustomerID → Name, Email, Phone

BicycleModel:
ModelID → Brand, ModelName
Brand, ModelName → ModelID

Bicycle:
BikeID → ModelID, ListedPrice

Sale:
SaleID → CustomerID, SaleDate

SaleItem:
BikeID → SaleID, PricePaid

ElectricBicycleModel:
ModelID → BatteryCapacity

Technician:
TechnicianID → Name

MaintenanceRecord:
BikeID, RecordNumber → TechnicianID, ServiceDate, Description

SaleID does not determine BikeID in SaleItem because one sale can
include multiple bicycles.

RecordNumber alone does not identify a maintenance record because
different bicycles can have the same record number. BikeID alone
is also insufficient because a bicycle can have several records.

## Closures and Keys

Each closure below is calculated within its own relation.

| Relation | Attribute closure | Key |
|---|---|---|
| Customer | {CustomerID}+ = {CustomerID, Name, Email, Phone} | CustomerID |
| BicycleModel | {ModelID}+ = {ModelID, Brand, ModelName} | ModelID |
| BicycleModel | {Brand, ModelName}+ = {Brand, ModelName, ModelID} | Brand, ModelName |
| Bicycle | {BikeID}+ = {BikeID, ModelID, ListedPrice} | BikeID |
| Sale | {SaleID}+ = {SaleID, CustomerID, SaleDate} | SaleID |
| SaleItem | {BikeID}+ = {BikeID, SaleID, PricePaid} | BikeID |
| ElectricBicycleModel | {ModelID}+ = {ModelID, BatteryCapacity} | ModelID |
| Technician | {TechnicianID}+ = {TechnicianID, Name} | TechnicianID |
| MaintenanceRecord | {BikeID, RecordNumber}+ = {BikeID, RecordNumber, TechnicianID, ServiceDate, Description} | BikeID, RecordNumber |

Each listed key determines every attribute in its table, and no
attribute can be removed from the key while keeping that property.

BicycleModel has two candidate keys: ModelID and (Brand, ModelName).
ModelID is the chosen primary key.

MaintenanceRecord uses the combined primary key (BikeID, RecordNumber).

## BCNF Justification

Under the stated dependencies, all eight relations are in BCNF:
every non-trivial functional dependency has a superkey on its left side.

In BicycleModel, both ModelID and (Brand, ModelName) are keys.
In MaintenanceRecord, the determinant is the complete combined key
(BikeID, RecordNumber).

Model details are stored separately from individual bicycles.
ModelID determines Brand and ModelName, but does not determine
BikeID or ListedPrice.

Technician names are stored in Technician rather than repeated
in MaintenanceRecord. Electric-model attributes are stored in
ElectricBicycleModel rather than added to every bicycle model.
