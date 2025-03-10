## **What is a Stored Procedure?**
A **stored procedure** is a collection of SQL statements stored in the database that can be executed as a single unit. Stored procedures can accept parameters, perform complex calculations, and return results.

### **Benefits of Using Stored Procedures**
- **Performance Improvement:** Stored procedures are precompiled, reducing query execution time.
- **Code Reusability:** Write once, use multiple times.
- **Security:** Restricts direct table access, providing controlled data access.
- **Maintainability:** Simplifies complex queries into manageable units.

---

## **Creating a Basic Stored Procedure**
The basic syntax for creating a stored procedure:

```sql
CREATE PROCEDURE ProcedureName
AS
BEGIN
    -- SQL Statements
END
```

### **Example: Simple Stored Procedure**
```sql
CREATE PROCEDURE GetAllEmployees
AS
BEGIN
    SELECT * FROM Employees;
END;
```

### **Executing the Stored Procedure**
To execute a stored procedure:
```sql
EXEC GetAllEmployees;
```
or
```sql
EXECUTE GetAllEmployees;
```

---

## **Stored Procedure with Parameters**
Stored procedures can accept **input** and **output** parameters.

### **Example: Stored Procedure with Input Parameter**
```sql
CREATE PROCEDURE GetEmployeeByID
    @EmployeeID INT
AS
BEGIN
    SELECT * FROM Employees WHERE EmployeeID = @EmployeeID;
END;
```

### **Executing with Parameters**
```sql
EXEC GetEmployeeByID @EmployeeID = 1;
```

---

## **Stored Procedure with Multiple Parameters**
```sql
CREATE PROCEDURE GetEmployeesByDepartment
    @DepartmentID INT,
    @MinSalary DECIMAL(10,2)
AS
BEGIN
    SELECT * FROM Employees
    WHERE DepartmentID = @DepartmentID AND Salary >= @MinSalary;
END;
```

### **Executing with Multiple Parameters**
```sql
EXEC GetEmployeesByDepartment @DepartmentID = 2, @MinSalary = 50000;
```

---

## **Stored Procedure with Output Parameters**
Output parameters allow a stored procedure to return a value.

### **Example: Returning an Employee's Salary**
```sql
CREATE PROCEDURE GetEmployeeSalary
    @EmployeeID INT,
    @Salary DECIMAL(10,2) OUTPUT
AS
BEGIN
    SELECT @Salary = Salary FROM Employees WHERE EmployeeID = @EmployeeID;
END;
```

### **Executing with Output Parameters**
```sql
DECLARE @EmpSalary DECIMAL(10,2);
EXEC GetEmployeeSalary @EmployeeID = 1, @Salary = @EmpSalary OUTPUT;
PRINT @EmpSalary;
```

---

## **Handling Transactions in Stored Procedures**
Transactions ensure **atomicity** (all or nothing execution).

### **Example: Using Transactions**
```sql
CREATE PROCEDURE TransferSalary
    @FromEmployeeID INT,
    @ToEmployeeID INT,
    @Amount DECIMAL(10,2)
AS
BEGIN
    BEGIN TRANSACTION;

    UPDATE Employees SET Salary = Salary - @Amount WHERE EmployeeID = @FromEmployeeID;
    UPDATE Employees SET Salary = Salary + @Amount WHERE EmployeeID = @ToEmployeeID;

    IF @@ERROR <> 0
    BEGIN
        ROLLBACK TRANSACTION;
        PRINT 'Transaction Failed';
    END
    ELSE
    BEGIN
        COMMIT TRANSACTION;
        PRINT 'Transaction Successful';
    END
END;
```

### **Executing the Transaction**
```sql
EXEC TransferSalary @FromEmployeeID = 1, @ToEmployeeID = 2, @Amount = 1000;
```

---

## **Error Handling in Stored Procedures**
Use `TRY...CATCH` for error handling.

### **Example: Handling Errors**
```sql
CREATE PROCEDURE SafeTransferSalary
    @FromEmployeeID INT,
    @ToEmployeeID INT,
    @Amount DECIMAL(10,2)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        
        UPDATE Employees SET Salary = Salary - @Amount WHERE EmployeeID = @FromEmployeeID;
        UPDATE Employees SET Salary = Salary + @Amount WHERE EmployeeID = @ToEmployeeID;
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT 'Error Occurred: ' + ERROR_MESSAGE();
    END CATCH
END;
```

---

## **Modifying and Deleting Stored Procedures**
### **Modifying a Stored Procedure**
```sql
ALTER PROCEDURE GetAllEmployees
AS
BEGIN
    SELECT EmployeeID, FirstName, LastName FROM Employees;
END;
```

### **Deleting a Stored Procedure**
```sql
DROP PROCEDURE GetAllEmployees;
```

---

## **Stored Procedures with Table-Valued Parameters**
You can pass a table as a parameter.

### **Example: Using Table-Valued Parameters**
```sql
CREATE TYPE EmployeeTableType AS TABLE
(
    EmployeeID INT,
    Salary DECIMAL(10,2)
);
```

```sql
CREATE PROCEDURE UpdateEmployeeSalaries
    @EmployeeSalaries EmployeeTableType READONLY
AS
BEGIN
    UPDATE e
    SET e.Salary = es.Salary
    FROM Employees e
    INNER JOIN @EmployeeSalaries es ON e.EmployeeID = es.EmployeeID;
END;
```

### **Executing with a Table Parameter**
```sql
DECLARE @Salaries EmployeeTableType;
INSERT INTO @Salaries VALUES (1, 60000), (2, 75000);

EXEC UpdateEmployeeSalaries @Salaries;
```

---

## **Returning Result Sets**
Stored procedures can return result sets, acting like table functions.

### **Example: Returning a Result Set**
```sql
CREATE PROCEDURE GetHighPaidEmployees
    @MinSalary DECIMAL(10,2)
AS
BEGIN
    SELECT EmployeeID, FirstName, LastName, Salary
    FROM Employees
    WHERE Salary > @MinSalary;
END;
```

### **Using in a Query**
```sql
EXEC GetHighPaidEmployees @MinSalary = 70000;
```


## **Best Practices for Stored Procedures**
- Use **meaningful names** (`usp_GetEmployeeByID`).
- Always **use schema name** (`dbo.GetAllEmployees`).
- **Use SET NOCOUNT ON** to avoid extra messages.
- **Avoid dynamic SQL** unless necessary (security risk).
- **Validate inputs** to prevent SQL injection.
- **Use proper indexing** for optimized performance.
- **Use TRY...CATCH** for error handling.
