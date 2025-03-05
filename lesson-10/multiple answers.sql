CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    OrderDate DATE
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductName VARCHAR(100),
    Quantity INT,
    UnitPrice DECIMAL(10,2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

INSERT INTO Orders VALUES 
	(1, 'Alice', '2024-03-01'),
	(2, 'Bob', '2024-03-02'),
	(3, 'Charlie', '2024-03-03');

INSERT INTO OrderDetails VALUES 
	(1, 1, 'Laptop', 1, 1000.00),
	(2, 1, 'Mouse', 2, 50.00),
	(3, 2, 'Phone', 1, 700.00),
	(4, 2, 'Charger', 1, 30.00),
	(5, 3, 'Tablet', 1, 400.00),
	(6, 3, 'Keyboard', 1, 80.00);


select * from Orders
select * from OrderDetails

/*
1	Alice	Laptop	1	1000.00
2	Bob		Phone	1	700.00
3	Charlie Tablet	1	400.00
*/



select OrderId, customerName,
(
	select top 1 UnitPrice from OrderDetails od
	where od.OrderID=o.OrderID
	order by UnitPrice desc
) as UnitPrice,
(
	select top 1 ProductName from OrderDetails od
	where od.OrderID=o.OrderID
	order by UnitPrice desc
) as ProductName
from Orders o;

select UnitPrice, OrderID from OrderDetails order by UnitPrice desc;


select o.OrderId, customerName, od.ProductName, od.UnitPrice
from Orders o
cross apply (
	select top 3 OrderID, ProductName, UnitPrice from OrderDetails od
	where od.OrderID=o.OrderID
	order by UnitPrice desc
) as od

select * from Orders

select top 2 OrderID, ProductName, UnitPrice from OrderDetails od
where od.OrderID=1
order by UnitPrice desc




CREATE TABLE TestMax
(
    Year1 INT
    ,Max1 INT
    ,Max2 INT
    ,Max3 INT
);

INSERT INTO TestMax 
VALUES
    (2001,10,101,87)
    ,(2002,103,19,88)
    ,(2003,21,23,89)
    ,(2004,27,28,91);

select * from TestMax;

/*
2001	101
2002	103
2003	89
2004	91
*/

-- Solution 1
select Year1, GREATEST(Max1, max2, Max3) from TestMax

-- Solution 2: Sanjarbek Gulomjonov
select Year1, max(Max1)from (	select Year1, Max1 from TestMax	union all	select Year1, Max2 from TestMax	union all	select Year1, Max3 from TestMax) as tgroup by Year1

-- Solution 3: Sohibjon Dilmurodov
SELECT Year1, 	CASE		WHEN Max1>Max2 THEN (CASE WHEN Max1>Max3 THEN Max1 ELSE Max3 END) 	ELSE (CASE WHEN Max2>Max3 THEN Max2 ELSE Max3 END)	END as absmaxFROM TestMax;


-- Solution 4: Azizbek Saparbayev
select Year1, Max(MaxValue) as MaxValue from (	select Year1, Max1 as MaxValue from TestMax	union all	select Year1, Max2 as MaxValue from TestMax	union all	select Year1, Max3 as MaxValue from TestMax) as MaxValgroup by Year1;


-- Solution 5: Sohibjon Dilmurodov
SELECT Year1,IIF(Max1>Max2, IIF(Max1>Max3, Max1, Max3), IIF(Max2>Max3, Max2, Max3)) as absmaxFROM TestMax;-- Solution6: Mardon Hazratovselect Year1,    (        select max(mx)         from         (            select Max1 as mx from TestMax t1 where t1.Year1 = t.Year1            union all             select Max2 from TestMax t1 where t1.Year1 = t.Year1            union all             select Max3 from TestMax t1 where t1.Year1 = t.Year1        ) as mx    )from TestMax t;-- ===============================-- VALUES-- ===============================create table demo(	col1 int, col2 int);insert into demoVALUES	(1, 2),	(3, 4),	(5, 6);insert into demoselect 1, 2union allselect 3, 4union allselect 5, 6select * from (	select 1 as col1, 2 as col2	union all	select 3, 4	union all	select 5, 6) t
select col1, col2 from (	VALUES		(1, 2),		(3, 4),		(5, 6)) t(col1, col2)select max(val) from (	values (10), (101), (87)) t(val)select	Year1, --max1, max2, max3,	(		select max(val) from (			values (max1), (max2), (max3)		) t(val)	) as max_valfrom TestMax;