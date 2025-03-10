-- Dynamic SQL
declare @sql_cmd varchar(max)= 'SELECT * FROM ';

set @sql_cmd = @sql_cmd + 'numbers'

EXEC(@sql_cmd)

go
create proc sp_select_all @table_name varchar(255), @top_k int
as
begin
	declare @sql_cmd varchar(max) = 'SELECT ';
	select @sql_cmd = CONCAT(@sql_cmd, 'TOP ', @top_k);
	select @sql_cmd = CONCAT(@sql_cmd, ' * FROM ', @table_name);
	
	EXEC(@sql_cmd);

end;


exec sp_select_all @table_name='numbers', @top_k=100

exec sp_select_all @table_name='numbers'


go
declare @table_name varchar(max) = 'emp';
declare @top_k int = 10;

declare @sql_cmd varchar(max) = 'SELECT ';
select @sql_cmd = CONCAT(@sql_cmd, 'TOP ', @top_k);
select @sql_cmd = CONCAT(@sql_cmd, ' * FROM ', @table_name);

EXEC(@sql_cmd)

create table demo(col varchar(max))