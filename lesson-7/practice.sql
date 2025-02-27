CREATE TABLE dbo.People
(
    ID INT
    ,NAME VARCHAR(10)
    ,GENDER VARCHAR(1)
);

INSERT INTO dbo.People(ID,NAME,GENDER)
VALUES
    (1,'Neeraj','M'),
    (2,'Mayank','M'),
    (3,'Pawan','M'),
    (4,'Gopal','M'),
    (5,'Sandeep','M'),
    (6,'Isha','F'),
    (7,'Sugandha','F'),
    (8,'kritika','F');

select * from People;


--ID	NAME		GENDER
--1		Neeraj		M
--6		Isha		F
--2		Mayank		M
--7		Sugandha	F
--3		Pawan		M
--8		kritika		F
--4		Gopal		M
--5		Sandeep		M


select
	*
from people
order by ROW_NUMBER() over(partition by gender order by id), gender asc;



select
	*, ROW_NUMBER() over(partition by gender order by id) as rn
from people
--where rn = 2
--group by rn
--having
order by rn, gender asc;

-- ===================================

create table department(
	id int primary key,
	name varchar(50)
);

--create table manager(
--	id int,
--	name varchar
--);

create table employee
(
	id int primary key,
	name varchar(50),
	salary int,
	department int,
	mgr_id int
);


insert into department
values
	(1, 'IT'),
	(2, 'Marketing'),
	(3, 'HR'),
	(4, 'Sales')

insert into employee
values 
	(1, 'Mardon', 50000, 1, NULL),
	(2, 'Iskandar', 4000, 2, 1),
	(3, 'Mirshod', 4500, 1, 1),
	(4, 'Shavkat', 4200, 3, 2);


select * from employee;
select * from employee;

--ManagerName	EmployeeName
--Mardon		Iskandar
--Mardon		Mirshod
--Iskandar		Shavkat

select
	* -- m.name, e.name
from employee e
join employee m
	on e.mgr_id = m.id;


select distinct mgr_id from employee;



select
	e.name, m.name
from employee e
join employee m
	on e.mgr_id = m.id;


-- Find employees who has salary greater than their manager;
-- EmployeeName, EmployeeSalary, ManagerName, ManagerSalary

select
	e.name EmployeeName, 
	e.salary EmployeeSalary, 
	m.name ManagerName, 
	m.salary ManagerSalary
from employee e
left join employee m
	on e.mgr_id = m.id and e.salary < m.salary;

-- Find employees whose manager works under another department

select
	e.name EmployeeName, 
	e.department EmployeeDept, 
	m.name ManagerName, 
	m.department ManagerDept
from employee e
join employee m
	on e.mgr_id = m.id and e.department <> m.department;



select
	e.name EmployeeName, 
	e.department EmployeeDept, 
	m.name ManagerName, 
	m.department ManagerDept
from employee e
join employee m
	on e.mgr_id = m.id
where e.department <> m.department;



select
	e.name EmpName,
	d1.name EmpDept,
	m.name MName,
	d2.name MDept
from employee e
join employee m
	on e.mgr_id = m.id and e.department <> m.department
join department as d1
	on d1.id = e.department
join department as d2
	on d2.id = m.department


select * from department;

select
	*
from employee e
join department d
	on e.department = d.id;


-- ==========================================

--SELECT
--FROM
--WHERE
--GROUP BY
--HAVING
--ORDER BY

--FROM
--WHERE
--GROUP BY
--HAVING
--SELECT
--ORDER BY

-- ==========================================

drop table numbers;
create table numbers
(
	num int
);

insert into numbers
select ordinal from string_split(REPLICATE(',', 19), ',', 1)


select ordinal as num
into numbers
from string_split(REPLICATE(',', 19), ',', 1)


select 
	n1.num,--, n2.num,
	sum(case 
		when n1.num % n2.num = 0 then 1
		else 0 end)
from  numbers n1
join numbers n2
	ON n1.num >= n2.num
group by n1.num
having sum(case 
		when n1.num % n2.num = 0 then 1
		else 0 end) = 2
order by n1.num



select 
	n1.num, n2.num,
	case 
		when n1.num % n2.num = 0 then 1
		else 0 end
from  numbers n1
join numbers n2
	ON n1.num >= n2.num
order by n1.num


-- ===================================
-- son 11

------------------
-- son	is_prime
-- 11	tub
------------------

select 11 as son, '' as is_prime

select son, 
	case when 
		sum(case 
			when son % ordinal = 0 then 1
			else 0 end) = 2 then 'tub'
	else 'tub emas' end
from (
	select 10 as son, ordinal from string_split(REPLICATE(',', 9), ',', 1)
) t
group by son;

select * from numbers;

delete from numbers
where num in (2, 4, 5, 6);




select *
from  numbers n1
join numbers n2
	ON n1.num >= n2.num
order by n1.num


select 2 as son, ordinal from string_split(REPLICATE(',', 1), ',', 1)
union all
select 3 as son, ordinal from string_split(REPLICATE(',', 2), ',', 1)
union all
select 4 as son, ordinal from string_split(REPLICATE(',', 3), ',', 1)


select n.num, t.ordinal
from numbers as n
outer apply string_split(REPLICATE(',', n.num-1), ',', 1) t


--f(num) = string_split(REPLICATE(',', num-1), ',', 1)


1
2
3
4

1 Name1
1 Name2
2 Name3
3 NULL
4 Name4
4 Name5
4 Name6



CREATE TABLE letters
(
	ID INT,
    VALUE VARCHAR(100)
);

INSERT INTO letters(ID,VALUE)
VALUES
	(1,'a,b,c'),
	(2,'s,t,u,v,w,x');

select * from letters

--1	a
--1	b
--1	c
--2	s
--2	t
--2	u
--2	v
--2	w
--2	x

select 1, value from string_split('a,b,c', ',')
union all
select 2, value from string_split('s,t,u,v,w,x', ',')

select
	l.id, t.value
from letters l
cross apply string_split(l.VALUE, ',') t
