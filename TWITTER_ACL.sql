/* Formatted on 02/09/2012 17:05:25 (QP5 v5.139.911.3011) */
BEGIN
   DBMS_NETWORK_ACL_ADMIN.drop_acl (acl => 'twitter_twitter.xml');
END;
/

BEGIN
   --DBMS_NETWORK_ACL_ADMIN.drop_acl (acl => 'harvest_harvest.xml');
   DBMS_NETWORK_ACL_ADMIN.create_acl (acl           => 'twitter_twitter.xml',
                                      description   => 'Twitter HTTP Access',
                                      principal     => 'TWITTER',
                                      is_grant      => TRUE,
                                      PRIVILEGE     => 'connect',
                                      start_date    => NULL,
                                      end_date      => NULL);
   DBMS_NETWORK_ACL_ADMIN.add_privilege (acl          => 'twitter_twitter.xml',
                                         principal    => 'TWITTER',
                                         is_grant     => TRUE,
                                         PRIVILEGE    => 'resolve',
                                         start_date   => NULL,
                                         end_date     => NULL);
   DBMS_NETWORK_ACL_ADMIN.assign_acl (acl => 'twitter_twitter.xml', HOST => '*.twitter.com');
   --DBMS_NETWORK_ACL_ADMIN.assign_acl (acl => 'oracle-base.xml', HOST => 'proxy02.sas.junta-andalucia.es');
   --10.234.23.117
   COMMIT;
END;
/