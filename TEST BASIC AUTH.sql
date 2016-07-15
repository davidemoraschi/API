/* Formatted on 27/11/2012 13:56:28 (QP5 v5.163.1008.3004) */
SET SERVEROUTPUT ON
SET DEFINE OFF

DECLARE
   req     UTL_HTTP.req;
   resp    UTL_HTTP.resp;
   name    VARCHAR2 (255);
   VALUE   VARCHAR2 (1023);
   v_msg   VARCHAR2 (80);
   v_url   VARCHAR2 (32767) := 'http://fraterno/MicroStrategy/asp/'; --TaskProc.aspx?taskId=login&taskEnv=xml&taskContentType=xml&server=FRATERNO&project=VALME+DIRECTO&userid=IUSR_WEBSERVICE&password=aumentanun4,9%';
BEGIN
   -- request that exceptions are raised for error status codes
   UTL_HTTP.set_response_error_check (enable => TRUE);

   -- allow testing for exceptions like Utl_Http.Http_Server_Error
   UTL_HTTP.set_detailed_excp_support (enable => TRUE);

   --UTL_HTTP.set_proxy (proxy => 'www-proxy.psoug.org', no_proxy_domains => 'psoug.org');

   req := UTL_HTTP.begin_request (url => v_url, method => 'GET');
   -- Or use method => 'POST' and utl_http.write_text
   -- to create an arbitrarily long msg

   UTL_HTTP.set_authentication (r           => req,
                                username    => 'VALME/upddm0',
                                password    => 'vhjz342',
                                scheme      => 'Basic',
                                for_proxy   => TRUE);

   UTL_HTTP.set_header (r => req, name => 'User-Agent', VALUE => 'Mozilla/4.0');

   resp := UTL_HTTP.get_response (r => req);

   DBMS_OUTPUT.put_line ('Status code: ' || resp.status_code);
   DBMS_OUTPUT.put_line ('Reason phrase: ' || resp.reason_phrase);

   FOR i IN 1 .. UTL_HTTP.get_header_count (r => resp)
   LOOP
      UTL_HTTP.get_header (r       => resp,
                           n       => i,
                           name    => name,
                           VALUE   => VALUE);
      DBMS_OUTPUT.put_line (name || ': ' || VALUE);
   END LOOP;

   BEGIN
      LOOP
         UTL_HTTP.read_text (r => resp, data => v_msg);
         DBMS_OUTPUT.put_line (v_msg);
      END LOOP;
   EXCEPTION
      WHEN UTL_HTTP.end_of_body
      THEN
         NULL;
   END;

   UTL_HTTP.end_response (r => resp);
EXCEPTION
   WHEN UTL_HTTP.request_failed
   THEN
      DBMS_OUTPUT.put_line ('Request Failed: ' || UTL_HTTP.get_detailed_sqlerrm);
   WHEN UTL_HTTP.http_server_error
   THEN
      DBMS_OUTPUT.put_line ('Server Error: ' || UTL_HTTP.get_detailed_sqlerrm);
   WHEN UTL_HTTP.http_client_error
   THEN
      DBMS_OUTPUT.put_line ('Client Error: ' || UTL_HTTP.get_detailed_sqlerrm);
   WHEN OTHERS
   THEN
      DBMS_OUTPUT.put_line (SQLERRM);
END;
/