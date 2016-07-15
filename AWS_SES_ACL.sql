/* Formatted on 12/09/2012 21:47:01 (QP5 v5.139.911.3011) */
BEGIN
   DBMS_NETWORK_ACL_ADMIN.drop_acl (acl => 'aws_ses_amazonaws.xml');
END;
/

BEGIN
   --DBMS_NETWORK_ACL_ADMIN.drop_acl (acl => 'harvest_harvest.xml');
   DBMS_NETWORK_ACL_ADMIN.create_acl (acl           => 'aws_ses_amazonaws.xml',
                                      description   => 'Amazon AWS HTTP Access',
                                      principal     => 'AWS_SES',
                                      is_grant      => TRUE,
                                      PRIVILEGE     => 'connect',
                                      start_date    => NULL,
                                      end_date      => NULL);
   DBMS_NETWORK_ACL_ADMIN.add_privilege (acl          => 'aws_ses_amazonaws.xml',
                                         principal    => 'AWS_SES',
                                         is_grant     => TRUE,
                                         PRIVILEGE    => 'resolve',
                                         start_date   => NULL,
                                         end_date     => NULL);
   DBMS_NETWORK_ACL_ADMIN.assign_acl (acl => 'aws_ses_amazonaws.xml', HOST => '*.amazonaws.com');
   --DBMS_NETWORK_ACL_ADMIN.assign_acl (acl => 'oracle-base.xml', HOST => 'proxy02.sas.junta-andalucia.es');
   --10.234.23.117
   COMMIT;
END;
/