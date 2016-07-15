CREATE OR REPLACE PACKAGE      REPORT_EXECUTE
AS
   const_host_port                 CONSTANT VARCHAR2 (1024) := 'http://fraterno';
   const_intelligent_server_name   CONSTANT VARCHAR2 (1024) := 'FRATERNO';
   const_intelligent_server_proj   CONSTANT VARCHAR2 (1024) := 'VALME+DIRECTO';
   const_intelligent_server_user   CONSTANT VARCHAR2 (1024) := 'IUSR_WEBSERVICE';
   const_intelligent_server_pass   CONSTANT VARCHAR2 (1024) := 'aumentanun4,9%';
   const_intelligent_server_wurl   CONSTANT VARCHAR2 (1024) := '/MicroStrategy/asp/TaskProc.aspx?';
   const_intelligent_server_ntus   CONSTANT VARCHAR2 (1024) := 'VALME\cueserval';
   const_intelligent_server_ntpw   CONSTANT VARCHAR2 (1024) := '.RO%DRI&GO.';

   PROCEDURE png (reportId   IN VARCHAR2 DEFAULT '9C5AE6B84A50C46DC5E94FA18D95D925',
                  rWidth     IN NUMBER DEFAULT 500,
                  rHeight    IN NUMBER DEFAULT 300);

   PROCEDURE htm;
END;
/
CREATE OR REPLACE PACKAGE BODY      REPORT_EXECUTE
AS
   PROCEDURE png (reportId   IN VARCHAR2 DEFAULT '9C5AE6B84A50C46DC5E94FA18D95D925',
                  rWidth     IN NUMBER DEFAULT 500,
                  rHeight    IN NUMBER DEFAULT 300)
   IS
      l_url            VARCHAR2 (32000);
      l_sessionState   VARCHAR2 (4000);
      l_clob           CLOB;
      l_xml            XMLTYPE;
      l_msg_id         VARCHAR2 (1000);
      l_image_blob     BLOB;
   BEGIN
      l_url :=
            const_host_port
         || const_intelligent_server_wurl
         || 'taskId=login&taskEnv=xml&taskContentType=xml&server='
         || const_intelligent_server_name
         || '&project='
         || const_intelligent_server_proj
         || '&userid='
         || const_intelligent_server_user
         || '&password='
         || const_intelligent_server_pass;
      l_clob := sys.ntlm_http_pkg.get_response_clob (l_url, const_intelligent_server_ntus, const_intelligent_server_ntpw);
      l_xml := xmltype (l_clob);
      l_sessionState := l_xml.EXTRACT ('taskResponse/root/sessionState/text()').getstringval ();

      l_url :=
            const_host_port
         || const_intelligent_server_wurl
         || 'taskId=reportExecute&taskEnv=xml&taskContentType=xml&sessionState='
         || UTL_URL.escape (l_sessionState)
         || '&reportViewMode=2&reportID='
         || reportId;
      l_clob := sys.ntlm_http_pkg.get_response_clob (l_url, const_intelligent_server_ntus, const_intelligent_server_ntpw);
      l_xml := xmltype (l_clob);
      l_msg_id := l_xml.EXTRACT ('taskResponse/msg/id/text()').getstringval ();

      l_url :=
            const_host_port
         || const_intelligent_server_wurl
         || 'taskId=getReportGraphImage&taskEnv=xml&taskContentType=xml&sessionState='
         || UTL_URL.escape (l_sessionState)
         || '&messageID='
         || l_msg_id
         || '&width='
         || rwidth
         || '&height='
         || rHeight
         || '&imgType=2&availWidth='
         || rwidth * 1.1
         || '&availHeight='
         || rHeight * 1.1;
      l_clob := sys.ntlm_http_pkg.get_response_clob (l_url, const_intelligent_server_ntus, const_intelligent_server_ntpw);
      l_xml := xmltype (l_clob);
      l_image_blob := FLEX_WS_API.CLOBBASE642BLOB (l_xml.EXTRACT ('taskResponse/root/ib/eb/text()').getclobval ());
      OWA_UTIL.mime_header ('image/png', FALSE, NULL);
      HTP.p ('<HR />Content-length: ' || DBMS_LOB.GETLENGTH (l_image_blob));
      OWA_UTIL.http_header_close;
      WPG_DOCLOAD.download_file (l_image_blob);

      l_url :=
            const_host_port
         || const_intelligent_server_wurl
         || 'taskId=logout&taskEnv=xml&taskContentType=xml&sessionState='
         || UTL_URL.escape (l_sessionState);
      l_clob := sys.ntlm_http_pkg.get_response_clob (l_url, const_intelligent_server_ntus, const_intelligent_server_ntpw);
      l_xml := xmltype (l_clob);
      l_msg_id := l_xml.EXTRACT ('taskResponse/text()').getstringval ();
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
