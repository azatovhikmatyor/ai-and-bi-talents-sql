# **Dynamic SQL in SQL Server: A Complete Guide**  

Dynamic SQL in SQL Server allows you to build and execute SQL queries **dynamically at runtime**. This is useful when query structure depends on user input, table names, or conditions that are not known in advance.

---

## **1. What is Dynamic SQL?**
Dynamic SQL is **SQL code generated and executed at runtime** using the `EXEC` or `sp_executesql` command.

### **Example Use Cases**
- Searching with **optional filters**.
- Querying **dynamic table names**.
- Creating **stored procedures that accept column names or sorting orders** dynamically.

---

## **2. Ways to Execute Dynamic SQL**
There are **two main ways** to execute dynamic SQL in SQL Server:

| Method | How it Works | When to Use |
|--------|-------------|-------------|
| `EXEC` (Immediate Execution) | Runs the SQL statement as a string | Simple queries with no parameters |
| `sp_executesql` (Parameterized Execution) | Runs SQL with parameters, preventing SQL injection | Recommended for security & performance |

---

## **3. Using `EXEC` for Dynamic SQL**
### **Basic Example**
```sql
DECLARE @sql NVARCHAR(MAX);
SET @sql = 'SELECT * FROM Employees';
EXEC(@sql);
```

### **Dynamic Table Name**
```sql
DECLARE @table NVARCHAR(100) = 'Employees';
DECLARE @sql NVARCHAR(MAX);

SET @sql = 'SELECT * FROM ' + @table;
EXEC(@sql);
```

> **Warning:** This method is **vulnerable to SQL injection**. Always sanitize inputs when using it.

---

## **4. Using `sp_executesql` for Secure Dynamic SQL**
The `sp_executesql` procedure allows you to **use parameters**, which makes queries safer and improves performance.

### **Syntax**
```sql
EXEC sp_executesql 
    @sql_query, 
    @parameter_definitions, 
    @param1 = value1, 
    @param2 = value2;
```

### **Example with Parameters**
```sql
DECLARE @sql NVARCHAR(MAX);
DECLARE @empID INT = 1;

SET @sql = N'SELECT * FROM Employees WHERE EmployeeID = @ID';
EXEC sp_executesql @sql, N'@ID INT', @ID = @empID;
```

**Advantages of `sp_executesql`**
- **Prevents SQL injection** by treating parameters as **values**, not part of the SQL string.
- **Improves query performance** via **plan reuse** in SQL Server.

---

## **5. Using Dynamic SQL in a Stored Procedure**
### **Example: Dynamic WHERE Clause**
```sql
CREATE PROCEDURE GetEmployeesByFilter
    @Department NVARCHAR(50) = NULL,
    @MinSalary DECIMAL(10,2) = NULL
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = 'SELECT * FROM Employees WHERE 1=1';

    IF @Department IS NOT NULL
        SET @sql = @sql + ' AND Department = @Department';
    
    IF @MinSalary IS NOT NULL
        SET @sql = @sql + ' AND Salary >= @MinSalary';

    EXEC sp_executesql @sql, N'@Department NVARCHAR(50), @MinSalary DECIMAL(10,2)', @Department, @MinSalary;
END;
```

### **Calling the Procedure**
```sql
EXEC GetEmployeesByFilter @Department = 'HR', @MinSalary = 50000;
```

**Key Points:**
- `1=1` in the `WHERE` clause simplifies dynamic conditions.
- Parameters are passed **safely** to avoid SQL injection.

---

## **6. Dynamic ORDER BY Clause**
Sorting dynamically using dynamic SQL.

### **Example**
```sql
CREATE PROCEDURE GetEmployeesSorted
    @SortColumn NVARCHAR(50),
    @SortOrder NVARCHAR(4)
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = 'SELECT * FROM Employees ORDER BY ' + QUOTENAME(@SortColumn) + ' ' + @SortOrder;

    EXEC(@sql);
END;
```

### **Calling the Procedure**
```sql
EXEC GetEmployeesSorted @SortColumn = 'Salary', @SortOrder = 'DESC';
```

**QUOTENAME()** prevents SQL injection when using column names dynamically.

---

## **7. Dynamic SQL with Table Names**
### **Example: Selecting Data from a Dynamic Table**
```sql
CREATE PROCEDURE GetDataFromTable
    @TableName NVARCHAR(100)
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = 'SELECT * FROM ' + QUOTENAME(@TableName);
    EXEC(@sql);
END;
```

### **Calling the Procedure**
```sql
EXEC GetDataFromTable @TableName = 'Employees';
```

**QUOTENAME()** prevents SQL injection when using dynamic table names.

---

## **8. Performance Considerations**
### **Bad Practices**
- Concatenating **parameters directly** into a string (`@sql = 'SELECT * FROM Employees WHERE Name = ''' + @Name + ''''`).
- Using `EXEC(@sql)` **without parameterization**.

### **Best Practices**
✔ **Use `sp_executesql`** for better security & performance.  
✔ **Use `QUOTENAME()`** for dynamic object names (tables, columns).  
✔ **Cache query plans** by parameterizing queries.  
✔ **Avoid excessive dynamic SQL** unless necessary.

---

## **9. Summary Table**
| Task | Solution |
|------|----------|
| Execute a simple dynamic query | `EXEC(@sql)` |
| Execute dynamic SQL with parameters | `sp_executesql` |
| Use dynamic WHERE conditions | Check if `@param IS NOT NULL` before adding conditions |
| Use dynamic ORDER BY | `QUOTENAME(@SortColumn) + ' ' + @SortOrder` |
| Use dynamic table names | `QUOTENAME(@TableName)` |

---

## **10. Conclusion**
Dynamic SQL is **powerful** for handling flexible queries but **must be used safely**.  
- **Use `sp_executesql`** for **parameters**.
- **Use `QUOTENAME()`** for **table/column names**.
- **Avoid excessive dynamic SQL** when a normal query can work.
