/* Formatted on 15/12/2013 14:11:15 (QP5 v5.163.1008.3004) */
BEGIN
   DBMS_NETWORK_ACL_ADMIN.drop_acl (acl => 'mstr_cloudapp.xml');
END;
/

BEGIN
   --DBMS_NETWORK_ACL_ADMIN.drop_acl (acl => 'harvest_harvest.xml');
   DBMS_NETWORK_ACL_ADMIN.create_acl (acl => 'mstr_cloudapp.xml', description => 'Cloudapp.net HTTP Access', principal => 'MSTR', is_grant => TRUE, PRIVILEGE => 'connect', start_date => NULL, end_date => NULL);
   DBMS_NETWORK_ACL_ADMIN.add_privilege (acl => 'mstr_cloudapp.xml', principal => 'MSTR', is_grant => TRUE, PRIVILEGE => 'resolve', start_date => NULL, end_date => NULL);
   -- DBMS_NETWORK_ACL_ADMIN.assign_acl (acl => 'mstr_cloudapp.xml', HOST => '10.232.32.179');
   --DBMS_NETWORK_ACL_ADMIN.assign_acl (acl => 'mstr_cloudapp.xml', HOST => 'proxy02.sas.junta-andalucia.es');
   DBMS_NETWORK_ACL_ADMIN.assign_acl (acl => 'mstr_cloudapp.xml', HOST => '*.cloudapp.net');
   --10.234.23.117
   COMMIT;
END;
/