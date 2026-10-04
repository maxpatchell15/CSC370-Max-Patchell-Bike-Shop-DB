# Functional Dependencies and BCNF

## Assumptions

- Each CustomerID identifies one customer.
- Each ModelID identifies one bicycle model.
- Each BikeID identifies one individual bicycle.
- Each SaleID identifies one sale.
- Each bicycle can't be sold more than once.
- Names, email addresses, phone numbers, and model names don't have to be unique.
- Individual bicycles of the same model may have different listed prices.

## Functional Dependencies

Customer:
CustomerID → Name, Email, Phone

BicycleModel:
ModelID → Brand, ModelName

Bicycle:
BikeID → ModelID, ListedPrice

Sale:
SaleID → CustomerID, SaleDate

SaleItem:
BikeID → SaleID, PricePaid

SaleID does not determine BikeID in SaleItem because one sale can include multiple bicycles.

## Closures and Keys

| Relation | Attribute closure | Key |
|---|---|---|
| Customer | {CustomerID}+ = {CustomerID, Name, Email, Phone} | CustomerID |
| BicycleModel | {ModelID}+ = {ModelID, Brand, ModelName} | ModelID |
| Bicycle | {BikeID}+ = {BikeID, ModelID, ListedPrice} | BikeID |
| Sale | {SaleID}+ = {SaleID, CustomerID, SaleDate} | SaleID |
| SaleItem | {BikeID}+ = {BikeID, SaleID, PricePaid} | BikeID |

For each table the listed ID determines all its columns. No additional
attributes are needed to form the key. 

## BCNF Justification

Under the above functional dependencies, all five relations are in
BCNF: every non-trivial dependency has a superkey on its left side.

Bicycle model details are stored separately from individual bicycles
because ModelID determines Brand and ModelName, but does not determine
BikeID or ListedPrice. This avoids repeating model details for every
bicycle.
