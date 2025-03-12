-- Functions
-- 1. Scalar function
-- 2. Table Valued function
	-- 2.1 Inline
	-- 2.2 Multiline

create database class13
go
use class13

go
create function makesquare(@num int)
returns int
as
begin
	return @num*@num;
end;

go

alter function makesquare(@num int = NULL)
returns int
as
begin
/*
	if @num is null
	begin
		return 0;
	end
	return @num * @num;
*/
	--return iif(@num is null, 0, @num * @num);
	return case when @num is null then 0 else @num * @num end;
end;

go

select dbo.makesquare(1.4)

select brand_id, dbo.makesquare(brand_id) from [BikeStores].[production].[brands]


--- 

create table emails
(
	id int,
	email varchar(255)
);

insert into emails
values 
	(1, 'example1@gmail.com'),
	(2, 'example2@gmail.com
	'),
	(3, 'example3@gmail.com
'),
	(4, '	example4@gmail.com')


go

create function dbo.clean_field(@field nvarchar(255))
returns nvarchar(max)
as
begin
	return trim(replace(
		replace(
			replace(@field, char(13), ''),
			char(9), ''
		),
		char(10), ''
	))
end

go


select *
from emails where dbo.clean_field(email) = 'example2@gmail.com'

----


-- 2. Table Valued function

-- 2.1 Inline
alter function my_tvf(@store_id int)
returns table
as
return
(
	select *
	from [BikeStores].[sales].[orders] 
	where store_id = isnull(@store_id, store_id)
	--where store_id = store_id -- TRUE
)

go

select * from my_tvf(1)

go

-- 2.2 Multiline


CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    FullName VARCHAR(100) NOT NULL,
    Department VARCHAR(50) NOT NULL
);

CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY IDENTITY(1,1),
    ProjectName VARCHAR(100) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NULL
);

CREATE TABLE EmployeeProjects (
    EmployeeID INT FOREIGN KEY REFERENCES Employees(EmployeeID),
    ProjectID INT FOREIGN KEY REFERENCES Projects(ProjectID),
    Role VARCHAR(50),
    HoursWorked DECIMAL(10,2),
    PRIMARY KEY (EmployeeID, ProjectID)
);


INSERT INTO Employees (FullName, Department) VALUES
    ('Alice Johnson', 'IT'),
    ('Bob Smith', 'IT'),
    ('Charlie Brown', 'HR'),
    ('David White', 'Finance');

INSERT INTO Projects (ProjectName, StartDate, EndDate) VALUES
    ('ERP System', '2023-01-01', '2024-06-30'),
    ('Website Redesign', '2023-05-15', '2023-12-31'),
    ('HR Automation', '2023-07-01', '2024-03-15'),
    ('Financial Forecasting', '2023-08-01', NULL); -- Ongoing project

INSERT INTO EmployeeProjects (EmployeeID, ProjectID, Role, HoursWorked) VALUES
    (1, 1, 'Developer', 400),
    (1, 2, 'Lead Developer', 300),
    (2, 1, 'QA Engineer', 250),
    (2, 3, 'Consultant', 150),
    (3, 3, 'HR Specialist', 350),
    (4, 4, 'Analyst', 200);


select * from EmployeeProjects
select * from Projects
select * from Employees

-- EmployeeName, Department, TotalProject, TotalHoursWorked, LatestProjectEndDate

create function getDetails()returns TABLEASRETURN (select     FullName,    Department,    sum(HoursWorked) over(partition by ep.EmployeeID) as TotalHoursWorked,    LAST_VALUE(ProjectName) over(partition by ep.EmployeeID order by EndDate rows between unbounded preceding and unbounded following ) as LastProjectNamefrom    EmployeeProjects as ep     join    Employees as e on ep.EmployeeID = e.EmployeeID    JOIN    Projects as p on ep.ProjectID = p.ProjectID)GOcreate function getDetails2()returns @newtable TABLE(    FullName VARCHAR(100),    Department VARCHAR(50),    TotalHoursWorked DECIMAL(10,2),    LastProjectName VARCHAR(100))ASBegininsert into @newtableselect     FullName,    Department,    sum(HoursWorked) over(partition by ep.EmployeeID) as TotalHoursWorked,    LAST_VALUE(ProjectName) over(partition by ep.EmployeeID order by EndDate rows between unbounded preceding and unbounded following ) as LastProjectNamefrom    EmployeeProjects as ep     join    Employees as e on ep.EmployeeID = e.EmployeeID    JOIN    Projects as p on ep.ProjectID = p.ProjectIDreturn ENDGOselect * from getDetails2()