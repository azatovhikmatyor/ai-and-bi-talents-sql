
--CREATE TABLE Shipments (
--    N INT PRIMARY KEY,
--    Num INT
--);

--INSERT INTO Shipments (N, Num) VALUES
--(1, 1), (2, 1), (3, 1), (4, 1), (5, 1), (6, 1), (7, 1), (8, 1),
--(9, 2), (10, 2), (11, 2), (12, 2), (13, 2), (14, 4), (15, 4), 
--(16, 4), (17, 4), (18, 4), (19, 4), (20, 4), (21, 4), (22, 4), 
--(23, 4), (24, 4), (25, 4), (26, 5), (27, 5), (28, 5), (29, 5), 
--(30, 5), (31, 5), (32, 6), (33, 7);


;WITH cte AS (	SELECT 1 AS days	UNION ALL	SELECT days + 1 FROM cte	WHERE days < 40),AdjustedTable AS (	SELECT top 40 		C.days AS Days,		ISNULL(S.Num, 0) AS Numbers,		ROW_NUMBER() OVER(ORDER BY ISNULL(S.Num, 0)) rnk,		count(days) over() as total	FROM cte C	LEFT JOIN Shipments S		ON C.days = S.N	order by rnk), cte2 as (	select *, count(1) over() as cnt	from AdjustedTable)--select * from cte2 order by rnkSELECT 	avg(Numbers*1.0) as medianFROM cte2where rnk IN (	(cnt + 1) / 2,	cnt / 2  + 1);

--1
--2
--3
--4
--5

--select (5+1) / 2 -- 3
--select 5 / 2 + 1 -- 3

--1
--2
--3
--4
--5
--6

--select (6+1) / 2 -- 3
--select 6 / 2 + 1 -- 4

