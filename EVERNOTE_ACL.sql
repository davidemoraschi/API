/* Formatted on 09/02/2014 18:29:20 (QP5 v5.163.1008.3004) PANDAS Copyright (c) 2013 -Davide Moraschi (davidem@eurostrategy.net)
Todos los derechos reservados. Prohibida su reproducción Total o Parcial. */
BEGIN
	DBMS_NETWORK_ACL_ADMIN.drop_acl (acl => 'evernote_evernote.xml');
END;
/

BEGIN
	--DBMS_NETWORK_ACL_ADMIN.drop_acl (acl => 'harvest_harvest.xml');
	DBMS_NETWORK_ACL_ADMIN.create_acl (acl => 'evernote_evernote.xml'
																		,description => 'Evernote HTTP Access'
																		,principal => 'EVERNOTE'
																		,is_grant => TRUE
																		,PRIVILEGE => 'connect'
																		,start_date => NULL
																		,end_date => NULL);
	DBMS_NETWORK_ACL_ADMIN.add_privilege (acl => 'evernote_evernote.xml'
																			 ,principal => 'EVERNOTE'
																			 ,is_grant => TRUE
																			 ,PRIVILEGE => 'resolve'
																			 ,start_date => NULL
																			 ,end_date => NULL);
	DBMS_NETWORK_ACL_ADMIN.assign_acl (acl => 'evernote_evernote.xml', HOST => '*.evernote.com');
	--DBMS_NETWORK_ACL_ADMIN.assign_acl (acl => 'oracle-base.xml', HOST => 'proxy02.sas.junta-andalucia.es');
	--10.234.23.117
	COMMIT;
END;
/