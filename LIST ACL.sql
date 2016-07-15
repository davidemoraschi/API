/* Formatted on 09/01/2013 8:19:06 (QP5 v5.163.1008.3004) */
SELECT HOST,
       lower_port,
       upper_port,
       acl
  FROM dba_network_acls;

select * FROM dba_network_acls;
select acl , principal , privilege , is_grant from DBA_NETWORK_ACL_PRIVILEGES;
SELECT acl,
       principal,
       privilege,
       is_grant,
       TO_CHAR(start_date, 'DD-MON-YYYY') AS start_date,
       TO_CHAR(end_date, 'DD-MON-YYYY') AS end_date
FROM   dba_network_acl_privileges;

SELECT *
FROM   TABLE(DBMS_NETWORK_ACL_UTILITY.domains('192.168.2.3'));


  SELECT HOST,
         lower_port,
         upper_port,
         acl,
         DECODE (DBMS_NETWORK_ACL_ADMIN.check_privilege_aclid (aclid, 'MSTR', 'connect'),  1, 'GRANTED',  0, 'DENIED',  NULL)
            connect_PRIVILEGE,
         DECODE (DBMS_NETWORK_ACL_ADMIN.check_privilege_aclid (aclid, 'MSTR', 'resolve'),  1, 'GRANTED',  0, 'DENIED',  NULL)
            resolve_PRIVILEGE,
         DECODE (DBMS_NETWORK_ACL_ADMIN.check_privilege_aclid (aclid, 'MSTR', 'use-client-certificates'),  1, 'GRANTED',  0, 'DENIED',  NULL)
            clientcertificates_PRIVILEGE
    FROM dba_network_acls
   --WHERE HOST IN (SELECT * FROM TABLE (DBMS_NETWORK_ACL_UTILITY.domains ('10.1.10.191')))
ORDER BY DBMS_NETWORK_ACL_UTILITY.domain_level (HOST) DESC, lower_port, upper_port;