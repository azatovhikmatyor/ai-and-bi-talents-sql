# **SQL Server Custom Scalar Functions**  

In SQL Server, a **scalar function** is a user-defined function (UDF) that **returns a single value** based on input parameters. These functions can be used to encapsulate logic, make queries more readable, and avoid code repetition.



# **1. Syntax for Defining a Scalar Function**
```sql
CREATE FUNCTION function_name (@param1 DataType, @param2 DataType, ...)
RETURNS ReturnDataType
AS
BEGIN
    -- Function logic
    RETURN value;
END;
```
- **`function_name`** → Name of the function (must be prefixed with `dbo.` when calling).
- **`@param1, @param2, ...`** → Input parameters.
- **`RETURNS ReturnDataType`** → Specifies the return type (e.g., `INT`, `VARCHAR`, `DECIMAL`).
- **`RETURN value;`** → Defines what the function returns.

---

# **2. Creating a Simple Scalar Function**
## **Example: Convert Fahrenheit to Celsius**
```sql
CREATE FUNCTION dbo.FahrenheitToCelsius(@Fahrenheit FLOAT)
RETURNS FLOAT
AS
BEGIN
    RETURN (@Fahrenheit - 32) * 5.0 / 9.0;
END;
```
**Calling the Function**
```sql
SELECT dbo.FahrenheitToCelsius(98.6) AS CelsiusTemp;
```
**Output:**

CelsiusTemp| 
-----------|
37.0       |


---

# **3. Using Scalar Functions in Queries**
Scalar functions can be used in **SELECT, WHERE, and ORDER BY**.

## **Example: Using Function in SELECT**
```sql
SELECT Name, Salary, dbo.FahrenheitToCelsius(98.6) AS TempInCelsius
FROM Employees;
```
Applies the function **to each row**.

---

# **4. Scalar Function with Multiple Parameters**
## **Example: Full Name Generator**
```sql
CREATE FUNCTION dbo.GetFullName(@FirstName NVARCHAR(50), @LastName NVARCHAR(50))
RETURNS NVARCHAR(100)
AS
BEGIN
    RETURN @FirstName + ' ' + @LastName;
END;
```
**Calling the Function**
```sql
SELECT dbo.GetFullName('John', 'Doe') AS FullName;
```
**Output:**

FullName    |
------------|
John Doe    |


---

# **5. Scalar Function with IF-ELSE Logic**
## **Example: Categorizing Employee Salaries**
```sql
CREATE FUNCTION dbo.SalaryCategory(@Salary DECIMAL(10,2))
RETURNS NVARCHAR(20)
AS
BEGIN
    DECLARE @Category NVARCHAR(20);

    IF @Salary < 30000
        SET @Category = 'Low';
    ELSE IF @Salary BETWEEN 30000 AND 70000
        SET @Category = 'Medium';
    ELSE
        SET @Category = 'High';

    RETURN @Category;
END;
```
**Calling the Function**
```sql
SELECT Name, Salary, dbo.SalaryCategory(Salary) AS SalaryLevel
FROM Employees;
```
**Categorizes employees' salaries** as **Low, Medium, or High**.

---

# **6. Scalar Function with Mathematical Calculations**
## **Example: Calculating Age from Birthdate**
```sql
CREATE FUNCTION dbo.CalculateAge(@Birthdate DATE)
RETURNS INT
AS
BEGIN
    RETURN DATEDIFF(YEAR, @Birthdate, GETDATE());
END;
```
**Calling the Function**
```sql
SELECT Name, Birthdate, dbo.CalculateAge(Birthdate) AS Age
FROM Employees;
```
**Calculates employee age dynamically**.

---

# **7. Handling NULL Values in Scalar Functions**
## **Example: Safe Division Function**
```sql
CREATE FUNCTION dbo.SafeDivide(@Numerator FLOAT, @Denominator FLOAT)
RETURNS FLOAT
AS
BEGIN
    RETURN CASE 
        WHEN @Denominator = 0 THEN NULL
        ELSE @Numerator / @Denominator
    END;
END;
```
**Calling the Function**
```sql
SELECT dbo.SafeDivide(10, 2) AS Result;  -- Returns 5.0
SELECT dbo.SafeDivide(10, 0) AS Result;  -- Returns NULL
```
**Prevents division by zero errors**.

---

# **8. Using Scalar Functions in Computed Columns**
Scalar functions can be used **inside table definitions** to create computed columns.

## **Example: Creating a Computed Column**
```sql
ALTER TABLE Employees
ADD FullName AS dbo.GetFullName(FirstName, LastName);
```
Adds a **FullName** column that dynamically updates.

