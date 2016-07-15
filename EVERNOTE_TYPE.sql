DROP TABLE EVERNOTE.OBJS_EVERNOTE;
/* Formatted on 02/09/2012 16:16:50 (QP5 v5.139.911.3011) */
CREATE OR REPLACE TYPE EVERNOTE.EVERNOTE
   UNDER OAUTH.OAUTH
   (oauth_callback VARCHAR2 (1000),
    oauth_api_version NUMBER,
    CONSTRUCTOR FUNCTION EVERNOTE (id                      IN VARCHAR2 DEFAULT 'test',
                                  oauth_consumer_key      IN VARCHAR2 DEFAULT NULL,
                                  oauth_consumer_secret   IN VARCHAR2 DEFAULT NULL,
                                  oauth_callback          IN VARCHAR2 DEFAULT 'oob')
       RETURN SELF AS RESULT,
    MEMBER PROCEDURE save,
    MEMBER PROCEDURE upgrade_token,
    MEMBER PROCEDURE get_account (p_callback IN VARCHAR2 DEFAULT NULL, p_credentials_in_response OUT XMLTYPE),
    MEMBER PROCEDURE post_status (p_status IN VARCHAR2 DEFAULT 'chip', p_result_in_response OUT XMLTYPE),
    MEMBER PROCEDURE post_status_with_media (p_status IN VARCHAR2 DEFAULT 'chip', p_result_in_response OUT XMLTYPE));
/

show errors;
SET DEFINE OFF

CREATE TABLE EVERNOTE.OBJS_EVERNOTE (ACCOUNT VARCHAR2 (250 BYTE), CREATION_DATE TIMESTAMP (6) WITH TIME ZONE, OBJ_EVERNOTE EVERNOTE.EVERNOTE)
COLUMN OBJ_EVERNOTE NOT SUBSTITUTABLE AT ALL LEVELS;

ALTER TABLE EVERNOTE.OBJS_EVERNOTE ADD (
  CONSTRAINT OBJECTS_EVERNOTE_PK
 PRIMARY KEY
 (ACCOUNT));

