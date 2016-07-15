/* Formatted on 17/09/2012 23:02:29 (QP5 v5.139.911.3011) */
SET DEFINE OFF

CREATE OR REPLACE PACKAGE AWS_SES.home
IS
   PROCEDURE htm;
END home;
/

CREATE OR REPLACE PACKAGE BODY AWS_SES.home
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

CREATE OR REPLACE PACKAGE AWS_SES.sendmail
IS
   PROCEDURE jsp (p_Sender      IN VARCHAR2,
                  p_Recipient   IN VARCHAR2,
                  p_Subject     IN VARCHAR2,
                  p_Html_Body   IN CLOB);

   PROCEDURE aspx (p_Sender      IN VARCHAR2,
                   p_Recipient   IN VARCHAR2,
                   p_Subject     IN VARCHAR2,
                   p_Html_Body   IN CLOB);

   PROCEDURE php (p_Sender      IN VARCHAR2,
                  p_Recipient   IN VARCHAR2,
                  p_Subject     IN VARCHAR2,
                  p_Html_Body   IN CLOB);

   PROCEDURE htm;

   PROCEDURE html;
END sendmail;
/


CREATE OR REPLACE PACKAGE BODY AWS_SES.sendmail
IS
   PROCEDURE jsp (p_Sender      IN VARCHAR2,
                  p_Recipient   IN VARCHAR2,
                  p_Subject     IN VARCHAR2,
                  p_Html_Body   IN CLOB)
   IS
      --BEGIN
      var_str_AmazonSES_api_Endpoint   VARCHAR2 (1000) := 'https://email.us-east-1.amazonaws.com/';
      var_str_AmazonSES_api_Action     VARCHAR2 (1000) := 'Action=SendEmail';
      var_str_AmazonSES_api_url        CLOB--VARCHAR2 (32767)
                                          :=    var_str_AmazonSES_api_Endpoint
                                             || '?'
                                             || var_str_AmazonSES_api_Action
                                             || '&Source='
                                             || UTL_URL.escape (p_Sender)
                                             || '&Destination.ToAddresses.member.1='
                                             || UTL_URL.escape (p_Recipient)
                                             || '&Message.Subject.Data='
                                             || UTL_URL.escape (p_Subject)
                                             || '&Message.Body.Html.Data='
                                             || UTL_URL.escape (p_Html_Body, true);
