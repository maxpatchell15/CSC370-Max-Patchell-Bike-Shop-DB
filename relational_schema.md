# Relational Schema

- Customer(**CustomerID**, Name, Email, Phone)
- BicycleModel(**ModelID**, Brand, ModelName)
- Bicycle(**BikeID**, ModelID, ListedPrice)
- Sale(**SaleID**, CustomerID, SaleDate)
- SaleItem(**BikeID**, SaleID, PricePaid)
- 
Primary keys are listed in **bold**.

## Foreign Keys

- Bicycle.ModelID references BicycleModel.ModelID.
- Sale.CustomerID references Customer.CustomerID.
- SaleItem.BikeID references Bicycle.BikeID.
- SaleItem.SaleID references Sale.SaleID.

## ERD Relation to Database Schema

Each rectangle entity is a table: Customer, Sale, Bicycle, and BicycleModel
Relationships are represented by foreign keys. 

- The Places relationship is represented by CustomerID in Sale.
- The Describes relationship is represented by ModelID in Bicycle.
- The Includes relationship is represented by SaleItem, with its PricePaid attribute.

SaleItem uses BikeID as its primary key because it's a unique ID and each bicycle can can only be sold once. SaleID can appear more than once as sale can be for multiple bicycles.

## Constraints

Foreign keys are NOT NULL requiring each sale to have a customer, each bicycle to have a model, and each sale item to reference a sale and bicycle.
