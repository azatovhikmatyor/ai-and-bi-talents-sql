# SQL Server Views

## Introduction
A **view** in SQL Server is a virtual table that represents the result of a stored query. Unlike a physical table, a view does not store data but retrieves it dynamically from one or more underlying tables when queried. Views can simplify complex queries, enhance security, and improve database maintainability.

## Benefits of Using Views
### 1. **Simplifies Complex Queries**
- Views allow users to encapsulate complex SQL logic, making it easier to work with data.
- Joins, aggregations, and calculations can be predefined in a view, reducing repetitive query writing.

### 2. **Enhances Security**
- Views can limit user access to specific columns or rows, ensuring data security.
- Users can be granted access to views without direct access to the underlying tables.

### 3. **Improves Maintainability**
- By using views, changes to the database schema (such as renaming columns or modifying joins) can be handled within the view without affecting application queries.

### 4. **Provides Data Consistency**
- A well-defined view ensures that multiple users and applications see consistent results from the same query logic.

### 5. **Supports Computed Columns and Aggregations**
- Predefined calculations, aggregates, and filters in views improve query efficiency.

## Creating a View
To create a view, use the `CREATE VIEW` statement:

```sql
CREATE VIEW ViewName AS
SELECT column1, column2, column3
FROM TableName
WHERE condition;
```

### Example:
```sql
CREATE VIEW EmployeeView AS
SELECT EmployeeID, FirstName, LastName, Department
FROM Employees
WHERE Department = 'IT';
```
This view filters employees who work in the IT department.

## Querying a View
Once a view is created, you can retrieve data from it just like a table:

```sql
SELECT * FROM EmployeeView;
```

## Updating Data Through a View
If a view is based on a single table without aggregations, you can perform `INSERT`, `UPDATE`, and `DELETE` operations on it.

### Example:
```sql
UPDATE EmployeeView
SET Department = 'HR'
WHERE EmployeeID = 101;
```

However, certain views, especially those using `JOIN`, `GROUP BY`, or aggregate functions, may not support updates.

### Updatable vs. Non-Updatable Views
A view is updatable if:
- It is based on a single table without `GROUP BY`, `DISTINCT`, `HAVING`, or `UNION`.
- It does not contain computed columns.

Example of a **non-updatable** view:
```sql
CREATE VIEW SalesSummary AS
SELECT ProductID, SUM(Quantity) AS TotalSales
FROM Sales
GROUP BY ProductID;
```
Since it includes an aggregate function (`SUM`), it cannot be updated directly.

## Modifying and Deleting a View
To modify an existing view:
```sql
ALTER VIEW EmployeeView AS
SELECT EmployeeID, FirstName, LastName, Salary
FROM Employees;
```
To delete a view:
```sql
DROP VIEW EmployeeView;
```

## Indexed (Materialized) Views
By default, views do not store data. However, SQL Server allows **indexed views** (also called materialized views), which store results physically in the database for performance optimization.

### Creating an Indexed View
1. The view must be created with `WITH SCHEMABINDING` to prevent schema changes to underlying tables.
2. A unique clustered index must be created on the view.

Example:
```sql
CREATE VIEW SalesSummary WITH SCHEMABINDING AS
SELECT ProductID, SUM(Quantity) AS TotalSales
FROM dbo.Sales
GROUP BY ProductID;
```
To create an index:
```sql
CREATE UNIQUE CLUSTERED INDEX IDX_SalesSummary
ON SalesSummary(ProductID);
```

### Advantages of Indexed Views
- **Improved Query Performance**: Indexed views store precomputed results, reducing query execution time.
- **Faster Aggregation and Joins**: Common aggregations and joins are precomputed.
- **Optimized Reporting**: Great for analytical workloads where data changes less frequently.

### Considerations for Indexed Views
- Indexed views consume extra storage.
- Updates to base tables require updates to the indexed view.
- Queries must use `WITH (NOEXPAND)` hint to leverage indexed views in some SQL Server editions.

## Security and Permissions
Views provide an additional security layer by restricting access to specific columns and rows.

### Granting Access to a View
To allow a user to select data from a view:
```sql
GRANT SELECT ON EmployeeView TO UserName;
```

### Revoking Access
To remove access:
```sql
REVOKE SELECT ON EmployeeView FROM UserName;
```

## Performance Considerations
- **Views do not improve performance by default** – they are just saved queries executed dynamically.
- **Use indexed views** for faster performance when dealing with large datasets.
- **Keep views simple** – Avoid nesting views within views as it can lead to performance issues.
- **Ensure proper indexing** on base tables to optimize query execution time.
