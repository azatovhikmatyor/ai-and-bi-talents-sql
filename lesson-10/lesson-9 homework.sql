
-- Given this Employee table below, find the level of depth each employee from the President.

select *, 0 as depth from Employees where ManagerID is null

UNION ALL

select emp.*, 1 as depth from Employees emp
join (
	select EmployeeID from Employees where ManagerID is null
) mgr
	on emp.ManagerID = mgr.EmployeeID

UNION ALL

select emp.*, 2 as depth from Employees emp
join (
	select emp.EmployeeID from Employees emp
		join (
			select EmployeeID from Employees where ManagerID is null
		) mgr
			on emp.ManagerID = mgr.EmployeeID
) mgr
	on emp.ManagerID = mgr.EmployeeID

UNION ALL
	
select emp.*, 3 as depth from Employees emp
join (
	select emp.EmployeeID from Employees emp
	join (
		select emp.EmployeeID from Employees emp
			join (
				select EmployeeID from Employees where ManagerID is null
			) mgr
				on emp.ManagerID = mgr.EmployeeID
	) mgr
		on emp.ManagerID = mgr.EmployeeID
) mgr
	on emp.ManagerID = mgr.EmployeeID

---


;with cte as (
	select *, 0 as depth from Employees where ManagerID is null

	union all

	select emp.*, depth + 1 as depth from Employees emp
	join cte mgr
		on emp.ManagerID = mgr.EmployeeID
)
select * from cte;
