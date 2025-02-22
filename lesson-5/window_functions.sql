create database class5;
go
use class5;

-- Window Functions

CREATE TABLE Sales (
    SaleID INT IDENTITY(1,1) PRIMARY KEY,
    SaleDate DATE NOT NULL,
    Amount DECIMAL(10,2) NOT NULL
);


INSERT INTO Sales (SaleDate, Amount) VALUES
('2024-01-01', 100),
('2024-01-02', 200),
('2024-01-03', 150),
('2024-01-04', 300),
('2024-01-05', 250),
('2024-01-06', 400),
('2024-01-07', 350),
('2024-01-08', 450),
('2024-01-09', 500),
('2024-01-10', 100);



select * from Sales

--SaleID	SaleDate	Amount Order
--1			2024-01-01	100.00 1
--2			2024-01-02	200.00 4
--3			2024-01-03	150.00 3
--4			2024-01-04	300.00
--5			2024-01-05	250.00 5
--6			2024-01-06	400.00
--7			2024-01-07	350.00
--8			2024-01-08	450.00
--9			2024-01-09	500.00
--10		2024-01-10	100.00 2

select 
	*,
	ROW_NUMBER() OVER(ORDER BY Amount ASC) as rn_asc,
	ROW_NUMBER() OVER(ORDER BY Amount DESC) as rn_desc,
	ROW_NUMBER() OVER(ORDER BY SaleDate DESC) as rn_date
from Sales
order by SaleID;

--select
--	*, DENSE_RANK() over(order by salary desc) as rn
--from emp
--where rn=2;

-- The function 'ROW_NUMBER' must have an OVER clause.
-- The function 'ROW_NUMBER' must have an OVER clause with ORDER BY.


select 
	*,
	ROW_NUMBER() OVER(ORDER BY Amount ASC) as rn_asc,
	DENSE_RANK() OVER(ORDER BY Amount ASC) as drnk_asc,
	RANK()		 OVER(ORDER BY Amount ASC) as drnk_asc
from Sales
order by SaleID;


select SaleDate, Amount, ROW_NUMBER() OVER(ORDER BY (SELECT NULL))
from Sales;


-- Aggregate-Window Functions
-- SUM, COUNT, MIN, MAX, AVG

drop table if exists Employees;
CREATE TABLE Employees (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    [Name] VARCHAR(50) NOT NULL,
    Department VARCHAR(50) NOT NULL,
    Salary DECIMAL(10,2) NOT NULL,
    HireDate DATE NOT NULL
);


INSERT INTO Employees ([Name], Department, Salary, HireDate) VALUES
('Alice', 'HR', 50000, '2020-06-15'),
('Bob', 'HR', 60000, '2018-09-10'),
('Charlie', 'IT', 70000, '2019-03-05'),
('David', 'IT', 80000, '2021-07-22'),
('Eve', 'Finance', 90000, '2017-11-30'),
('Frank', 'Finance', 75000, '2019-12-25'),
('Grace', 'Marketing', 65000, '2016-05-14'),
('Hank', 'Marketing', 72000, '2019-10-08'),
('Ivy', 'IT', 67000, '2022-01-12'),
('Jack', 'HR', 52000, '2021-03-29');



select *, (select sum(amount) from sales)
from sales

select sum(amount) from sales

select *, sum(amount) OVER()
from sales;

select 
	*,
	sum(salary) over(partition by department)
from Employees;

select department, sum(salary)
from Employees
group by department

select 
	*,
	max(salary) over(partition by department)
from Employees;

select department, max(salary)
from Employees
group by department;


-- ===========================

select * from (
	select 
		*,
		dense_rank() over(partition by department order by salary desc) as rnk
	from Employees
) mytable
where rnk = 2
order by department, rnk;

-- =============================

select 
		*,
		sum(salary) over(),
		sum(salary) over(order by HireDate)
from Employees
order by HireDate;

-- Running Total
-- Cumulativ


select 
		*,
		sum(salary) over(),
		sum(salary) over(order by HireDate),
		sum(salary) over(partition by department order by HireDate) as res
from Employees
order by department;



select 
		*,
		sum(salary) over(order by HireDate) as res0,
		sum(salary) over(order by HireDate rows between 1 preceding and current row) as res1,
		sum(salary) over(order by HireDate rows between 1 preceding and 1 following) as res2,
		sum(salary) over(order by HireDate rows between unbounded preceding and current row) as res3,
		sum(salary) over(order by HireDate rows between current row and unbounded following) as res4
from Employees
order by HireDate;







