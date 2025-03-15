
-- PIVOT is used to transform ROWS into COLUMNS
select *
into #temp
from
(
	select 
		category_name,
		model_year,
		product_id
	 from [production].[products] p
	join [production].[categories] c
		on p.category_id = c.category_id
	--group by category_name
) tbl
PIVOT
(
	COUNT(product_id) FOR category_name in (
		[Children Bicycles],
		[Comfort Bicycles],
		[Cruisers Bicycles],
		[Cyclocross Bicycles],
		[Electric Bikes],
		[Mountain Bikes],
		[Road Bikes]
	)
) cnt



select *
from
(
	select 
		category_name,
		product_id
	 from [production].[products] p
	join [production].[categories] c
		on p.category_id = c.category_id
	--group by category_name
) tbl
PIVOT
(
	COUNT(product_id) FOR category_name in (
		[Children Bicycles],
		[Comfort Bicycles],
		[Cruisers Bicycles],
		[Cyclocross Bicycles],
		[Electric Bikes],
		[Mountain Bikes],
		[Road Bikes]

	)
) cnt


--select <column>
--from <table>
--PIVOT (
--	(<col_name>) FOR col_name (<predefined values>)
--)


select *
into #temp2
from
(
	select 
		category_name,
		count(product_id) as cnt
	from [production].[products] p
	join [production].[categories] c
		on p.category_id = c.category_id
	group by category_name
) tbl
PIVOT
(
	MAX(cnt) FOR category_name in (
		[Children Bicycles],
		[Comfort Bicycles],
		[Cruisers Bicycles],
		[Cyclocross Bicycles],
		[Electric Bikes],
		[Mountain Bikes],
		[Road Bikes]

	)
) cnt



select BikeType, Counts
from #temp2
UNPIVOT -- TRANSFORM COLUMNS INTO ROWS
(
	Counts FOR BikeType  IN (
		[Children Bicycles],
		[Comfort Bicycles],
		[Cruisers Bicycles],
		[Cyclocross Bicycles],
		[Electric Bikes],
		[Mountain Bikes],
		[Road Bikes]
	)
) unpvt


--BikeType			Counts
--Children Bicycles	59
--Comfort Bicycles	30
--...

select *
from #temp
UNPIVOT -- TRANSFORM COLUMNS INTO ROWS
(
	Counts FOR BikeType  IN (
		[Children Bicycles],
		[Comfort Bicycles],
		[Cruisers Bicycles],
		[Cyclocross Bicycles],
		[Electric Bikes],
		[Mountain Bikes],
		[Road Bikes]
	)
) unpvt


--- 


CREATE TABLE TestMax
(
	Year1 INT
	,Max1 INT
	,Max2 INT
	,Max3 INT
)
 INSERT INTO TestMax 
VALUES
 (2001,10,101,87)
,(2002,103,19,88)
,(2003,21,23,89)
,(2004,27,28,91)

Select Year1,Max1,Max2,Max3 FROM TestMax




