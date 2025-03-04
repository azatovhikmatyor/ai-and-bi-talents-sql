### Task 1
Given this Employee table below, find the level of depth each employee from the President. 

```sql
CREATE TABLE Employees
(
	EmployeeID  INTEGER PRIMARY KEY,
	ManagerID   INTEGER NULL,
	JobTitle    VARCHAR(100) NOT NULL
);
INSERT INTO Employees (EmployeeID, ManagerID, JobTitle) 
VALUES
	(1001, NULL, 'President'),
	(2002, 1001, 'Director'),
	(3003, 1001, 'Office Manager'),
	(4004, 2002, 'Engineer'),
	(5005, 2002, 'Engineer'),
	(6006, 2002, 'Engineer');
```

Expected Output:

EmployeeID | ManagerID | JobTitle | Depth
-----------|-----------|----------|------
1001       | NULL      | President|0
2002       | 1001      | Director | 1
3003       | 1001      | Office Manager | 1
4004       | 2002      | Engineer | 2
5005       | 2002      | Engineer | 2
6006       | 2002      | Engineer | 2

---

### Task 2

Find Factorials up to $N$.

Expected output for $N = 10$:

Num	|Factorial
----|---------
1	|1
2	|2
3	|6
4	|24
5	|120
6	|720
7	|5040
8	|40320
9	|362880
10	|3628800


---

### Task 3
Find Fibonacci numbers up to $N$.

Expected output for $N = 10$:

n	|Fibonacci_Number
----|----------------
1	|1
2	|1
3	|2
4	|3
5	|5
6	|8
7	|13
8	|21
9	|34
10	|55