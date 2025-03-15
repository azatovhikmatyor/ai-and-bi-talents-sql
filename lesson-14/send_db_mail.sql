
exec msdb.dbo.sp_send_dbmail
	@profile_name = 'NewProfile',
	@recipients = 'azatovhikmatyor@outlook.com;dilmurodovsohibjon@gmail.com',
	@subject = 'This is test from sql server',
	@body = 'Lorem ipsum dolor ...'


SELECT 
    sent_status, 
    * 
FROM msdb.dbo.sysmail_allitems 
ORDER BY send_request_date DESC;


SELECT * FROM msdb.dbo.sysmail_event_log 
ORDER BY log_date DESC;



