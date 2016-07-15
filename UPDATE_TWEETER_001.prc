CREATE OR REPLACE PROCEDURE ALMAGESTO.update_tweeter_001
--SOLO LA PRIMA VOLTA, POI ANDARE IN INTERNET A PRENDERE IL VERIFICATION CODEurlencode 
AS
   con_str_wallet_path                  CONSTANT VARCHAR2 (50)  := 'file:C:\oracle';
   con_str_wallet_pass                  CONSTANT VARCHAR2 (50)  := 'Lepanto1571';
   
   oauth_get_request_token_url          CONSTANT VARCHAR2 (1000) := 'http://api.twitter.com/oauth/request_token';
   oauth_get_access_token_url           CONSTANT VARCHAR2 (1000) := 'https://api.twitter.com/oauth/access_token';
   oauth_callback                       CONSTANT VARCHAR2 (1000)   := 'oob';
   oauth_consumer_key                   CONSTANT VARCHAR2 (50) := urlencode ('5HFrVcwi7Hp1KpEQc4gfZQ');
   oauth_nonce                                   VARCHAR2 (50);
   oauth_signature_method               CONSTANT VARCHAR2 (10)  := urlencode ('HMAC-SHA1');
   oauth_timestamp                               VARCHAR2 (50);
   oauth_version                        CONSTANT VARCHAR2 (5)   := urlencode ('1.0');
   oauth_consumer_secret                CONSTANT VARCHAR2 (50) := 'FV3fn9H6ZR3yrgNjfmb21I6zF58KmZLydWq4jXHqhA';
   oauth_token                                   VARCHAR2 (500);
   oauth_token_secret                            VARCHAR2 (500);
   oauth_verifier                                VARCHAR2 (500) := 'vd3fgs3D';

   oauth_base_string                             VARCHAR2 (4000);
   oauth_key                                     VARCHAR2 (500) := urlencode (oauth_consumer_secret) || '&';-- || urlencode (oauth_token);
   oauth_signature                               VARCHAR2 (100);

   l_sig_mac                                     RAW (2000);

   http_req_url                                  VARCHAR2 (4000);
   http_method                                   VARCHAR2 (5) := 'GET';
   http_req                                      UTL_HTTP.req;
   http_resp                                     UTL_HTTP.resp;

   h_name                                        VARCHAR2 (255);
   h_value                                       VARCHAR2 (1023);
   res_value                                     VARCHAR2 (32767);
   show_header                                   NUMBER := 0;
   show_xml                                      NUMBER := 1;

BEGIN
      utl_http.set_wallet (PATH => con_str_wallet_path, PASSWORD => con_str_wallet_pass);
