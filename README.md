# SQL Learning Repository

This repository is a structured SQL learning path focused on Microsoft SQL Server and practical data work.

The content is organized from fundamentals to advanced database topics. The writing style follows the same teaching approach used in the Python notebooks: short definitions, practical context, real examples, warnings, and gradual difficulty.

## Learning Path

| Level | Folder | Focus |
| --- | --- | --- |
| 101 | [01-sql-101](01-sql-101/) | SQL basics, databases, data types, DDL, DML, DQL, DCL, TCL |
| 201 | [02-sql-201](02-sql-201/) | Filtering, aggregation, grouping, joins, subqueries |
| 301 | [03-sql-301](03-sql-301/) | T-SQL programming, variables, conditions, loops, functions, procedures |
| 401 | [04-sql-401](04-sql-401/) | Performance, indexing, transactions, security, production practices |

## Query Families

SQL commands are separated by intent:

- **DDL**: Defines database objects such as databases, tables, and columns.
- **DML**: Changes data with `INSERT`, `UPDATE`, and `DELETE`.
- **DQL**: Reads and analyzes data with `SELECT`.
- **DCL**: Controls access with `GRANT`, `REVOKE`, and `DENY`.
- **TCL**: Controls transaction safety with `COMMIT`, `ROLLBACK`, and save points.

## How To Study

Start from SQL 101 and run the scripts in order. Read the comments before executing each query. SQL is not only about writing commands; it is about understanding what the command changes in the database.

Before running `UPDATE`, `DELETE`, `DROP`, or `TRUNCATE`, always check the target table and condition with a `SELECT` query.

## Repository Structure

~~~text
SQL/
  00-roadmap/
  01-sql-101/
  02-sql-201/
  03-sql-301/
  04-sql-401/
~~~
