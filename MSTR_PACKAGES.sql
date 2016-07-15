/* Formatted on 17/09/2012 22:58:07 (QP5 v5.139.911.3011) */
SET DEFINE OFF

CREATE OR REPLACE PACKAGE MSTR.home
IS
   PROCEDURE htm;
END home;
/

CREATE OR REPLACE PACKAGE BODY MSTR.home
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

CREATE OR REPLACE PACKAGE MSTR.flex_ws_api
AS
   empty_vc_arr         wwv_flow_global.vc_arr2;

   g_request_cookies    UTL_HTTP.cookie_table;
   g_response_cookies   UTL_HTTP.cookie_table;

   TYPE header IS RECORD (name VARCHAR2 (256), VALUE VARCHAR2 (1024));

   TYPE header_table IS TABLE OF header
                           INDEX BY BINARY_INTEGER;

   g_headers            header_table;
   g_request_headers    header_table;

   g_status_code        PLS_INTEGER;


   FUNCTION blob2clobbase64 (p_blob IN BLOB)
      RETURN CLOB;

   FUNCTION clobbase642blob (p_clob IN CLOB)
      RETURN BLOB;

   PROCEDURE make_request (p_url               IN VARCHAR2,
                           p_action            IN VARCHAR2 DEFAULT NULL,
                           p_version           IN VARCHAR2 DEFAULT '1.1',
                           p_collection_name   IN VARCHAR2 DEFAULT NULL,
                           p_envelope          IN CLOB,
                           p_username          IN VARCHAR2 DEFAULT NULL,
                           p_password          IN VARCHAR2 DEFAULT NULL,
                           p_proxy_override    IN VARCHAR2 DEFAULT NULL,
                           p_wallet_path       IN VARCHAR2 DEFAULT NULL,
                           p_wallet_pwd        IN VARCHAR2 DEFAULT NULL,
                           p_extra_headers     IN wwv_flow_global.vc_arr2 DEFAULT empty_vc_arr);

   FUNCTION make_request (p_url              IN VARCHAR2,
                          p_action           IN VARCHAR2 DEFAULT NULL,
                          p_version          IN VARCHAR2 DEFAULT '1.1',
                          p_envelope         IN CLOB,
                          p_username         IN VARCHAR2 DEFAULT NULL,
                          p_password         IN VARCHAR2 DEFAULT NULL,
                          p_proxy_override   IN VARCHAR2 DEFAULT NULL,
                          p_wallet_path      IN VARCHAR2 DEFAULT NULL,
                          p_wallet_pwd       IN VARCHAR2 DEFAULT NULL,
                          p_extra_headers    IN wwv_flow_global.vc_arr2 DEFAULT empty_vc_arr)
      RETURN XMLTYPE;

   FUNCTION make_rest_request (p_url               IN VARCHAR2,
                               p_http_method       IN VARCHAR2,
                               p_username          IN VARCHAR2 DEFAULT NULL,
                               p_password          IN VARCHAR2 DEFAULT NULL,
                               p_proxy_override    IN VARCHAR2 DEFAULT NULL,
                               p_body              IN CLOB DEFAULT EMPTY_CLOB (),
                               p_body_blob         IN BLOB DEFAULT EMPTY_BLOB (),
                               p_parm_name         IN wwv_flow_global.vc_arr2 DEFAULT empty_vc_arr,
                               p_parm_value        IN wwv_flow_global.vc_arr2 DEFAULT empty_vc_arr,
                               p_http_headers      IN wwv_flow_global.vc_arr2 DEFAULT empty_vc_arr,
                               p_http_hdr_values   IN wwv_flow_global.vc_arr2 DEFAULT empty_vc_arr,
                               p_wallet_path       IN VARCHAR2 DEFAULT NULL,
                               p_wallet_pwd        IN VARCHAR2 DEFAULT NULL)
      RETURN CLOB;

   FUNCTION parse_xml (p_xml IN XMLTYPE, p_xpath IN VARCHAR2, p_ns IN VARCHAR2 DEFAULT NULL)
      RETURN VARCHAR2;

   FUNCTION parse_xml_clob (p_xml IN XMLTYPE, p_xpath IN VARCHAR2, p_ns IN VARCHAR2 DEFAULT NULL)
      RETURN CLOB;

   FUNCTION parse_response (p_collection_name IN VARCHAR2, p_xpath IN VARCHAR2, p_ns IN VARCHAR2 DEFAULT NULL)
      RETURN VARCHAR2;

   FUNCTION parse_response_clob (p_collection_name IN VARCHAR2, p_xpath IN VARCHAR2, p_ns IN VARCHAR2 DEFAULT NULL)
      RETURN CLOB;
END flex_ws_api;
/

show errors

