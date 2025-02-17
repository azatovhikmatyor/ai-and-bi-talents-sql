create table nums
(
	num int
);

insert into nums
values (1),(2),(3),(4),(5),(6); 


select * from nums;

--num	COL1
--1		NULL
--2		HI
--3		BYE
--4		HI
--5		NULL
--6		HI BYE

SELECT *, NULL AS Col1FROM numsWHERE not (num %2 = 0 or num%3=0)	UNION ALLSELECT *, 'HI' as Col1FROM numsWHERE num % 2 = 0 and not num % 3 = 0	UNION ALLSELECT *, 'BYE' as Col1FROM numsWHERE num % 3 = 0 and not num % 2 = 0	UNION ALLSELECT *, 'HI BYE' as Col1FROM numsWHERE num % 6 = 0ORDER BY num;

/*
Question 1:
Select everything from table if ID is prime number
*/


/* CASE */

SELECT num, 	CASE 		WHEN num % 6 = 0 THEN 'HI BYE'		WHEN num % 2 = 0 THEN 'HI'		WHEN num % 3 = 0 THEN 'BYE'		ELSE NULL	END AS Col1FROM nums;SELECT num, 	IIF(num % 6 = 0, 'HI BYE',		IIF(num % 2 = 0,'HI',			IIF(num % 3 = 0, 'BYE',	NULL)			)		)	AS Col1FROM nums;/* IIF() */SELECT 
	num,
	IIF(num % 2 = 0, 'juft', 'toq') as col
FROM nums;

select 
	num,
	case when num % 2 = 0 then 'juft' else 'toq' end
from nums;



