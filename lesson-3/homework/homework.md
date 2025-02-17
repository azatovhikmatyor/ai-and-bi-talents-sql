## DDL
```sql
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2),
    HireDate DATE
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    Status VARCHAR(20) CHECK (Status IN ('Pending', 'Shipped', 'Delivered', 'Cancelled'))
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    Stock INT
);
```

---

### **Task 1: Employee Salary Report**
Write an SQL query that:
- Selects the **top 10% highest-paid** employees.
- Groups them by **department** and calculates the **average salary per department**.
- Displays a new column `SalaryCategory`:
  - 'High' if Salary > 80,000  
  - 'Medium' if Salary is **between** 50,000 and 80,000  
  - 'Low' otherwise.  
- Orders the result by `AverageSalary` **descending**.
- Skips the first 2 records and fetches the next 5.

---

### **Task 2: Customer Order Insights**
Write an SQL query that:
- Selects customers who placed orders **between** '2023-01-01' and '2023-12-31'.  
- Includes a new column `OrderStatus` that returns:
  - 'Completed' for **Shipped** or **Delivered** orders.  
  - 'Pending' for **Pending** orders.  
  - 'Cancelled' for **Cancelled** orders.  
- Groups by `OrderStatus` and finds the **total number of orders** and **total revenue**.  
- Filters only statuses where revenue is greater than 5000.  
- Orders by `TotalRevenue` **descending**.

---

### **Task 3: Product Inventory Check**
Write an SQL query that:
- Selects **distinct** product categories.
- Finds the **most expensive** product in each category.
- Assigns an inventory status using `IIF`:
  - 'Out of Stock' if `Stock = 0`.  
  - 'Low Stock' if `Stock` is **between** 1 and 10.  
  - 'In Stock' otherwise.  
- Orders the result by `Price` **descending** and skips the first 5 rows.

