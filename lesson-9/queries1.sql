use class7
go

SELECT [id]
      ,[name]
      ,[salary]
      ,[department]
      ,[mgr_id]
FROM [class7].[dbo].[employee]

-- EmpName, EmpDept, MgrName, MgrDept

select
	emp.name as EmpName,
	emp.department,
	mgr.name as MgrName,
	mgr.department
from employee emp
join employee mgr
	on emp.mgr_id = mgr.id


select 
	emp.name as EmpName,
	emp.dept_name,
	mgr.name as MgrName,
	mgr.dept_name
from (
	select e.id, e.name, d.name as dept_name, e.mgr_id
	from employee e
	join department d
		on e.department = d.id
) emp
join (
	select e.id, e.name, d.name as dept_name, e.mgr_id
	from employee e
	join department d
		on e.department = d.id
) mgr
	on emp.mgr_id = mgr.id

-- Common Table Expression

--	WITH <cte name>[column names] 
--	AS 
--	(
--		<inner query>
--	)
--	<outer query>

;WITH emp
AS
(
	select e.id, e.name, d.name as dept_name, e.mgr_id
	from employee e
	join department d
		on e.department = d.id
), dept as (
	select e.id, e.name, d.name as dept_name, e.mgr_id
	from employee e
	join department d
		on e.department = d.id
)
select
	e.name as EmpName,
	e.dept_name,
	m.name as MgrName,
	m.dept_name
from emp e
join dept m
	on e.mgr_id=m.id;

-- =====================================
-- Recursive CTE

;with cte
as (
	select 1 as n
	union all 
	select n + 1 from cte
	where n < 15000
)
select n from cte
option (MAXRECURSION 0);

----The statement terminated. The maximum recursion 100 has been exhausted before statement completion.

select ordinal from string_split(replicate(',', 15000), ',', 1)


declare @word varchar(50) = 'Hello World';

;with cte as (
	select 1 as n, SUBSTRING(@word, 1, 1) as chars
	union all
	select n + 1, SUBSTRING(@word, n + 1, 1)
	from cte
	where n < len(@word)
)
select * from cte;


-- 
go

declare @word varchar(50) = 'aaaaaaaabbbcccccc';
-- a 8
-- b 3
-- c 6



--1 H
--2 e
--3 l
--4 l
--5 o
--6 
--7 W
--...




