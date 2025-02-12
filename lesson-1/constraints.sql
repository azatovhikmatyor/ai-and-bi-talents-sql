/* CONSTRAINT = Cheklov */


/* 1. NOT NULL Constraint*/
drop table if exists person;
create table person
(
	id int not null,
	name varchar(50)
);

insert into person(id)
values (1);

select * from person;

/* 2. UNIQUE Constraint */

drop table if exists person;
create table person
(
	id int not null unique,
	name varchar(50)
);

insert into person(id, name)
values 
	(1, 'John'),
	(2, 'John');


insert into person
select NULL, 'Josh';


--Violation of UNIQUE KEY constraint 'UQ__person__3213E83E0A5EF033'. 
--Cannot insert duplicate key in object 'dbo.person'. The duplicate key value is (1).
select * from person;

--if NULL IS NULL
--begin 
--	print 'true'
--end
--else
--begin
--	print 'false'
--end


drop table if exists person;
create table person
(
	id int not null,
	name varchar(50)
);

alter table person
add unique(id);

alter table person
add constraint UC_person_id unique(id);

alter table person
drop constraint UC_person_id;


drop table if exists person;
create table person
(
	id int not null,
	name varchar(50)
);

alter table person
add unique(id);

alter table person
add unique(name);

alter table person
add unique(id, name);

insert into person(id, name)
values (1, 'John');

select * from person;

/* PRIMARY KEY */

drop table if exists person;
create table person
(
	id int primary key,
	name varchar(50)
);

insert into person(id, name)
values (1, 'John');

/* Foreign Key */

drop table if exists person;
create table person
(
	id int primary key,
	name varchar(50),
	department_id int
);

insert into person
values (1, 'John', 1);
insert into person
values (2, 'Adam', 2);
insert into person
values (3, 'Anna', 1);

insert into person
values (4, 'Smith', 5);

select * from person;

create table department
(
	id int primary key,
	name varchar(50)
);

insert into department
values 
	(1	,'HR'),
	(2	,'IT'),
	(3	,'Marketing')

select * from department;
select * from person;

--- =======================================

drop table if exists department;
create table department
(
	id int primary key,
	name varchar(50)
);

drop table if exists person;
create table person
(
	id int primary key,
	name varchar(50),
	department_id int foreign key references department(id)
);

-- The INSERT statement conflicted with the FOREIGN KEY constraint "FK__person__departme__7C4F7684". The conflict occurred in database "class1", table "dbo.department", column 'id'.

/* CHECK Constraint */
drop table if exists employee;
create table employee
(
	id int primary key,
	name varchar(50),
	age int check (age > 0)
);

insert into employee
select 1, 'John', -1

select * from employee;


/* DEFAULT Constraint */

drop table if exists employee;
create table employee
(
	id int primary key,
	name varchar(50),
	age int check (age > 0),
	email varchar(255) NOT NULL DEFAULT 'No Email'
);


insert into employee(id, name, age, email)
select 1, 'Josh', 45, NULL

select * from employee;

/* IDENTITY */

drop table if exists person;
create table person
(
	id int primary key identity,
	name varchar(50)
);

insert into person(id, name)
values (3, 'John')

--An explicit value for the identity column in table 'person' can only be specified when a column list is used and IDENTITY_INSERT is ON.

insert into person(name)
values ('John')

select * from person

SET IDENTITY_INSERT person OFF

