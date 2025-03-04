
;with hire_years as (
	select distinct year(hire_date) y
	from EMPLOYEES_N
), all_years as (
	select 1974 + ordinal as y
	from string_split(replicate(',', year(getdate()) - 1975), ',', 1)
), not_hire_years as (
	select a.y
	from all_years a
	left join hire_years b
		on a.y = b.y
	where b.y is null
)
select concat(min(y), '-', max(y))
from (
	select y,
		y - ROW_NUMBER() over (order by y) as grp
	from not_hire_years
) t
group by grp;




