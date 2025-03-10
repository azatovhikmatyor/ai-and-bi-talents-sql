
alter proc generate_numbers @upto int
as
begin
	declare @num int = 0;
	declare @numbers table (num int);

	while @num <= @upto
	begin
		insert into @numbers
		select @num;

		set @num = @num + 1;

	end;

	select num from @numbers;
end;

exec generate_numbers 20;

create table emp(
	id int,
	name varchar(50)
);

insert into emp
values 
	(1, 'name1'),
	(4, 'name4'),
	(7, 'name7'),
	(11, 'name11'),
	(19, 'name19')

create table numbers (num int)

insert into numbers
exec generate_numbers 20;
select * from emp;




