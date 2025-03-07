-- ==============================
-- SQL Server Temporary Tables
-- ==============================

create table #sales
(
	id int,
	product varchar(50),
	price int
);

insert into #sales
values (1, 'apple', 10), (2, 'cherry', 30);

select * from #sales;


-- ==============================
-- SQL Server Global Temp Tables
-- ==============================

create table ##emp
(
	id int,
	name varchar(50)
);

insert into ##emp
values (1, 'john'), (2, 'doe');

select * from ##emp





