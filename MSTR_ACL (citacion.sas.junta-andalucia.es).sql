/* Formatted on 12/09/2012 21:47:01 (QP5 v5.139.911.3011) */
BEGIN
   DBMS_NETWORK_ACL_ADMIN.drop_acl (acl => 'mstr_citacion.sas.junta-andalucia.es.xml');
END;
/

BEGIN
   --DBMS_NETWORK_ACL_ADMIN.drop_acl (acl => 'harvest_harvest.xml');
   DBMS_NETWORK_ACL_ADMIN.create_acl (acl           => 'mstr_citacion.sas.junta-andalucia.es.xml',
                                      description   => 'citacion.sas.junta-andalucia.es HTTP Access',
                                      principal     => 'MSTR',
                                      is_grant      => TRUE,
                                      PRIVILEGE     => 'connect',
                                      start_date    => NULL,
                                      end_date      => NULL);
   DBMS_NETWORK_ACL_ADMIN.add_privilege (acl          => 'mstr_citacion.sas.junta-andalucia.es.xml',
                                         principal    => 'MSTR',
                                         is_grant     => TRUE,
                                         PRIVILEGE    => 'resolve',
                                         start_date   => NULL,
                                         end_date     => NULL);
   DBMS_NETWORK_ACL_ADMIN.assign_acl (acl => 'mstr_citacion.sas.junta-andalucia.es.xml', HOST => '10.232.32.40');
   DBMS_NETWORK_ACL_ADMIN.assign_acl (acl => 'mstr_citacion.sas.junta-andalucia.es.xml', HOST => 'proxy02.sas.junta-andalucia.es');
   DBMS_NETWORK_ACL_ADMIN.assign_acl (acl => 'mstr_citacion.sas.junta-andalucia.es.xml', HOST => 'citacion.sas.junta-andalucia.es');
   --10.234.23.117
   COMMIT;
END;
/