drop table if exists items;
go

create table items
(
	ID						varchar(10),
	CurrentQuantity			int,
	QuantityChange   		int,
	ChangeType				varchar(10),
	Change_datetime			datetime
);
go

insert into items values
('A0013', 278,   99 ,   'out', '2020-05-25 0:25'), 
('A0012', 377,   31 ,   'in',  '2020-05-24 22:00'),
('A0011', 346,   1  ,   'out', '2020-05-24 15:01'),
('A0010', 347,   1  ,   'out', '2020-05-23 5:00'),
('A009',  348,   102,   'in',  '2020-04-25 18:00'),
('A008',  246,   43 ,   'in',  '2020-04-25 2:00'),
('A007',  203,   2  ,   'out', '2020-02-25 9:00'),
('A006',  205,   129,   'out', '2020-02-18 7:00'),
('A005',  334,   1  ,   'out', '2020-02-18 6:00'),
('A004',  335,   27 ,   'out', '2020-01-29 5:00'),
('A003',  362,   120,   'in',  '2019-12-31 2:00'),
('A002',  242,   8  ,   'out', '2019-05-22 0:50'),
('A001',  250,   250,   'in',  '2019-05-20 0:45');


select * from items;

/*
You should dynamically split into time interval groups by adding +90 days to create new group and 
find the count of items by measuring their age in days considering change types.
For example: 'in' means item arrived in warehouse while 'out' means item exited the warehouse
for each time interval groups. Like: in A001 250 ('2019-05-20 0:45') items intered the warehouse
and in A002 ('2019-05-22 0:50') 8 of them left the warehouse so by that time there are 242 items
with the age of 2 days since they all stayed there at least 2 days. That is how you should calculate
the age of each item.
*/

--======================Expected Output=======================----------
------------------------------------------------------------------------
--||0-90 days old||91-180 days old||181-270 days old||271-365 days old||
--||-------------||---------------||----------------||----------------||
--||   	         || 	          || 	            ||  			  ||
------------------------------------------------------------------------


--======================Expected Output=======================----------------------------
------------------------------------------------------------------------------------------
--||1-90 days old||91-180 days old||181-270 days old||271-360 days old||361-450 days old||
--||-------------||---------------||----------------||----------------||----------------||
--||184	         ||120	          ||27	            ||132			  ||83				||
------------------------------------------------------------------------------------------

