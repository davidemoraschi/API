/* Formatted on 2010/08/11 13:48 (Formatter Plus v4.8.8) */
BEGIN
   dbms_network_acl_admin.drop_acl (acl              => 'twitter.xml');
   dbms_network_acl_admin.create_acl (acl              => 'twitter.xml'
                                     ,description      => 'twitter HTTP Access'
                                     ,principal        => 'ALMAGESTO'
                                     ,is_grant         => TRUE
                                     ,PRIVILEGE        => 'connect'
                                     ,start_date       => NULL
                                     ,end_date         => NULL);
   dbms_network_acl_admin.add_privilege (acl             => 'twitter.xml'
                                        ,principal       => 'ALMAGESTO'
                                        ,is_grant        => TRUE
                                        ,PRIVILEGE       => 'resolve'
                                        ,start_date      => NULL
                                        ,end_date        => NULL);
   dbms_network_acl_admin.assign_acl (acl => 'twitter.xml', HOST => '*.twitter.com');
   dbms_network_acl_admin.assign_acl (acl => 'twitter.xml', HOST => '10.234.23.117');
   --10.234.23.117
   COMMIT;
END;