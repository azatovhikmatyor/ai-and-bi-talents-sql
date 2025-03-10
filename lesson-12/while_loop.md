# **SQL Server WHILE Loop – A Complete Guide**  

In SQL Server, the `WHILE` loop allows you to execute a block of code **repeatedly** while a condition remains true. This is useful when performing repetitive tasks such as inserting multiple rows, iterating over a dataset, or processing data step by step.

---

## **1. WHILE Loop Syntax**
```sql
WHILE condition  
BEGIN  
    -- Code to execute  
END;
```
- The loop runs **as long as** `condition` is **true**.
- If the condition is **false** at the start, the loop **never executes**.
- Use **BREAK** to exit the loop early.
- Use **CONTINUE** to skip the rest of the current iteration.

---

## **2. Basic Example**
### **Printing Numbers from 1 to 5**
```sql
DECLARE @counter INT = 1;

WHILE @counter <= 5  
BEGIN  
    PRINT 'Counter: ' + CAST(@counter AS NVARCHAR);
    SET @counter = @counter + 1;  -- Increment counter
END;
```

**Output:**
```
Counter: 1
Counter: 2
Counter: 3
Counter: 4
Counter: 5
```
✔ The loop stops when `@counter > 5`.

---

## **3. Using BREAK to Exit a Loop**
The `BREAK` statement **stops** the loop immediately.

### **Example: Stop at 3**
```sql
DECLARE @counter INT = 1;

WHILE @counter <= 5  
BEGIN  
    PRINT 'Counter: ' + CAST(@counter AS NVARCHAR);
    
    IF @counter = 3  
        BREAK;  -- Exit loop when counter reaches 3

    SET @counter = @counter + 1;
END;
```

**Output:**
```
Counter: 1
Counter: 2
Counter: 3
```
✔ The loop **exits early** when `@counter = 3`.

---

## **4. Using CONTINUE to Skip an Iteration**
The `CONTINUE` statement **skips** the rest of the loop’s code **for the current iteration**.

### **Example: Skip 3**
```sql
DECLARE @counter INT = 0;

WHILE @counter < 5  
BEGIN  
    SET @counter = @counter + 1;

    IF @counter = 3  
        CONTINUE;  -- Skip printing when counter is 3

    PRINT 'Counter: ' + CAST(@counter AS NVARCHAR);
END;
```

**Output:**
```
Counter: 1
Counter: 2
Counter: 4
Counter: 5
```
✔ The loop **skips** `PRINT` when `@counter = 3`, but still increments it.

---

## **5. Using WHILE Loop to Insert Data**
You can use `WHILE` to insert multiple rows dynamically.

### **Example: Insert 5 Employees**
```sql
DECLARE @counter INT = 1;

WHILE @counter <= 5  
BEGIN  
    INSERT INTO Employees (Name, Salary)
    VALUES ('Employee ' + CAST(@counter AS NVARCHAR), 5000 * @counter);

    SET @counter = @counter + 1;
END;
```
✔ This inserts **5 rows** into the `Employees` table.

---

## **6. Using WHILE Loop to Process Data**
### **Example: Update Salaries Incrementally**
```sql
DECLARE @salary INT = 10000;

WHILE @salary <= 20000  
BEGIN  
    UPDATE Employees  
    SET Salary = Salary + 1000  
    WHERE Salary = @salary;

    SET @salary = @salary + 1000;
END;
```
✔ The loop increases salaries from **10,000 to 20,000** in **1,000 increments**.

---

## **7. Using WHILE Loop for Fibonacci Sequence**
```sql
DECLARE @n1 INT = 0, @n2 INT = 1, @next INT, @counter INT = 1;

WHILE @counter <= 10  
BEGIN  
    PRINT CAST(@n1 AS NVARCHAR);

    SET @next = @n1 + @n2;
    SET @n1 = @n2;
    SET @n2 = @next;
    SET @counter = @counter + 1;
END;
```

**Output:**
```
0
1
1
2
3
5
8
13
21
34
```
✔ This generates the **first 10 Fibonacci numbers**.

---

## **8. Nested WHILE Loops**
You can nest `WHILE` loops inside each other.

### **Example: Print Multiplication Table (1 to 3)**
```sql
DECLARE @outer INT = 1, @inner INT;

WHILE @outer <= 3  
BEGIN  
    SET @inner = 1;

    WHILE @inner <= 3  
    BEGIN  
        PRINT CAST(@outer AS NVARCHAR) + ' x ' + CAST(@inner AS NVARCHAR) + ' = ' + CAST(@outer * @inner AS NVARCHAR);
        SET @inner = @inner + 1;
    END;

    SET @outer = @outer + 1;
    PRINT '---';  -- Separator
END;
```

**Output:**
```
1 x 1 = 1
1 x 2 = 2
1 x 3 = 3
---
2 x 1 = 2
2 x 2 = 4
2 x 3 = 6
---
3 x 1 = 3
3 x 2 = 6
3 x 3 = 9
---
```
✔ The **inner loop** runs **three times per outer loop iteration**.

---

## **9. Infinite Loop (AVOID THIS!)**
If a `WHILE` condition never becomes `FALSE`, the loop **runs forever**.

### **Example of an Infinite Loop**
```sql
DECLARE @counter INT = 1;

WHILE @counter > 0  
BEGIN  
    PRINT 'This is an infinite loop!';
END;
```

**Fix:** Always have a termination condition:
```sql
DECLARE @counter INT = 1;

WHILE @counter <= 5  
BEGIN  
    PRINT 'Counter: ' + CAST(@counter AS NVARCHAR);
    SET @counter = @counter + 1;
END;
```

---

## **10. Summary Table**
| Feature | Example |
|---------|---------|
| **Basic WHILE loop** | `WHILE @counter <= 5 BEGIN ... END` |
| **BREAK (Exit Loop)** | `IF @counter = 3 BREAK;` |
| **CONTINUE (Skip Iteration)** | `IF @counter = 3 CONTINUE;` |
| **Inserting rows** | Insert multiple records dynamically |
| **Processing data** | Update rows in a loop |
| **Fibonacci sequence** | Generate numbers dynamically |
| **Nested loops** | Multiplication table |
| **Infinite loop** | Avoid missing termination conditions |

---

## **11. Conclusion**
The `WHILE` loop is a powerful control flow statement in SQL Server for **iterating over data, inserting rows, updating records, and performing calculations**. However, **always ensure**:
- The loop **has a termination condition**.
- Use `BREAK` when needed to exit early.
- Use `CONTINUE` to skip unwanted iterations.
