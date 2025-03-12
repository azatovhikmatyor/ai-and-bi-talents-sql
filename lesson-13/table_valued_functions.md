# **Table-Valued Functions in SQL Server**  

A **Table-Valued Function (TVF)** is a user-defined function in SQL Server that **returns a table** instead of a single value. TVFs are useful for **reusable queries**, improving **code modularity**, and **simplifying complex joins**.


# **1. Types of Table-Valued Functions**
SQL Server supports **two types** of Table-Valued Functions:

| Type | Description |
|------|------------|
| **Inline Table-Valued Function (ITVF)** | Returns a table **with a single `RETURN` statement** (like a view). |
| **Multi-Statement Table-Valued Function (MSTVF)** | Uses **multiple statements** inside a function and returns a table variable. |

---

# **2. Syntax for Table-Valued Functions**
## **2.1. Inline Table-Valued Function (ITVF)**
```sql
CREATE FUNCTION function_name (@param1 DataType, @param2 DataType, ...)
RETURNS TABLE
AS
RETURN (
    SELECT columns FROM table WHERE conditions
);
```

## **2.2. Multi-Statement Table-Valued Function (MSTVF)**
```sql
CREATE FUNCTION function_name (@param1 DataType, @param2 DataType, ...)
RETURNS @TableVariable TABLE (column1 DataType, column2 DataType, ...)
AS
BEGIN
    -- Insert data into the table variable
    INSERT INTO @TableVariable
    SELECT columns FROM table WHERE conditions;

    RETURN;
END;
```

---

# **3. Creating and Using Inline Table-Valued Functions (ITVF)**
## **Example: Get Employees by Department**
```sql
CREATE FUNCTION dbo.GetEmployeesByDept(@DeptID INT)
RETURNS TABLE
AS
RETURN (
    SELECT EmployeeID, Name, Salary
    FROM Employees
    WHERE DepartmentID = @DeptID
);
```
**Calling the Function**
```sql
SELECT * FROM dbo.GetEmployeesByDept(2);
```
Returns **all employees in Department 2**.

---

# **4. Creating and Using Multi-Statement Table-Valued Functions (MSTVF)**
## **Example: Get High-Salary Employees**
```sql
CREATE FUNCTION dbo.GetHighSalaryEmployees(@MinSalary DECIMAL(10,2))
RETURNS @EmployeeTable TABLE (EmployeeID INT, Name NVARCHAR(100), Salary DECIMAL(10,2))
AS
BEGIN
    INSERT INTO @EmployeeTable
    SELECT EmployeeID, Name, Salary FROM Employees WHERE Salary >= @MinSalary;

    RETURN;
END;
```
**Calling the Function**
```sql
SELECT * FROM dbo.GetHighSalaryEmployees(50000);
```
Returns **all employees with salary $\ge$ 50,000**.

---

# **5. Using Table-Valued Functions in Queries**
TVFs **can be used like tables** in `SELECT`, `JOIN`, `WHERE`, etc.

## **Example: Using a Function in a JOIN**
```sql
SELECT e.EmployeeID, e.Name, d.DepartmentName
FROM dbo.GetEmployeesByDept(2) e
JOIN Departments d ON e.DepartmentID = d.DepartmentID;
```
**Joins employees from Department 2** with department details.

---

# **6. Using Parameters in Table-Valued Functions**
## **Example: Get Employees Hired After a Certain Date**
```sql
CREATE FUNCTION dbo.GetEmployeesAfterDate(@HireDate DATE)
RETURNS TABLE
AS
RETURN (
    SELECT EmployeeID, Name, HireDate FROM Employees WHERE HireDate > @HireDate
);
```
**Calling the Function**
```sql
SELECT * FROM dbo.GetEmployeesAfterDate('2022-01-01');
```
Returns **all employees hired after Jan 1, 2022**.

