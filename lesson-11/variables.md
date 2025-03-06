# SQL Server Variables

## Introduction
Variables in SQL Server are objects that store values temporarily during the execution of a query, batch, or session. They are primarily used to store and manipulate data dynamically within SQL scripts.

There are three main types of variables in SQL Server:
1. **Scalar Variables** – Store a single value of a specific data type.
2. **Table Variables** – Store a result set in memory like a temporary table.
3. **System Variables** – Built-in global variables that provide metadata about the SQL Server session.

---

## 1. Declaring and Assigning Values to Variables
### 1.1 Declaring a Scalar Variable
A scalar variable holds a single value. It must be declared before use, using the `DECLARE` statement, followed by its name (prefixed with `@`) and a data type.

```sql
DECLARE @Counter INT;
DECLARE @EmployeeName VARCHAR(100);
```

### 1.2 Assigning Values to Variables
There are two primary ways to assign values to a variable:
- **Using `SET`** (Recommended for single assignments)
- **Using `SELECT`** (Allows multiple assignments at once)

#### Using `SET`
```sql
SET @Counter = 10;
SET @EmployeeName = 'John Doe';
```

#### Using `SELECT`
```sql
SELECT @Counter = COUNT(*) FROM Employees;
SELECT @EmployeeName = Name FROM Employees WHERE EmployeeID = 1;
```

**Difference between `SET` and `SELECT`:**
| Feature            | `SET` | `SELECT` |
|--------------------|-------|----------|
| Single Assignment | Yes   | Yes      |
| Multiple Assignments | No  | Yes      |
| Behavior on No Rows | Assigns `NULL` | Assigns `NULL` if no rows, but last row value if multiple rows |

---

## 2. Table Variables (`@TableName`)
A **table variable** acts like a temporary table but is stored in memory rather than `tempdb`. It is useful for holding small sets of data within a query batch.

### 2.1 Declaring a Table Variable
```sql
DECLARE @EmployeeTable TABLE (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(100),
    Department VARCHAR(50)
);
```

### 2.2 Inserting and Retrieving Data
```sql
INSERT INTO @EmployeeTable (EmployeeID, Name, Department)
VALUES (1, 'Alice', 'HR'), (2, 'Bob', 'IT');

SELECT * FROM @EmployeeTable;
```

**Key Differences Between Table Variables and Temporary Tables:**
| Feature            | Table Variable (`@Table`) | Temporary Table (`#TempTable`) |
|--------------------|-------------------------|-------------------------------|
| Stored In         | Memory (`tempdb` for large data) | `tempdb` (disk-based) |
| Scope             | Limited to batch or session | Exists until explicitly dropped |
| Indexes           | Only Primary Keys | Supports full indexing |
| Transaction Support | No | Yes |

---

## 3. System Variables (`@@` Global Variables)
SQL Server provides built-in system variables, known as global variables, which store session and system-level metadata.

### 3.1 Common System Variables
| Variable | Description |
|----------|-------------|
| `@@IDENTITY` | Returns the last identity value inserted into a table |
| `@@ROWCOUNT` | Number of rows affected by the last statement |
| `@@ERROR` | Returns the error number of the last executed statement |
| `@@TRANCOUNT` | Returns the number of active transactions |
| `@@VERSION` | Provides SQL Server version details |

### 3.2 Using System Variables
#### Example: Getting the Last Inserted Identity Value
```sql
INSERT INTO Employees (Name, Department) VALUES ('Eve', 'Finance');
SELECT @@IDENTITY AS LastInsertedID;
```

#### Example: Checking Rows Affected by a Query
```sql
UPDATE Employees SET Department = 'HR' WHERE EmployeeID = 1;
SELECT @@ROWCOUNT AS RowsUpdated;
```

#### Example: Checking Active Transactions
```sql
SELECT @@TRANCOUNT AS ActiveTransactions;
```

