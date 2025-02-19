
create table agents
(
	name varchar(50),
	office varchar(50),
	isheadoffice varchar(3)
);

insert into agents
values
	('Rich', 'UK', 'yes'),
	('Rich', 'US', 'no'),
	('Rich', 'NZ', 'no'),
	('Brandy', 'US', 'yes'),
	('Brandy', 'UK', 'no'),
	('Brandy', 'AUS', 'no'),
	('Karen', 'NZ', 'yes'),
	('Karen', 'UK', 'no'),
	('Karen', 'RUS', 'no'),
	('Mary', 'US', 'yes'),
	('Mary', 'UK', 'no'),
	('Mary', 'CAN', 'no'),
	('Charles', 'US', 'yes'),
	('Charles', 'UZB', 'no'),
	('Charles', 'AUS', 'no');


-- Find agents who has head office in 'US' and also office in 'UK';

select name --,*
from agents 
where (office='US' and isheadoffice='yes') OR (office='UK' and isheadoffice = 'no')
group by name 
having count(distinct office) = 2;


-- ============================

create table parent
(
	pname varchar(50),
	cname varchar(50),
	gender char(1)
);

insert into parent
values
	('Karen', 'John', 'M'),
	('Karen', 'Steve', 'M'),
	('Karen', 'Ann', 'F'),
	('Rich', 'Cody', 'M'),
	('Rich', 'Stacy', 'F'),
	('Rich', 'Mike', 'M'),
	('Tom', 'John', 'M'),
	('Tom', 'Ross', 'M'),
	('Tom', 'Rob', 'M'),
	('Roger', 'Brandy', 'F'),
	('Roger', 'Jennifer', 'F'),
	('Roger', 'Sara', 'F')
	

-- Find parents who have both male and female children

select pname
from parent
group by pname
having count(distinct gender)=2
