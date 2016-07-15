/* Formatted on 27/02/2013 16:46:06 (QP5 v5.163.1008.3004) */
BEGIN
   DBMS_NETWORK_ACL_ADMIN.drop_acl (acl => 'mstr.xml');
END;
/

BEGIN
   --DBMS_NETWORK_ACL_ADMIN.drop_acl (acl => 'harvest_harvest.xml');
   DBMS_NETWORK_ACL_ADMIN.create_acl (acl           => 'mstr.xml',
                                      description   => 'MicroStrategy REST services',
                                      principal     => 'MSTR',
                                      is_grant      => TRUE,
                                      PRIVILEGE     => 'connect',
                                      start_date    => NULL,
                                      end_date      => NULL);
   --   DBMS_NETWORK_ACL_ADMIN.add_privilege (acl          => 'mstr.xml',
   --                                         principal    => 'MSTR',
   --                                         is_grant     => TRUE,
   --                                         PRIVILEGE    => 'resolve',
   --                                         start_date   => NULL,
   --                                         end_date     => NULL);
   --   DBMS_NETWORK_ACL_ADMIN.ADD_PRIVILEGE (acl          => 'mstr.xml',
   --                                         principal    => 'MSTR',
   --                                         is_grant     => TRUE,
   --                                         PRIVILEGE    => 'use-client-certificates',
   --                                         start_date   => NULL,
   --                                         end_date     => NULL);
   --   DBMS_NETWORK_ACL_ADMIN.assign_acl (acl => 'mstr.xml', HOST => 'fraterno');
   DBMS_NETWORK_ACL_ADMIN.assign_acl (acl => 'mstr.xml', HOST => 'pandas');
   --DBMS_NETWORK_ACL_ADMIN.assign_acl (acl => 'oracle-base.xml', HOST => 'proxy02.sas.junta-andalucia.es');
   --10.234.23.117
   COMMIT;
END;
/

/* http://ilmarkerm.blogspot.com.es/2012/06/using-ssl-clint-certificates-for.html */

BEGIN
   --   DBMS_NETWORK_ACL_ADMIN.ADD_PRIVILEGE ('mstr.xml',
   --                                         'MSTR',
   --                                         TRUE,
   --                                         'connect');
   DBMS_NETWORK_ACL_ADMIN.ADD_PRIVILEGE (acl          => 'mstr.xml',
                                         principal    => 'MSTR',
                                         is_grant     => TRUE,
                                         PRIVILEGE    => 'use-client-certificates',
                                         start_date   => NULL,
                                         end_date     => NULL);
END;

EXEC DBMS_NETWORK_ACL_ADMIN.ASSIGN_WALLET_ACL ('mstr.xml', 'file:/u01/app/oracle/wallet');
EXEC DBMS_NETWORK_ACL_ADMIN.UNASSIGN_WALLET_ACL ('mstr.xml', 'file:/u01/app/oracle/wallet');