--      utl_http.set_follow_redirect (max_redirects => 3);

   SELECT urlencode (oauth_nonce_seq.NEXTVAL)
   INTO   oauth_nonce
   FROM   DUAL;

   SELECT urlencode ((SYSDATE - TO_DATE ('01-01-1970', 'DD-MM-YYYY')) * (86400)) - 7200
   INTO   oauth_timestamp
   FROM   DUAL;

   oauth_base_string :=
         http_method
      || '&'
      || urlencode (oauth_get_request_token_url)
      || '&'
      || urlencode (   'oauth_callback'
                    || '='
                    || oauth_callback
                    || '&'
                    || 'oauth_consumer_key'
                    || '='
                    || oauth_consumer_key
                    || '&'
                    || 'oauth_nonce'
                    || '='
                    || oauth_nonce
                    || '&'
                    || 'oauth_signature_method'
                    || '='
                    || oauth_signature_method
                    || '&'
                    || 'oauth_timestamp'
                    || '='
                    || oauth_timestamp
                    || '&'
                    || 'oauth_version'
                    || '='
                    || oauth_version);
   --DBMS_OUTPUT.put_line (oauth_base_string);
   l_sig_mac :=
      DBMS_CRYPTO.mac (UTL_I18N.string_to_raw (oauth_base_string, 'AL32UTF8')
                      ,DBMS_CRYPTO.hmac_sh1
                      ,UTL_I18N.string_to_raw (oauth_key, 'AL32UTF8'));
   oauth_signature := UTL_RAW.cast_to_varchar2 (UTL_ENCODE.base64_encode (l_sig_mac));
   DBMS_OUTPUT.put_line ('MAC Signature (Base64-encoded): ' || oauth_signature);
   UTL_HTTP.set_proxy ('proxy02.sas.junta-andalucia.es:8080');
   http_req_url :=
         oauth_get_request_token_url
      || '?'
      || 'oauth_callback'
      || '='
      || oauth_callback
      || '&'
      || 'oauth_consumer_key'
      || '='
      || oauth_consumer_key
      || '&'
      || 'oauth_nonce'
      || '='
      || oauth_nonce
      || '&'
      || 'oauth_signature'
      || '='
      || urlencode (oauth_signature)
      || '&'
      || 'oauth_signature_method'
      || '='
      || oauth_signature_method
      || '&'
      || 'oauth_timestamp'
      || '='
      || oauth_timestamp
      || '&'
      || 'oauth_version'
      || '='
      || oauth_version;
   http_req := UTL_HTTP.begin_request (http_req_url, http_method, UTL_HTTP.http_version_1_1);
   UTL_HTTP.set_response_error_check (TRUE);
   UTL_HTTP.set_detailed_excp_support (TRUE);
   UTL_HTTP.set_body_charset (http_req, 'UTF-8');
   UTL_HTTP.set_header (http_req, 'User-Agent', 'Mozilla/4.0');

   http_resp := UTL_HTTP.get_response (http_req);
   DBMS_OUTPUT.put_line ('status code: ' || http_resp.status_code);
   DBMS_OUTPUT.put_line ('reason phrase: ' || http_resp.reason_phrase);

   IF show_header = 1
   THEN
      FOR i IN 1 .. UTL_HTTP.get_header_count (http_resp)
      LOOP
         UTL_HTTP.get_header (http_resp, i, h_name, h_value);
         DBMS_OUTPUT.put_line (h_name || ': ' || h_value);
      END LOOP;
   END IF;

   IF show_xml = 1
   THEN
      BEGIN
         WHILE 1 = 1
         LOOP
            UTL_HTTP.read_line (http_resp, res_value, TRUE);
            DBMS_OUTPUT.put_line (res_value);
            IF INSTR (res_value, 'oauth_token') > 0 THEN
              oauth_token := UTL_URL.UNESCAPE (SUBSTR (res_value, 13, instr(res_value, '&oauth_token_secre') - INSTR (res_value, 'oauth_token') - 12));
              oauth_token_secret := UTL_URL.UNESCAPE(SUBSTR (res_value, instr(res_value, '&oauth_token_secret') + 20, instr(res_value, '&oauth_callback_confirmed')- instr(res_value, '&oauth_token_secret') - 20));
            DBMS_OUTPUT.put_line ('oauth_token:'||oauth_token);
            DBMS_OUTPUT.put_line ('oauth_token_secret:'||oauth_token_secret);
            oauth_key := urlencode (oauth_consumer_secret) || '&' || urlencode (oauth_token_secret);
            DBMS_OUTPUT.put_line ('oauth_key:'||oauth_key);            
            END IF;
         END LOOP;
      EXCEPTION
         WHEN UTL_HTTP.end_of_body
         THEN
            NULL;
      END;
   END IF;

   UTL_HTTP.end_response (http_resp); 
