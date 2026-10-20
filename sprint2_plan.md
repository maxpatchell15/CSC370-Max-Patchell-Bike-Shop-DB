# Sprint 2 Plan

## Current Progress and Priorities

The database currently has eight tables, including electric bicycle models,
technicians, and maintenance records. I added model uniqueness and
explicit deletion rules, updated the ERD, and tested selected constraints.

I prioritised these changes in response to TA feedback. The planned
minimal-basis, dependency-projection, 3NF, and 4NF analyses were not
completed. The rule that each sale contains at least one bicycle also
remains unenforced.

Next sprint will focus on Complex SQL Queries and Advanced SQL.
The main aim is to develop my Data Analytics skills by writing and
checking more useful queries, while improving database consistency.

## 1. Extend Current Queries

The current queries show purchases, available bikes, sale totals,
and maintenance history. I will extend these to answer more detailed
questions about the shop.

Goals:
- Summarise customer spending using aggregation, WHERE, and HAVING,
  including customer details determined by CustomerID.
- Use a subquery to calculate an average over customer spending totals,
  with EXISTS to select customers who have qualifying purchases.
- Demonstrate inserts and deletes based on query conditions using
  disposable test data.

**Success criteria:** Save the queries with sample data showing expected
and actual results. Include customers with no and multiple purchases to 
check the calculations and filtering.

## 2. Review Query Simplicity and Performance

The current dataset is too small to assess performance meaningfully.

Goals:
- Generate and check a larger fictional dataset.
- Compare a subquery with an equivalent join and explain which is clearer.
- Use EXPLAIN and timing measurements to compare a selected query before
  and after adding a non-primary index.

**Success criteria:** Both query versions should return the same results.
Save the query plans and timing results for the index comparison.
Explain whether the index helps and whether it should be retained.

## 3. Improve Consistency and Handle NULL Values

The database currently relies on primary keys, foreign keys, and
uniqueness constraints. Customer email and phone values can be NULL.

Goals:
- Implement a trigger that rejects changes to PricePaid on an existing
  sale item, treating recorded sale prices as fixed within this project's scope.
- Test queries involving missing contact details and explain how TRUE,
  FALSE, and UNKNOWN affect filtering.
- Investigate how to enforce the requirement that a completed sale
  contains at least one bicycle, and how completion should be represented.

**Success criteria:** Show that the trigger rejects a price change while
allowing a valid new sale item. Demonstrate expected query results with
both present and NULL contact details. Find an approach to empty
sales.

## Deferred Work and Evidence

The unfinished normalization analysis remains a recorded gap.
I will rework its priority according to Client/TA alongside the new SQL goals
for next sprint.

The next submission will include SQL scripts, expected and actual
results, query-plan comparisons, and another update on completed and
unfinished goals. Client feedback will guide adjustments to the scope.
