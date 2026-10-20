# CSC370-Max-Patchell-Bike-Shop-DB
CSC370 UVic Course Project: Bike Shop Database

## Project Overview
This project follows the development of a database for a bicycle shop using MySQL. 
Core logic is to sell bicycles and track inventory. The initial entities to store 
are bicycle models, individual bicycles, customers, and sales so the shop can 
identify available stock and review purchase history.

The database now includes electric bicycle model details, technicians,
and maintenance records. It has eight tables. Future work will focus
on more detailed queries, performance, and consistency.

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

## Organisation

| File | Content |
| --- | --- |
| README.md | Project overview and requirements. |
| ERD.pdf | Conceptual design, including inheritance and a weak entity. |
| relational_schema.md | Tables, keys, deletion rules, assumptions, and ERD mapping. |
| BCNF.md | Functional dependencies, closures, keys, and BCNF justification. |
| schema.sql | SQL statements to create the eight tables and their constraints. |
| sample_data.sql | Sample customers, models, bicycles, sales, technicians, and maintenance records. |
| queries.sql | Purchase details, available inventory, sale totals, and electric-bike maintenance history. |
| constraint_test.sql | Intentional constraint violations with expected errors. |
| design_review.md | Review of the eight design qualities, TA feedback, test results, and limitations. |
| sprint1_plan.md | Original goals and success criteria submitted at kickoff. |
| sprint2_plan.md | Next-sprint goals covering Complex SQL Queries and Advanced SQL. |

## AI Usage
GenAI will be used for this project under the restrictions provided by the course/project outline. It will be used mostly for formatting, and will be aptly described when used otherwise.


