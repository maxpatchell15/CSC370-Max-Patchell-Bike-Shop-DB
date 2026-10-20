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
| Extensibility | Maintenance and electri model details were added without changing the structure of the existing sales tables. Other model subtypes could follow the same approach if needed. |
| Normality | Under the documented functional dependencies, the eight relations satisfy BCNF. The dependencies and keys are recorded in BCNF.md. |
