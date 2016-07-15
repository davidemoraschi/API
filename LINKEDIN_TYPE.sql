/* Formatted on 02/09/2012 15:50:17 (QP5 v5.139.911.3011) */
--DROP TYPE LINKEDIN;

CREATE OR REPLACE TYPE LINKEDIN.LINKEDIN
   UNDER OAUTH.OAUTH
   (
      oauth_callback VARCHAR2 (1000),
      originalurl VARCHAR2 (4000),
      CONSTRUCTOR FUNCTION LINKEDIN (id                      IN VARCHAR2 DEFAULT 'test',
                                     oauth_consumer_key      IN VARCHAR2 DEFAULT NULL,
                                     oauth_consumer_secret   IN VARCHAR2 DEFAULT NULL,
                                     oauth_callback          IN VARCHAR2 DEFAULT 'oob')
         RETURN SELF AS RESULT,
      MEMBER FUNCTION base_string_scope (p_http_method         IN VARCHAR2 DEFAULT 'GET',
                                         p_request_token_url   IN VARCHAR2,
                                         p_callback_url        IN VARCHAR2 DEFAULT NULL,
                                         p_consumer_key        IN VARCHAR2,
                                         p_timestamp           IN VARCHAR2,
                                         p_nonce               IN VARCHAR2,
                                         p_token               IN VARCHAR2 DEFAULT NULL,
                                         p_token_verifier      IN VARCHAR2 DEFAULT NULL,
                                         p_scope               IN VARCHAR2 DEFAULT 'r_network%20r_contactinfo%20rw_groups')
         RETURN VARCHAR2,
      MEMBER FUNCTION blob_to_clob (blob_in IN BLOB)
         RETURN CLOB,
      MEMBER PROCEDURE save,
      MEMBER PROCEDURE remove,
      MEMBER PROCEDURE upgrade_token,
      MEMBER PROCEDURE get_profile (p_fields IN VARCHAR2 DEFAULT '(id,first-name,last-name,headline)'),
      MEMBER PROCEDURE get_connections (p_fields IN VARCHAR2 DEFAULT '(id,first-name,last-name)', p_response OUT XMLTYPE),
      MEMBER PROCEDURE get_connection_profile (p_account    IN     VARCHAR2,
                                               p_fields     IN     VARCHAR2 DEFAULT '(id,first-name,last-name)',
                                               p_response      OUT XMLTYPE));
/

CREATE TABLE LINKEDIN.OBJS_LINKEDIN
(
   ACCOUNT         VARCHAR2 (50 BYTE),
   CREATION_DATE   TIMESTAMP (6) WITH TIME ZONE,
   OBJ_LINKEDIN    LINKEDIN.LINKEDIN,
  CONSTRAINT OBJECTS_LINKEDIN_PK
 PRIMARY KEY
 (ACCOUNT)
)
;

--DROP TYPE BODY LINKEDIN.LINKEDIN;