CREATE OR REPLACE PACKAGE BODY MSTR.flex_ws_api
AS
   FUNCTION blob2clobbase64 (p_blob IN BLOB)
      RETURN CLOB
   IS
      pos       PLS_INTEGER := 1;
      buffer    VARCHAR2 (32767);
      res       CLOB;
      lob_len   INTEGER := DBMS_LOB.getlength (p_blob);
      l_width   PLS_INTEGER := (76 / 4 * 3) - 9;
   BEGIN
      DBMS_LOB.createtemporary (res, TRUE);
      DBMS_LOB.open (res, DBMS_LOB.lob_readwrite);

      WHILE (pos < lob_len)
      LOOP
         buffer := UTL_RAW.cast_to_varchar2 (UTL_ENCODE.base64_encode (DBMS_LOB.SUBSTR (p_blob, l_width, pos)));

         DBMS_LOB.writeappend (res, LENGTH (buffer), buffer);

         pos := pos + l_width;
      END LOOP;

      RETURN res;
   END blob2clobbase64;

   FUNCTION clobbase642blob (p_clob IN CLOB)
      RETURN BLOB
   IS
      pos       PLS_INTEGER := 1;
      buffer    RAW (36);
      res       BLOB;
      lob_len   INTEGER := DBMS_LOB.getlength (p_clob);
      l_width   PLS_INTEGER := (76 / 4 * 3) - 9;
   BEGIN
      DBMS_LOB.createtemporary (res, TRUE);
      DBMS_LOB.open (res, DBMS_LOB.lob_readwrite);

      WHILE (pos < lob_len)
      LOOP
         buffer := UTL_ENCODE.base64_decode (UTL_RAW.cast_to_raw (DBMS_LOB.SUBSTR (p_clob, l_width, pos)));

         DBMS_LOB.writeappend (res, UTL_RAW.LENGTH (buffer), buffer);

         pos := pos + l_width;
      END LOOP;

      RETURN res;
   END clobbase642blob;

   PROCEDURE make_request (p_url               IN VARCHAR2,
                           p_action            IN VARCHAR2 DEFAULT NULL,
                           p_version           IN VARCHAR2 DEFAULT '1.1',
                           p_collection_name   IN VARCHAR2 DEFAULT NULL,
                           p_envelope          IN CLOB,
                           p_username          IN VARCHAR2 DEFAULT NULL,
                           p_password          IN VARCHAR2 DEFAULT NULL,
                           p_proxy_override    IN VARCHAR2 DEFAULT NULL,
                           p_wallet_path       IN VARCHAR2 DEFAULT NULL,
                           p_wallet_pwd        IN VARCHAR2 DEFAULT NULL,
                           p_extra_headers     IN wwv_flow_global.vc_arr2 DEFAULT empty_vc_arr)
   IS
      l_clob         CLOB;
      l_http_req     UTL_HTTP.req;
      l_http_resp    UTL_HTTP.resp;
      l_amount       BINARY_INTEGER := 8000;
      l_offset       INTEGER := 1;
      l_buffer       VARCHAR2 (32000);
      l_db_charset   VARCHAR2 (100);
      l_env_lenb     INTEGER := 0;
      i              INTEGER := 0;
      l_headers      wwv_flow_global.vc_arr2;
      l_response     VARCHAR2 (2000);
      l_name         VARCHAR2 (256);
      l_hdr_value    VARCHAR2 (1024);
      l_hdr          header;
      l_hdrs         header_table;
   BEGIN
      -- determine database characterset, if not AL32UTF8, conversion will be necessary
      SELECT VALUE
        INTO l_db_charset
        FROM nls_database_parameters
       WHERE parameter = 'NLS_CHARACTERSET';

      -- determine length for content-length header
      LOOP
         EXIT WHEN wwv_flow_utilities.clob_to_varchar2 (p_envelope, i * 32767) IS NULL;

         IF l_db_charset = 'AL32UTF8'
         THEN
            l_env_lenb := l_env_lenb + LENGTHB (wwv_flow_utilities.clob_to_varchar2 (p_envelope, i * 32767));
         ELSE
            l_env_lenb :=
               l_env_lenb
               + UTL_RAW.
                 LENGTH (
                    UTL_RAW.
                    CONVERT (UTL_RAW.cast_to_raw (wwv_flow_utilities.clob_to_varchar2 (p_envelope, i * 32767)),
                             'american_america.al32utf8',
                             'american_america.' || l_db_charset));
         END IF;

         i := i + 1;
      END LOOP;

      -- set a proxy if required
      IF APEX_APPLICATION.g_proxy_server IS NOT NULL AND p_proxy_override IS NULL
      THEN
         UTL_HTTP.set_proxy (proxy => APEX_APPLICATION.g_proxy_server);
      ELSIF p_proxy_override IS NOT NULL
      THEN
         UTL_HTTP.set_proxy (proxy => p_proxy_override);
      END IF;

      UTL_HTTP.set_persistent_conn_support (TRUE);
      UTL_HTTP.set_transfer_timeout (600);

      -- set wallet if necessary
      IF INSTR (LOWER (p_url), 'https') = 1
      THEN
         UTL_HTTP.set_wallet (p_wallet_path, p_wallet_pwd);
      END IF;

      -- set cookies if necessary
      BEGIN
         IF g_request_cookies.COUNT > 0
         THEN
            UTL_HTTP.clear_cookies;
            UTL_HTTP.add_cookies (g_request_cookies);
         END IF;
      EXCEPTION
         WHEN OTHERS
         THEN
            raise_application_error (-20001, 'The provided cookie is invalid.');
      END;

      -- begin the request
      IF wwv_flow_utilities.db_version LIKE '9.%'
      THEN
         l_http_req := UTL_HTTP.begin_request (p_url, 'POST', 'HTTP/1.0');
      ELSE
         l_http_req := UTL_HTTP.begin_request (p_url, 'POST');
      END IF;

      -- set basic authentication if required
      IF p_username IS NOT NULL
      THEN
         UTL_HTTP.set_authentication (r           => l_http_req,
                                      username    => p_username,
                                      password    => p_password,
                                      scheme      => 'Basic',
                                      for_proxy   => FALSE);
      END IF;

      -- set standard HTTP headers for a SOAP request
      UTL_HTTP.set_header (l_http_req, 'Proxy-Connection', 'Keep-Alive');

      IF p_version = '1.2'
      THEN
         UTL_HTTP.set_header (l_http_req, 'Content-Type', 'application/soap+xml; charset=UTF-8; action="' || p_action || '";');
      ELSE
         UTL_HTTP.set_header (l_http_req, 'SOAPAction', p_action);
         UTL_HTTP.set_header (l_http_req, 'Content-Type', 'text/xml; charset=UTF-8');
      END IF;

      UTL_HTTP.set_header (l_http_req, 'Content-Length', l_env_lenb);

      -- set additional headers if supplied, these are separated by a colon (:) as name/value pairs
      FOR i IN 1 .. p_extra_headers.COUNT
      LOOP
         l_headers := APEX_UTIL.string_to_table (p_extra_headers (i));
         UTL_HTTP.set_header (l_http_req, l_headers (1), l_headers (2));
      END LOOP;

      --set headers from g_request_headers
      FOR i IN 1 .. g_request_headers.COUNT
      LOOP
         UTL_HTTP.set_header (l_http_req, g_request_headers (i).name, g_request_headers (i).VALUE);
      END LOOP;

      -- read the envelope, convert to UTF8 if necessary, then write it to the HTTP request
      BEGIN
         LOOP
            DBMS_LOB.read (p_envelope,
                           l_amount,
                           l_offset,
                           l_buffer);

            IF l_db_charset = 'AL32UTF8'
            THEN
               UTL_HTTP.write_text (l_http_req, l_buffer);
            ELSE
               UTL_HTTP.
               write_raw (
                  l_http_req,
                  UTL_RAW.
                  CONVERT (UTL_RAW.cast_to_raw (l_buffer), 'american_america.al32utf8', 'american_america.' || l_db_charset));
            END IF;

            l_offset := l_offset + l_amount;
            l_amount := 8000;
         END LOOP;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            NULL;
      END;

      -- get the response
      l_http_resp := UTL_HTTP.get_response (l_http_req);

      -- set response code, response http header and response cookies global
      g_status_code := l_http_resp.status_code;
      UTL_HTTP.get_cookies (g_response_cookies);

      FOR i IN 1 .. UTL_HTTP.get_header_count (l_http_resp)
      LOOP
         UTL_HTTP.get_header (l_http_resp,
                              i,
                              l_name,
                              l_hdr_value);
         l_hdr.name := l_name;
         l_hdr.VALUE := l_hdr_value;
         l_hdrs (i) := l_hdr;
      END LOOP;

      g_headers := l_hdrs;

      -- put the response in a collection if necessary
      IF p_collection_name IS NOT NULL
      THEN
         apex_collection.create_or_truncate_collection (p_collection_name);

         DBMS_LOB.createtemporary (l_clob, FALSE);
         DBMS_LOB.open (l_clob, DBMS_LOB.lob_readwrite);

         BEGIN
            LOOP
               UTL_HTTP.read_text (l_http_resp, l_buffer);
               DBMS_LOB.writeappend (l_clob, LENGTH (l_buffer), l_buffer);
            END LOOP;
         EXCEPTION
            WHEN OTHERS
            THEN
               IF SQLCODE <> -29266
               THEN
                  RAISE;
               END IF;
         END;

         apex_collection.add_member (p_collection_name => p_collection_name, p_clob001 => l_clob);
      END IF;

      --
      UTL_HTTP.end_response (l_http_resp);
   END make_request;

   FUNCTION make_request (p_url              IN VARCHAR2,
                          p_action           IN VARCHAR2 DEFAULT NULL,
                          p_version          IN VARCHAR2 DEFAULT '1.1',
                          p_envelope         IN CLOB,
                          p_username         IN VARCHAR2 DEFAULT NULL,
                          p_password         IN VARCHAR2 DEFAULT NULL,
                          p_proxy_override   IN VARCHAR2 DEFAULT NULL,
                          p_wallet_path      IN VARCHAR2 DEFAULT NULL,
                          p_wallet_pwd       IN VARCHAR2 DEFAULT NULL,
                          p_extra_headers    IN wwv_flow_global.vc_arr2 DEFAULT empty_vc_arr)
      RETURN XMLTYPE
   IS
      l_clob         CLOB;
      l_http_req     UTL_HTTP.req;
      l_http_resp    UTL_HTTP.resp;
      l_amount       BINARY_INTEGER := 8000;
      l_offset       INTEGER := 1;
      l_buffer       VARCHAR2 (32000);
      l_db_charset   VARCHAR2 (100);
      l_env_lenb     INTEGER := 0;
      i              INTEGER := 0;
      l_headers      wwv_flow_global.vc_arr2;
      l_response     VARCHAR2 (2000);
      l_name         VARCHAR2 (256);
      l_hdr_value    VARCHAR2 (1024);
      l_hdr          header;
      l_hdrs         header_table;
   BEGIN
      -- determine database characterset, if not AL32UTF8, conversion will be necessary
      SELECT VALUE
        INTO l_db_charset
        FROM nls_database_parameters
       WHERE parameter = 'NLS_CHARACTERSET';

      -- determine length for content-length header
      LOOP
         EXIT WHEN wwv_flow_utilities.clob_to_varchar2 (p_envelope, i * 32767) IS NULL;

         IF l_db_charset = 'AL32UTF8'
         THEN
            l_env_lenb := l_env_lenb + LENGTHB (wwv_flow_utilities.clob_to_varchar2 (p_envelope, i * 32767));
         ELSE
            l_env_lenb :=
               l_env_lenb
               + UTL_RAW.
                 LENGTH (
                    UTL_RAW.
                    CONVERT (UTL_RAW.cast_to_raw (wwv_flow_utilities.clob_to_varchar2 (p_envelope, i * 32767)),
                             'american_america.al32utf8',
                             'american_america.' || l_db_charset));
         END IF;

         i := i + 1;
      END LOOP;

      -- set a proxy if required
      IF APEX_APPLICATION.g_proxy_server IS NOT NULL AND p_proxy_override IS NULL
      THEN
         UTL_HTTP.set_proxy (proxy => APEX_APPLICATION.g_proxy_server);
      ELSIF p_proxy_override IS NOT NULL
      THEN
         UTL_HTTP.set_proxy (proxy => p_proxy_override);
      END IF;

      UTL_HTTP.set_persistent_conn_support (TRUE);
      UTL_HTTP.set_transfer_timeout (600);

      -- set wallet if necessary
      IF INSTR (LOWER (p_url), 'https') = 1
      THEN
         UTL_HTTP.set_wallet (p_wallet_path, p_wallet_pwd);
      END IF;

      -- set cookies if necessary
      BEGIN
         IF g_request_cookies.COUNT > 0
         THEN
            UTL_HTTP.clear_cookies;
            UTL_HTTP.add_cookies (g_request_cookies);
         END IF;
      EXCEPTION
         WHEN OTHERS
         THEN
            raise_application_error (-20001, 'The provided cookie is invalid.');
      END;

      -- begin the request
      IF wwv_flow_utilities.db_version LIKE '9.%'
      THEN
         l_http_req := UTL_HTTP.begin_request (p_url, 'POST', 'HTTP/1.0');
      ELSE
         l_http_req := UTL_HTTP.begin_request (p_url, 'POST');
      END IF;

      -- set basic authentication if required
      IF p_username IS NOT NULL
      THEN
         UTL_HTTP.set_authentication (r           => l_http_req,
                                      username    => p_username,
                                      password    => p_password,
                                      scheme      => 'Basic',
                                      for_proxy   => FALSE);
      END IF;

      -- set standard HTTP headers for a SOAP request
      UTL_HTTP.set_header (l_http_req, 'Proxy-Connection', 'Keep-Alive');

      IF p_version = '1.2'
      THEN
         UTL_HTTP.set_header (l_http_req, 'Content-Type', 'application/soap+xml; charset=UTF-8; action="' || p_action || '";');
      ELSE
         UTL_HTTP.set_header (l_http_req, 'SOAPAction', p_action);
         UTL_HTTP.set_header (l_http_req, 'Content-Type', 'text/xml; charset=UTF-8');
      END IF;

      UTL_HTTP.set_header (l_http_req, 'Content-Length', l_env_lenb);

      -- set additional headers if supplied, these are separated by a colon (:) as name/value pairs
      FOR i IN 1 .. p_extra_headers.COUNT
      LOOP
         l_headers := APEX_UTIL.string_to_table (p_extra_headers (i));
         UTL_HTTP.set_header (l_http_req, l_headers (1), l_headers (2));
      END LOOP;

      --set headers from g_request_headers
      FOR i IN 1 .. g_request_headers.COUNT
      LOOP
         UTL_HTTP.set_header (l_http_req, g_request_headers (i).name, g_request_headers (i).VALUE);
      END LOOP;

      -- read the envelope, convert to UTF8 if necessary, then write it to the HTTP request
      BEGIN
         LOOP
            DBMS_LOB.read (p_envelope,
                           l_amount,
                           l_offset,
                           l_buffer);

            IF l_db_charset = 'AL32UTF8'
            THEN
               UTL_HTTP.write_text (l_http_req, l_buffer);
            ELSE
               UTL_HTTP.
               write_raw (
                  l_http_req,
                  UTL_RAW.
                  CONVERT (UTL_RAW.cast_to_raw (l_buffer), 'american_america.al32utf8', 'american_america.' || l_db_charset));
            END IF;

            l_offset := l_offset + l_amount;
            l_amount := 8000;
         END LOOP;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            NULL;
      END;

      -- get the response
      l_http_resp := UTL_HTTP.get_response (l_http_req);

      -- set response code, response http header and response cookies global
      g_status_code := l_http_resp.status_code;
      UTL_HTTP.get_cookies (g_response_cookies);

      FOR i IN 1 .. UTL_HTTP.get_header_count (l_http_resp)
      LOOP
         UTL_HTTP.get_header (l_http_resp,
                              i,
                              l_name,
                              l_hdr_value);
         l_hdr.name := l_name;
         l_hdr.VALUE := l_hdr_value;
         l_hdrs (i) := l_hdr;
      END LOOP;

      g_headers := l_hdrs;

      -- put the response in a clob
      DBMS_LOB.createtemporary (l_clob, FALSE);
      DBMS_LOB.open (l_clob, DBMS_LOB.lob_readwrite);

      BEGIN
         LOOP
            UTL_HTTP.read_text (l_http_resp, l_buffer);
            DBMS_LOB.writeappend (l_clob, LENGTH (l_buffer), l_buffer);
         END LOOP;
      EXCEPTION
         WHEN OTHERS
         THEN
            IF SQLCODE <> -29266
            THEN
               RAISE;
            END IF;
      END;

      UTL_HTTP.end_response (l_http_resp);

      RETURN xmltype.createxml (l_clob);
   EXCEPTION
      WHEN OTHERS
      THEN
         IF SQLCODE = -31011
         THEN -- its not xml
            RETURN NULL;
         END IF;
   END make_request;

   FUNCTION make_rest_request (p_url               IN VARCHAR2,
                               p_http_method       IN VARCHAR2,
                               p_username          IN VARCHAR2 DEFAULT NULL,
                               p_password          IN VARCHAR2 DEFAULT NULL,
                               p_proxy_override    IN VARCHAR2 DEFAULT NULL,
                               p_body              IN CLOB DEFAULT EMPTY_CLOB (),
                               p_body_blob         IN BLOB DEFAULT EMPTY_BLOB (),
                               p_parm_name         IN wwv_flow_global.vc_arr2 DEFAULT empty_vc_arr,
                               p_parm_value        IN wwv_flow_global.vc_arr2 DEFAULT empty_vc_arr,
                               p_http_headers      IN wwv_flow_global.vc_arr2 DEFAULT empty_vc_arr,
                               p_http_hdr_values   IN wwv_flow_global.vc_arr2 DEFAULT empty_vc_arr,
                               p_wallet_path       IN VARCHAR2 DEFAULT NULL,
                               p_wallet_pwd        IN VARCHAR2 DEFAULT NULL)
      RETURN CLOB
   IS
      l_http_req     UTL_HTTP.req;
      l_http_resp    UTL_HTTP.resp;
      --
      l_body         CLOB DEFAULT EMPTY_CLOB ();
      i              INTEGER;
      l_env_lenb     NUMBER := 0;
      l_db_charset   VARCHAR2 (100) := 'AL32UTF8';
      l_buffer       VARCHAR2 (32767);
      l_raw          RAW (48);
      l_amount       NUMBER;
      l_offset       NUMBER;
      l_value        CLOB;
      l_url          VARCHAR2 (32767);
      l_parm_value   VARCHAR2 (32767);
      l_name         VARCHAR2 (256);
      l_hdr_value    VARCHAR2 (1024);
      l_hdr          header;
      l_hdrs         header_table;
   BEGIN
      -- determine database characterset, if not AL32UTF8, conversion will be necessary
      SELECT VALUE
        INTO l_db_charset
        FROM nls_database_parameters
       WHERE parameter = 'NLS_CHARACTERSET';

      -- set a proxy if required
      IF APEX_APPLICATION.g_proxy_server IS NOT NULL AND p_proxy_override IS NULL
      THEN
         UTL_HTTP.set_proxy (proxy => APEX_APPLICATION.g_proxy_server);
      ELSIF p_proxy_override IS NOT NULL
      THEN
         UTL_HTTP.set_proxy (proxy => p_proxy_override);
      END IF;

      UTL_HTTP.set_persistent_conn_support (TRUE);
      UTL_HTTP.set_transfer_timeout (180);

      IF INSTR (LOWER (p_url), 'https') = 1
      THEN
         UTL_HTTP.set_wallet (p_wallet_path, p_wallet_pwd);
      END IF;

      IF DBMS_LOB.getlength (p_body) = 0
      THEN
         FOR i IN 1 .. p_parm_name.COUNT
         LOOP
            IF p_http_method = 'GET'
            THEN
               l_parm_value := APEX_UTIL.url_encode (p_parm_value (i));
            ELSE
               l_parm_value := p_parm_value (i);
            END IF;

            IF i = 1
            THEN
               l_body := p_parm_name (i) || '=' || l_parm_value;
            ELSE
               l_body := l_body || '&' || p_parm_name (i) || '=' || l_parm_value;
            END IF;
         END LOOP;
      ELSE
         l_body := p_body;
      END IF;

      i := 0;

      l_url := p_url;

      IF p_http_method = 'GET'
      THEN
         l_url := l_url || '?' || wwv_flow_utilities.clob_to_varchar2 (l_body);
      END IF;

      -- determine length in bytes of l_body;
      IF DBMS_LOB.getlength (p_body_blob) > 0
      THEN
         l_env_lenb := DBMS_LOB.getlength (p_body_blob);
      ELSE
         LOOP
            EXIT WHEN wwv_flow_utilities.clob_to_varchar2 (l_body, i * 32767) IS NULL;

            IF l_db_charset = 'AL32UTF8'
            THEN
               l_env_lenb := l_env_lenb + LENGTHB (wwv_flow_utilities.clob_to_varchar2 (l_body, i * 32767));
            ELSE
               l_env_lenb :=
                  l_env_lenb
                  + UTL_RAW.
                    LENGTH (
                       UTL_RAW.
                       CONVERT (UTL_RAW.cast_to_raw (wwv_flow_utilities.clob_to_varchar2 (l_body, i * 32767)),
                                'american_america.al32utf8',
                                'american_america.' || l_db_charset));
            END IF;

            i := i + 1;
         END LOOP;
      END IF;

      -- set cookies if necessary
      BEGIN
         IF g_request_cookies.COUNT > 0
         THEN
            UTL_HTTP.clear_cookies;
            UTL_HTTP.add_cookies (g_request_cookies);
         END IF;
      EXCEPTION
         WHEN OTHERS
         THEN
            raise_application_error (-20001, 'The provided cookie is invalid.');
      END;

      BEGIN
         l_http_req := UTL_HTTP.begin_request (l_url, p_http_method);

         -- set basic authentication if necessary
         IF p_username IS NOT NULL
         THEN
            UTL_HTTP.set_authentication (l_http_req, p_username, p_password);
         END IF;

         UTL_HTTP.set_header (l_http_req, 'Proxy-Connection', 'Keep-Alive');

         IF p_http_method != 'GET'
         THEN
            UTL_HTTP.set_header (l_http_req, 'Content-Length', l_env_lenb);
         END IF;

         -- set additional headers if supplied, these are separated by a colon (:) as name/value pairs
         FOR i IN 1 .. p_http_headers.COUNT
         LOOP
            UTL_HTTP.set_header (l_http_req, p_http_headers (i), p_http_hdr_values (i));
         END LOOP;
      EXCEPTION
         WHEN OTHERS
         THEN
            raise_application_error (-20001, 'The URL provided is invalid or you need to set a proxy.');
      END;

      --set headers from g_request_headers
      FOR i IN 1 .. g_request_headers.COUNT
      LOOP
         UTL_HTTP.set_header (l_http_req, g_request_headers (i).name, g_request_headers (i).VALUE);
      END LOOP;

      --
      l_amount := 8000;
      l_offset := 1;

      IF p_http_method != 'GET'
      THEN
         IF DBMS_LOB.getlength (l_body) > 0
         THEN
            BEGIN
               LOOP
                  DBMS_LOB.read (l_body,
                                 l_amount,
                                 l_offset,
                                 l_buffer);

                  IF l_db_charset = 'AL32UTF8'
                  THEN
                     UTL_HTTP.write_text (l_http_req, l_buffer);
                  ELSE
                     UTL_HTTP.
                     write_raw (
                        l_http_req,
                        UTL_RAW.
                        CONVERT (UTL_RAW.cast_to_raw (l_buffer),
                                 'american_america.al32utf8',
                                 'american_america.' || l_db_charset));
                  END IF;

                  l_offset := l_offset + l_amount;
                  l_amount := 8000;
               END LOOP;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  NULL;
            END;
         ELSIF DBMS_LOB.getlength (p_body_blob) > 0
         THEN
            BEGIN
               l_amount := 48;

               WHILE (l_offset < l_env_lenb)
               LOOP
                  DBMS_LOB.read (p_body_blob,
                                 l_amount,
                                 l_offset,
                                 l_raw);
                  UTL_HTTP.write_raw (l_http_req, l_raw);
                  l_offset := l_offset + l_amount;
               END LOOP;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  NULL;
            END;
         END IF;
      END IF;

      --
      BEGIN
         l_http_resp := UTL_HTTP.get_response (l_http_req);
      EXCEPTION
         WHEN OTHERS
         THEN
            raise_application_error (-20001, 'The URL provided is invalid or you need to set a proxy.');
      END;

      --

      -- set response code, response http header and response cookies global
      g_status_code := l_http_resp.status_code;
      UTL_HTTP.get_cookies (g_response_cookies);

      FOR i IN 1 .. UTL_HTTP.get_header_count (l_http_resp)
      LOOP
         UTL_HTTP.get_header (l_http_resp,
                              i,
                              l_name,
                              l_hdr_value);
         l_hdr.name := l_name;
         l_hdr.VALUE := l_hdr_value;
         l_hdrs (i) := l_hdr;
      END LOOP;

      g_headers := l_hdrs;

      --
      DBMS_LOB.createtemporary (l_value, FALSE);
      DBMS_LOB.open (l_value, DBMS_LOB.lob_readwrite);

      BEGIN
         LOOP
            UTL_HTTP.read_text (l_http_resp, l_buffer);
            DBMS_LOB.writeappend (l_value, LENGTH (l_buffer), l_buffer);
         END LOOP;
      EXCEPTION
         WHEN OTHERS
         THEN
            IF SQLCODE <> -29266
            THEN
               RAISE;
            END IF;
      END;

      --
      UTL_HTTP.end_response (l_http_resp);

      RETURN l_value;
   END make_rest_request;

   FUNCTION parse_xml (p_xml IN XMLTYPE, p_xpath IN VARCHAR2, p_ns IN VARCHAR2 DEFAULT NULL)
      RETURN VARCHAR2
   IS
      l_response   VARCHAR2 (32767);
   BEGIN
      l_response := DBMS_XMLGEN.CONVERT (p_xml.EXTRACT (p_xpath, p_ns).getstringval (), 1);

      RETURN l_response;
   EXCEPTION
      WHEN OTHERS
      THEN
         IF SQLCODE = -30625
         THEN -- path not found
            RETURN NULL;
         END IF;
   END parse_xml;

   FUNCTION parse_xml_clob (p_xml IN XMLTYPE, p_xpath IN VARCHAR2, p_ns IN VARCHAR2 DEFAULT NULL)
      RETURN CLOB
   IS
      l_response   CLOB;
   BEGIN
      l_response := p_xml.EXTRACT (p_xpath, p_ns).getclobval ();

      RETURN l_response;
   EXCEPTION
      WHEN OTHERS
      THEN
         IF SQLCODE = -30625
         THEN -- path not found
            RETURN NULL;
         END IF;
   END parse_xml_clob;

   FUNCTION parse_response (p_collection_name IN VARCHAR2, p_xpath IN VARCHAR2, p_ns IN VARCHAR2 DEFAULT NULL)
      RETURN VARCHAR2
   IS
      l_response   VARCHAR2 (32767);
      l_xml        XMLTYPE;
   BEGIN
      FOR c1 IN (SELECT clob001
                   FROM apex_collections
                  WHERE collection_name = p_collection_name)
      LOOP
         l_xml := xmltype.createxml (c1.clob001);
         EXIT;
      END LOOP;

      l_response := parse_xml (l_xml, p_xpath, p_ns);

      RETURN l_response;
   EXCEPTION
      WHEN OTHERS
      THEN
         IF SQLCODE = -31011
         THEN -- its not xml
            RETURN NULL;
         END IF;
   END parse_response;

   FUNCTION parse_response_clob (p_collection_name IN VARCHAR2, p_xpath IN VARCHAR2, p_ns IN VARCHAR2 DEFAULT NULL)
      RETURN CLOB
   IS
      l_response   CLOB;
      l_xml        XMLTYPE;
   BEGIN
      FOR c1 IN (SELECT clob001
                   FROM apex_collections
                  WHERE collection_name = p_collection_name)
      LOOP
         l_xml := xmltype.createxml (c1.clob001);
         EXIT;
      END LOOP;

      l_response := parse_xml_clob (l_xml, p_xpath, p_ns);

      RETURN l_response;
   EXCEPTION
      WHEN OTHERS
      THEN
         IF SQLCODE = -31011
         THEN -- its not xml
            RETURN NULL;
         END IF;
   END parse_response_clob;
