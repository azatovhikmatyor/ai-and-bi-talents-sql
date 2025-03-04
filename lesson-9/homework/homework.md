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
