-- https://www.mssqltips.com/sqlservertip/2537/sql-server-row-count-for-all-tables-in-a-database/

declare @tr varchar(max);

;with cte as (
	SELECT
			QUOTENAME(SCHEMA_NAME(sOBJ.schema_id)) + '.' + QUOTENAME(sOBJ.name) AS [TableName]
			, SUM(sPTN.Rows) AS [Rows]
	FROM 
			sys.objects AS sOBJ
			INNER JOIN sys.partitions AS sPTN
				ON sOBJ.object_id = sPTN.object_id
	WHERE
			sOBJ.type = 'U'
			AND sOBJ.is_ms_shipped = 0x0
			AND index_id < 2 -- 0:Heap, 1:Clustered
	GROUP BY 
			sOBJ.schema_id
			, sOBJ.name
)
select @tr=cast (
	(select 
		TableName as td, '',
		Rows as td
	from cte
	for xml path('tr'))
	as varchar(max)
);

declare @html_body varchar(max) = '
		<style>
			#customers {
			  font-family: Arial, Helvetica, sans-serif;
			  border-collapse: collapse;
			  width: 100%;
			}

			#customers td, #customers th {
			  border: 1px solid #ddd;
			  padding: 8px;
			}

			#customers tr:nth-child(even){background-color: #f2f2f2;}

			#customers tr:hover {background-color: #ddd;}

			#customers th {
			  padding-top: 12px;
			  padding-bottom: 12px;
			  text-align: left;
			  background-color: #04AA6D;
			  color: white;
			}
			</style>
			</head>
			<body>

			<h1>A Fancy Table</h1>

			<table id="customers">
			  <tr>
				<th>Table Name</th>
				<th>Rows</th>
			  </tr>
			  ' +@tr +
			  '
			</table>

			</body>
'

exec msdb.dbo.sp_send_dbmail
	@profile_name = 'GmailProfile',
	@recipients = 'azatovhikmatyor@outlook.com;dilmurodovsohibjon@gmail.com',
	@subject = 'This is test from sql server',
	@body = @html_body,
	@body_format = 'HTML'


