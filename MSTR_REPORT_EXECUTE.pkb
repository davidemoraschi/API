CREATE OR REPLACE PACKAGE BODY MSTR.REPORT_EXECUTE
AS
   PROCEDURE png (reportId   IN VARCHAR2 DEFAULT '114B1D5C11E249CF47370080EFF51A55',
                  rWidth     IN NUMBER DEFAULT 750,
                  rHeight    IN NUMBER DEFAULT 400)
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
      /* For Windows based web services and IIS security use the NTLM package */
      --l_clob := sys.ntlm_http_pkg.get_response_clob (l_url, const_intelligent_server_ntus, const_intelligent_server_ntpw);
      l_clob := HTTPURITYPE.createuri (l_url).getclob ();
      /* For Windows based web services and IIS security use the NTLM package */
      l_xml := xmltype (l_clob);
      l_sessionState := l_xml.EXTRACT ('taskResponse/root/sessionState/text()').getstringval ();
      --HTP.p (l_sessionState);

      l_url :=
            const_host_port
         || const_intelligent_server_wurl
         || 'taskId=reportExecute&taskEnv=xml&taskContentType=xml&sessionState='
         || UTL_URL.escape (l_sessionState)
         || '&reportViewMode=2&reportID='
         || reportId;
      /* For Windows based web services and IIS security use the NTLM package */
      --l_clob := sys.ntlm_http_pkg.get_response_clob (l_url, const_intelligent_server_ntus, const_intelligent_server_ntpw);
      l_clob := HTTPURITYPE.createuri (l_url).getclob ();
      /* For Windows based web services and IIS security use the NTLM package */
      l_xml := xmltype (l_clob);
      l_msg_id := l_xml.EXTRACT ('taskResponse/msg/id/text()').getstringval ();
      --HTP.p (l_msg_id);

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
         || rwidth
         || '&availHeight='
         || rHeight;
      /* For Windows based web services and IIS security use the NTLM package */
      --l_clob := sys.ntlm_http_pkg.get_response_clob (l_url, const_intelligent_server_ntus, const_intelligent_server_ntpw);
      l_clob := HTTPURITYPE.createuri (l_url).getclob ();
      /* For Windows based web services and IIS security use the NTLM package */
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
      /* For Windows based web services and IIS security use the NTLM package */
      --l_clob := sys.ntlm_http_pkg.get_response_clob (l_url, const_intelligent_server_ntus, const_intelligent_server_ntpw);
      l_clob := HTTPURITYPE.createuri (l_url).getclob ();
      /* For Windows based web services and IIS security use the NTLM package */
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

