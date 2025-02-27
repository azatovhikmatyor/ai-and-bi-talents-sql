```sql
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10,2)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50)
);
```


#### **1️ Retrieve All Customers With Their Orders (Include Customers Without Orders)**
- Use an appropriate `JOIN` to list all customers, their order IDs, and order dates.
- Ensure that customers with no orders still appear.

#### **2️ Find Customers Who Have Never Placed an Order**
- Return customers who have no orders.

#### **3️ List All Orders With Their Products**
- Show each order with its product names and quantity.

#### **4️ Find Customers With More Than One Order**
- List customers who have placed more than one order.

#### **5️ Find the Most Expensive Product in Each Order**

#### **6️ Find the Latest Order for Each Customer**

#### **7️ Find Customers Who Ordered Only 'Electronics' Products**
- List customers who **only** purchased items from the 'Electronics' category.

#### **8️ Find Customers Who Ordered at Least One 'Stationery' Product**
- List customers who have purchased at least one product from the 'Stationery' category.

#### **9️ Find Total Amount Spent by Each Customer**
- Show `CustomerID`, `CustomerName`, and `TotalSpent`.

