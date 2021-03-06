/* Formatted on 02/09/2012 17:05:25 (QP5 v5.139.911.3011) */
BEGIN
   DBMS_NETWORK_ACL_ADMIN.drop_acl (acl => 'pandas.xml');
END;
/

BEGIN
   --DBMS_NETWORK_ACL_ADMIN.drop_acl (acl => 'harvest_harvest.xml');
   DBMS_NETWORK_ACL_ADMIN.create_acl (acl           => 'pandas.xml',
                                      description   => 'PANDAS HTTP Access',
                                      principal     => 'MSTR',
                                      is_grant      => TRUE,
                                      PRIVILEGE     => 'connect',
                                      start_date    => NULL,
                                      end_date      => NULL);
--   DBMS_NETWORK_ACL_ADMIN.add_privilege (acl          => 'pandas.xml',
--                                         principal    => 'MSTR',
--                                         is_grant     => TRUE,
--                                         PRIVILEGE    => 'resolve',
--                                         start_date   => NULL,
--                                         end_date     => NULL);
   DBMS_NETWORK_ACL_ADMIN.assign_acl (acl => 'pandas.xml', HOST => 'localhost');
   --DBMS_NETWORK_ACL_ADMIN.assign_acl (acl => 'oracle-base.xml', HOST => 'proxy02.sas.junta-andalucia.es');
   --10.234.23.117
   COMMIT;
END;
/
BEGIN
DBMS_NETWORK_ACL_ADMIN.ASSIGN_WALLET_ACL('pandas.xml','file:/u01/app/oracle/wallet');

END;
/
EXEC DBMS_NETWORK_ACL_ADMIN.DELETE_PRIVILEGE('all_access.xml','MSTR', true, 'use-client-certificates');
EXEC DBMS_NETWORK_ACL_ADMIN.ADD_PRIVILEGE('pandas.xml','MSTR', true, 'use-client-certificates');
--EXEC DBMS_NETWORK_ACL_ADMIN.ADD_PRIVILEGE('pandas.xml','MSTR', true, 'resolve');