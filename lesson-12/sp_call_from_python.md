# **Calling SQL Server Stored Procedures from Python: A Complete Guide**  

Integrating Python with SQL Server is common for data processing, analytics, and automation. This guide covers how to call **SQL Server stored procedures** from Python using **pyodbc** and **SQLAlchemy**.

---

## **1. Installing Required Packages**  
To connect to SQL Server from Python, install `pyodbc` or `SQLAlchemy` with `pymssql`:

```sh
pip install pyodbc
pip install sqlalchemy pymssql
```

---

## **2. Connecting to SQL Server from Python**  
### **Using `pyodbc`**
```python
import pyodbc

conn = pyodbc.connect(
    "DRIVER={SQL Server};"
    "SERVER=YourServerName;"
    "DATABASE=YourDatabaseName;"
    "Trusted_Connection=yes;"
)

cursor = conn.cursor()
```

> **Replace** `YourServerName` and `YourDatabaseName` with actual values.

### **Using `SQLAlchemy`**
```python
from sqlalchemy import create_engine

engine = create_engine("mssql+pyodbc://YourServerName/YourDatabaseName?trusted_connection=yes&driver=SQL+Server")
conn = engine.connect()
```

---

## **3. Executing Stored Procedures**
### **3.1 Calling a Stored Procedure Without Parameters**  
#### **SQL Server Stored Procedure**
```sql
CREATE PROCEDURE GetAllEmployees
AS
BEGIN
    SELECT * FROM Employees;
END;
```

#### **Python Code to Execute the Procedure**
```python
cursor.execute("EXEC GetAllEmployees")
rows = cursor.fetchall()

for row in rows:
    print(row)
```

---

### **3.2 Calling a Stored Procedure with Input Parameters**
#### **SQL Server Stored Procedure**
```sql
CREATE PROCEDURE GetEmployeeByID
    @EmployeeID INT
AS
BEGIN
    SELECT * FROM Employees WHERE EmployeeID = @EmployeeID;
END;
```

#### **Python Code**
```python
cursor.execute("EXEC GetEmployeeByID ?", (1,))
rows = cursor.fetchall()

for row in rows:
    print(row)
```

> **Note:** Use `?` as a placeholder for parameters in `pyodbc`.

---

### **3.3 Calling a Stored Procedure with Multiple Parameters**
#### **SQL Server Stored Procedure**
```sql
CREATE PROCEDURE GetEmployeesByDepartment
    @DepartmentID INT,
    @MinSalary DECIMAL(10,2)
AS
BEGIN
    SELECT * FROM Employees WHERE DepartmentID = @DepartmentID AND Salary >= @MinSalary;
END;
```

#### **Python Code**
```python
cursor.execute("EXEC GetEmployeesByDepartment ?, ?", (2, 50000))
rows = cursor.fetchall()

for row in rows:
    print(row)
```

---

### **3.4 Calling a Stored Procedure with an Output Parameter**
#### **SQL Server Stored Procedure**
```sql
CREATE PROCEDURE GetEmployeeSalary
    @EmployeeID INT,
    @Salary DECIMAL(10,2) OUTPUT
AS
BEGIN
    SELECT @Salary = Salary FROM Employees WHERE EmployeeID = @EmployeeID;
END;
```

#### **Python Code**
```python
cursor.execute("DECLARE @Salary DECIMAL(10,2); EXEC GetEmployeeSalary ?, @Salary OUTPUT; SELECT @Salary;", (1,))
salary = cursor.fetchone()[0]
print("Employee Salary:", salary)
```

> **Alternative Approach:** Use `callproc()`, but `pyodbc` does not natively support output parameters.

---

### **3.5 Calling a Stored Procedure with Transactions**
#### **SQL Server Stored Procedure**
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
    COMMIT TRANSACTION;
END;
```

#### **Python Code with Transaction Handling**
```python
try:
    cursor.execute("EXEC TransferSalary ?, ?, ?", (1, 2, 1000))
    conn.commit()
    print("Transaction successful")
except Exception as e:
    conn.rollback()
    print("Transaction failed:", str(e))
```

---

## **4. Using SQLAlchemy to Call Stored Procedures**
### **4.1 Calling a Stored Procedure Without Parameters**
```python
from sqlalchemy import text

with engine.connect() as conn:
    result = conn.execute(text("EXEC GetAllEmployees"))
    for row in result:
        print(row)
```

---

### **4.2 Calling a Stored Procedure with Parameters**
```python
with engine.connect() as conn:
    result = conn.execute(text("EXEC GetEmployeeByID :emp_id"), {"emp_id": 1})
    for row in result:
        print(row)
```

---

## **5. Handling Errors**
Use `try-except` blocks to handle errors gracefully.

```python
try:
    cursor.execute("EXEC GetEmployeeByID ?", (9999,))
    rows = cursor.fetchall()
    for row in rows:
        print(row)
except Exception as e:
    print("Error:", str(e))
```

---

## **6. Closing the Connection**
Always close the connection when done.

```python
cursor.close()
conn.close()
```

---

## **7. Best Practices**
- **Use Parameterized Queries:** Prevents SQL injection.
- **Manage Connections Properly:** Use `with` statements or ensure connections are closed.
- **Handle Errors:** Always use `try-except` blocks.
- **Use Transactions:** Ensure atomic operations where needed.
- **Optimize Stored Procedures:** Use indexes and avoid unnecessary operations.
