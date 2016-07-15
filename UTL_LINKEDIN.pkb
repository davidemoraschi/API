/* Formatted on 2010/08/17 14:37 (Formatter Plus v4.8.8) */
CREATE OR REPLACE PACKAGE BODY utl_linkedin
AS
   FUNCTION base_string (
      p_http_method         IN   VARCHAR2
     ,p_request_token_url   IN   VARCHAR2
     ,p_consumer_key        IN   VARCHAR2
     ,p_timestamp           IN   VARCHAR2
     ,p_nonce               IN   VARCHAR2)
      RETURN VARCHAR2
   AS
      v_oauth_base_string           VARCHAR2 (2000);
   BEGIN
      SELECT    p_http_method
             || '&'
             || urlencode (p_request_token_url)
             || '&'
             || urlencode (   'oauth_callback'
                           || '='
                           || 'oob'
                           || '&'
                           || 'oauth_consumer_key'
                           || '='
                           || urlencode (p_consumer_key)
                           || '&'
                           || 'oauth_nonce'
                           || '='
                           || p_nonce
                           || '&'
                           || 'oauth_signature_method'
                           || '='
                           || 'HMAC-SHA1'
                           || '&'
                           || 'oauth_timestamp'
                           || '='
                           || p_timestamp
                           || '&'
                           || 'oauth_version'
                           || '='
                           || '1.0')
      INTO   v_oauth_base_string
      FROM   DUAL;

      RETURN v_oauth_base_string;
   END base_string;

   FUNCTION base_string_token (
      p_http_method         IN   VARCHAR2
     ,p_request_token_url   IN   VARCHAR2
     ,p_consumer_key        IN   VARCHAR2
     ,p_timestamp           IN   VARCHAR2
     ,p_nonce               IN   VARCHAR2
     ,p_token               IN   VARCHAR2
     ,p_token_verifier      IN   VARCHAR2)
      RETURN VARCHAR2
   AS
      v_oauth_base_string           VARCHAR2 (2000);
   BEGIN
      SELECT    p_http_method
             || '&'
             || urlencode (p_request_token_url)
             || '&'
             || urlencode (   'oauth_callback'
                           || '='
                           || 'oob'
                           || '&'
                           || 'oauth_consumer_key'
                           || '='
                           || urlencode (p_consumer_key)
                           || '&'
                           || 'oauth_nonce'
                           || '='
                           || p_nonce
                           || '&'
                           || 'oauth_signature_method'
                           || '='
                           || 'HMAC-SHA1'
                           || '&'
                           || 'oauth_timestamp'
                           || '='
                           || p_timestamp
                           || '&'
                           || 'oauth_token'
                           || '='
                           || urlencode (p_token)
                           || '&'
                           || 'oauth_verifier'
                           || '='
                           || p_token_verifier
                           || '&'
                           || 'oauth_version'
                           || '='
                           || '1.0')
      INTO   v_oauth_base_string
      FROM   DUAL;

      RETURN v_oauth_base_string;
   END base_string_token;

   FUNCTION base_string_access_token (
      p_http_method         IN   VARCHAR2
     ,p_request_token_url   IN   VARCHAR2
     ,p_consumer_key        IN   VARCHAR2
     ,p_timestamp           IN   VARCHAR2
     ,p_nonce               IN   VARCHAR2
     ,p_token               IN   VARCHAR2)
      RETURN VARCHAR2
   AS
         /*
          oauth_consumer_key
          oauth_nonce
          oauth_signature_method
          oauth_timestamp
          oauth_version

          oauth_signature

          action=user-get
          response=xml

      */
      v_oauth_base_string           VARCHAR2 (2000);
   BEGIN
      SELECT    p_http_method
             || '&'
             || urlencode (p_request_token_url)
             || '&'
             || urlencode (   'oauth_consumer_key'
                           || '='
                           || urlencode (p_consumer_key)
                           || '&'
                           || 'oauth_nonce'
                           || '='
                           || p_nonce
                           || '&'
                           || 'oauth_signature_method'
                           || '='
                           || 'HMAC-SHA1'
                           || '&'
                           || 'oauth_timestamp'
                           || '='
                           || p_timestamp
                           || '&'
                           || 'oauth_token'
                           || '='
                           || urlencode (p_token)
                           || '&'
                           || 'oauth_version'
                           || '='
                           || '1.0')
      INTO   v_oauth_base_string
      FROM   DUAL;

      RETURN v_oauth_base_string;
   END base_string_access_token;

   FUNCTION KEY (p_consumer_secret IN VARCHAR2)
      RETURN VARCHAR2
   AS
      v_oauth_key                   VARCHAR2 (500);
   BEGIN
      SELECT urlencode (p_consumer_secret) || '&'
      INTO   v_oauth_key
      FROM   DUAL;

      RETURN v_oauth_key;
   END KEY;

   FUNCTION key_token (p_consumer_secret IN VARCHAR2, p_token_secret IN VARCHAR2)
      RETURN VARCHAR2
   AS
      v_oauth_key                   VARCHAR2 (500);
   BEGIN
      SELECT urlencode (p_consumer_secret) || '&' || urlencode (p_token_secret)                                  --giá urlencodato
      INTO   v_oauth_key
      FROM   DUAL;

      RETURN v_oauth_key;
   END key_token;

   FUNCTION signature (p_oauth_base_string IN VARCHAR2, p_oauth_key IN VARCHAR2)
      RETURN VARCHAR2
   AS
      v_oauth_signature             VARCHAR2 (500);
   BEGIN
      v_oauth_signature :=
         UTL_RAW.cast_to_varchar2 (UTL_ENCODE.base64_encode (DBMS_CRYPTO.mac (UTL_I18N.string_to_raw (p_oauth_base_string
                                                                                                     ,'AL32UTF8')
                                                                             ,DBMS_CRYPTO.hmac_sh1
                                                                             ,UTL_I18N.string_to_raw (p_oauth_key, 'AL32UTF8'))));
      RETURN v_oauth_signature;
   END signature;

   FUNCTION http_req_url (
      p_request_token_url   IN   VARCHAR2
     ,p_consumer_key        IN   VARCHAR2
     ,p_timestamp           IN   VARCHAR2
     ,p_nonce               IN   VARCHAR2
     ,p_signature           IN   VARCHAR2)
      RETURN VARCHAR2
   AS
      v_http_req_url                VARCHAR2 (4000);
   BEGIN
      v_http_req_url :=
            p_request_token_url
         || '?'
         || 'oauth_callback'
         || '='
         || 'oob'
         || '&'
         || 'oauth_consumer_key'
         || '='
         || p_consumer_key
         || '&'
         || 'oauth_nonce'
         || '='
         || p_nonce
         || '&'
         || 'oauth_signature'
         || '='
         || urlencode (p_signature)
         || '&'
         || 'oauth_signature_method'
         || '='
         || 'HMAC-SHA1'
         || '&'
         || 'oauth_timestamp'
         || '='
         || p_timestamp
         || '&'
         || 'oauth_version'
         || '='
         || '1.0';
      RETURN v_http_req_url;
   END http_req_url;

   FUNCTION http_req_url_token (
      p_request_token_url   IN   VARCHAR2
     ,p_consumer_key        IN   VARCHAR2
     ,p_timestamp           IN   VARCHAR2
     ,p_nonce               IN   VARCHAR2
     ,p_signature           IN   VARCHAR2
     ,p_token               IN   VARCHAR2
     ,p_token_verifier      IN   VARCHAR2)
      RETURN VARCHAR2
   AS
      v_http_req_url                VARCHAR2 (4000);
   BEGIN
      v_http_req_url :=
            p_request_token_url
         || '?'
         || 'oauth_callback'
         || '='
         || 'oob'
         || '&'
         || 'oauth_consumer_key'
         || '='
         || p_consumer_key
         || '&'
         || 'oauth_nonce'
         || '='
         || p_nonce
         || '&'
         || 'oauth_signature'
         || '='
         || urlencode (p_signature)
         || '&'
         || 'oauth_signature_method'
         || '='
         || 'HMAC-SHA1'
         || '&'
         || 'oauth_timestamp'
         || '='
         || p_timestamp
         || '&'
         || 'oauth_token'
         || '='
         || urlencode (p_token)
         || '&'
         || 'oauth_verifier'
         || '='
         || p_token_verifier
         || '&'
         || 'oauth_version'
         || '='
         || '1.0';
      RETURN v_http_req_url;
   END http_req_url_token;

   FUNCTION http_req_url_access_token (
      p_request_token_url   IN   VARCHAR2
     ,p_consumer_key        IN   VARCHAR2
     ,p_timestamp           IN   VARCHAR2
     ,p_nonce               IN   VARCHAR2
     ,p_signature           IN   VARCHAR2
     ,p_token               IN   VARCHAR2)
      RETURN VARCHAR2
   AS
      v_http_req_url                VARCHAR2 (4000);
   BEGIN
      v_http_req_url :=
            p_request_token_url
         || '?'
         || 'oauth_callback'
         || '='
         || 'oob'
         || '&'
         || 'oauth_consumer_key'
         || '='
         || p_consumer_key
         || '&'
         || 'oauth_nonce'
         || '='
         || p_nonce
         || '&'
         || 'oauth_signature'
         || '='
         || urlencode (p_signature)
         || '&'
         || 'oauth_signature_method'
         || '='
         || 'HMAC-SHA1'
         || '&'
         || 'oauth_timestamp'
         || '='
         || p_timestamp
         || '&'
         || 'oauth_token'
         || '='
         || p_token
         || '&'
         || 'oauth_version'
         || '='
         || '1.0';
      RETURN v_http_req_url;
   END http_req_url_access_token;

   FUNCTION get_token (the_list VARCHAR2, the_index NUMBER, delim VARCHAR2 := ',')
      RETURN VARCHAR2
   IS
      start_pos                     NUMBER;
      end_pos                       NUMBER;
   BEGIN
      IF the_index = 1
      THEN
         start_pos := 1;
      ELSE
         start_pos := INSTR (the_list, delim, 1, the_index - 1);

         IF start_pos = 0
         THEN
            RETURN NULL;
         ELSE
            start_pos := start_pos + LENGTH (delim);
         END IF;
      END IF;

      end_pos := INSTR (the_list, delim, start_pos, 1);

      IF end_pos = 0
      THEN
         RETURN SUBSTR (the_list, start_pos);
      ELSE
         RETURN SUBSTR (the_list, start_pos, end_pos - start_pos);
      END IF;
   END get_token;

   FUNCTION authorization_header (
      p_consumer_key   IN   VARCHAR2
     ,p_token          IN   VARCHAR2
     ,p_timestamp      IN   VARCHAR2
     ,p_nonce          IN   VARCHAR2
     ,p_signature      IN   VARCHAR2)
      RETURN VARCHAR2
   IS
      v_authorization_header        VARCHAR2 (4000);
   BEGIN
      v_authorization_header :=
            'OAuth realm="",oauth_version="1.0",oauth_consumer_key="'
         || p_consumer_key
         || '",oauth_token="'
         || p_token
         || '",oauth_timestamp="'
         || p_timestamp
         || '",oauth_nonce="'
         || p_nonce
         || '",oauth_signature_method="HMAC-SHA1",oauth_signature="'
         || urlencode (p_signature)
         || '"';
      RETURN v_authorization_header;
   END authorization_header;

   FUNCTION authorization_header_no_token (
      p_consumer_key   IN   VARCHAR2
     ,p_timestamp      IN   VARCHAR2
     ,p_nonce          IN   VARCHAR2
     ,p_signature      IN   VARCHAR2)
      RETURN VARCHAR2
   IS
      v_authorization_header        VARCHAR2 (4000);
   BEGIN
      v_authorization_header :=
            'OAuth realm="",oauth_callback="oob",oauth_version="1.0",oauth_consumer_key="'
         || p_consumer_key
         || '",oauth_timestamp="'
         || p_timestamp
         || '",oauth_nonce="'
         || p_nonce
         || '",oauth_signature_method="HMAC-SHA1",oauth_signature="'
         || urlencode (p_signature)
         || '"';
      RETURN v_authorization_header;
   END authorization_header_no_token;

   FUNCTION urlencode (p_str IN VARCHAR2)
      RETURN VARCHAR2
   AS
      l_tmp                         VARCHAR2 (6000);
      l_bad                         VARCHAR2 (100) DEFAULT ' >%}\~];?@&<#{|^[`/:=$+''"';
      l_char                        CHAR (1);
   BEGIN
      FOR i IN 1 .. NVL (LENGTH (p_str), 0)
      LOOP
         l_char := SUBSTR (p_str, i, 1);

         IF (INSTR (l_bad, l_char) > 0)
         THEN
            l_tmp := l_tmp || '%' || TO_CHAR (ASCII (l_char), 'fmXX');
         ELSE
            l_tmp := l_tmp || l_char;
         END IF;
      END LOOP;

      RETURN l_tmp;
   END urlencode;

   PROCEDURE twiting_by_the_pl (p_status IN VARCHAR2)
   AS
      http_method          CONSTANT VARCHAR2 (5) := 'POST';
      http_req                      UTL_HTTP.req;
      http_resp                     UTL_HTTP.resp;
      con_str_wallet_path  CONSTANT VARCHAR2 (50) := 'file:C:\oracle';
      con_str_wallet_pass  CONSTANT VARCHAR2 (50) := 'Lepanto1571';
      oauth_api_url                 VARCHAR2 (1000) := 'http://api.twitter.com/1/statuses/update.xml';
      oauth_consumer_key            VARCHAR2 (50);
      oauth_consumer_secret         VARCHAR2 (50);
      oauth_nonce                   VARCHAR2 (50);
      oauth_timestamp               VARCHAR2 (50);
      oauth_base_string             VARCHAR2 (1000);
      oauth_signature               VARCHAR2 (100);
      oauth_access_token            VARCHAR2 (500);
      oauth_access_token_secret     VARCHAR2 (500);
      var_http_req_url              VARCHAR2 (4000);
      return_xml                    VARCHAR2 (30000);
      var_http_authorization_header VARCHAR2 (1024);
      v_user_params                 VARCHAR2 (1024) := 'status=' || pkg_oauth.urlencode (p_status);
      show_header                   NUMBER := 0;
      h_name                        VARCHAR2 (255);
      h_value                       VARCHAR2 (1023);
      res_value                     VARCHAR2 (32767);
   BEGIN
      UTL_HTTP.set_proxy ('10.234.23.117:8080');
      UTL_HTTP.set_wallet (PATH => con_str_wallet_path, PASSWORD => con_str_wallet_pass);
      UTL_HTTP.set_response_error_check (TRUE);
      UTL_HTTP.set_detailed_excp_support (TRUE);

      SELECT oauth_consumer_key, oauth_consumer_secret, oauth_access_token, oauth_access_token_secret
      INTO   oauth_consumer_key, oauth_consumer_secret, oauth_access_token, oauth_access_token_secret
      FROM   oauth_parameters;

      SELECT pkg_oauth.urlencode (oauth_nonce_seq.NEXTVAL)
      INTO   oauth_nonce
      FROM   DUAL;

      SELECT TO_CHAR (  (SYSDATE - TO_DATE ('01-01-1970', 'DD-MM-YYYY')) * (86400)
                      - (TO_NUMBER (SUBSTR (SESSIONTIMEZONE, 2, 2)) * 3600))
      INTO   oauth_timestamp
      FROM   DUAL;

      oauth_base_string :=
            pkg_oauth.base_string_access_token (http_method
                                               ,oauth_api_url
                                               ,oauth_consumer_key
                                               ,oauth_timestamp
                                               ,oauth_nonce
                                               ,oauth_access_token)
         || pkg_oauth.urlencode ('&' || v_user_params);
      oauth_signature :=
                   pkg_oauth.signature (oauth_base_string, pkg_oauth.key_token (oauth_consumer_secret, oauth_access_token_secret));
      var_http_req_url :=
         pkg_oauth.http_req_url_access_token (oauth_api_url
                                             ,oauth_consumer_key
                                             ,oauth_timestamp
                                             ,oauth_nonce
                                             ,oauth_signature
                                             ,oauth_access_token);
      var_http_authorization_header :=
            pkg_oauth.authorization_header (oauth_consumer_key, oauth_access_token, oauth_timestamp, oauth_nonce, oauth_signature);
      http_req := UTL_HTTP.begin_request (oauth_api_url, http_method, UTL_HTTP.http_version_1_1);
      UTL_HTTP.set_response_error_check (TRUE);
      UTL_HTTP.set_detailed_excp_support (TRUE);
      UTL_HTTP.set_body_charset (http_req, 'UTF-8');
      UTL_HTTP.set_header (http_req, 'User-Agent', 'Mozilla/4.0');
      UTL_HTTP.set_header (r => http_req, NAME => 'Authorization', VALUE => var_http_authorization_header);
      UTL_HTTP.set_header (r => http_req, NAME => 'Content-Type', VALUE => 'application/x-www-form-urlencoded');
      UTL_HTTP.set_header (r => http_req, NAME => 'Content-Length', VALUE => LENGTH (v_user_params));
      UTL_HTTP.write_text (http_req, v_user_params);
      http_resp := UTL_HTTP.get_response (http_req);

      IF show_header = 1
      THEN
         DBMS_OUTPUT.put_line ('status code: ' || http_resp.status_code);
         DBMS_OUTPUT.put_line ('reason phrase: ' || http_resp.reason_phrase);

         FOR i IN 1 .. UTL_HTTP.get_header_count (http_resp)
         LOOP
            UTL_HTTP.get_header (http_resp, i, h_name, h_value);
            DBMS_OUTPUT.put_line (h_name || ': ' || h_value);
         END LOOP;
      END IF;

      BEGIN
         WHILE 1 = 1
         LOOP
            UTL_HTTP.read_line (http_resp, res_value, TRUE);
         END LOOP;
      EXCEPTION
         WHEN UTL_HTTP.end_of_body
         THEN
            NULL;
      END;

      UTL_HTTP.end_response (http_resp);
   EXCEPTION
      WHEN OTHERS
      THEN
         DBMS_OUTPUT.put_line (SQLERRM);
         RAISE;
   END twiting_by_the_pl;

   PROCEDURE quoteoftheday
   IS
      var_http_request              UTL_HTTP.req;
      var_http_response             UTL_HTTP.resp;
      var_http_value                VARCHAR2 (32767);
      var_http_xml_result           VARCHAR2 (32767);
      var_http_xml                  XMLTYPE;
      tweet_string                  VARCHAR2 (140);
   BEGIN
      UTL_HTTP.set_proxy ('10.234.23.117:8080');
      var_http_request := UTL_HTTP.begin_request (url => 'http://feeds.feedburner.com/brainyquote/QUOTEFU', method => 'GET');
      UTL_HTTP.set_header (var_http_request, 'User-Agent', 'Mozilla/4.0');
      var_http_response := UTL_HTTP.get_response (r => var_http_request);

      BEGIN
         LOOP
            UTL_HTTP.read_line (r => var_http_response, DATA => var_http_value, remove_crlf => TRUE);
            var_http_xml_result := var_http_xml_result || var_http_value;
         END LOOP;
      EXCEPTION
         WHEN UTL_HTTP.end_of_body
         THEN
            UTL_HTTP.end_response (r => var_http_response);
      END;

      var_http_xml := XMLTYPE (var_http_xml_result);

      UPDATE log_google
         SET entry = var_http_xml;

      COMMIT;

      SELECT    REPLACE (EXTRACTVALUE (a.entry, '/rss/channel/item[1]/description'), '"')
             || ' - '
             || REPLACE (EXTRACTVALUE (a.entry, '/rss/channel/item[1]/title'), '"')
      INTO   tweet_string
      FROM   log_google a;

      pkg_oauth.twiting_by_the_pl (tweet_string);
   END;
END utl_linkedin;
/