# Sprint 3 Plan

## Current Progress and Priorities

The database now includes customer spending queries, subqueries, NULL examples, and a trigger preventing changes to already recorded sale prices. I added CHECK constraints to address Client/TA feedback and compared query performance before and after adding a date index to a larger test dataset.

The earlier normalisation analysis remains unfinished. I investigated how to prevent a sale from being completed with no items, but have not implemented this rule yet.

Next sprint will focus on ACID Transactions, Basic Security, and Analysing Query Algorithms. The current project has only a basic rollback test and does not yet demonstrate concurrent transactions, recovery, or different user permissions. The transaction and access-control goals will develop skills from Back-end Engineering Levels 1 and 2. The query analysis will build on the index work from Data Analytics Level 3 and develop Level 4 skills by explaining disk-access costs and comparing query plans.

## 1. Review Transactions and Consistency

Creating a sale and its items currently requires separate statements. These changes should succeed or fail together.

Goals:
- Group the creation of a sale and its items into a transaction using COMMIT and ROLLBACK.
- Review the existing CHECK constraints and express the completed-sale rule as an assertion, identifying a suitable enforcement approach for the project.
- Use two database connections to compare transaction behaviour and select an appropriate isolation level.
- Work through a small example of manually recovering database contents from a transaction log.

**Success criteria:** Show a successful transaction and a failed operation followed by a rollback, leaving no partial sale. Record the results from two connections and explain the isolation-level choice. Document the completed-sale rule and the proposed enforcement approach. Demonstrate recovery from a transaction log, showing which changes are retained or undone.

## 2. Add Access Control and Views

The project does not currently demonstrate different permissions for different users. I will use inventory viewing and maintenance recording as examples of tasks requiring different access.

Goals:
- Create test users with permissions appropriate to their tasks.
- Grant and revoke permissions and check the effect on access.
- Create a view that exposes only the data needed for one task.
- Demonstrate an insert or delete using an updatable view.

**Success criteria:** Show that allowed operations succeed and restricted operations fail, including after a permission is revoked. Demonstrate that a view change updates the intended table record.

## 3. Extend the Query Performance Analysis

The index experiment showed a faster lookup, but the current analysis does not explain the disk accesses involved or compare alternative query plans.

Goals:
- Use a small B+-tree example to calculate I/O costs for an exact lookup and a range query.
- Analyse the I/O costs of an insertion, including a case requiring a node split.
- Produce equivalent logical query plans for an existing query.
- Compare filtering before and after a join and explain how this affects the amount of data processed.

**Success criteria:** Save worked I/O calculations with their assumptions, equivalent query plans, and an explanation of when filtering before a join improves performance. Connect these findings to the date-index experiment and an EXPLAIN plan.

## Deferred Work and Evidence

The unfinished normalization analysis remains a recorded gap. I will review its priority with the TA/Client alongside the new goals.

The next submission will include SQL scripts, expected and actual results, transaction and permission tests, and worked recovery and query-analysis examples. I will compare the results with the success criteria and explain any unfinished goals.

TA/Client feedback will guide changes to the scope while keeping the plan aligned with the course competencies.
