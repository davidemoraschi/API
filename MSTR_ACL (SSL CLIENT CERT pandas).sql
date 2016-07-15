/* Formatted on 27/02/2013 14:06:26 (QP5 v5.163.1008.3004) */
BEGIN
   DBMS_NETWORK_ACL_ADMIN.drop_acl (acl => 'mstr_client_cert.xml');
END;
/

BEGIN
   --DBMS_NETWORK_ACL_ADMIN.drop_acl (acl => 'harvest_harvest.xml');
   DBMS_NETWORK_ACL_ADMIN.create_acl (acl           => 'mstr_client_cert.xml',
                                      description   => 'MicroStrategy REST services',
                                      principal     => 'MSTR',
                                      is_grant      => TRUE,
                                      PRIVILEGE     => 'connect',
                                      start_date    => NULL,
                                      end_date      => NULL);
--   DBMS_NETWORK_ACL_ADMIN.ADD_PRIVILEGE (acl          => 'mstr_client_cert.xml',
--                                         principal    => 'MSTR',
--                                         is_grant     => TRUE,
--                                         PRIVILEGE    => 'resolve',
--                                         start_date   => NULL,
--                                         end_date     => NULL);
   DBMS_NETWORK_ACL_ADMIN.add_privilege (acl          => 'mstr_client_cert.xml',
                                         principal    => 'MSTR',
                                         is_grant     => TRUE,
                                         PRIVILEGE    => 'use-client-certificates',
                                         start_date   => NULL,
                                         end_date     => NULL);
   --DBMS_NETWORK_ACL_ADMIN.assign_acl (acl => 'mstr_client_cert.xml', HOST => 'fraterno');
   --DBMS_NETWORK_ACL_ADMIN.assign_acl (acl => 'oracle-base.xml', HOST => 'proxy02.sas.junta-andalucia.es');
   DBMS_NETWORK_ACL_ADMIN.assign_acl (acl => 'mstr_client_cert.xml', HOST => 'pandas');
   --   DBMS_NETWORK_ACL_ADMIN.ASSIGN_WALLET_ACL ('mstr_client_cert.xml', 'file:C:\oracle\product\11.2.0');
 --  DBMS_NETWORK_ACL_ADMIN.ASSIGN_WALLET_ACL ('mstr_client_cert.xml', 'file:/u01/app/oracle/wallet');
   --10.234.23.117
   COMMIT;
END;
/
EXEC DBMS_NETWORK_ACL_ADMIN.ASSIGN_WALLET_ACL ('mstr_client_cert.xml', 'file:/u01/app/oracle/wallet');
/* http://ilmarkerm.blogspot.com.es/2012/06/using-ssl-clint-certificates-for.html

BEGIN
   --   DBMS_NETWORK_ACL_ADMIN.ADD_PRIVILEGE ('mstr.xml',
   --                                         'MSTR',
   --                                         TRUE,
   --                                         'connect');
   DBMS_NETWORK_ACL_ADMIN.ADD_PRIVILEGE (acl          => 'mstr_client_cert.xml',
                                         principal    => 'MSTR',
                                         is_grant     => TRUE,
                                         PRIVILEGE    => 'use-client-certificates',
                                         start_date   => NULL,
                                         end_date     => NULL);
END;

*/