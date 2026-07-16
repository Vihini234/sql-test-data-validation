# SQL Test Data Validation

A set of SQL queries simulating real QA data-validation checks against
a small sample e-commerce database (customers, orders, order_items).
Built to practice the kind of backend data verification a QA engineer
performs alongside UI and API testing.

## What this demonstrates

- Writing SQL to validate data integrity: missing fields, calculation
  mismatches, orphaned records
- INNER and LEFT JOIN across multiple related tables
- Aggregate functions (COUNT, SUM, AVG) with GROUP BY and HAVING
- Thinking about data the way a tester does — not just "does the query
  run" but "what real-world problem would this catch"

## Database structure

| Table | Purpose |
|-------|---------|
| `customers` | customer_id, name, email |
| `orders` | order_id, customer_id, order_date, total_amount |
| `order_items` | item_id, order_id, product_name, price, quantity |

Sample data was seeded with a few intentional problems, so the
validation queries have real issues to catch — not just theoretical
ones.

## How to run

1. Download [DB Browser for SQLite](https://sqlitebrowser.org/) (free)
2. Open `schema.sql` in the **Execute SQL** tab and run it — this
   creates the tables and inserts the sample data
3. Run any query from `queries.sql` the same way

## Files

| File | Contents |
|------|----------|
| `schema.sql` | Table definitions and sample data (with planted issues) |
| `queries.sql` | 10+ validation queries, each with a comment explaining what it checks |

## Sample findings

- One customer record is missing an email address
- One order's `total_amount` doesn't match the sum of its line items
- One order references a `customer_id` that doesn't exist in the
  customers table (orphaned record)

**Note:** SQLite's foreign key constraints correctly blocked the
orphaned-record insert by default. I disabled them intentionally
(`PRAGMA foreign_keys = OFF`) to simulate a real-world data integrity
failure — exactly the kind of issue a data-validation check is meant
to catch, even when the database itself tries to prevent it.

---

*Part of my QA portfolio — see also:
[SauceDemo Manual Testing](https://github.com/Vihini234/QA-Portfolio) ·
[Restful Booker API Tests](https://github.com/Vihini234/restful-booker-api-tests)*
