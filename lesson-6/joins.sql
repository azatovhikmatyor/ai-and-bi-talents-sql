-- ==========================
-- JOINS
-- ==========================

/*
1. INNER JOIN
2. OUTER JOIN:
	2.1 LEFT OUTER JOIN
	2.2 RIGHT OUTER JOIN
	2.3 FULL OUTER JOIN
3. CROSS JOIN

(SELF JOIN)
*/

drop table if exists employee;
drop table if exists department;

create table department
(
	id int primary key identity,
	name varchar(50) not null,
	description varchar(max)
);

create table employee
(
	id int primary key identity,
	name varchar(50),
	salary int,
	dept_id int --foreign key references department(id)
);


insert into department(name)
values
	('IT'), ('Marketing'), ('HR'), ('Finance')

select * from department;


insert into employee(name, salary, dept_id)
values 
	('John', 15000, 4),
	('Josh', 12000, 5),
	('Adam', 9000, 2),
	('Smith', 11000, 4),
	('Doe', 10000, 1);

select * from employee;


select
	e.*, '|' as '|', d.*
from employee as e -- left table
inner join department as d -- right table
	on e.dept_id <> d.id --and d.id <> 1
where d.id <> 1
order by e.id, e.name, e.salary, e.dept_id


-- Ambiguous column name 'id'.


select
	*
from employee as e
left outer join department as d
	on e.dept_id = d.id;

select
	*
from employee as e
right outer join department as d
	on e.dept_id = d.id;


select
	*
from employee as e
full outer join department as d
	on e.dept_id = d.id;

select
	*
from employee
cross join department

select
	*
from employee, department;


select
	*
from employee a
cross join employee b;


--empoloyee
--	id
--	name
--	salary
--	manager_id

--manager
--	id