CREATE OR REPLACE TYPE BODY EVERNOTE.EVERNOTE
AS
   CONSTRUCTOR FUNCTION EVERNOTE (id                      IN VARCHAR2 DEFAULT 'test',
                                 oauth_consumer_key      IN VARCHAR2 DEFAULT NULL,
                                 oauth_consumer_secret   IN VARCHAR2 DEFAULT NULL,
                                 oauth_callback          IN VARCHAR2 DEFAULT 'oob')
      RETURN SELF AS RESULT
   IS
      http_method             CONSTANT VARCHAR2 (5) := 'POST';
      http_req                UTL_HTTP.req;
      http_resp               UTL_HTTP.resp;
      var_http_header_name    VARCHAR2 (255);
      var_http_header_value   VARCHAR2 (1023);
      var_http_resp_value     VARCHAR2 (32767);
      con_str_wallet_path     CONSTANT VARCHAR2 (500) := OAUTH.global_constants.con_str_wallet_path; --'file:C:\INyDIA\wallet';
      con_str_wallet_pass     CONSTANT VARCHAR2 (100) := OAUTH.global_constants.con_str_wallet_pass; --'Lepanto1571';
   BEGIN
      SELF.id := id;
      SELF.con_num_timestamp_tz_diff := OAUTH.global_constants.con_num_timestamp_tz_diff;
      SELF.oauth_consumer_key := oauth_consumer_key;
      SELF.oauth_consumer_secret := oauth_consumer_secret;
      SELF.oauth_api_version := 0;
      SELF.oauth_callback := oauth_callback;
      SELF.oauth_api_request_token_url := 'https://sandbox.evernote.com/oauth';
      SELF.oauth_api_authorization_url :=  'https://sandbox.evernote.com/OAuth.action';
      SELF.oauth_api_access_token_url :=  'https://sandbox.evernote.com/oauth';
      SELF.oauth_timestamp :=
         TO_CHAR (TRUNC ( (SYSDATE - TO_DATE ('01-01-1970', 'DD-MM-YYYY')) * (86400) - con_num_timestamp_tz_diff));
      SELF.oauth_nonce := SELF.urlencode (SUBSTR (oauth_timestamp, 6));
      SELF.oauth_base_string :=
         SELF.base_string (p_http_method         => http_method,
                           p_request_token_url   => SELF.oauth_api_request_token_url,
                           p_callback_url        => SELF.oauth_callback,
                           p_consumer_key        => SELF.oauth_consumer_key,
                           p_timestamp           => SELF.oauth_timestamp,
                           p_nonce               => SELF.oauth_nonce);
      SELF.oauth_signature :=
         SELF.
         signature (p_oauth_base_string   => SELF.oauth_base_string,
                    p_oauth_key           => SELF.key_token (SELF.oauth_consumer_secret, NULL));
      SELF.var_http_authorization_header :=
         SELF.authorization_header (p_callback_url   => SELF.oauth_callback,
                                    p_consumer_key   => SELF.oauth_consumer_key,
                                    p_timestamp      => SELF.oauth_timestamp,
                                    p_nonce          => SELF.oauth_nonce,
                                    p_signature      => SELF.oauth_signature);
      --UTL_HTTP.set_proxy (pq_constants.con_str_http_proxy);
      UTL_HTTP.set_wallet (PATH => con_str_wallet_path, password => con_str_wallet_pass);
      UTL_HTTP.set_response_error_check (FALSE);
      UTL_HTTP.set_detailed_excp_support (FALSE);
      http_req := UTL_HTTP.begin_request (SELF.oauth_api_request_token_url, http_method, UTL_HTTP.http_version_1_1);
      UTL_HTTP.set_header (r => http_req, name => 'Authorization', VALUE => SELF.var_http_authorization_header);
      http_resp := UTL_HTTP.get_response (http_req);

      -- reads the Headers
      FOR i IN 1 .. UTL_HTTP.get_header_count (http_resp)
      LOOP
         UTL_HTTP.get_header (http_resp,
                              i,
                              var_http_header_name,
                              var_http_header_value);
      --DBMS_OUTPUT.put_line (var_http_header_name || ': ' || var_http_header_value);
      END LOOP;

      -- reads the Content
      BEGIN
         WHILE TRUE
         LOOP
            UTL_HTTP.read_line (http_resp, var_http_resp_value, TRUE);
            DBMS_OUTPUT.put_line ('Resp : ' || var_http_resp_value);

            IF INSTR (var_http_resp_value, 'oauth_token=') > 0
            THEN
               SELF.oauth_request_token_secret := SELF.token_extract (p_str => var_http_resp_value, p_pat => 'oauth_token_secret');
               SELF.oauth_request_token := SELF.token_extract (p_str => var_http_resp_value, p_pat => 'oauth_token');
               DBMS_OUTPUT.put_line ('oauth_token          : ' || SELF.oauth_request_token);
               DBMS_OUTPUT.put_line ('oauth_token_secret   : ' || SELF.oauth_request_token_secret);
               SELF.id := SELF.oauth_request_token;
               SELF.oauth_api_authorization_url := SELF.oauth_api_authorization_url || '?oauth_token=' || SELF.oauth_request_token;
            END IF;
         END LOOP;
      EXCEPTION
         WHEN UTL_HTTP.end_of_body
         THEN
            NULL;
      END;

      UTL_HTTP.end_response (http_resp);

      RETURN;
   END;

   MEMBER PROCEDURE save
   IS
   BEGIN
      UPDATE objs_evernote c
         SET c.obj_evernote = SELF
       WHERE account = SELF.id;

      IF SQL%ROWCOUNT = 0
      THEN
         INSERT INTO objs_evernote
              VALUES (SELF.id, SYSTIMESTAMP, SELF);
      END IF;
   END;

   MEMBER PROCEDURE upgrade_token
   IS
      http_method             CONSTANT VARCHAR2 (5) := 'POST';
      http_req                UTL_HTTP.req;
      http_resp               UTL_HTTP.resp;
      var_http_header_name    VARCHAR2 (255);
      var_http_header_value   VARCHAR2 (1023);
      var_http_resp_value     VARCHAR2 (32767);
      con_str_wallet_path     CONSTANT VARCHAR2 (500) := OAUTH.global_constants.con_str_wallet_path; --'file:C:\INyDIA\wallet';
      con_str_wallet_pass     CONSTANT VARCHAR2 (100) := OAUTH.global_constants.con_str_wallet_pass; --'Lepanto1571';
   BEGIN
      SELF.oauth_timestamp :=
         TO_CHAR (TRUNC ( (SYSDATE - TO_DATE ('01-01-1970', 'DD-MM-YYYY')) * (86400) - con_num_timestamp_tz_diff));
      SELF.oauth_nonce := SELF.urlencode (SUBSTR (oauth_timestamp, 6));

      SELF.oauth_base_string :=
         SELF.base_string (p_http_method         => http_method,
                           p_request_token_url   => SELF.oauth_api_access_token_url,
                           --p_callback_url        => SELF.oauth_callback,
                           p_consumer_key        => SELF.oauth_consumer_key,
                           p_timestamp           => SELF.oauth_timestamp,
                           p_nonce               => SELF.oauth_nonce,
                           p_token               => SELF.oauth_request_token,
                           p_token_verifier      => SELF.oauth_verifier);
      SELF.oauth_signature :=
         SELF.
         signature (p_oauth_base_string   => SELF.oauth_base_string,
                    p_oauth_key           => SELF.key_token (SELF.oauth_consumer_secret, SELF.oauth_request_token_secret));
      SELF.var_http_authorization_header :=
            'OAuth'
         || ' oauth_nonce="'
         || SELF.oauth_nonce
         || '", oauth_signature_method="HMAC-SHA1", oauth_timestamp="'
         || SELF.oauth_timestamp
         || '", oauth_consumer_key="'
         || SELF.oauth_consumer_key
         || '", oauth_token="'
         || SELF.oauth_request_token
         || '", oauth_verifier="'
         || SELF.oauth_verifier
         || '", oauth_signature="'
         || SELF.urlencode (oauth_signature)
         || '", oauth_version="1.0"';
      --

      SELF.oauth_api_access_token_url :=
            SELF.oauth_api_access_token_url
         || '?'
         || 'oauth_consumer_key='
         || SELF.oauth_consumer_key
         || '&oauth_token='
         || SELF.oauth_request_token;
      --UTL_HTTP.set_proxy (pq_constants.con_str_http_proxy);
      --            DBMS_OUTPUT.put_line ('oauth_consumer_key : ' || SELF.oauth_consumer_key);
      --            DBMS_OUTPUT.put_line ('oauth_consumer_secret : ' || SELF.oauth_consumer_secret);
      --            DBMS_OUTPUT.put_line ('oauth_request_token : ' || SELF.oauth_request_token);
      --            DBMS_OUTPUT.put_line ('oauth_request_token_secret : ' || SELF.oauth_request_token_secret);
      --            DBMS_OUTPUT.put_line ('oauth_nonce : ' || SELF.oauth_nonce);
      --            DBMS_OUTPUT.put_line ('oauth_timestamp : ' || SELF.oauth_timestamp);
      --            DBMS_OUTPUT.put_line ('oauth_base_string : ' || SELF.oauth_base_string);
      --            DBMS_OUTPUT.put_line ('oauth_signature : ' || SELF.oauth_signature);
      --            DBMS_OUTPUT.put_line ('var_http_authorization_header : ' || SELF.var_http_authorization_header);
      --            DBMS_OUTPUT.put_line ('oauth_api_access_token_url : ' || SELF.oauth_api_access_token_url);

      UTL_HTTP.set_wallet (PATH => con_str_wallet_path, PASSWORD => con_str_wallet_pass);
      UTL_HTTP.set_response_error_check (FALSE);
      UTL_HTTP.set_detailed_excp_support (FALSE);
      http_req := UTL_HTTP.begin_request (SELF.oauth_api_access_token_url, http_method, UTL_HTTP.http_version_1_1);
      UTL_HTTP.set_header (r => http_req, NAME => 'Authorization', VALUE => SELF.var_http_authorization_header);
      --UTL_HTTP.set_header (r => http_req, name => 'Content-Type', VALUE => 'text/xml');
      http_resp := UTL_HTTP.get_response (http_req);

      -- reads the Headers
      FOR i IN 1 .. UTL_HTTP.get_header_count (http_resp)
      LOOP
         UTL_HTTP.get_header (http_resp,
                              i,
                              var_http_header_name,
                              var_http_header_value);
      --DBMS_OUTPUT.put_line (var_http_header_name || ': ' || var_http_header_value);
      END LOOP;

      -- reads the Content
      BEGIN
         WHILE TRUE
         LOOP
            UTL_HTTP.read_line (http_resp, var_http_resp_value, TRUE);
            DBMS_OUTPUT.put_line ('Resp : ' || var_http_resp_value);

            IF INSTR (var_http_resp_value, 'oauth_token=') > 0
            THEN
               SELF.oauth_access_token := SELF.token_extract (p_str => var_http_resp_value, p_pat => 'oauth_token');
               SELF.oauth_access_token_secret := SELF.token_extract (p_str => var_http_resp_value, p_pat => 'oauth_token_secret');
               DBMS_OUTPUT.put_line ('oauth_token          : ' || SELF.oauth_access_token);
               DBMS_OUTPUT.put_line ('oauth_token_secret   : ' || SELF.oauth_access_token_secret);
            END IF;
         END LOOP;
      EXCEPTION
         WHEN UTL_HTTP.end_of_body
         THEN
            NULL;
      END;

      UTL_HTTP.end_response (http_resp);
   END upgrade_token;

   MEMBER PROCEDURE get_account (p_callback IN VARCHAR2 DEFAULT NULL, p_credentials_in_response OUT XMLTYPE)
   IS
      http_method             CONSTANT VARCHAR2 (5) := 'GET';
      oauth_api_url           VARCHAR2 (1000) := 'https://api.twitter.com/1/account/verify_credentials.xml';
      http_req                UTL_HTTP.req;
      http_resp               UTL_HTTP.resp;
      var_http_header_name    VARCHAR2 (255);
      var_http_header_value   VARCHAR2 (1023);
      var_http_resp_value     VARCHAR2 (32767);
      con_str_wallet_path     CONSTANT VARCHAR2 (500) := OAUTH.global_constants.con_str_wallet_path; --'file:C:\INyDIA\wallet';
      con_str_wallet_pass     CONSTANT VARCHAR2 (100) := OAUTH.global_constants.con_str_wallet_pass; --'Lepanto1571';
      l_clob                  CLOB;
      l_xml                   XMLTYPE;
      l_html                  VARCHAR2 (32767);
   BEGIN
      SELF.oauth_timestamp :=
         TO_CHAR (TRUNC ( (SYSDATE - TO_DATE ('01-01-1970', 'DD-MM-YYYY')) * (86400) - con_num_timestamp_tz_diff));
      SELF.oauth_nonce := SELF.urlencode (SUBSTR (oauth_timestamp, 6));
      SELF.oauth_base_string :=
         SELF.base_string (p_http_method         => http_method,
                           p_request_token_url   => oauth_api_url,
                           p_callback_url        => NULL,
                           p_consumer_key        => SELF.oauth_consumer_key,
                           p_timestamp           => SELF.oauth_timestamp,
                           p_nonce               => SELF.oauth_nonce,
                           p_token               => SELF.oauth_access_token,
                           p_token_verifier      => NULL);
      SELF.oauth_signature :=
         SELF.
         signature (p_oauth_base_string   => SELF.oauth_base_string,
                    p_oauth_key           => SELF.key_token (SELF.oauth_consumer_secret, SELF.oauth_access_token_secret));
      SELF.var_http_authorization_header :=
            'OAuth'
         || ' oauth_consumer_key="'
         || SELF.oauth_consumer_key
         || '", oauth_nonce="'
         || SELF.oauth_nonce
         || '", oauth_signature="'
         || SELF.urlencode (oauth_signature)
         || '", oauth_signature_method="HMAC-SHA1", oauth_timestamp="'
         || SELF.oauth_timestamp
         || '", oauth_token="'
         || SELF.oauth_access_token
         || '", oauth_version="1.0"';
      --|| '"';

      --      oauth_api_url :=
      --            oauth_api_url
      --         || '?'
      --         || 'oauth_consumer_key='
      --         || SELF.oauth_consumer_key
      --         || '&oauth_nonce='
      --         || SELF.oauth_nonce
      --         || '&oauth_signature='
      --         || SELF.urlencode (oauth_signature)
      --         || '&oauth_signature_method=HMAC-SHA1'
      --         || '&oauth_timestamp='
      --         || SELF.oauth_timestamp
      --         || '&oauth_token='
      --         || SELF.oauth_access_token
      --         || '&oauth_version=1.0';

      --      DBMS_OUTPUT.put_line ('oauth_consumer_key : ' || SELF.oauth_consumer_key);
      --      DBMS_OUTPUT.put_line ('oauth_consumer_secret : ' || SELF.oauth_consumer_secret);
      --      DBMS_OUTPUT.put_line ('oauth_access_token : ' || SELF.oauth_access_token);
      --      DBMS_OUTPUT.put_line ('oauth_access_token_secret : ' || SELF.oauth_access_token_secret);
      --      DBMS_OUTPUT.put_line ('oauth_nonce : ' || SELF.oauth_nonce);
      --      DBMS_OUTPUT.put_line ('oauth_timestamp : ' || SELF.oauth_timestamp);
      --      DBMS_OUTPUT.put_line ('oauth_base_string : ' || SELF.oauth_base_string);
      --      DBMS_OUTPUT.put_line ('oauth_signature : ' || SELF.oauth_signature);
      --      DBMS_OUTPUT.put_line ('var_http_authorization_header : ' || SELF.var_http_authorization_header);
      --      DBMS_OUTPUT.put_line ('oauth_api_url : ' || oauth_api_url);

      UTL_HTTP.set_wallet (PATH => con_str_wallet_path, PASSWORD => con_str_wallet_pass);
      UTL_HTTP.set_response_error_check (FALSE);
      UTL_HTTP.set_detailed_excp_support (FALSE);
      http_req := UTL_HTTP.begin_request (oauth_api_url, http_method, UTL_HTTP.http_version_1_1);
      UTL_HTTP.set_header (r => http_req, name => 'Authorization', VALUE => var_http_authorization_header);
      http_resp := UTL_HTTP.get_response (http_req);

      -- reads the Headers
      FOR i IN 1 .. UTL_HTTP.get_header_count (http_resp)
      LOOP
         UTL_HTTP.get_header (http_resp,
                              i,
                              var_http_header_name,
                              var_http_header_value);
      --DBMS_OUTPUT.put_line (var_http_header_name || ': ' || var_http_header_value);
      END LOOP;

      DBMS_LOB.createtemporary (l_clob, FALSE);

      -- reads the Content
      BEGIN
         WHILE TRUE
         LOOP
            UTL_HTTP.read_line (http_resp, var_http_resp_value, TRUE);
            --DBMS_OUTPUT.put_line ('Resp : ' || var_http_resp_value);
            DBMS_LOB.writeappend (l_clob, LENGTH (var_http_resp_value), var_http_resp_value);
         END LOOP;
      EXCEPTION
         WHEN UTL_HTTP.end_of_body
         THEN
            NULL;
      END;

      p_credentials_in_response := xmltype (l_clob);

      UTL_HTTP.end_response (http_resp);
      --HTP.p (l_clob);
      DBMS_LOB.freetemporary (l_clob);
   END get_account;

   MEMBER PROCEDURE post_status (p_status IN VARCHAR2 DEFAULT 'chip', p_result_in_response OUT XMLTYPE)
   IS
      http_method             CONSTANT VARCHAR2 (5) := 'POST';
      oauth_api_url           VARCHAR2 (1000) := 'https://api.twitter.com/1/statuses/update.xml';
      oauth_api_params        VARCHAR2 (2000)
                                 :=    'status='
                                    || REPLACE (SELF.urlencode (p_status), ' ', '+')
                                    || '&trim_user=true&include_entities=true&wrap_links=true';
      http_req                UTL_HTTP.req;
      http_resp               UTL_HTTP.resp;
      var_http_header_name    VARCHAR2 (255);
      var_http_header_value   VARCHAR2 (1023);
      var_http_resp_value     VARCHAR2 (32767);
      con_str_wallet_path     CONSTANT VARCHAR2 (500) := OAUTH.global_constants.con_str_wallet_path; --'file:C:\INyDIA\wallet';
      con_str_wallet_pass     CONSTANT VARCHAR2 (100) := OAUTH.global_constants.con_str_wallet_pass; --'Lepanto1571';
      l_clob                  CLOB;
      l_xml                   XMLTYPE;
      l_html                  VARCHAR2 (32767);
   BEGIN
      SELF.oauth_timestamp :=
         TO_CHAR (TRUNC ( (SYSDATE - TO_DATE ('01-01-1970', 'DD-MM-YYYY')) * (86400) - con_num_timestamp_tz_diff));
      SELF.oauth_nonce := SELF.urlencode (SUBSTR (oauth_timestamp, 6));
      SELF.oauth_base_string :=
         http_method || '&' || SELF.urlencode (oauth_api_url) || '&'
         || SELF.urlencode (
                  'include_entities=true&oauth_consumer_key='
               || SELF.urlencode (SELF.oauth_consumer_key)
               || '&oauth_nonce='
               || SELF.oauth_nonce
               || '&oauth_signature_method=HMAC-SHA1&oauth_timestamp='
               || SELF.oauth_timestamp
               || '&oauth_token='
               || SELF.oauth_access_token
               || '&oauth_version=1.0'
               || '&status='
               || SELF.urlencode (p_status)
               || '&trim_user=true&wrap_links=true');

      SELF.oauth_signature :=
         SELF.
         signature (p_oauth_base_string   => SELF.oauth_base_string,
                    p_oauth_key           => SELF.key_token (SELF.oauth_consumer_secret, SELF.oauth_access_token_secret));
      SELF.var_http_authorization_header :=
            'OAuth'
         || ' oauth_consumer_key="'
         || SELF.oauth_consumer_key
         || '", oauth_nonce="'
         || SELF.oauth_nonce
         || '", oauth_signature="'
         || SELF.urlencode (oauth_signature)
         || '", oauth_signature_method="HMAC-SHA1", oauth_timestamp="'
         || SELF.oauth_timestamp
         || '", oauth_token="'
         || SELF.oauth_access_token
         || '", oauth_version="1.0"';

      --      DBMS_OUTPUT.put_line ('oauth_consumer_key : ' || SELF.oauth_consumer_key);
      --      DBMS_OUTPUT.put_line ('oauth_consumer_secret : ' || SELF.oauth_consumer_secret);
      --      DBMS_OUTPUT.put_line ('oauth_access_token : ' || SELF.oauth_access_token);
      --      DBMS_OUTPUT.put_line ('oauth_access_token_secret : ' || SELF.oauth_access_token_secret);
      --      DBMS_OUTPUT.put_line ('oauth_nonce : ' || SELF.oauth_nonce);
      --      DBMS_OUTPUT.put_line ('oauth_timestamp : ' || SELF.oauth_timestamp);
      --DBMS_OUTPUT.put_line ('oauth_base_string : ' || SELF.oauth_base_string);
      --DBMS_OUTPUT.put_line ('oauth_api_params : ' || oauth_api_params);
      --      DBMS_OUTPUT.put_line ('oauth_signature : ' || SELF.oauth_signature);
      --      DBMS_OUTPUT.put_line ('var_http_authorization_header : ' || SELF.var_http_authorization_header);
      --      DBMS_OUTPUT.put_line ('oauth_api_url : ' || oauth_api_url);

      UTL_HTTP.set_wallet (PATH => con_str_wallet_path, PASSWORD => con_str_wallet_pass);
      UTL_HTTP.set_response_error_check (FALSE);
      UTL_HTTP.set_detailed_excp_support (FALSE);
      http_req := UTL_HTTP.begin_request (oauth_api_url, http_method, UTL_HTTP.http_version_1_1);
      UTL_HTTP.set_header (r => http_req, name => 'Authorization', VALUE => var_http_authorization_header);

      UTL_HTTP.set_header (r => http_req, name => 'Content-Length', VALUE => LENGTH (oauth_api_params));
      UTL_HTTP.write_text (r => http_req, data => oauth_api_params);
      http_resp := UTL_HTTP.get_response (http_req);

      -- reads the Headers
      FOR i IN 1 .. UTL_HTTP.get_header_count (http_resp)
      LOOP
         UTL_HTTP.get_header (http_resp,
                              i,
                              var_http_header_name,
                              var_http_header_value);
      --DBMS_OUTPUT.put_line (var_http_header_name || ': ' || var_http_header_value);
      END LOOP;

      DBMS_LOB.createtemporary (l_clob, FALSE);

      -- reads the Content
      BEGIN
         WHILE TRUE
         LOOP
            UTL_HTTP.read_line (http_resp, var_http_resp_value, TRUE);
            --DBMS_OUTPUT.put_line ('Resp : ' || var_http_resp_value);
            DBMS_LOB.writeappend (l_clob, LENGTH (var_http_resp_value), var_http_resp_value);
         END LOOP;
      EXCEPTION
         WHEN UTL_HTTP.end_of_body
         THEN
            NULL;
      END;

      p_result_in_response := xmltype (l_clob);

      UTL_HTTP.end_response (http_resp);
      --HTP.p (l_clob);
      DBMS_LOB.freetemporary (l_clob);
   END post_status;

   MEMBER PROCEDURE post_status_with_media (p_status IN VARCHAR2 DEFAULT 'chip', p_result_in_response OUT XMLTYPE)
   IS
      http_method             CONSTANT VARCHAR2 (5) := 'POST';
      oauth_api_url           VARCHAR2 (1000) := 'https://upload.twitter.com/1/statuses/update_with_media.xml';
      oauth_api_params        VARCHAR2 (2000)
                                 :=    'status='
                                    || REPLACE (SELF.urlencode (p_status), ' ', '+')
                                    || '&trim_user=true&include_entities=true';
      http_req                UTL_HTTP.req;
      http_resp               UTL_HTTP.resp;
      var_http_header_name    VARCHAR2 (255);
      var_http_header_value   VARCHAR2 (1023);
      var_http_resp_value     VARCHAR2 (32767);
      con_str_wallet_path     CONSTANT VARCHAR2 (500) := OAUTH.global_constants.con_str_wallet_path; --'file:C:\INyDIA\wallet';
      con_str_wallet_pass     CONSTANT VARCHAR2 (100) := OAUTH.global_constants.con_str_wallet_pass; --'Lepanto1571';
      l_clob                  CLOB;
      l_xml                   XMLTYPE;
      l_html                  VARCHAR2 (32767);
      l_msg_multipart         VARCHAR2 (32767) := NULL;
      l_msg_multipart2        VARCHAR2 (32767) := NULL;
      con_str_crlf            CONSTANT VARCHAR2 (2) := CHR (13) || CHR (10);
      l_source_pic            BFILE;
      p_filename              VARCHAR2 (150) := 'mstr.gif';
      p_file_dir              VARCHAR2 (50) := 'EUROSTAT';
      l_multipart             NUMBER;
      l_amount                BINARY_INTEGER;
      l_buffer_size           CONSTANT BINARY_INTEGER := 32767;
      l_offset                NUMBER (38);
      l_buffer                RAW (32767);
   BEGIN
      SELF.oauth_timestamp :=
         TO_CHAR (TRUNC ( (SYSDATE - TO_DATE ('01-01-1970', 'DD-MM-YYYY')) * (86400) - con_num_timestamp_tz_diff));
      SELF.oauth_nonce := SELF.urlencode (SUBSTR (oauth_timestamp, 6));
      SELF.oauth_base_string :=
         http_method || '&' || SELF.urlencode (oauth_api_url) || '&'
         || SELF.urlencode (
                  'oauth_consumer_key='
               || SELF.urlencode (SELF.oauth_consumer_key)
               || '&oauth_nonce='
               || SELF.oauth_nonce
               || '&oauth_signature_method=HMAC-SHA1&oauth_timestamp='
               || SELF.oauth_timestamp
               || '&oauth_token='
               || SELF.oauth_access_token
               || '&oauth_version=1.0');

      SELF.oauth_signature :=
         SELF.
         signature (p_oauth_base_string   => SELF.oauth_base_string,
                    p_oauth_key           => SELF.key_token (SELF.oauth_consumer_secret, SELF.oauth_access_token_secret));
      SELF.var_http_authorization_header :=
            'OAuth'
         || ' oauth_consumer_key="'
         || SELF.oauth_consumer_key
         || '", oauth_nonce="'
         || SELF.oauth_nonce
         || '", oauth_signature="'
         || SELF.urlencode (oauth_signature)
         || '", oauth_signature_method="HMAC-SHA1", oauth_timestamp="'
         || SELF.oauth_timestamp
         || '", oauth_token="'
         || SELF.oauth_access_token
         || '", oauth_version="1.0"';

      --      DBMS_OUTPUT.put_line ('oauth_consumer_key : ' || SELF.oauth_consumer_key);
      --      DBMS_OUTPUT.put_line ('oauth_consumer_secret : ' || SELF.oauth_consumer_secret);
      --      DBMS_OUTPUT.put_line ('oauth_access_token : ' || SELF.oauth_access_token);
      --      DBMS_OUTPUT.put_line ('oauth_access_token_secret : ' || SELF.oauth_access_token_secret);
      --      DBMS_OUTPUT.put_line ('oauth_nonce : ' || SELF.oauth_nonce);
      --      DBMS_OUTPUT.put_line ('oauth_timestamp : ' || SELF.oauth_timestamp);
      --      DBMS_OUTPUT.put_line ('oauth_base_string : ' || SELF.oauth_base_string);
      --      DBMS_OUTPUT.put_line ('oauth_api_params : ' || oauth_api_params);
      --      DBMS_OUTPUT.put_line ('oauth_signature : ' || SELF.oauth_signature);
      --      DBMS_OUTPUT.put_line ('var_http_authorization_header : ' || SELF.var_http_authorization_header);
      --      DBMS_OUTPUT.put_line ('oauth_api_url : ' || oauth_api_url);

      --reads picture file locator
      l_source_pic := BFILENAME (p_file_dir, p_filename);
      --open picture file for LOB
      DBMS_LOB.FILEOPEN (file_loc => l_source_pic, open_mode => DBMS_LOB.FILE_READONLY);

      --post message
      l_msg_multipart := l_msg_multipart || '-----------------------------7d5b36e0752' || con_str_crlf;
      l_msg_multipart :=
            l_msg_multipart
         || 'Content-Disposition: form-data; name="media_data[]"; filename="'
         || p_filename
         || '"'
         || con_str_crlf;
      l_msg_multipart := l_msg_multipart || 'Content-Type: ' || 'image/gif' || con_str_crlf;
      --l_msg_multipart := l_msg_multipart || con_str_crlf;
      l_msg_multipart2 := l_msg_multipart2 || '-----------------------------7d5b36e0752' || con_str_crlf;
      l_msg_multipart2 := l_msg_multipart2 || 'Content-Disposition: form-data; name="status"' || con_str_crlf;
      --l_msg_multipart2 := l_msg_multipart2 || 'Content-Type: ' || 'text/plain; charset=utf-8' || con_str_crlf;
      l_msg_multipart2 := l_msg_multipart2 || con_str_crlf;
      l_msg_multipart2 := l_msg_multipart2 || 'Eccomi' || con_str_crlf;
      l_msg_multipart2 := l_msg_multipart2 || '-----------------------------7d5b36e0752' || con_str_crlf;

      DBMS_OUTPUT.put_line (l_msg_multipart);
      DBMS_OUTPUT.put_line ('flength :' || TO_CHAR (flength (p_file_dir, p_filename)));
      DBMS_OUTPUT.put_line (l_msg_multipart2);

      --calculates message total length
      l_multipart := LENGTH (l_msg_multipart) + LENGTH (l_msg_multipart2) + flength (p_file_dir, p_filename);
      DBMS_OUTPUT.put_line ('l_multipart :' || TO_CHAR (l_multipart));

      UTL_HTTP.set_wallet (PATH => con_str_wallet_path, PASSWORD => con_str_wallet_pass);
      UTL_HTTP.set_response_error_check (FALSE);
      UTL_HTTP.set_detailed_excp_support (FALSE);
      http_req := UTL_HTTP.begin_request (oauth_api_url, http_method, UTL_HTTP.http_version_1_1);

      UTL_HTTP.set_header (r => http_req, name => 'Authorization', VALUE => var_http_authorization_header);
      UTL_HTTP.
      set_header (r       => http_req,
                  name    => 'Content-Type',
                  VALUE   => 'multipart/form-data; boundary=---------------------------7d5b36e0752');
      UTL_HTTP.set_header (r => http_req, name => 'Content-Length', VALUE => TO_CHAR (l_multipart));

      --sends the message text part
      UTL_HTTP.write_text (http_req, l_msg_multipart);
      l_amount := l_buffer_size;
      l_offset := 1;

      --sends the message binary part
      WHILE l_amount >= l_buffer_size
      LOOP
         DBMS_LOB.READ (file_loc   => l_source_pic,
                        amount     => l_amount,
                        offset     => l_offset,
                        buffer     => l_buffer);
         l_offset := l_offset + l_amount;
         UTL_HTTP.write_raw (http_req, l_buffer);
      END LOOP;

      --sends the message text end boundary
      UTL_HTTP.write_text (http_req, '-----------------------------7d5b36e0752' || con_str_crlf);

      --sends the second message text part
      UTL_HTTP.write_text (http_req, l_msg_multipart2);
      --      --sends the message text end boundary
      --      UTL_HTTP.write_text (http_req, '-----------------------------7d5b36e0752' || con_str_crlf);

      http_resp := UTL_HTTP.get_response (http_req);

      --
      --      -- reads the Headers
      FOR i IN 1 .. UTL_HTTP.get_header_count (http_resp)
      LOOP
         UTL_HTTP.get_header (http_resp,
                              i,
                              var_http_header_name,
                              var_http_header_value);
         DBMS_OUTPUT.put_line (var_http_header_name || ': ' || var_http_header_value);
      END LOOP;

      --
      -- reads the Content
      BEGIN
         WHILE TRUE
         LOOP
            UTL_HTTP.read_line (http_resp, var_http_resp_value, TRUE);
            DBMS_OUTPUT.put_line ('Resp : ' || var_http_resp_value);
         --DBMS_LOB.writeappend (l_clob, LENGTH (var_http_resp_value), var_http_resp_value);
         END LOOP;
      EXCEPTION
         WHEN UTL_HTTP.end_of_body
         THEN
            NULL;
      END;


      UTL_HTTP.end_response (http_resp);
   --      DBMS_LOB.createtemporary (l_clob, FALSE);
   --
   --      -- reads the Content
   --      BEGIN
   --         WHILE TRUE
   --         LOOP
   --            UTL_HTTP.read_line (http_resp, var_http_resp_value, TRUE);
   --            --DBMS_OUTPUT.put_line ('Resp : ' || var_http_resp_value);
   --            DBMS_LOB.writeappend (l_clob, LENGTH (var_http_resp_value), var_http_resp_value);
   --         END LOOP;
   --      EXCEPTION
   --         WHEN UTL_HTTP.end_of_body
   --         THEN
   --            NULL;
   --      END;
   --
   --      p_result_in_response := xmltype (l_clob);
   --
   --      UTL_HTTP.end_response (http_resp);
   --      --HTP.p (l_clob);
   --      DBMS_LOB.freetemporary (l_clob);
   END post_status_with_media;
END;
/