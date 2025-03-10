
select 
	TABLE_CATALOG as DatabaseName,
	TABLE_SCHEMA as SchemaName,
	TABLE_NAME as TableName,
	COLUMN_NAME as ColumnName,
	concat(
		DATA_TYPE,'('+ 
			case when cast(CHARACTER_MAXIMUM_LENGTH as varchar) = '-1'
			then 'max'
			else cast(CHARACTER_MAXIMUM_LENGTH as varchar) end
		+')'
	) as DataType
from class10.INFORMATION_SCHEMA.COLUMNS;


declare @name varchar(255);
declare @i int = 1;
declare @count int;
select @count = count(1)
from sys.databases where name not in ('master', 'tempdb', 'model', 'msdb')


while @i < @count
begin
	;with cte as (
		select name, ROW_NUMBER() OVER(order BY name) as rn
		from sys.databases where name not in ('master', 'tempdb', 'model', 'msdb')
	)
	select @name=name from cte
	where rn = @i;

	--select 
	--	TABLE_CATALOG as DatabaseName,
	--	TABLE_SCHEMA as SchemaName,
	--	TABLE_NAME as TableName,
	--	COLUMN_NAME as ColumnName,
	--	concat(
	--		DATA_TYPE,'('+ 
	--			case when cast(CHARACTER_MAXIMUM_LENGTH as varchar) = '-1'
	--			then 'max'
	--			else cast(CHARACTER_MAXIMUM_LENGTH as varchar) end
	--		+')'
	--	) as DataType
	--from @name.INFORMATION_SCHEMA.COLUMNS;


	set @i = @i + 1;

end



