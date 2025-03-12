-- CURSOR

declare my_cursor cursor for 
	select name, database_id from sys.databases where name not in 
	('master', 'tempdb');

open my_cursor;

declare @db_name table(name varchar(255), database_id int);
fetch next from my_cursor into @db_name;

while @@FETCH_STATUS = 0
begin
	PRINT @db_name;
	fetch next from my_cursor into @db_name;
end;
close my_cursor;
deallocate my_cursor;

