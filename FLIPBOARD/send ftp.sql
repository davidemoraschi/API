/* Formatted on 14/01/2014 10:50:22 (QP5 v5.163.1008.3004) PANDAS Copyright (c) 2013 -Davide Moraschi (davidem@eurostrategy.net)
Todos los derechos reservados. Prohibida su reproducción Total o Parcial. */
-- Retrieve an ASCII file from a remote FTP server.
create or replace procedure p_ftp_put_ascii
as
	l_conn UTL_TCP.connection;
BEGIN
	l_conn := ftp.login ('waws-prod-am2-003.ftp.azurewebsites.windows.net'
											,'21'
											,'PANDAS10\pandas'
											,'pandas10');
	ftp.ASCII (p_conn => l_conn);
	-- ftp.get (p_conn => l_conn
	--	 ,p_from_file => '/site/wwwroot/hello.htm'
	--	 ,p_to_dir => 'UPLOAD'
	--	 ,p_to_file => 'hello1.htm');
	ftp.put (p_conn => l_conn
					,p_from_dir => 'UPLOAD'
					,p_from_file => 'hello.htm'
					,p_to_file => '/site/wwwroot/hello2.htm');
	ftp.LOGOUT (l_conn);
END;
/