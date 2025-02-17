SELECT 
	productid, productname
FROM Production.Products;

SELECT TOP 10
	*
FROM Production.Products;

SELECT TOP 10 PERCENT
	*
FROM Production.Products;

SELECT 1 AS NUM, * FROM Production.Products;

SELECT 
	1 AS NUM, 
	productid as ID, 
	* 
FROM Production.Products;

SELECT
	ID = productid, 
	* 
FROM Production.Products;

SELECT *,
	2 * unitprice as Price2
FROM Production.Products;

SELECT *,
	Price2 = 2 * unitprice
FROM Production.Products;

SELECT
	Production.Products.productid
FROM Production.Products;


SELECT
	P.productid
FROM Production.Products AS P;


SELECT DISTINCT supplierid, categoryid FROM Production.Products;

SELECT DISTINCT productid, supplierid, categoryid FROM Production.Products;

/*  */
-- WHERE - ma'lumotlarni filter qilish uchun

SELECT *
FROM [Sales].[Orders]
WHERE 
	freight > 50 AND 
	shipperid = 1 AND
	empid IN (1, 2, 4); -- (empid = 1 OR empid = 2 OR empid = 4)

SELECT *
FROM [Sales].[Orders]
WHERE 
	freight > 50 AND 
	shipperid = 1 AND
	(empid = 1 OR 
	empid = 2 OR 
	empid = 4);

SELECT distinct shipperid
FROM [Sales].[Orders]
WHERE 
	--shipperid != 2
	 shipperid <> 1;


SELECT distinct shipperid
FROM [Sales].[Orders]
WHERE 
	 NOT shipperid = 1
	--shipperid != 2


SELECT DISTINCT empid
FROM [Sales].[Orders]
WHERE 
	NOT (empid = 1 OR 
	empid = 2 OR 
	empid = 4);

SELECT DISTINCT empid
FROM [Sales].[Orders]
WHERE 
	empid <> 1 AND 
	empid <> 2 AND
	empid <> 4;


-- AND, OR, NOT, BETWEEN, IN
-- =, <> or !=, >, <, >=, <=

SELECT DISTINCT empid
FROM [Sales].[Orders]
WHERE 
	empid BETWEEN 3 AND 5;

SELECT DISTINCT empid
FROM [Sales].[Orders]
WHERE 
	empid >=3 AND empid <= 5;


-- GROUP BY - Ma'lumotlarni guruhlash uchun
SELECT DISTINCT empid
FROM [Sales].[Orders];

SELECT empid
FROM [Sales].[Orders]
GROUP BY empid

/* Aggregate function: SUM, COUNT, ... */

SELECT COUNT(*)
FROM [Sales].[Orders];


SELECT empid,  COUNT(*) as cnt
FROM [Sales].[Orders]
GROUP BY empid;
--Column 'Sales.Orders.empid' is invalid in the select list because it is not contained in either an aggregate function or the GROUP BY clause.


SELECT COUNT(*) as cnt
FROM [Sales].[Orders]
WHERE empid = 1;


SELECT empid,  COUNT(*) as cnt
FROM [Sales].[Orders]
WHERE empid < 5
GROUP BY empid


SELECT empid,  COUNT(*) as cnt
FROM [Sales].[Orders]
--WHERE cnt > 50
GROUP BY empid
HAVING COUNT(*) > 50;


SELECT empid,  COUNT(*) as cnt
FROM [Sales].[Orders]
--WHERE cnt > 50
GROUP BY empid
HAVING cnt > 50;

--Invalid column name 'cnt'.

/* Syntax order:

SELECT <COLUMNS>
FROM <TABLE NAME>
WHERE <FILTERING CONDITION>
GROUP BY <COLUMNS>
HAVING <FILTERING CONDITION>
ORDER BY
*/


/* Execution order:

FROM <TABLE NAME>
WHERE <FILTERING CONDITION>
GROUP BY <COLUMNS>
HAVING <FILTERING CONDITION>
SELECT <COLUMNS>
ORDER BY
*/

SELECT *,
	2 * unitprice as Price2
FROM Production.Products
WHERE 2 * unitprice > 100
ORDER BY supplierid DESC

SELECT *,
	2 * unitprice as Price2
FROM Production.Products
WHERE 2 * unitprice > 100
ORDER BY discontinued, Price2 DESC;


SELECT *,
	2 * unitprice as Price2
FROM Production.Products
WHERE 2 * unitprice > 100
ORDER BY 2 DESC;


SELECT 1
FROM Production.Products;


/* TOP and ORDER BY */

SELECT 
TOP 5
*,
	2 * unitprice as Price2
FROM Production.Products
ORDER BY unitprice;

/* OFFSET and FECTH */

/*
...
ORDER BY <COLUMNS> [ASC, DESC]
OFFSET <n_rows to skip> {ROW|ROWS}
FETCH {FIRST|NEXT} <n_rows to select> {ROW|ROWS} ONLY
*/

SELECT *,
	2 * unitprice as Price2
FROM Production.Products
ORDER BY productid
OFFSET 1 ROW FETCH NEXT 10 ROWS ONLY;

SELECT *,
	2 * unitprice as Price2
FROM Production.Products
ORDER BY productid
OFFSET 1 ROW FETCH NEXT 30 ROWS ONLY;

SELECT *,
	2 * unitprice as Price2
FROM Production.Products
ORDER BY productid
OFFSET 1 ROW FETCH FIRST 10 ROWS ONLY;
--A TOP can not be used in the same query or sub-query as a OFFSET.


