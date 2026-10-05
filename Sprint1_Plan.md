# Sprint 1 Plan

## Current Progress

The current database supports basic bicycle inventory, customers, and sales. I have implemented five tables and documented their ERD, relational schema, functional dependencies, and BCNF properties. 
Sprint 1 will focus on progressing from Data Architecutre Level 2 to Level 3, using the course material covered between BCNF and Advanced Relational Design.

## 1. Review the Design and Its Constraints

The current design will be assessed against the eight design-quality criteria.

I will:
- Review eight design-quality criteria: completeness, correctness, minimality, expressiveness, readability, self-explanation, extensibility, and normality.
- Map the requirements to the ERD and SQL implementation.
- Test primary-key and foreign-key constraints.

**Success criteria:** A review covering all eight qualities, examples of justified improvements, and tests of edge cases with expected and actual results. Tests will include a duplicate bicycle sale, a nonexistent referenced record, and a sale with no items.

## 2. Check the ERD and Explore Advanced Modelling

The current ERD uses basic entities and binary relationships.  The next step will be to include add inheritance and weak entities, such as electric bicycle models and maintenance records numbered within each bicycle. 
This is a general plan for the features of next sprint, at this point in time I do not want to commit to these design decisions without review from the TA/Client, they need to belong in the implemented database.

**Success criteria:** Update the ERD from the relational schema, and explain any differences. Produce inheritance and weak-entity example with their relational mappings.
