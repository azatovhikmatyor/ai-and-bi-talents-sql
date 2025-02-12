/* Inserting values */

--create database class1;
--go
use class1;

create table test(
	id int null,
	name varchar(100) null
);

insert into test
values
	(1, 'demo1'),
	(2, 'demo2');

select * from test;

select * from dbo.test;

select * from class1.dbo.test;

--insert into test
--values
--	(2, 'demo2')

/* Inserting values using SELECT statement */

/*
select 1 as id, 'John' as another;
print 1;

select 1 id, 'John' another;

select 
	id AS MyID, 
	name
from test;

select
	id,
	name
from test;
*/

select * from test;

insert into test
select 3, 'demo3';

insert into test
select 4, 'demo4'
union all
select 5, 'demo5';

select distinct * from test;

select 4, 'demo4'
union all
select 5, 'demo5'
union all
select 5, 'demo5';
