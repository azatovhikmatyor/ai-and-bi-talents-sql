-- n = 2

select top 1 * 
from (
	select top 2 *
	from employee
	order by salary desc
) as t1
order by salary;


select * from employee where salary = (
	select top 1 salary 
	from (
		select distinct top 2 salary
		from employee
		order by salary desc
	) t1
	order by salary
);

;with t1 as (
	select distinct top 2 salary
	from employee
	order by salary desc
), t2 as (
	select top 1 salary 
	from t1
	order by salary
)
select * from employee 
where salary = (select t2.salary from t2)


-- Find second highest salary in each department

declare @n int = 3;

select * from (
	select *, DENSE_RANK() over(partition by dept_id order by salary desc) rnk
	from employee
) t
where rnk=@n;
--Must declare the scalar variable "@n".

-- ================================================












