# CSC370-Max-Patchell-Bike-Shop-DB
CSC370 UVic Course Project: Bike Shop Database

## Project Overview
This project follows the development of a database for a bicycle shop using MySQL. 
Core logic is to sell bicycles and track inventory. The initial entities to store 
are bicycle models, individual bicycles, customers, and sales so the shop can 
identify available stock and review purchase history.

The database now includes electric bicycle model details, technicians, and maintenance 
records across eight tables. Sprint 2 adds customer spending queries, NULL examples, 
a trigger protecting recorded sale prices, and an index experiment using a larger test dataset.

## Requirements
- Store bike brands and models, with each brand/model combination unique.
- Identify each bicycle by a unique BikeID and link it to its model.
- Allow individual bicycles to have different listed prices.
- Identify customers and link them to contact details and purchases.
- Record each sale's customer, date, bicycles, and actual prices paid.
- Allow a sale to include multiple bicycles.
- Prevent a bicycle from being sold more than once.
- Preserve sales history and prevent deletion of referenced records.
- Store battery capacity in watt-hours for electric bicycle models.
- Record maintenance dates, descriptions, and the technician responsible.
- Number maintenance records within each bicycle's history.
- Allow prices of zero but reject negative prices.
- Require positive battery capacity for electric bicycle models.
- Prevent changes to recorded sale prices.

## Organisation

| File | Content |
| --- | --- |
| README.md | Project overview, requirements, and running instructions. |
| ERD.pdf | Conceptual design, including inheritance and a weak entity. |
| relational_schema.md | Tables, keys, deletion rules, constraints, and ERD mapping. |
| BCNF.md | Functional dependencies, closures, keys, and BCNF justification. |
| schema.sql | Creates the eight tables, constraints, and sale-price trigger. |
| sample_data.sql | Sample data, including customers with multiple purchases, no purchases, and missing contact details. |
| queries.sql | Purchase and maintenance queries, spending summaries, subqueries, NULL examples, temporary-data changes, and equivalent query comparisons. |
| constraints_test.sql | Constraint and trigger tests with expected results, including a valid insert rolled back after testing. |
| index_experiment.sql | Generates 10000 test sales and compares query plans and timings before and after adding a date index. |
| sprint2_changes.sql | Applies Sprint 2 constraints and the trigger to the existing database. |
| quality_assessment.md | Review of the eight design qualities, TA feedback, and remaining limitations. |
| sprint1_plan.md | Original goals and success criteria submitted at kickoff. |
| sprint2_plan.md | Submitted Sprint 2 goals covering Complex SQL Queries and Advanced SQL. |

## AI Usage
GenAI will be used for this project under the restrictions provided by the course/project outline. It will be used mostly for formatting, and will be aptly described when used otherwise.