CREATE OR REPLACE TYPE BODY LINKEDIN.LINKEDIN
AS
   CONSTRUCTOR FUNCTION LINKEDIN (id                      IN VARCHAR2 DEFAULT 'test',
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
   BEGIN
      SELF.id := id;
      SELF.con_num_timestamp_tz_diff := OAUTH.global_constants.con_num_timestamp_tz_diff;
      SELF.oauth_consumer_key := oauth_consumer_key;
      SELF.oauth_consumer_secret := oauth_consumer_secret;
      --SELF.oauth_api_request_token_url := 'https://api.linkedin.com/uas/oauth/requestToken?scope=r_network+r_contactinfo+rw_groups';
      SELF.oauth_api_request_token_url := 'https://api.linkedin.com/uas/oauth/requestToken';
      SELF.oauth_api_authorization_url := 'https://www.linkedin.com/uas/oauth/authenticate';
      SELF.oauth_api_access_token_url := 'https://api.linkedin.com/uas/oauth/accessToken';
      SELF.oauth_timestamp :=
         TO_CHAR (TRUNC ( (SYSDATE - TO_DATE ('01-01-1970', 'DD-MM-YYYY')) * (86400) - SELF.con_num_timestamp_tz_diff));
      SELF.oauth_nonce := SELF.urlencode (SUBSTR (oauth_timestamp, 6));
      SELF.oauth_callback := oauth_callback;
      SELF.oauth_base_string :=
         SELF.base_string_scope (p_http_method         => http_method,
                                 p_request_token_url   => SELF.oauth_api_request_token_url,
                                 p_callback_url        => SELF.oauth_callback,
                                 p_consumer_key        => SELF.oauth_consumer_key,
                                 p_timestamp           => SELF.oauth_timestamp,
                                 p_nonce               => SELF.oauth_nonce,
                                 p_token               => NULL,
                                 p_token_verifier      => NULL,
                                 p_scope               => 'r_network%20r_contactinfo%20rw_groups%20r_fullprofile');
      --DBMS_OUTPUT.put_line ('oauth_base_string' || ': ' || oauth_base_string);
      SELF.oauth_signature :=
         SELF.
         signature (p_oauth_base_string   => SELF.oauth_base_string,
                    p_oauth_key           => SELF.key_token (SELF.oauth_consumer_secret, NULL));
      SELF.var_http_authorization_header :=
         SELF.authorization_header (p_callback_url   => SELF.oauth_callback,
                                    p_consumer_key   => SELF.oauth_consumer_key,
                                    p_timestamp      => SELF.oauth_timestamp,
                                    p_nonce          => SELF.oauth_nonce,
                                    p_signature      => SELF.oauth_signature,
                                    p_token          => NULL,
                                    p_verifier       => NULL);
      --UTL_HTTP.set_proxy (pq_constants.con_str_http_proxy);
      UTL_HTTP.
      set_wallet (PATH => OAUTH.global_constants.con_str_wallet_path, PASSWORD => OAUTH.global_constants.con_str_wallet_pass);
      UTL_HTTP.set_response_error_check (FALSE);
      UTL_HTTP.set_detailed_excp_support (FALSE);
      http_req :=
         UTL_HTTP.
         begin_request (SELF.oauth_api_request_token_url || '?scope=r_network+r_contactinfo+rw_groups+r_fullprofile',
                        http_method,
                        UTL_HTTP.http_version_1_1);
      UTL_HTTP.set_header (r => http_req, NAME => 'Authorization', VALUE => SELF.var_http_authorization_header);
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
               SELF.oauth_request_token := SELF.token_extract (p_str => var_http_resp_value, p_pat => 'oauth_token');
               SELF.oauth_request_token_secret := SELF.token_extract (p_str => var_http_resp_value, p_pat => 'oauth_token_secret');
               DBMS_OUTPUT.put_line ('oauth_token          : ' || SELF.oauth_request_token);
               DBMS_OUTPUT.put_line ('oauth_token_secret   : ' || SELF.oauth_request_token_secret);
               SELF.ID := SELF.oauth_request_token;
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

   MEMBER FUNCTION base_string_scope (p_http_method         IN VARCHAR2 DEFAULT 'GET',
                                      p_request_token_url   IN VARCHAR2,
                                      p_callback_url        IN VARCHAR2 DEFAULT NULL,
                                      p_consumer_key        IN VARCHAR2,
                                      p_timestamp           IN VARCHAR2,
                                      p_nonce               IN VARCHAR2,
                                      p_token               IN VARCHAR2 DEFAULT NULL,
                                      p_token_verifier      IN VARCHAR2 DEFAULT NULL,
                                      p_scope               IN VARCHAR2 DEFAULT 'r_network%20r_contactinfo%20rw_groups')
      RETURN VARCHAR2
   IS
      v_oauth_base_string            VARCHAR2 (4000);
      v_temp_base_string             VARCHAR2 (4000);

      TYPE typ_str_oauth_parameter_values IS TABLE OF VARCHAR2 (4000)
                                                INDEX BY VARCHAR2 (250);

      v_str_oauth_parameter_values   typ_str_oauth_parameter_values;
      v_idx                          VARCHAR2 (250);
   BEGIN
      IF p_callback_url IS NOT NULL
      THEN
         v_str_oauth_parameter_values ('oauth_callback') := SELF.urlencode (p_callback_url);
      END IF;

      v_str_oauth_parameter_values ('oauth_consumer_key') := SELF.urlencode (p_consumer_key);
      v_str_oauth_parameter_values ('oauth_nonce') := p_nonce;
      v_str_oauth_parameter_values ('oauth_signature_method') := 'HMAC-SHA1';
      v_str_oauth_parameter_values ('oauth_timestamp') := p_timestamp;

      --v_str_oauth_parameter_values ('scope') := p_scope;

      IF p_token IS NOT NULL
      THEN
         v_str_oauth_parameter_values ('oauth_token') := SELF.urlencode (p_token);
      END IF;

      IF p_scope IS NOT NULL
      THEN
         v_str_oauth_parameter_values ('scope') := (p_scope);
      END IF;

      IF p_token_verifier IS NOT NULL
      THEN
         v_str_oauth_parameter_values ('oauth_verifier') := p_token_verifier;
      END IF;

      v_str_oauth_parameter_values ('oauth_version') := '1.0';
      v_idx := v_str_oauth_parameter_values.FIRST;

      LOOP
         v_temp_base_string := v_temp_base_string || v_idx || '=' || v_str_oauth_parameter_values (v_idx);
         v_idx := v_str_oauth_parameter_values.NEXT (v_idx);

         IF v_idx IS NOT NULL
         THEN
            v_temp_base_string := v_temp_base_string || '&';
         END IF;

         EXIT WHEN v_idx IS NULL;
      END LOOP;

      v_oauth_base_string :=
         p_http_method || '&' || SELF.urlencode (p_request_token_url) || '&' || SELF.urlencode (v_temp_base_string);
      RETURN v_oauth_base_string;
   END base_string_scope;

   MEMBER FUNCTION blob_to_clob (blob_in IN BLOB)
      RETURN CLOB
   AS
      v_clob      CLOB;
      v_varchar   VARCHAR2 (32767);
      v_start     PLS_INTEGER := 1;
      v_buffer    PLS_INTEGER := 32767;
   BEGIN
      DBMS_LOB.CREATETEMPORARY (v_clob, TRUE);

      FOR i IN 1 .. CEIL (DBMS_LOB.GETLENGTH (blob_in) / v_buffer)
      LOOP
         v_varchar := UTL_RAW.CAST_TO_VARCHAR2 (DBMS_LOB.SUBSTR (blob_in, v_buffer, v_start));

         DBMS_LOB.WRITEAPPEND (v_clob, LENGTH (v_varchar), v_varchar);

         v_start := v_start + v_buffer;
      END LOOP;

      RETURN v_clob;
   END blob_to_clob;

   MEMBER PROCEDURE SAVE
   IS
   BEGIN
      UPDATE objs_linkedin C
         SET c.obj_linkedin = SELF
       WHERE ACCOUNT = SELF.ID;

      IF SQL%ROWCOUNT = 0
      THEN
         INSERT INTO objs_linkedin
              VALUES (SELF.ID, SYSTIMESTAMP, SELF);
      END IF;
   END;

   MEMBER PROCEDURE remove
   IS
   BEGIN
      DELETE objs_linkedin
       --SET c.obj_linkedin = SELF
       WHERE ACCOUNT = SELF.ID;
   --      IF SQL%ROWCOUNT = 0
   --      THEN
   --         INSERT INTO objs_linkedin
   --              VALUES (SELF.ID, SYSTIMESTAMP, SELF);
   --      END IF;
   END;

   MEMBER PROCEDURE upgrade_token
   IS
      http_method             CONSTANT VARCHAR2 (5) := 'POST';
      http_req                UTL_HTTP.req;
      http_resp               UTL_HTTP.resp;
      var_http_header_name    VARCHAR2 (255);
      var_http_header_value   VARCHAR2 (1023);
      var_http_resp_value     VARCHAR2 (32767);
   --con_str_wallet_path   CONSTANT VARCHAR2 (500) := 'file:C:\INyDIA\wallet';
   --con_str_wallet_pass   CONSTANT VARCHAR2 (100) := 'Lepanto1571';
   BEGIN
      SELF.oauth_timestamp :=
         TO_CHAR (TRUNC ( (SYSDATE - TO_DATE ('01-01-1970', 'DD-MM-YYYY')) * (86400) - con_num_timestamp_tz_diff));
      SELF.oauth_nonce := SELF.urlencode (SUBSTR (oauth_timestamp, 6));

      SELF.oauth_base_string :=
         SELF.base_string2 (p_http_method         => http_method,
                            p_request_token_url   => SELF.oauth_api_access_token_url,
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
         SELF.authorization_header (p_consumer_key   => SELF.oauth_consumer_key,
                                    p_timestamp      => SELF.oauth_timestamp,
                                    p_nonce          => SELF.oauth_nonce,
                                    p_signature      => SELF.oauth_signature,
                                    p_token          => SELF.oauth_request_token,
                                    p_verifier       => SELF.oauth_verifier);
      --UTL_HTTP.set_proxy (pq_constants.con_str_http_proxy);

      UTL_HTTP.
      set_wallet (PATH => OAUTH.global_constants.con_str_wallet_path, PASSWORD => OAUTH.global_constants.con_str_wallet_pass);
      UTL_HTTP.set_response_error_check (FALSE);
      UTL_HTTP.set_detailed_excp_support (FALSE);

      http_req := UTL_HTTP.begin_request (SELF.oauth_api_access_token_url, http_method, UTL_HTTP.http_version_1_1);
      UTL_HTTP.set_header (r => http_req, NAME => 'Authorization', VALUE => SELF.var_http_authorization_header);
      UTL_HTTP.set_header (r => http_req, name => 'Content-Type', VALUE => 'text/xml');
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

   MEMBER PROCEDURE get_profile (p_fields IN VARCHAR2 DEFAULT '(id,first-name,last-name,headline)')
   IS
      http_method             CONSTANT VARCHAR2 (5) := 'GET';
      oauth_api_url           VARCHAR2 (1000) := 'http://api.linkedin.com/v1/people/~:' || p_fields;
      http_req                UTL_HTTP.req;
      http_resp               UTL_HTTP.resp;
      var_http_header_name    VARCHAR2 (255);
      var_http_header_value   VARCHAR2 (1023);
      var_http_resp_value     VARCHAR2 (32767);
      l_clob                  CLOB;
      l_xml                   XMLTYPE;
   BEGIN
      SELF.oauth_timestamp :=
         TO_CHAR (TRUNC ( (SYSDATE - TO_DATE ('01-01-1970', 'DD-MM-YYYY')) * (86400) - con_num_timestamp_tz_diff));
      SELF.oauth_nonce := SELF.urlencode (SUBSTR (oauth_timestamp, 6));
      SELF.oauth_base_string :=
         SELF.base_string2 (p_http_method         => http_method,
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
         SELF.authorization_header (p_consumer_key   => SELF.oauth_consumer_key,
                                    p_timestamp      => SELF.oauth_timestamp,
                                    p_nonce          => SELF.oauth_nonce,
                                    p_signature      => SELF.oauth_signature,
                                    p_token          => SELF.oauth_access_token,
                                    p_verifier       => NULL);
      --UTL_HTTP.set_proxy (pq_constants.con_str_http_proxy);
      UTL_HTTP.
      set_wallet (PATH => OAUTH.global_constants.con_str_wallet_path, PASSWORD => OAUTH.global_constants.con_str_wallet_pass);
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
            DBMS_LOB.writeappend (l_clob, LENGTH (var_http_resp_value), var_http_resp_value);
         END LOOP;
      EXCEPTION
         WHEN UTL_HTTP.end_of_body
         THEN
            NULL;
      END;

      l_xml := xmltype (l_clob);
      DBMS_LOB.freetemporary (l_clob);

      UTL_HTTP.end_response (http_resp);
      SELF.remove;
      SELF.ID := 'LNKD_' || l_xml.EXTRACT ('/person/id/text()').getstringval ();
      SELF.descr :=
            l_xml.EXTRACT ('/person/first-name/text()').getstringval ()
         || ' '
         || l_xml.EXTRACT ('/person/last-name/text()').getstringval ();
      SELF.save;
   END get_profile;

   MEMBER PROCEDURE get_connections (p_fields IN VARCHAR2 DEFAULT '(id,first-name,last-name)', p_response OUT XMLTYPE)
   --RETURN XMLTYPE
   IS
      http_method             CONSTANT VARCHAR2 (5) := 'GET';
      oauth_api_url           VARCHAR2 (1000) := 'http://api.linkedin.com/v1/people/~/connections:' || p_fields;
      --http://api.linkedin.com/v1/people/~/connections:(headline,first-name,last-name)
      http_req                UTL_HTTP.req;
      http_resp               UTL_HTTP.resp;
      var_http_header_name    VARCHAR2 (255);
      var_http_header_value   VARCHAR2 (1023);
      var_http_resp_value     VARCHAR2 (32767);
      l_uncompressed_clob     CLOB;
      --l_xml                   XMLTYPE;
      l_uncompressed_blob     BLOB;
      l_gzcompressed_blob     BLOB;
      l_raw                   RAW (32767);
   BEGIN
      SELF.oauth_timestamp :=
         TO_CHAR (TRUNC ( (SYSDATE - TO_DATE ('01-01-1970', 'DD-MM-YYYY')) * (86400) - con_num_timestamp_tz_diff));
      SELF.oauth_nonce := SELF.urlencode (SUBSTR (oauth_timestamp, 6));
      SELF.oauth_base_string :=
         SELF.base_string2 (p_http_method         => http_method,
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
         SELF.authorization_header (p_consumer_key   => SELF.oauth_consumer_key,
                                    p_timestamp      => SELF.oauth_timestamp,
                                    p_nonce          => SELF.oauth_nonce,
                                    p_signature      => SELF.oauth_signature,
                                    p_token          => SELF.oauth_access_token,
                                    p_verifier       => NULL);
      --UTL_HTTP.set_proxy (pq_constants.con_str_http_proxy);
      UTL_HTTP.
      set_wallet (PATH => OAUTH.global_constants.con_str_wallet_path, PASSWORD => OAUTH.global_constants.con_str_wallet_pass);
      UTL_HTTP.set_response_error_check (FALSE);
      UTL_HTTP.set_detailed_excp_support (FALSE);
      http_req := UTL_HTTP.begin_request (oauth_api_url, http_method, UTL_HTTP.http_version_1_1);
      UTL_HTTP.set_header (r => http_req, name => 'Authorization', VALUE => var_http_authorization_header);
      UTL_HTTP.set_header (r => http_req, name => 'Accept-Encoding', VALUE => 'gzip,deflate');
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

      --DBMS_LOB.createtemporary (l_clob, FALSE);
      DBMS_LOB.createtemporary (l_gzcompressed_blob, FALSE);

      -- reads the Content
      BEGIN
         WHILE TRUE
         LOOP
            -- UTL_HTTP.read_line (http_resp, var_http_resp_value, TRUE);
            UTL_HTTP.read_raw (http_resp, l_raw, 32766);
            DBMS_LOB.writeappend (l_gzcompressed_blob, UTL_RAW.LENGTH (l_raw), l_raw);
         --DBMS_OUTPUT.put_line (var_http_resp_value);
         --DBMS_LOB.writeappend (l_clob, LENGTH (var_http_resp_value), var_http_resp_value);
         END LOOP;
      EXCEPTION
         WHEN UTL_HTTP.end_of_body
         THEN
            NULL;
      END;

      --l_xml := xmltype (l_clob);
      --DBMS_LOB.freetemporary (l_clob);
      DBMS_LOB.createtemporary (l_uncompressed_blob, FALSE);

      UTL_COMPRESS.lz_uncompress (src => l_gzcompressed_blob, dst => l_uncompressed_blob);
      --DBMS_OUTPUT.put_line ('Uncompressed Data: ' || UTL_RAW.CAST_TO_VARCHAR2 (l_uncompressed_blob));
      DBMS_LOB.freetemporary (l_gzcompressed_blob);
      --p_response := XMLTYPE (UTL_RAW.CAST_TO_VARCHAR2 (l_uncompressed_blob));
      l_uncompressed_clob := blob_to_clob (l_uncompressed_blob);
      p_response := XMLTYPE (l_uncompressed_clob);
      DBMS_LOB.freetemporary (l_uncompressed_blob);


      UTL_HTTP.end_response (http_resp);
   --SELF.remove;
   --SELF.ID := 'LNKD_' || l_xml.EXTRACT ('/person/id/text()').getstringval ();
   --      SELF.descr :=
   --            l_xml.EXTRACT ('/person/first-name/text()').getstringval ()
   --         || ' '
   --         || l_xml.EXTRACT ('/person/last-name/text()').getstringval ();
   --SELF.save;

   -- RETURN xmltype('<ok />');
   END get_connections;

   MEMBER PROCEDURE get_connection_profile (p_account    IN     VARCHAR2,
                                            p_fields     IN     VARCHAR2 DEFAULT '(id,first-name,last-name)',
                                            p_response      OUT XMLTYPE)
   --RETURN XMLTYPE
   IS
      http_method             CONSTANT VARCHAR2 (5) := 'GET';
      oauth_api_url           VARCHAR2 (1000) := 'http://api.linkedin.com/v1/people/' || p_account || '/connections:' || p_fields;
      --http://api.linkedin.com/v1/people/~/connections:(headline,first-name,last-name)
      http_req                UTL_HTTP.req;
      http_resp               UTL_HTTP.resp;
      var_http_header_name    VARCHAR2 (255);
      var_http_header_value   VARCHAR2 (1023);
      var_http_resp_value     VARCHAR2 (32767);
      l_uncompressed_clob     CLOB;
      --l_xml                   XMLTYPE;
      l_uncompressed_blob     BLOB;
      l_gzcompressed_blob     BLOB;
      l_raw                   RAW (32767);
   BEGIN
      SELF.oauth_timestamp :=
         TO_CHAR (TRUNC ( (SYSDATE - TO_DATE ('01-01-1970', 'DD-MM-YYYY')) * (86400) - con_num_timestamp_tz_diff));
      SELF.oauth_nonce := SELF.urlencode (SUBSTR (oauth_timestamp, 6));
      SELF.oauth_base_string :=
         SELF.base_string2 (p_http_method         => http_method,
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
         SELF.authorization_header (p_consumer_key   => SELF.oauth_consumer_key,
                                    p_timestamp      => SELF.oauth_timestamp,
                                    p_nonce          => SELF.oauth_nonce,
                                    p_signature      => SELF.oauth_signature,
                                    p_token          => SELF.oauth_access_token,
                                    p_verifier       => NULL);
      --UTL_HTTP.set_proxy (pq_constants.con_str_http_proxy);
      UTL_HTTP.
      set_wallet (PATH => OAUTH.global_constants.con_str_wallet_path, PASSWORD => OAUTH.global_constants.con_str_wallet_pass);
      UTL_HTTP.set_response_error_check (FALSE);
      UTL_HTTP.set_detailed_excp_support (FALSE);
      http_req := UTL_HTTP.begin_request (oauth_api_url, http_method, UTL_HTTP.http_version_1_1);
      UTL_HTTP.set_header (r => http_req, name => 'Authorization', VALUE => var_http_authorization_header);
      UTL_HTTP.set_header (r => http_req, name => 'Accept-Encoding', VALUE => 'gzip,deflate');
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

      --DBMS_LOB.createtemporary (l_clob, FALSE);
      DBMS_LOB.createtemporary (l_gzcompressed_blob, FALSE);

      -- reads the Content
      BEGIN
         WHILE TRUE
         LOOP
            -- UTL_HTTP.read_line (http_resp, var_http_resp_value, TRUE);
            UTL_HTTP.read_raw (http_resp, l_raw, 32766);
            DBMS_LOB.writeappend (l_gzcompressed_blob, UTL_RAW.LENGTH (l_raw), l_raw);
         --DBMS_OUTPUT.put_line (var_http_resp_value);
         --DBMS_LOB.writeappend (l_clob, LENGTH (var_http_resp_value), var_http_resp_value);
         END LOOP;
      EXCEPTION
         WHEN UTL_HTTP.end_of_body
         THEN
            NULL;
      END;

      --l_xml := xmltype (l_clob);
      --DBMS_LOB.freetemporary (l_clob);
      DBMS_LOB.createtemporary (l_uncompressed_blob, FALSE);

      UTL_COMPRESS.lz_uncompress (src => l_gzcompressed_blob, dst => l_uncompressed_blob);
      --DBMS_OUTPUT.put_line ('Uncompressed Data: ' || UTL_RAW.CAST_TO_VARCHAR2 (l_uncompressed_blob));
      DBMS_LOB.freetemporary (l_gzcompressed_blob);
      --p_response := XMLTYPE (UTL_RAW.CAST_TO_VARCHAR2 (l_uncompressed_blob));
      l_uncompressed_clob := blob_to_clob (l_uncompressed_blob);
      p_response := XMLTYPE (l_uncompressed_clob);
      DBMS_LOB.freetemporary (l_uncompressed_blob);


      UTL_HTTP.end_response (http_resp);
   --SELF.remove;
   --SELF.ID := 'LNKD_' || l_xml.EXTRACT ('/person/id/text()').getstringval ();
   --      SELF.descr :=
   --            l_xml.EXTRACT ('/person/first-name/text()').getstringval ()
   --         || ' '
   --         || l_xml.EXTRACT ('/person/last-name/text()').getstringval ();
   --SELF.save;

   -- RETURN xmltype('<ok />');
   END get_connection_profile;
END;
/

