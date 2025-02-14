-- DDL: Data Definition Language

/* COMMON DATA TYPES */

-- INTEGER
/*
1. TINYINT = (0, 255)
2. SMALLINT = (-32,..., 32,...)
3. INT = (-2B, 2B)
4. BIGINT = (-2^63, 2^63-1)
*/
DROP TABLE IF EXISTS test;
create table test
(
	id TINYINT
);

INSERT INTO test
VALUES (1), (2), (3);

INSERT INTO test
VALUES (256);

--Arithmetic overflow error for data type tinyint, value = 256.


SELECT * FROM test;

-- SMALLINT
DROP TABLE IF EXISTS test;
create table test
(
	id SMALLINT
);

INSERT INTO test
VALUES (33000);

--Arithmetic overflow error for data type smallint, value = 33000.
SELECT * FROM test;


-- INT
DROP TABLE IF EXISTS test;
create table test
(
	id INT
);

INSERT INTO test
VALUES (3000000000);

-- Arithmetic overflow error converting expression to data type int.

SELECT * FROM test;

-- BIGINT
DROP TABLE IF EXISTS test;
create table test
(
	id BIGINT
);


INSERT INTO test
VALUES (30000000000000000100);

SELECT * FROM test;

-- DECIMAL
drop table if exists product;
create table product(
	id int primary key identity,
	name varchar(255),
	price decimal(10, 2)
);

insert into product
select 'cherry', 50.256;

SELECT * FROM product

-- FLOAT

drop table if exists product;
create table product(
	id int primary key identity,
	name varchar(255),
	price float
);

insert into product
select 'cherry', 50.256;


/* String */

/* CHAR(50), NCHAR(50), VARCHAR(50), NVARCHAR(50) */
/* TEXT, NTEXT */
/* NVARCHAR(MAX) */

drop table if exists blog;
create table blog(
	id int,
	title varchar(255),
	body varchar(MAX)
);


/* DATE AND TIME */

/*
DATE = YYYY-MM-DD
TIME = HH:MM:SS
DATETIME = YYYY-MM-DD HH:MM:SS
*/

-- DATE
create table person
(
	name varchar(100),
	birth_date DATE
);

insert into person
select 'john', '1950-11-23'

SELECT * FROM person

-- TIME

create table exam
(
	subject varchar(50),
	exam_time time
);

insert into exam
select 'python', '16:00';

select * from exam;

-- DATETIME
SELECT GETDATE();

--2025-02-14 20:34:50.883

create table orders
(
	item varchar(50),
	price int,
	created_datetime datetime
	--updated_datetime datetime
);

insert into orders
select 'apple', 1000, GETDATE();

insert into orders
values ('cherry', 3000, GETDATE());


SELECT * FROM orders;

SELECT GETDATE();
SELECT GETUTCDATE();
--2025-02-14 15:39:53.993

-- DATETIME2

/* GUID */
create table emp
(
	id UNIQUEIDENTIFIER,
	name varchar(50)
);

SELECT NEWID();

insert into emp
select '4FE476E9-4DB8-4B0', 'jane';

select * from emp;

--D7950DDB-E289-41C1-9FF4-F36BE0FB1832

/* MA'LUMOTLAR BAZASIDA RASM SAQLAMOQCHIMIZ */

-- 1.
create table products
(
	id int primary key,
	name varchar(50),
	category_name varchar(50),
	photo_path varchar(50)
);


drop table if exists products;
create table products
(
	id int primary key,
	name varchar(50),
	photo varbinary(MAX)
);


insert into products
select 1, 'apple', BulkColumn from openrowset(
	BULK 'D:\SQL\ai-and-bi-talents-sql\lesson-2\images\apple.jpg', SINGLE_BLOB
) AS img;

SELECT * FROM products;

SELECT @@SERVERNAME;


select * from openrowset(
	BULK 'D:\SQL\ai-and-bi-talents-sql\lesson-2\sample.csv', SINGLE_CLOB
) as data;

--Either a format file or one of the three options SINGLE_BLOB, SINGLE_CLOB, or SINGLE_NCLOB must be specified.


drop table if exists employee;
create table employee
(
	id int primary key identity,
	name varchar(100)
);

insert into employee(name)
select 'john'
union
select 'adam';

SELECT * FROM employee;

DELETE FROM employee;

BULK INSERT employee
FROM 'D:\SQL\ai-and-bi-talents-sql\lesson-2\sample.csv'
WITH (
	firstrow=2,
	fieldterminator=',',
	rowterminator='\n'
);

/* DROP vs DELETE vs TRUNCATE */

DELETE FROM employee WHERE id=2;
TRUNCATE TABLE employee;

SELECT * FROM employee;


DROP TABLE employee;

