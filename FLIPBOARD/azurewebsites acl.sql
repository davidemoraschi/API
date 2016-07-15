/* Formatted on 14/01/2014 10:33:11 (QP5 v5.163.1008.3004) PANDAS Copyright (c) 2013 -Davide Moraschi (davidem@eurostrategy.net)
Todos los derechos reservados. Prohibida su reproducción Total o Parcial. */
BEGIN
	DBMS_NETWORK_ACL_ADMIN.drop_acl (acl => 'utl_tcp.xml');
END;
/
DECLARE
	l_acl_name VARCHAR2 (30) := 'utl_tcp.xml';
	l_ftp_server_ip VARCHAR2 (20) := '137.117.232.17';
	l_ftp_server_name VARCHAR2 (200) := 'waws-prod-am2-003.ftp.azurewebsites.windows.net';
	l_username VARCHAR2 (30) := 'FLIPBOARD';
BEGIN
	DBMS_NETWORK_ACL_ADMIN.create_acl (acl => l_acl_name
																		,description => 'Allow connections using UTL_TCP'
																		,principal => l_username
																		,is_grant => TRUE
																		,privilege => 'connect'
																		,start_date => SYSTIMESTAMP
																		,end_date => NULL);

	COMMIT;

	DBMS_NETWORK_ACL_ADMIN.add_privilege (acl => l_acl_name
																			 ,principal => l_username
																			 ,is_grant => FALSE
																			 ,privilege => 'connect'
																			 ,position => NULL
																			 ,start_date => NULL
																			 ,end_date => NULL);

	COMMIT;

	DBMS_NETWORK_ACL_ADMIN.assign_acl (acl => l_acl_name
																		,HOST => l_ftp_server_ip
																		,lower_port => NULL
																		,upper_port => NULL);

	DBMS_NETWORK_ACL_ADMIN.assign_acl (acl => l_acl_name
																		,HOST => l_ftp_server_name
																		,lower_port => NULL
																		,upper_port => NULL);

	COMMIT;
END;
/