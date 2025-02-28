

-- ===============================
-- Subquery = Sub query
-- ===============================

select 1 as a -- One column, one row
select 1a, 2b -- Two column, one row


select *,
	(select SUM(Price) from OrderDetails where ProductID = 1)
from OrderDetails


select *,
	(select SUM(Price) from OrderDetails where ProductID = 1),
	(select MAX(Price) from OrderDetails where ProductID = 1)
from OrderDetails;


select *
	--,(select Price from OrderDetails where ProductID = 1)
from OrderDetails

select Price from OrderDetails where ProductID = 1
-- Only one expression can be specified in the select list when the subquery is not introduced with EXISTS.
-- Subquery returned more than 1 value. This is not permitted when the subquery follows =, !=, <, <= , >, >= or when the subquery is used as an expression.


select Category, ProductName, Price
into newtable
from OrderDetails od
join Products p
	on od.ProductID = p.ProductID;


select *
from (
	select --TOP 100 PERCENT
		*, DENSE_RANK() OVER(PARTITION BY Category ORDER BY Price desc) as rn
	from newtable
	--order by rn
) as mytable
order by rn;

-- No column name was specified for column 4 of 't'.
-- The ORDER BY clause is invalid in views, inline functions, derived tables, subqueries, and common table expressions, unless TOP, OFFSET or FOR XML is also specified.

select * 
from OrderDetails
where Price > (
	select avg(price) from OrderDetails
);


select * 
from OrderDetails
where CONCAT(ProductID, ProductName) IN (
	select CONCAT(ProductID, ProductName) from Products where Category = 'Electronics'
)





;with cte as (
	select *,ROW_NUMBER() OVER(order by (select NULL)) rn from newtable
)
update cte
set Category = 'Stationery'
where rn in (5, 6)

-- Windowed functions can only appear in the SELECT or ORDER BY clauses.

-- ==================================================
-- Puzzles
-- Puzzle 1

--First_Name	Last_Name
-------------------------
--Zebulen		Cattrell
--Grady			Gannaway
--Gaylord		Yesson
--Mathilda		Ryding
--Hermina		Currey

select fname, lname
from (
	select value as fname,
		row_number() over(order by (select null)) as rn
	from string_split('Zebulen,Grady,Gaylord,Mathilda,Hermina', ',')
) as l
join (
	select value as lname,
		row_number() over(order by (select null)) as rn
	from string_split('Cattrell,Gannaway,Yesson,Ryding,Currey', ',')
) as r
	on r.rn = l.rn;

-- Puzzle 2
drop table numbers
select ordinal as num into numbers from string_split(replicate(',', 9), ',', 1)

-- Find cumulative sum of numbers
-- Using window functions
select
	num,
	sum(num) over(order by num)
from numbers;

select
	num,
	(select sum(num) from numbers t2 where t2.num <= t1.num)
from numbers t1

select sum(num) from numbers where num <= 1
select sum(num) from numbers where num <= 2
select sum(num) from numbers where num <= 3


-- Puzzle 3

drop table if exists lagt;
CREATE TABLE lagt
(
	BusinessEntityID INT
	,SalesYear   INT
	,CurrentQuota  DECIMAL(20,4)
)
GO
 
INSERT INTO lagt
SELECT 275 , 2005 , '367000.00'
UNION ALL
SELECT 275 , 2006 , '556000.00'
UNION ALL
SELECT 275 , 2007 , '502000.00'
UNION ALL
SELECT 275 , 2008 , '550000.00'
UNION ALL
SELECT 275 , 2009 , '1429000.00'
UNION ALL
SELECT 275 , 2010 ,  '1324000.00'
UNION ALL
SELECT 276 , 2005 , '367000.00'
UNION ALL
SELECT 276 , 2006 , '556000.00'
UNION ALL
SELECT 276 , 2007 , '502000.00'
UNION ALL
SELECT 276 , 2008 , '550000.00'
UNION ALL
SELECT 276 , 2009 , '1429000.00'
UNION ALL
SELECT 276 , 2010 ,  '1324000.00'


-- Using window functions
select 
	*,
	lag(CurrentQuota, 1, 0) over(partition by BusinessEntityId order by SalesYear)
from lagt;

-- Using JOIN

select
	t1.*, 
	isnull(t2.CurrentQuota, 0) as PrevQuota
from lagt t1
left join lagt t2
	on t1.BusinessEntityID = t2.BusinessEntityID
		and t1.SalesYear = t2.SalesYear + 1;


-- Using SUBQUERY

select *,
	isnull((
		select currentquota 
		from lagt t2 
		where t1.BusinessEntityID = t2.BusinessEntityID
			and t1.SalesYear = t2.SalesYear + 1
	), 0)
from lagt t1

select 
	*
from lagt

