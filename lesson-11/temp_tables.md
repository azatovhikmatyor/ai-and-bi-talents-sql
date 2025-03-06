# Temporary Tables in SQL Server

## Introduction
Temporary tables in SQL Server are special tables that store intermediate results during query execution. They exist only for the duration of a session or transaction and help manage temporary data efficiently.

SQL Server provides three types of temporary tables:
1. **Local Temporary Tables (`#TableName`)**
2. **Global Temporary Tables (`##TableName`)**
3. **Table Variables (`@TableName`)**
4. **Temporary Table Equivalents (Common Table Expressions and Derived Tables)**

## 1. Local Temporary Tables (`#TableName`)
A **local temporary table** is created with a single `#` sign and is only visible to the session that created it. It gets automatically deleted when the session ends.

### Creating a Local Temporary Table
```sql
CREATE TABLE #TempEmployees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(100),
    Department VARCHAR(50)
);
```

### Inserting Data
```sql
INSERT INTO #TempEmployees (EmployeeID, Name, Department)
VALUES (1, 'John Doe', 'IT'), (2, 'Jane Smith', 'HR');
```

### Querying Data
```sql
SELECT * FROM #TempEmployees;
```

### Dropping the Table
Although local temporary tables are automatically removed after the session ends, you can manually drop them:
```sql
DROP TABLE #TempEmployees;
```

## 2. Global Temporary Tables (`##TableName`)
A **global temporary table** is created with `##` and is visible to all sessions. It remains available until the session that created it disconnects **and** all active queries using it are completed.

### Creating a Global Temporary Table
```sql
CREATE TABLE ##GlobalTemp (
    ID INT,
    Data VARCHAR(50)
);
```

### Using the Table in Multiple Sessions
- Any session can insert, update, or delete data from the table.
- The table persists until the last session using it is closed.

### Dropping a Global Temporary Table
```sql
DROP TABLE ##GlobalTemp;
```

## 3. Table Variables (`@TableName`)
A **table variable** is declared using `DECLARE` and exists only within the batch or stored procedure in which it is defined. Unlike temporary tables, table variables do not support indexes except for primary keys.

### Declaring a Table Variable
```sql
DECLARE @TempTable TABLE (
    ID INT PRIMARY KEY,
    Name VARCHAR(50)
);
```

### Inserting Data
```sql
INSERT INTO @TempTable (ID, Name)
VALUES (1, 'Alice'), (2, 'Bob');
```

### Querying Data
```sql
SELECT * FROM @TempTable;
```

### Differences Between Table Variables and Temporary Tables
| Feature               | Temporary Table (`#TempTable`) | Table Variable (`@TableVariable`) |
|-----------------------|--------------------------------|-----------------------------------|
| Scope                | Session or transaction        | Batch, function, or procedure    |
| Indexes              | Supports indexes explicitly   | Only supports primary key index  |
| Rollback in Transactions | Yes                        | No                                |
| Performance          | Stored in `tempdb` (disk/I/O) | Stored in memory (faster for small data) |
| Supports Constraints | Yes                            | Limited support                  |

## 4. Temporary Table Equivalents
### Common Table Expressions (CTE)
A **CTE** provides a temporary result set that can be used in the same execution scope.
```sql
WITH TempCTE AS (
    SELECT EmployeeID, Name FROM Employees WHERE Department = 'IT'
)
SELECT * FROM TempCTE;
```

### Derived Tables
A **derived table** is a subquery within a `FROM` clause.
```sql
SELECT * FROM (
    SELECT EmployeeID, Name FROM Employees WHERE Department = 'IT'
) AS TempDerived;
```

## Performance Considerations
1. **Temporary Tables (`#`)** are useful when dealing with large datasets that require indexing.
2. **Global Temporary Tables (`##`)** should be used cautiously as they affect all users.
3. **Table Variables (`@`)** are optimal for small datasets and procedural logic.
4. **CTEs and Derived Tables** are ideal for in-memory, read-only temporary storage.
