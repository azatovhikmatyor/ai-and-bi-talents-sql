
-- ==============================
-- SQL Server Variables
-- ==============================

declare @txt varchar(max);
set @txt = 'Test';
select @txt;


declare @num int;
select @num = 2; -- This line is only setting value
select @num;

go
select @num
-- Must declare the scalar variable "@num".

declare @num int;
-- The variable name '@num' has already been declared. Variable names must be unique within a query batch or stored procedure.

select 1, @num=2;

-- A SELECT statement that assigns a value to a variable must not be combined with data-retrieval operations.


;with cte as (
	select 1 as n
	union all
	select n+ 1  from cte
	where n < 10
)
select * into numbers from cte


go
declare @num int = 0;
select @num = @num + n from numbers-- order by n desc;
select @num;

select * from numbers;


select @@SERVERNAME
select @@IDENTITY


create table emp
(
	id int primary key identity,
	name varchar(50)
);

insert into emp(name)
values ('josh')

select @@IDENTITY;
select @@ROWCOUNT;
select @@ERROR;
select @@VERSION;

select @@TRANCOUNT;

select * from emp

begin tran t1
insert into emp(name)
values ('adam')

commit tran t1
rollback tran t1

-- Table variable

declare @dept table (
	id int,
	name varchar(50)
);
insert into @dept
values (1, 'hr'), (2, 'it');


insert into newtable
select * 
from @dept;

select * from  newtable
