-- IF and WHILE

declare @num int = 11;

if @num % 2 = 0
begin
	PRINT 'Juft Son'
end
else
begin
	PRINT 'Toq Son'
end;

go

declare @num int = 0;

while @num < 10
begin
	select @num;
	
	set @num = @num + 1;

	--select @num = @num + 1;
end;



-- BREAK - loopni sindiradi
go

declare @num int = 0;

while @num < 10
begin
	PRINT @num;
	
	set @num = @num + 1;

	if @num = 5
		break
end;


-- CONTINUE - loopni bitta qadamini sindiradi
go

declare @num int = 0;

while @num < 10
begin
	
	set @num = @num + 1;
	PRINT @num;

	if @num = 5
		continue

	print 'nimadir';
end;