/*   
   oauth_base_string :=
         http_method
      || '&'
      || urlencode (oauth_get_access_token_url)
      || '&'
      || urlencode (
                     'oauth_consumer_key'
                    || '='
                    || oauth_consumer_key
                    || '&'
                    || 'oauth_nonce'
                    || '='
                    || oauth_nonce
                    || '&'
                    || 'oauth_signature_method'
                    || '='
                    || oauth_signature_method
                    || '&'
                    || 'oauth_timestamp'
                    || '='
                    || oauth_timestamp
                    || '&'
                    || 'oauth_token'
                    || '='
                    || oauth_token
                    || '&'
                    || 'oauth_verifier'
                    || '='
                    || oauth_verifier
                    || '&'
                    || 'oauth_version'
                    || '='
                    || oauth_version);
   DBMS_OUTPUT.put_line ('oauth_base_string:'||oauth_base_string);
   oauth_key := urlencode(oauth_consumer_secret) || '&' || urlencode(oauth_token_secret);
   DBMS_OUTPUT.put_line ('oauth_key:'||oauth_key);
   l_sig_mac :=
      DBMS_CRYPTO.mac (UTL_I18N.string_to_raw (oauth_base_string, 'AL32UTF8')
                      ,DBMS_CRYPTO.hmac_sh1
                      ,UTL_I18N.string_to_raw (oauth_key, 'AL32UTF8'));
   oauth_signature := UTL_RAW.cast_to_varchar2 (UTL_ENCODE.base64_encode (l_sig_mac));
   DBMS_OUTPUT.put_line ('MAC Signature (Base64-encoded): ' || oauth_signature);
   UTL_HTTP.set_proxy ('proxy02.sas.junta-andalucia.es:8080');
   
   http_req_url :=
         oauth_get_access_token_url
      || '?'
      || 'oauth_consumer_key'
      || '='
      || oauth_consumer_key
      || '&'
      || 'oauth_nonce'
      || '='
      || oauth_nonce
      || '&'
      || 'oauth_signature'
      || '='
      || urlencode (oauth_signature)
      || '&'
      || 'oauth_signature_method'
      || '='
      || oauth_signature_method
      || '&'
      || 'oauth_timestamp'
      || '='
      || oauth_timestamp
      || '&'
      || 'oauth_token'
      || '='
      || oauth_token
      || '&'
      || 'oauth_verifier'
      || '='
      || oauth_verifier
      || '&'
      || 'oauth_version'
      || '='
      || oauth_version;
   DBMS_OUTPUT.put_line ('http_req:'||http_req_url);

   http_req := UTL_HTTP.begin_request (http_req_url, http_method, UTL_HTTP.http_version_1_1);
   UTL_HTTP.set_response_error_check (TRUE);
   UTL_HTTP.set_detailed_excp_support (TRUE);
   UTL_HTTP.set_body_charset (http_req, 'UTF-8');
   UTL_HTTP.set_header (http_req, 'User-Agent', 'Mozilla/4.0');
   http_resp := UTL_HTTP.get_response (http_req);
   DBMS_OUTPUT.put_line ('status code: ' || http_resp.status_code);
   DBMS_OUTPUT.put_line ('reason phrase: ' || http_resp.reason_phrase);

   IF show_header = 1
   THEN
      FOR i IN 1 .. UTL_HTTP.get_header_count (http_resp)
      LOOP
         UTL_HTTP.get_header (http_resp, i, h_name, h_value);
         DBMS_OUTPUT.put_line (h_name || ': ' || h_value);
      END LOOP;
   END IF;

   IF show_xml = 1
   THEN
      BEGIN
         WHILE 1 = 1
         LOOP
            UTL_HTTP.read_line (http_resp, res_value, TRUE);
            DBMS_OUTPUT.put_line (res_value);
         END LOOP;
      EXCEPTION
         WHEN UTL_HTTP.end_of_body
         THEN
            NULL;
      END;
   END IF;

   UTL_HTTP.end_response (http_resp);
*/
--EXCEPTION
--   WHEN OTHERS
--   THEN
--      DBMS_OUTPUT.put_line (SQLERRM);
--      RAISE;
END update_tweeter_001;
/
