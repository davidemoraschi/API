/* Formatted on 17/09/2012 22:59:26 (QP5 v5.139.911.3011) */
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