--                                             || REPLACE(REPLACE(REPLACE(UTL_URL.escape (p_Html_Body),'=','%3d'),';','%3b'),'/','%2f');--
      http_method                      CONSTANT VARCHAR2 (5) := 'GET';
      http_req                         UTL_HTTP.req;
      http_resp                        UTL_HTTP.resp;
      var_http_header_name             VARCHAR2 (255);
      var_http_header_value            VARCHAR2 (1023);
      var_str_AWSDateHeader            VARCHAR2 (250)
                                          := TO_CHAR (SYSTIMESTAMP, 'Dy, DD Mon YYYY HH24:MI:SS ', 'NLS_DATE_LANGUAGE=ENGLISH')
                                             || REPLACE (TO_CHAR (SYSTIMESTAMP, 'TZR', 'NLS_DATE_LANGUAGE=ENGLISH'), ':', '');
      var_str_AWSRequestSignature      VARCHAR2 (2500);
      var_str_XAmznAuthorization       VARCHAR2 (2500);
      var_http_resp_value              VARCHAR2 (32767);

      l_clob                           CLOB;
      l_xml                            XMLTYPE;
   BEGIN
      --UTL_HTTP.set_proxy (OAUTH.global_constants.con_str_http_proxy);
      UTL_HTTP.
      set_wallet (PATH => OAUTH.global_constants.con_str_wallet_path, password => OAUTH.global_constants.con_str_wallet_pass);
      UTL_HTTP.set_response_error_check (FALSE);
      UTL_HTTP.set_detailed_excp_support (FALSE);

      var_str_AWSRequestSignature :=
         UTL_RAW.
         cast_to_varchar2 (
            UTL_ENCODE.
            base64_encode (
               DBMS_CRYPTO.
               mac (UTL_I18N.string_to_raw (var_str_AWSDateHeader, 'AL32UTF8'),
                    DBMS_CRYPTO.hmac_sh1,
                    UTL_I18N.string_to_raw (OAUTH.global_constants.con_str_AWSSecretKeyId, 'AL32UTF8'))));

      var_str_XAmznAuthorization :=
            'AWS3-HTTPS AWSAccessKeyId='
         || OAUTH.global_constants.con_str_AWSAccessKeyId
         || ', Algorithm=HmacSHA1, Signature='
         || var_str_AWSRequestSignature;

      --      DBMS_OUTPUT.put_line ('var_str_AmazonSES_api_url: ' || var_str_AmazonSES_api_url);
      --      DBMS_OUTPUT.put_line ('var_str_AWSDateHeader: ' || var_str_AWSDateHeader);
      --      DBMS_OUTPUT.put_line ('var_str_AWSRequestSignature: ' || var_str_AWSRequestSignature);
      --      DBMS_OUTPUT.put_line ('var_str_XAmznAuthorization: ' || var_str_XAmznAuthorization);

      http_req := UTL_HTTP.begin_request (var_str_AmazonSES_api_url, http_method, UTL_HTTP.http_version_1_1);
      UTL_HTTP.set_header (r => http_req, name => 'Date', VALUE => var_str_AWSDateHeader);
      UTL_HTTP.set_header (r => http_req, name => 'X-Amzn-Authorization', VALUE => var_str_XAmznAuthorization);
      http_resp := UTL_HTTP.get_response (http_req);

      FOR i IN 1 .. UTL_HTTP.get_header_count (http_resp)
      LOOP
         UTL_HTTP.get_header (http_resp,
                              i,
                              var_http_header_name,
                              var_http_header_value);
      --HTP.p ('<hr />'||var_http_header_name || var_http_header_value);
      END LOOP;

      --DBMS_LOB.createtemporary (l_clob, FALSE);

      BEGIN
         WHILE TRUE
         LOOP
            UTL_HTTP.read_line (http_resp, var_http_resp_value, TRUE);
            --HTP.p ('<hr />'||UTL_URL.unescape(var_http_resp_value));
            --DBMS_LOB.writeappend (l_clob, LENGTH (var_http_resp_value), var_http_resp_value);
         END LOOP;
      EXCEPTION
         WHEN UTL_HTTP.end_of_body
         THEN
            NULL;
      END;

      --l_xml := xmltype (l_clob);
      UTL_HTTP.end_response (http_resp);
      --DBMS_OUTPUT.put_line (l_xml.getclobval ());
      --HTP.p (UTL_URL.unescape(var_str_AmazonSES_api_url));
      HTP.P('<ok />');
      --DBMS_LOB.freetemporary (l_clob);
   EXCEPTION
      WHEN OTHERS
      THEN
         error_handler.jsp (SQLCODE, SQLERRM, DBMS_UTILITY.format_error_backtrace);
   END jsp;

   PROCEDURE aspx (p_Sender      IN VARCHAR2,
                  p_Recipient   IN VARCHAR2,
                  p_Subject     IN VARCHAR2,
                  p_Html_Body   IN CLOB)
   IS
      --BEGIN
      var_str_AmazonSES_api_Endpoint   VARCHAR2 (1000) := 'https://email.us-east-1.amazonaws.com/';
      var_str_AmazonSES_api_Action     VARCHAR2 (1000) := 'Action=SendEmail';
      var_str_AmazonSES_api_url        CLOB--VARCHAR2 (32767)
                                          :=    var_str_AmazonSES_api_Endpoint;
                                             --|| '?'
                                             --|| var_str_AmazonSES_api_Action;
                                             /*
                                             || '&Source='
                                             || UTL_URL.escape (p_Sender)
                                             || '&Destination.ToAddresses.member.1='
                                             || UTL_URL.escape (p_Recipient)
                                             || '&Message.Subject.Data='
                                             || UTL_URL.escape (p_Subject)
                                             || '&Message.Body.Html.Data='
                                             || UTL_URL.escape (p_Html_Body, true);*/

      http_method                      CONSTANT VARCHAR2 (5) := 'POST';
      http_req                         UTL_HTTP.req;
      http_resp                        UTL_HTTP.resp;
      var_http_header_name             VARCHAR2 (255);
      var_http_header_value            VARCHAR2 (1023);
      var_str_AWSDateHeader            VARCHAR2 (250)
                                          := TO_CHAR (SYSTIMESTAMP, 'Dy, DD Mon YYYY HH24:MI:SS ', 'NLS_DATE_LANGUAGE=ENGLISH')
                                             || REPLACE (TO_CHAR (SYSTIMESTAMP, 'TZR', 'NLS_DATE_LANGUAGE=ENGLISH'), ':', '');
      var_str_AWSRequestSignature      VARCHAR2 (2500);
      var_str_XAmznAuthorization       VARCHAR2 (2500);
      var_http_post_data               VARCHAR2 (32767);
      var_http_resp_value              VARCHAR2 (32767);

      l_clob                           CLOB;
      l_xml                            XMLTYPE;
   BEGIN
      --UTL_HTTP.set_proxy (OAUTH.global_constants.con_str_http_proxy);
      UTL_HTTP.
      set_wallet (PATH => OAUTH.global_constants.con_str_wallet_path, password => OAUTH.global_constants.con_str_wallet_pass);
      UTL_HTTP.set_response_error_check (FALSE);
      UTL_HTTP.set_detailed_excp_support (FALSE);

      var_str_AWSRequestSignature :=
         UTL_RAW.
         cast_to_varchar2 (
            UTL_ENCODE.
            base64_encode (
               DBMS_CRYPTO.
               mac (UTL_I18N.string_to_raw (var_str_AWSDateHeader, 'AL32UTF8'),
                    DBMS_CRYPTO.hmac_sh1,
                    UTL_I18N.string_to_raw (OAUTH.global_constants.con_str_AWSSecretKeyId, 'AL32UTF8'))));

      var_str_XAmznAuthorization :=
            'AWS3-HTTPS AWSAccessKeyId='
         || OAUTH.global_constants.con_str_AWSAccessKeyId
         || ', Algorithm=HmacSHA1, Signature='
         || var_str_AWSRequestSignature;
         
         var_http_post_data:='Action=SendEmail&Destination.ToAddresses.member.1='|| UTL_URL.escape (p_Recipient)|| '&Source='
                                             || UTL_URL.escape (p_Sender)|| '&Message.Subject.Data='
                                             || UTL_URL.escape (p_Subject)|| '&Message.Body.Html.Data='
                                             || UTL_URL.escape (p_Html_Body, true);

      --      DBMS_OUTPUT.put_line ('var_str_AmazonSES_api_url: ' || var_str_AmazonSES_api_url);
      --      DBMS_OUTPUT.put_line ('var_str_AWSDateHeader: ' || var_str_AWSDateHeader);
      --      DBMS_OUTPUT.put_line ('var_str_AWSRequestSignature: ' || var_str_AWSRequestSignature);
      --      DBMS_OUTPUT.put_line ('var_str_XAmznAuthorization: ' || var_str_XAmznAuthorization);

      http_req := UTL_HTTP.begin_request (var_str_AmazonSES_api_url, http_method, UTL_HTTP.http_version_1_1);
      UTL_HTTP.set_header (r => http_req, name => 'Date', VALUE => var_str_AWSDateHeader);
      UTL_HTTP.set_header (r => http_req, name => 'X-Amzn-Authorization', VALUE => var_str_XAmznAuthorization);
      
      UTL_HTTP.set_header (r => http_req, name => 'Content-Type', VALUE => 'application/x-www-form-urlencoded');
      UTL_HTTP.set_header (r => http_req, name => 'Content-Length', VALUE => length(var_http_post_data));
      
      UTL_HTTP.WRITE_TEXT (r => http_req, data   =>  var_http_post_data);
