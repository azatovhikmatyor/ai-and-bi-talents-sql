-- Stored Procedure

/*
CREATE PROC/PROCEDURE <name>
AS
BEGIN
	<statement 1>
	<statement 2>
	<statement 3>
END;

EXEC <name>
EXECUTE <name>
*/

alter procedure sp_sales_for_date @date_key int
as
begin
	create table #temp
	(
		ProductKey int,
		UnitPrice decimal(10, 2),
		ExtendedAmount decimal(10, 2)
	);

	insert into #temp
	select 
		ProductKey, 
		UnitPrice,
		ExtendedAmount
	from [AdventureWorksDW2019].[dbo].[FactInternetSales]
	where OrderDateKey=@date_key;

	select * from #temp;
end

go


EXECUTE sp_sales_for_date @date_key=20110111;

GO

ALTER procedure [dbo].[sp_sales_for_date]
as
begin
	create table #temp
	(
		ProductKey int,
		UnitPrice decimal(10, 2),
		ExtendedAmount decimal(10, 2),
		OrderDateKey int
	);

	insert into #temp
	select 
		ProductKey, 
		UnitPrice,
		ExtendedAmount,
		OrderDateKey
	from [AdventureWorksDW2019].[dbo].[FactInternetSales]
	where OrderDateKey=20110111;

	select * from #temp;
end;