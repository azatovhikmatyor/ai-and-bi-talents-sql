-- ==============================
-- SQL Server View
-- ==============================

CREATE VIEW SalesAnalysis AS
SELECT  
		dp.EnglishProductName,
		dd.EnglishDayNameOfWeek,
		dc.FirstName
FROM [AdventureWorksDW2019].[dbo].[FactInternetSales] fis
JOIN [AdventureWorksDW2019].[dbo].[DimProduct] dp
	on fis.ProductKey = dp.ProductKey
JOIN  [AdventureWorksDW2019].[dbo].[DimDate] dd
	on fis.OrderDateKey = dd.DateKey
JOIN [AdventureWorksDW2019].[dbo].[DimCustomer] dc
	on dc.CustomerKey = fis.CustomerKey

go

ALTER VIEW SalesAnalysisByDay AS
SELECT
		dd.EnglishDayNameOfWeek as NewColName,
		SUM(fis.ExtendedAmount) TotalSales
FROM [AdventureWorksDW2019].[dbo].[FactInternetSales] fis
JOIN  [AdventureWorksDW2019].[dbo].[DimDate] dd
	on fis.OrderDateKey = dd.DateKey
GROUP BY dd.EnglishDayNameOfWeek
go

select * from SalesAnalysisByDay

update SalesAnalysisByDay
set TotalSales = 0
where EnglishDayNameOfWeek = 'Wednesday'

-- Update or insert of view or function 'SalesAnalysisByDay' failed because it contains a derived or constant field.


select * from [AdventureWorksDW2019].[dbo].[FactInternetSales]

