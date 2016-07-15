/* Formatted on 02/09/2012 15:06:06 (QP5 v5.139.911.3011) */
BEGIN
   DBMS_EPG.drop_dad (dad_name => 'twitter');
END;
/

BEGIN
   DBMS_EPG.create_dad (dad_name => 'twitter', PATH => '/twitter/*');
   DBMS_EPG.authorize_dad (dad_name => 'twitter', USER => 'TWITTER');
   DBMS_EPG.set_dad_attribute (dad_name => 'twitter', attr_name => 'default-page', attr_value => 'home.htm');
   DBMS_EPG.set_dad_attribute (dad_name => 'twitter', attr_name => 'database-username', attr_value => 'TWITTER');
   DBMS_EPG.set_dad_attribute (dad_name => 'twitter', attr_name => 'nls-language', attr_value => 'american_america.al32utf8');
   DBMS_EPG.authorize_dad (dad_name => 'twitter', USER => 'TWITTER');
END;
/

SET DEFINE OFF

CREATE OR REPLACE PACKAGE TWITTER.home
IS
   PROCEDURE htm;
END home;
/

CREATE OR REPLACE PACKAGE BODY TWITTER.home
IS
   PROCEDURE htm
   IS
   BEGIN
      HTP.htmlOpen;
      HTP.headOpen;
      HTP.title ('phpinfo()');
      HTP.p ('<style type="text/css">
        body {background-color: #ffffff; color: #000000;}
        body, td, th, h1, h2 {font-family: sans-serif;}
        pre {margin: 0px; font-family: monospace;}
        a:link {color: #000099; text-decoration: none; background-color: #ffffff;}
        a:hover {text-decoration: underline;}
        table {border-collapse: collapse;}
        .center {text-align: center;}
        .center table { margin-left: auto; margin-right: auto; text-align: left;}
        .center th { text-align: center !important; }
        td, th { border: 1px solid #000000; font-size: 75%; vertical-align: baseline;}
        h1 {font-size: 150%;}
        h2 {font-size: 125%;}
        .p {text-align: left;}
        .e {background-color: #ccccff; font-weight: bold; color: #000000;}
        .h {background-color: #9999cc; font-weight: bold; color: #000000;}
        .v {background-color: #cccccc; color: #000000;}
        .vr {background-color: #cccccc; text-align: right; color: #000000;}
        img {float: right; border: 0px;}
        hr {width: 600px; background-color: #cccccc; border: 0px; height: 1px; color: #000000;}
        </style>
        <title>phpinfo()</title><meta name="ROBOTS" content="NOINDEX,FOLLOW,NOARCHIVE" />');
      HTP.headClose;
      HTP.bodyOpen;
      HTP.
      p (
         '<div class="center">
    <table border="0" cellpadding="3" width="600">
    <tr class="h"><td>
    <a href="http://www.php.net/"><img border="0" src="http://s69855.gridserver.com/gs-bin/phpinfo.php5?=PHPE9568F34-D428-11d2-A769-00AA001ACF42" alt="PHP Logo" /></a><h1 class="p">PHP Version 5.2.17</h1>
    </td></tr>
    </table><br />
    <table border="0" cellpadding="3" width="600">
    <tr><td class="e">System </td><td class="v">'
         || USER
         || ' on Linux n28 2.6.35.14mtv9 #1 SMP Thu Nov 3 01:36:17 PDT 2011 x86_64 </td></tr>

    <tr><td class="e">Build Date </td><td class="v">'
         || TO_CHAR (SYSDATE, 'Mon MM YYYY HH24:MI:SS')
         || '</td></tr>
    <tr><td class="e">Configure Command </td><td class="v"> &#039;./configure&#039;  &#039;--prefix=/usr/local/php-5.2.17&#039; &#039;--enable-cli&#039; &#039;--enable-cgi&#039; &#039;--enable-fastcgi&#039; &#039;--disable-debug&#039; &#039;--disable-rpath&#039; &#039;--disable-static&#039; &#039;--with-pic&#039; &#039;--with-openssl=/usr&#039; &#039;--enable-bcmath&#039; &#039;--with-bz2&#039; &#039;--enable-calendar&#039; &#039;--enable-ctype&#039; &#039;--with-curl&#039; &#039;--with-db4&#039; &#039;--with-zlib-dir=/usr&#039; &#039;--with-xsl&#039; &#039;--enable-exif&#039; &#039;--enable-ftp&#039; &#039;--with-gd&#039; &#039;--with-ttf&#039; &#039;--with-mime-magic=/usr/share/file/magic.mime&#039; &#039;--enable-gd-native-ttf&#039; &#039;--with-jpeg-dir=/usr&#039; &#039;--with-png-dir=/usr&#039; &#039;--with-freetype-dir=/usr&#039; &#039;--with-gettext&#039; &#039;--with-iconv&#039; &#039;--with-imap&#039; &#039;--with-kerberos=/usr&#039; &#039;--with-imap-ssl=/usr&#039; &#039;--enable-mbstring&#039; &#039;--with-mhash&#039; &#039;--with-mysql=/usr/bin/mysql_config&#039; &#039;--with-mysqli=/usr/bin/mysql_config&#039; &#039;--with-pcre-regex=/usr&#039; &#039;--with-pgsql&#039; &#039;--with-pspell=/usr&#039; &#039;--enable-sockets&#039; &#039;--enable-wddx&#039; &#039;--with-xmlrpc&#039; &#039;--with-zlib=/usr&#039; &#039;--with-pear&#039; &#039;--with-layout=GNU&#039; &#039;--with-ldap&#039; &#039;--with-sqlite&#039; &#039;--enable-pdo&#039; &#039;--with-pdo-mysql=/usr&#039; &#039;--with-pdo-pgsql=/usr&#039; &#039;--enable-soap&#039; &#039;--with-mcrypt&#039; &#039;--with-pcre-regex=/usr&#039; </td></tr>

    <tr><td class="e">Server API </td><td class="v">CGI/FastCGI </td></tr>
    <tr><td class="e">Virtual Directory Support </td><td class="v">disabled </td></tr>
    <tr><td class="e">Configuration File (php.ini) Path </td><td class="v">/usr/local/php-5.2.17/etc </td></tr>
    <tr><td class="e">Loaded Configuration File </td><td class="v">/usr/local/php-5.2.17/etc/php.ini </td></tr>
    <tr><td class="e">Scan this dir for additional .ini files </td><td class="v">(none) </td></tr>
    <tr><td class="e">additional .ini files parsed </td><td class="v">(none) </td></tr>

    <tr><td class="e">PHP API </td><td class="v">20041225 </td></tr>
    <tr><td class="e">PHP Extension </td><td class="v">20060613 </td></tr>
    <tr><td class="e">Zend Extension </td><td class="v">220060519 </td></tr>
    <tr><td class="e">Debug Build </td><td class="v">no </td></tr>
    <tr><td class="e">Thread Safety </td><td class="v">disabled </td></tr>
    <tr><td class="e">Zend Memory Manager </td><td class="v">enabled </td></tr>

    <tr><td class="e">IPv6 Support </td><td class="v">enabled </td></tr>
    <tr><td class="e">Registered PHP Streams </td><td class="v">https, ftps, compress.zlib, compress.bzip2, php, file, data, http, ftp   </td></tr>
    <tr><td class="e">Registered Stream Socket Transports </td><td class="v">tcp, udp, unix, udg, ssl, sslv3, sslv2, tls </td></tr>
    <tr><td class="e">Registered Stream Filters </td><td class="v">zlib.*, bzip2.*, convert.iconv.*, string.rot13, string.toupper, string.tolower, string.strip_tags, convert.*, consumed </td></tr>
    </table><br />   </div></body>');
      HTP.bodyClose;
      HTP.htmlClose;
   END htm;
END home;
/