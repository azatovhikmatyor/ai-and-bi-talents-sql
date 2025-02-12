#### **1. NOT NULL Constraint**  
- Create a table named `student` with columns:  
  - `id` (integer, should **not allow NULL values**)  
  - `name` (string, can allow NULL values)  
  - `age` (integer, can allow NULL values)  
- First, create the table without the NOT NULL constraint.  
- Then, use `ALTER TABLE` to apply the NOT NULL constraint to the `id` column.  

---

#### **2. UNIQUE Constraint**  
- Create a table named `product` with the following columns:  
  - `product_id` (integer, should be **unique**)  
  - `product_name` (string, no constraint)  
  - `price` (decimal, no constraint)  
- First, define `product_id` as UNIQUE inside the `CREATE TABLE` statement.  
- Then, drop the unique constraint and add it again using `ALTER TABLE`.  
- Extend the constraint so that the combination of `product_id` and `product_name` must be unique.  

---

#### **3. PRIMARY KEY Constraint**  
- Create a table named `orders` with:  
  - `order_id` (integer, should be the **primary key**)  
  - `customer_name` (string, no constraint)  
  - `order_date` (date, no constraint)  
- First, define the primary key inside the `CREATE TABLE` statement.  
- Then, drop the primary key and add it again using `ALTER TABLE`.  

---

#### **4. FOREIGN KEY Constraint**  
- Create two tables:  
  - `category`:  
    - `category_id` (integer, primary key)  
    - `category_name` (string)  
  - `item`:  
    - `item_id` (integer, primary key)  
    - `item_name` (string)  
    - `category_id` (integer, should be a **foreign key referencing category_id in category table**)  
- First, define the foreign key inside `CREATE TABLE`.  
- Then, drop and add the foreign key using `ALTER TABLE`.  

---

#### **5. CHECK Constraint**  
- Create a table named `account` with:  
  - `account_id` (integer, primary key)  
  - `balance` (decimal, should always be greater than or equal to 0)  
  - `account_type` (string, should only accept values `'Saving'` or `'Checking'`)  
- Use `CHECK` constraints to enforce these rules.  
- First, define the constraints inside `CREATE TABLE`.  
- Then, drop and re-add the `CHECK` constraints using `ALTER TABLE`.  

---

#### **6. DEFAULT Constraint**  
- Create a table named `customer` with:  
  - `customer_id` (integer, primary key)  
  - `name` (string, no constraint)  
  - `city` (string, should have a default value of `'Unknown'`)  
- First, define the default value inside `CREATE TABLE`.  
- Then, drop and re-add the default constraint using `ALTER TABLE`.  

---

#### **7. IDENTITY Column**  
- Create a table named `invoice` with:  
  - `invoice_id` (integer, should **auto-increment starting from 1**)  
  - `amount` (decimal, no constraint)  
- Insert 5 rows into the table without specifying `invoice_id`.  
- Enable and disable `IDENTITY_INSERT`, then manually insert a row with `invoice_id = 100`.  

---

### **8. All at once**  
- Create a `books` table with:  
  - `book_id` (integer, primary key, auto-increment)  
  - `title` (string, **must not be empty**)  
  - `price` (decimal, **must be greater than 0**)  
  - `genre` (string, default should be `'Unknown'`)  
- Insert data and test if all constraints work as expected.  

---

### **9. Scenario: Library Management System**  
You need to design a simple database for a library where books are borrowed by members.  

### **Tables and Columns:**  

1. **Book** (Stores information about books)  
   - `book_id` (Primary Key)  
   - `title` (Text)  
   - `author` (Text)  
   - `published_year` (Integer)  

2. **Member** (Stores information about library members)  
   - `member_id` (Primary Key)  
   - `name` (Text)  
   - `email` (Text)  
   - `phone_number` (Text)  

3. **Loan** (Tracks which members borrow which books)  
   - `loan_id` (Primary Key)  
   - `book_id` (Foreign Key → References `book.book_id`)  
   - `member_id` (Foreign Key → References `member.member_id`)  
   - `loan_date` (Date)  
   - `return_date` (Date, can be NULL if not returned yet)  

### **Tasks:**  
1. **Understand Relationships**  
   - A **member** can borrow multiple **books**.  
   - A **book** can be borrowed by different members at different times.  
   - The **Loan** table connects `Book` and `Member` (Many-to-Many).  

2. **Write SQL Statements**  
   - Create the tables with proper constraints (Primary Key, Foreign Key).  
   - Insert at least 2-3 sample records into each table.  
