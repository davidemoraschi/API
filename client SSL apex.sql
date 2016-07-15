/*
SSL_CLIENT_S_DN_CN, 
SSL_CLIENT_S_DN_O,
 SSL_CLIENT_S_DN, 
 SSL_CLIENT_CERT, 
 SSL_CLIENT_I_DN_CN,
  SSL_CLIENT_S_DN_Email,
   SSL_CLIENT_I_DN_UID,
    SSL_CLIENT_I_DN 
*/

begin
DBMS_EPG.SET_DAD_ATTRIBUTE (
   dad_name    => 'APEX',
   attr_name   => 'cgi-environment-list',
   attr_value  => 'SSL_CLIENT_S_DN_CN');

DBMS_EPG.SET_DAD_ATTRIBUTE (
   dad_name    => 'APEX',
   attr_name   => 'cgi-environment-list',
   attr_value  => 'SSL_CLIENT_S_DN_O');

DBMS_EPG.SET_DAD_ATTRIBUTE (
   dad_name    => 'APEX',
   attr_name   => 'cgi-environment-list',
   attr_value  => 'SSL_CLIENT_S_DN');

DBMS_EPG.SET_DAD_ATTRIBUTE (
   dad_name    => 'APEX',
   attr_name   => 'cgi-environment-list',
   attr_value  => 'SSL_CLIENT_CERT');

DBMS_EPG.SET_DAD_ATTRIBUTE (
   dad_name    => 'APEX',
   attr_name   => 'cgi-environment-list',
   attr_value  => 'SSL_CLIENT_I_DN_CN');

DBMS_EPG.SET_DAD_ATTRIBUTE (
   dad_name    => 'APEX',
   attr_name   => 'cgi-environment-list',
   attr_value  => 'SSL_CLIENT_S_DN_Email');

DBMS_EPG.SET_DAD_ATTRIBUTE (
   dad_name    => 'APEX',
   attr_name   => 'cgi-environment-list',
   attr_value  => 'SSL_CLIENT_I_DN_UID');

DBMS_EPG.SET_DAD_ATTRIBUTE (
   dad_name    => 'APEX',
   attr_name   => 'cgi-environment-list',
   attr_value  => 'SSL_CLIENT_I_DN');
end;
/