/*
UTL_HTTP.SET_HEADER (r      =>  req, 
                     name   =>  'Content-Type',   
                     value  =>  'application/x-www-form-urlencoded');
UTL_HTTP.SET_HEADER (r      =>   req, 
                     name   =>   'Content-Length', 
                     value  =>'  <length of data posted in bytes>');
UTL_HTTP.WRITE_TEXT (r      =>   req, 
                     data   =>   'p1 = value1&p2=value2...');
*/      
      http_resp := UTL_HTTP.get_response (http_req);

      FOR i IN 1 .. UTL_HTTP.get_header_count (http_resp)
      LOOP
         UTL_HTTP.get_header (http_resp,
                              i,
                              var_http_header_name,
                              var_http_header_value);
      HTP.p ('<hr />'||var_http_header_name || var_http_header_value);
      END LOOP;

      --DBMS_LOB.createtemporary (l_clob, FALSE);

      BEGIN
         WHILE TRUE
         LOOP
            UTL_HTTP.read_line (http_resp, var_http_resp_value, TRUE);
            HTP.p ('<hr />'||UTL_URL.unescape(var_http_resp_value));
            --DBMS_LOB.writeappend (l_clob, LENGTH (var_http_resp_value), var_http_resp_value);
         END LOOP;
      EXCEPTION
         WHEN UTL_HTTP.end_of_body
         THEN
            NULL;
      END;

      --l_xml := xmltype (l_clob);
      UTL_HTTP.end_response (http_resp);
      --DBMS_OUTPUT.put_line (l_xml.getclobval ());
      HTP.p (UTL_URL.unescape(var_str_AmazonSES_api_url));
      --HTP.P('<ok />');
      --DBMS_LOB.freetemporary (l_clob);
   EXCEPTION
      WHEN OTHERS
      THEN
         error_handler.jsp (SQLCODE, SQLERRM, DBMS_UTILITY.format_error_backtrace);
   END aspx;

   PROCEDURE php (p_Sender      IN VARCHAR2,
                  p_Recipient   IN VARCHAR2,
                  p_Subject     IN VARCHAR2,
                  p_Html_Body   IN CLOB)
   IS
      --BEGIN
      var_str_AmazonSES_api_Endpoint   VARCHAR2 (1000) := 'https://email.us-east-1.amazonaws.com/';
      var_str_AmazonSES_api_Action     VARCHAR2 (1000) := 'Action=SendRawEmail';
      var_str_AmazonSES_api_url        CLOB--VARCHAR2 (32767)
                                          :=    var_str_AmazonSES_api_Endpoint
                                             || '?'
                                             || var_str_AmazonSES_api_Action;
                                             /*
                                             || '&Source='
                                             || UTL_URL.escape (p_Sender)
                                             || '&Destination.ToAddresses.member.1='
                                             || UTL_URL.escape (p_Recipient)
                                             || '&Message.Subject.Data='
                                             || UTL_URL.escape (p_Subject)
                                             || '&Message.Body.Html.Data='
                                             || UTL_URL.escape (p_Html_Body, true);*/

      http_method                      CONSTANT VARCHAR2 (5) := 'POST';
      http_req                         UTL_HTTP.req;
      http_resp                        UTL_HTTP.resp;
      var_http_header_name             VARCHAR2 (255);
      var_http_header_value            VARCHAR2 (1023);
      var_str_AWSDateHeader            VARCHAR2 (250)
                                          := TO_CHAR (SYSTIMESTAMP, 'Dy, DD Mon YYYY HH24:MI:SS ', 'NLS_DATE_LANGUAGE=ENGLISH')
                                             || REPLACE (TO_CHAR (SYSTIMESTAMP, 'TZR', 'NLS_DATE_LANGUAGE=ENGLISH'), ':', '');
      var_str_AWSRequestSignature      VARCHAR2 (2500);
      var_str_XAmznAuthorization       VARCHAR2 (2500);
      var_http_post_data               VARCHAR2 (32767);
      var_http_resp_value              VARCHAR2 (32767);

      l_clob                           CLOB;
      l_xml                            XMLTYPE;
      r RAW(32767);
   BEGIN
      --UTL_HTTP.set_proxy (OAUTH.global_constants.con_str_http_proxy);
      UTL_HTTP.
      set_wallet (PATH => OAUTH.global_constants.con_str_wallet_path, password => OAUTH.global_constants.con_str_wallet_pass);
      UTL_HTTP.set_response_error_check (FALSE);
      UTL_HTTP.set_detailed_excp_support (FALSE);

      var_str_AWSRequestSignature :=
         UTL_RAW.
         cast_to_varchar2 (
            UTL_ENCODE.
            base64_encode (
               DBMS_CRYPTO.
               mac (UTL_I18N.string_to_raw (var_str_AWSDateHeader, 'AL32UTF8'),
                    DBMS_CRYPTO.hmac_sh1,
                    UTL_I18N.string_to_raw (OAUTH.global_constants.con_str_AWSSecretKeyId, 'AL32UTF8'))));

      var_str_XAmznAuthorization :=
            'AWS3-HTTPS AWSAccessKeyId='
         || OAUTH.global_constants.con_str_AWSAccessKeyId
         || ', Algorithm=HmacSHA1, Signature='
         || var_str_AWSRequestSignature;
         
         var_http_post_data:=--'Action=SendRawEmail'
        /* 'Destination.ToAddresses.member.1='|| UTL_URL.escape (p_Recipient)
         || '&Source='
                                             || UTL_URL.escape (p_Sender)/*|| '&Message.Subject.Data='
                                             || '&Destination.member.1='
                                             || (p_Recipient)
                                             /*|| UTL_URL.escape (p_Subject)*/
                                             'RawMessage.Data='|| UTL_URL.escape(utl_raw.cast_to_varchar2(utl_encode.base64_encode(utl_raw.cast_to_raw(--utl_raw.cast_to_varchar2(utl_encode.base64_encode(utl_raw.cast_to_raw(
                                             p_Html_Body
            ))), true);--);--||utl_encode.base64_encode(utl_raw.cast_to_raw('Hello'));
                                            -- || p_Html_Body;
                                            -- r := utl_raw.cast_to_raw(var_http_post_data);
                                            -- r := utl_encode.base64_encode(r);

      --      DBMS_OUTPUT.put_line ('var_str_AmazonSES_api_url: ' || var_str_AmazonSES_api_url);
      --      DBMS_OUTPUT.put_line ('var_str_AWSDateHeader: ' || var_str_AWSDateHeader);
      --      DBMS_OUTPUT.put_line ('var_str_AWSRequestSignature: ' || var_str_AWSRequestSignature);
      --      DBMS_OUTPUT.put_line ('var_str_XAmznAuthorization: ' || var_str_XAmznAuthorization);

      http_req := UTL_HTTP.begin_request (var_str_AmazonSES_api_url, http_method, UTL_HTTP.http_version_1_1);
      UTL_HTTP.set_header (r => http_req, name => 'Date', VALUE => var_str_AWSDateHeader);
      UTL_HTTP.set_header (r => http_req, name => 'X-Amzn-Authorization', VALUE => var_str_XAmznAuthorization);
      
      UTL_HTTP.set_header (r => http_req, name => 'Content-Type', VALUE => 'application/x-www-form-urlencoded');
      UTL_HTTP.set_header (r => http_req, name => 'Content-Length', VALUE => length(var_http_post_data));
      
      UTL_HTTP.WRITE_TEXT (r => http_req, data   =>  var_http_post_data);
/*
UTL_HTTP.SET_HEADER (r      =>  req, 
                     name   =>  'Content-Type',   
                     value  =>  'application/x-www-form-urlencoded');
UTL_HTTP.SET_HEADER (r      =>   req, 
                     name   =>   'Content-Length', 
                     value  =>'  <length of data posted in bytes>');
UTL_HTTP.WRITE_TEXT (r      =>   req, 
                     data   =>   'p1 = value1&p2=value2...');
*/      
      http_resp := UTL_HTTP.get_response (http_req);

      FOR i IN 1 .. UTL_HTTP.get_header_count (http_resp)
      LOOP
         UTL_HTTP.get_header (http_resp,
                              i,
                              var_http_header_name,
                              var_http_header_value);
      --HTP.p ('<hr />'||var_http_header_name || var_http_header_value);
      END LOOP;

      --DBMS_LOB.createtemporary (l_clob, FALSE);

      BEGIN
         WHILE TRUE
         LOOP
            UTL_HTTP.read_line (http_resp, var_http_resp_value, TRUE);
            --HTP.p ('<hr />'||UTL_URL.unescape(var_http_resp_value));
            --DBMS_LOB.writeappend (l_clob, LENGTH (var_http_resp_value), var_http_resp_value);
         END LOOP;
      EXCEPTION
         WHEN UTL_HTTP.end_of_body
         THEN
            NULL;
      END;

      --l_xml := xmltype (l_clob);
      UTL_HTTP.end_response (http_resp);
      --DBMS_OUTPUT.put_line (l_xml.getclobval ());
      --HTP.p ((var_str_AmazonSES_api_url||' - ' ||var_http_post_data));
      --HTP.P('<ok />');
      --DBMS_LOB.freetemporary (l_clob);
   EXCEPTION
      WHEN OTHERS
      THEN
         error_handler.jsp (SQLCODE, SQLERRM, DBMS_UTILITY.format_error_backtrace);
   END php;

   PROCEDURE htm
   IS
   BEGIN
      HTP.p ('<html>
<head>
<title>Example html forms</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body bgcolor="#FFFFFF" text="#000000">
<table width="480" border="0" align="center">
  <tr>
    <td height="127" colspan="2">
      <H2>Fill-Out Form Example #1 </H2>
      This is a very simple fill-out form example. 
      <P>
      <FORM action=sendmail.php method=post>
        A single text entry field goes here: 
        <INPUT name=p_Sender>
        <INPUT name=p_Recipient>
        <INPUT name=p_Subject>
        <TEXTAREA name=p_Html_Body></TEXTAREA>
        <P>Note that it has no default value but one  could easily be added. 
        <P>To submit the query, press this button: 
          <INPUT type=submit value="Submit Query">
      </FORM>
    </td>
  </tr>
</table>
</body>
</html>
');
   END;
procedure html
is
begin
htp.p('<img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAUA
AAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO
9TXL0Y4OHwAAAABJRU5ErkJggg==" alt="Red dot">');
end;
END sendmail;
/

GRANT EXECUTE ON AWS_SES.sendmail TO PUBLIC;

CREATE OR REPLACE PACKAGE AWS_SES.error_handler
IS
   --      con_str_hostname_port   CONSTANT VARCHAR2 (1024) := 'http://eurostrategy.net:8181';
   PROCEDURE jsp (p_error_code      IN VARCHAR2 DEFAULT NULL,
                  p_error_message   IN VARCHAR2 DEFAULT NULL,
                  p_stack_trace     IN VARCHAR2 DEFAULT NULL);
--   PROCEDURE test;
--
--   PROCEDURE add_gcal_error_event (p_error_code      IN VARCHAR2 DEFAULT NULL,
--                                   p_error_message   IN VARCHAR2 DEFAULT NULL,
--                                   p_stack_trace     IN VARCHAR2 DEFAULT NULL);
END;
/

--DROP PACKAGE BODY TWITTER.ERROR_HANDLER;

CREATE OR REPLACE PACKAGE BODY AWS_SES.error_handler
IS
   PROCEDURE jsp (p_error_code      IN VARCHAR2 DEFAULT NULL,
                  p_error_message   IN VARCHAR2 DEFAULT NULL,
                  p_stack_trace     IN VARCHAR2 DEFAULT NULL)
   IS
   BEGIN
      HTP.
      p (
         '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"> 
        <html xmlns="http://www.w3.org/1999/xhtml"> 
        <head> 
        <title>IIS 7.0 Detailed Error - 404.0 - Not Found</title> 
        <style type="text/css"> 
        <!-- 
        body{margin:0;font-size:.7em;font-family:Verdana,Arial,Helvetica,sans-serif;background:#CBE1EF;} 
        code{margin:0;color:#006600;font-size:1.1em;font-weight:bold;} 
        .config_source code{font-size:.8em;color:#000000;} 
        pre{margin:0;font-size:1.4em;word-wrap:break-word;} 
        ul,ol{margin:10px 0 10px 40px;} 
        ul.first,ol.first{margin-top:5px;} 
        fieldset{padding:0 15px 10px 15px;} 
        .summary-container fieldset{padding-bottom:5px;margin-top:4px;} 
        legend.no-expand-all{padding:2px 15px 4px 10px;margin:0 0 0 -12px;} 
        legend{color:#333333;padding:4px 15px 4px 10px;margin:4px 0 8px -12px;_margin-top:0px; 
         border-top:1px solid #EDEDED;border-left:1px solid #EDEDED;border-right:1px solid #969696; 
         border-bottom:1px solid #969696;background:#E7ECF0;font-weight:bold;font-size:1em;} 
        a:link,a:visited{color:#007EFF;font-weight:bold;} 
        a:hover{text-decoration:none;} 
        h1{font-size:2.4em;margin:0;color:#FFF;} 
        h2{font-size:1.7em;margin:0;color:#CC0000;} 
        h3{font-size:1.4em;margin:10px 0 0 0;color:#CC0000;} 
        h4{font-size:1.2em;margin:10px 0 5px 0; 
        }#header{width:96%;margin:0 0 0 0;padding:6px 2% 6px 2%;font-family:"trebuchet MS",Verdana,sans-serif; 
         color:#FFF;background-color:#5C87B2; 
        }#content{margin:0 0 0 2%;position:relative;} 
        .summary-container,.content-container{background:#FFF;width:96%;margin-top:8px;padding:10px;position:relative;} 
        .config_source{background:#fff5c4;} 
        .content-container p{margin:0 0 10px 0; 
        }#details-left{width:35%;float:left;margin-right:2%; 
        }#details-right{width:63%;float:left; 
        }#server_version{width:96%;_height:1px;min-height:1px;margin:0 0 5px 0;padding:11px 2% 8px 2%;color:#FFFFFF; 
         background-color:#5A7FA5;border-bottom:1px solid #C1CFDD;border-top:1px solid #4A6C8E;font-weight:normal; 
         font-size:1em;color:#FFF;text-align:right; 
        }#server_version p{margin:5px 0;} 
        table{margin:4px 0 4px 0;width:100%;border:none;} 
        td,th{vertical-align:top;padding:3px 0;text-align:left;font-weight:bold;border:none;} 
        th{width:30%;text-align:right;padding-right:2%;font-weight:normal;} 
        thead th{background-color:#ebebeb;width:25%; 
        }#details-right th{width:20%;} 
        table tr.alt td,table tr.alt th{background-color:#ebebeb;} 
        .highlight-code{color:#CC0000;font-weight:bold;font-style:italic;} 
        .clear{clear:both;} 
        .preferred{padding:0 5px 2px 5px;font-weight:normal;background:#006633;color:#FFF;font-size:.8em;} 
        --> 
        </style> 
         
        </head> 
        <body> 
        <div id="header"><h1>Server Error in Application "EuroStrategy.net"</h1></div> 
        <div id="server_version"><p>Internet Information Services 7.0</p></div> 
        <div id="content"> 
        <div class="content-container"> 
         <fieldset><legend>Error Summary</legend> 
          <h2>'
         || p_error_message
         || '</h2> 
          <h3>'
         || p_stack_trace
         || '.</h3> 
         </fieldset> 

        </div> 
        <div class="content-container"> 
         <fieldset><legend>Detailed Error Information</legend> 
          <div id="details-left"> 
           <table border="0" cellpadding="0" cellspacing="0"> 
            <tr class="alt"><th>Module</th><td>IIS Web Core</td></tr> 
            <tr><th>Notification</th><td>MapRequestHandler</td></tr> 
            <tr class="alt"><th>Handler</th><td>StaticFile</td></tr> 
            <tr><th>Error Code</th><td>'
         || p_error_code
         || '</td></tr> 
             
           </table> 
          </div> 
          <div id="details-right"> 
           <table border="0" cellpadding="0" cellspacing="0"> 
            <tr class="alt"><th>Requested URL</th><td>http://'
         || OWA_UTIL.get_cgi_env ('SERVER_NAME')
         || ':'
         || OWA_UTIL.get_cgi_env ('SERVER_PORT')
         || '</td></tr> 
            <tr><th>Physical Path</th><td>'
         || OWA_UTIL.get_cgi_env ('PATH_INFO')
         || '</td></tr> 
            <tr class="alt"><th>Logon Method</th><td>Anonymous</td></tr> 
            <tr><th>Detailed trace</th><td>'
         || p_stack_trace
         || '</td></tr> 
             
           </table> 
           <div class="clear"></div> 
          </div> 
         </fieldset> 

        </div> 
        <div class="content-container"> 
         <fieldset><legend>Most likely causes:</legend> 
          <ul>     <li>The directory or file specified does not exist on the Web server.</li>     <li>The URL contains a typographical error.</li>     <li>A custom filter or module, such as URLScan, restricts access to the file.</li> </ul> 
         </fieldset> 
        </div> 
        <div class="content-container"> 
         <fieldset><legend>Things you can try:</legend> 
          <ul>     <li>Create the content on the Web server.</li>     <li>Review the browser URL.</li>     <li>Create a tracing rule to track failed requests for this HTTP status code and see which module is calling SetStatus. For more information about creating a tracing rule for failed requests, click <a href="http://go.microsoft.com/fwlink/?LinkID=66439">here</a>. </li> </ul> 
         </fieldset> 

        </div> 
         
         
        <div class="content-container"> 
         <fieldset><legend>Links and More Information</legend> 
          This error means that the file or directory does not exist on the server. Create the file or directory and try the request again. 
          <p><a href="http://go.microsoft.com/fwlink/?LinkID=62293&amp;IIS70Error=404,0,0x80070002,6002">View more information &raquo;</a></p> 
           
         </fieldset> 
        </div> 
        </div> 
        </body> 
        </html> 
');
   --add_gcal_error_event (p_error_code, p_error_message, p_stack_trace);
   END;
--   PROCEDURE test
--   IS
--   BEGIN
--      RAISE_APPLICATION_ERROR (-20000, 'Force and exception');
--   EXCEPTION
--      WHEN OTHERS
--      THEN
--         SSO.error_handler.aspx (SQLCODE, SQLERRM, DBMS_UTILITY.format_error_backtrace);
--   END;
--
--   PROCEDURE add_gcal_error_event (p_error_code      IN VARCHAR2 DEFAULT NULL,
--                                   p_error_message   IN VARCHAR2 DEFAULT NULL,
--                                   p_stack_trace     IN VARCHAR2 DEFAULT NULL)
--   IS
--      v_obj_google   google;
--   BEGIN
--      SELECT (obj_google)
--        INTO v_obj_google
--        FROM objs_google
--       WHERE account = 'GCAL_logger';
--
--      v_obj_google.refresh_token;
--      v_obj_google.
--      gcal_create_event (
--         p_start   => SYSDATE,
--         p_end     => (SYSDATE + 1 / 24),
--         p_title   => p_error_message,
--         p_note    => REPLACE (TRIM (REPLACE (REPLACE (DBMS_UTILITY.format_error_backtrace, CHR (10), ' '), CHR (13), ' ')),
--                               '"',
--                               '\"'));
--   END;
END;
/

SHOW ERRORS;