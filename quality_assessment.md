# Quality Assessment


## Eight Design Qualities

| Quality | Assessment |
|---|---|
| Completeness | The design covers inventory, customers, sales, electric-model details, technicians, and maintenance records. The requirement that a sale contains at least one bicycle is still not enforced. |
| Correctness | SaleItem uses BikeID as its primary key to prevent repeat sales. MaintenanceRecord uses (BikeID, RecordNumber), allowing each bicycle to have its own numbered history. |
| Minimality | Model details and technician names are stored once in their respective tables. Sale totals are calculated rather than stored. |
| Expressiveness | The updated ERD represents electric models through inheritance and maintenance records as weak entities owned by bicycles. |
| Readability | Entities, relationships, and attributes are labelled in the ERD. The relational schema lists primary keys, foreign keys, and deletion rules. |
| Self-explanation | Names such as PricePaid and ServiceDate describe what the attributes represent. The documentation explains record numbering and the units used for BatteryCapacity. |
| Extensibility | Maintenance and electric model details were added without changing the structure of the existing sales tables. Other model subtypes could follow the same approach if needed. |
| Normality | Under the documented functional dependencies, the eight relations satisfy BCNF. The dependencies and keys are recorded in BCNF.md. |

## Sprint 2 feedback
This section reviews the changes made during Sprint 2 and the remaining limitations. 

I added CHECK constraints to reject negative ListedPrice and PricePaid values, and BatteryCapacity values of zero or less. Tests confirmed these values were rejected. I also removed a stray character noted in schema.sql.

## Deleting Bikes with Maintenance Records
I kept ON DELETE RESTRICT because deleting a bike should not also erase its maintenance history. Losing that history could be a safety issue, as it makes it harder to track previous safety-related repairs. A bike with maintenance records cannot currently be deleted. A possible solution would be to implement an archived status that could allow a bike to be removed from active inventory while keeping its history, but this is not currently implemented.

## Sales with No Items
The database still allows sales with no items. One possible solution is to distinguish draft sales from completed sales and check that a sale has at least one item before it can be completed. The system would also need to prevent removing or moving the last item out of a completed sale. I investigated having a sale status as an approach but have not implemented it.

## Deferred Normalisation Work
The minimal-basis, dependency-projection, 3NF, and 4NF analyses remain unfinished. This sprint focused on the SQL goals in the submitted plan and the new TA/Client feedback.