END flex_ws_api;
/

show errors;

CREATE OR REPLACE PACKAGE MSTR.error_handler
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

CREATE OR REPLACE PACKAGE BODY MSTR.error_handler
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

CREATE OR REPLACE PACKAGE MSTR.REPORT_EXECUTE
AS
   PROCEDURE png (p_varchar_1 IN VARCHAR2 DEFAULT '1200A5684D156325A83AFBB158EB72FE');

   PROCEDURE htm;
END;
/

CREATE OR REPLACE PACKAGE BODY MSTR.REPORT_EXECUTE
AS
   PROCEDURE png (p_varchar_1 IN VARCHAR2 DEFAULT '1200A5684D156325A83AFBB158EB72FE')
   IS
      const_host_port   CONSTANT VARCHAR2 (1024) := 'http://eurostrategy.net:8080';
      v_sessionState    VARCHAR2 (4000)
                           := HTTPURITYPE.
                              createuri (
                                 const_host_port
                                 || '/MicroStrategy/servlet/taskProc?taskId=login&taskEnv=xml&taskContentType=xml&server=IP-10-34-95-214&project=INyDIA&userid=atorres&password=Amazon').
                              getxml ().EXTRACT ('taskResponse/root/sessionState/text()').getstringval ();
      v_msg_id          VARCHAR2 (1000)
                           := HTTPURITYPE.
                              createuri (
                                 const_host_port
                                 || '/MicroStrategy/servlet/taskProc?taskId=reportExecute&taskEnv=xml&taskContentType=xml&sessionState='
                                 || UTL_URL.escape (v_sessionState)
                                 || '&reportViewMode=2&reportID='
                                 || p_varchar_1).getxml ().EXTRACT ('taskResponse/msg/id/text()').getstringval ();
      v_image_blob      BLOB
                           := FLEX_WS_API.
                              CLOBBASE642BLOB (
                                 HTTPURITYPE.
                                 createuri (
                                    const_host_port
                                    || '/MicroStrategy/servlet/taskProc?taskId=getReportGraphImage&taskEnv=xml&taskContentType=xml&sessionState='
                                    || UTL_URL.escape (v_sessionState)
                                    || '&messageID='
                                    || v_msg_id
                                    || '&width=500&height=300&imgType=2&availWidth=550&availHeight=350').getxml ().
                                 EXTRACT ('taskResponse/root/ib/eb/text()').getclobval ());
   BEGIN
      OWA_UTIL.mime_header ('image/png', FALSE, NULL);
      HTP.p ('<HR />Content-length: ' || DBMS_LOB.GETLENGTH (v_image_blob));
      OWA_UTIL.http_header_close;
      WPG_DOCLOAD.download_file (v_image_blob);
      v_sessionState :=
         HTTPURITYPE.
         createuri (
               const_host_port
            || '/MicroStrategy/servlet/taskProc?taskId=logout&taskEnv=xml&taskContentType=xml&sessionState='
            || UTL_URL.escape (v_sessionState)).getxml ().EXTRACT ('taskResponse/text()').getstringval ();
   EXCEPTION
      WHEN OTHERS
      THEN
         error_handler.jsp (SQLERRM, DBMS_UTILITY.format_error_backtrace);
   END;

   PROCEDURE htm
   IS
   BEGIN
      HTP.p ('ok');
   END;
END;
/


CREATE OR REPLACE PACKAGE MSTR.REPORT_SEND
AS
   PROCEDURE png (p_varchar_1 IN VARCHAR2 DEFAULT '1200A5684D156325A83AFBB158EB72FE');

   PROCEDURE htm;
END;
/

CREATE OR REPLACE PACKAGE BODY MSTR.REPORT_SEND
AS
   PROCEDURE png (p_varchar_1 IN VARCHAR2 DEFAULT '1200A5684D156325A83AFBB158EB72FE')
   IS
      const_host_port   CONSTANT VARCHAR2 (1024) := 'http://eurostrategy.net:8080';
      v_sessionState    VARCHAR2 (4000)
                           := HTTPURITYPE.
                              createuri (
                                 const_host_port
                                 || '/MicroStrategy/servlet/taskProc?taskId=login&taskEnv=xml&taskContentType=xml&server=IP-10-34-95-214&project=INyDIA&userid=atorres&password=Amazon').
                              getxml ().EXTRACT ('taskResponse/root/sessionState/text()').getstringval ();
      v_msg_id          VARCHAR2 (1000)
                           := HTTPURITYPE.
                              createuri (
                                 const_host_port
                                 || '/MicroStrategy/servlet/taskProc?taskId=reportExecute&taskEnv=xml&taskContentType=xml&sessionState='
                                 || UTL_URL.escape (v_sessionState)
                                 || '&reportViewMode=2&reportID='
                                 || p_varchar_1).getxml ().EXTRACT ('taskResponse/msg/id/text()').getstringval ();
      v_image_clob      CLOB
                           := 
                                 HTTPURITYPE.
                                 createuri (
                                    const_host_port
                                    || '/MicroStrategy/servlet/taskProc?taskId=getReportGraphImage&taskEnv=xml&taskContentType=xml&sessionState='
                                    || UTL_URL.escape (v_sessionState)
                                    || '&messageID='
                                    || v_msg_id
                                    || '&width=500&height=300&imgType=2&availWidth=550&availHeight=350').getxml ().
                                 EXTRACT ('taskResponse/root/ib/eb/text()').getclobval ();
   BEGIN
      --OWA_UTIL.mime_header ('image/png', FALSE, NULL);
      --HTP.p ('<HR />Content-length: ' || DBMS_LOB.GETLENGTH (v_image_blob));
      --OWA_UTIL.http_header_close;
      --WPG_DOCLOAD.download_file (v_image_blob);
      /*
      p_Sender      IN VARCHAR2,
                  p_Recipient   IN VARCHAR2,
                  p_Subject     IN VARCHAR2,
                  p_Html_Body   IN CLOB
                  */
      AWS_SES.SENDMAIL.PHP(p_Sender => 'dmoraschi@gmail.com', p_Recipient => 'dmoraschi@gmail.com', p_Subject => 'test', p_Html_Body => 'To: dmoraschi@gmail.com
Subject: Mail Sending Options Test2
From: Davide Moraschi <dmoraschi@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="simple boundary 1"

--simple boundary 1
Content-Type: multipart/related; boundary="simple boundary 2"

--simple boundary 2
Content-Type: multipart/alternative; boundary="simple boundary 3"

--simple boundary 3
Content-Type: text/plain

Text without inline reference
--simple boundary 3
Content-Type: text/html

<h1>Text with inline reference</h1>
<img src="cid:Inline.png" />
--simple boundary 3--
--simple boundary 2
Content-Type: image/png; name="inline.PNG"
Content-Transfer-Encoding: base64
Content-ID: <6583CF49B56F42FEA6A4A118F46F96FB@example.com>
Content-Disposition: inline; filename="Inline.png"

'
||v_image_clob
||'
--simple boundary 2--

--simple boundary 1
Content-Type: image/png; name=" Attachment "
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="Attachment.png"

...Attachment data encoded with base64...
--simple boundary 1--');
      v_sessionState :=
         HTTPURITYPE.
         createuri (
               const_host_port
            || '/MicroStrategy/servlet/taskProc?taskId=logout&taskEnv=xml&taskContentType=xml&sessionState='
            || UTL_URL.escape (v_sessionState)).getxml ().EXTRACT ('taskResponse/text()').getstringval ();
   EXCEPTION
      WHEN OTHERS
      THEN
         error_handler.jsp (SQLERRM, DBMS_UTILITY.format_error_backtrace);
   END;

   PROCEDURE htm
   IS
   BEGIN
      HTP.p ('ok');
   END;
END;
/