CREATE OR REPLACE PACKAGE BODY MSTR.PANDAS_001_REPORT_EXECUTE_v2
AS
   PROCEDURE png (reportId      IN VARCHAR2 DEFAULT '9C5AE6B84A50C46DC5E94FA18D95D925',
                  projectName   IN VARCHAR2 DEFAULT const_intelligent_server_proj,
                  rWidth        IN NUMBER DEFAULT 750,
                  rHeight       IN NUMBER DEFAULT 400)
   IS
      l_url            VARCHAR2 (32000);
      l_sessionState   VARCHAR2 (4000);
      l_clob           CLOB;
      l_xml            XMLTYPE;
      l_msg_id         VARCHAR2 (1000);
      l_image_blob     BLOB;
   BEGIN
      DBMS_APPLICATION_INFO.set_client_info (OWA_UTIL.get_cgi_env ('HTTP_USER_AGENT'));
      DBMS_SESSION.set_identifier ('MicroStrategy Pandas Connector');
      DBMS_APPLICATION_INFO.set_module ('REPORT_EXECUTE', 'png');

      l_url :=
            const_host_port
         || const_intelligent_server_wurl
         || 'taskId=login&taskEnv=xml&maxRows=64000&taskContentType=xml&server='
         || const_intelligent_server_name
         || '&project='
         || UTL_URL.escape (projectName)
         || '&userid='
         || const_intelligent_server_user
         || '&password='
         || UTL_URL.escape (const_intelligent_server_pass);
      l_clob := sys.ntlm_http_pkg.get_response_clob (l_url, const_intelligent_server_ntus, const_intelligent_server_ntpw);
      l_xml := xmltype (l_clob);
      l_sessionState := l_xml.EXTRACT ('taskResponse/root/sessionState/text()').getstringval ();
      --      HTP.p (l_sessionState);
      --      RETURN;

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
         || rwidth
         || '&availHeight='
         || rHeight;
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
      DBMS_APPLICATION_INFO.set_module ('REPORT_EXECUTE', NULL);
   EXCEPTION
      WHEN OTHERS
      THEN
         error_handler.jsp (SQLERRM, DBMS_UTILITY.format_error_backtrace);
         DBMS_APPLICATION_INFO.set_module ('REPORT_EXECUTE', NULL);
   END;

   PROCEDURE htm (reportId      IN VARCHAR2 DEFAULT '99E6EA454EFE37373F2980A43323C92D',
                  projectName   IN VARCHAR2 DEFAULT const_intelligent_server_proj)
   IS
      l_url           VARCHAR2 (32000);
      p_content       CLOB;
      l_file_etag     VARCHAR2 (100);
      l_header_etag   VARCHAR2 (100);
   BEGIN
      DBMS_APPLICATION_INFO.set_client_info (OWA_UTIL.get_cgi_env ('HTTP_USER_AGENT'));
      DBMS_SESSION.set_identifier ('MicroStrategy Pandas Connector');
      DBMS_APPLICATION_INFO.set_module ('REPORT_EXECUTE', 'htm');
      DBMS_LOB.createtemporary (p_content, TRUE);
      l_file_etag := TO_CHAR (SYSTIMESTAMP, 'J') || reportId;
      l_header_etag := OWA_UTIL.get_cgi_env ('HTTP_IF_NONE_MATCH');

      IF l_file_etag = l_header_etag
      /* check if file is newer, if not returns status 304 = read from browser cache*/
      THEN
         OWA_UTIL.status_line (NSTATUS => 304, CREASON => 'Not Modified', BCLOSE_HEADER => TRUE);
         DBMS_APPLICATION_INFO.set_module ('REPORT_EXECUTE', NULL);
         RETURN;
      ELSE
         l_url :=
               const_host_port
            || const_intelligent_server_wurl
            || 'taskId=reportDataService&taskEnv=html&maxRows=64000&taskContentType=html&server='
            || const_intelligent_server_name
            || '&project='
            || UTL_URL.escape (projectName)
            || '&userid='
            || const_intelligent_server_user
            || '&password='
            || UTL_URL.escape (const_intelligent_server_pass)
            /*ReportGridStyle-ForExportDocumentsExcel = Grid only*/
            --            || '&styleName=ReportGridStyle-ForExportDocumentsExcel&reportID='
            /*ReportGridiPhoneStyle = formatted*/
            || '&styleName=ReportGridiPhoneStyle&reportID='
            || reportId;
         --htp.p (l_url);
         /* For Windows based web services and IIS security use the NTLM package */
         p_content := sys.ntlm_http_pkg.get_response_clob (l_url, const_intelligent_server_ntus, const_intelligent_server_ntpw);
         --p_content := HTTPURITYPE.createuri (l_url).getclob ();
         /* For Windows based web services and IIS security use the NTLM package */
         p_content :=
            REPLACE (
               p_content,
               '<table summary="This table displays the requested report results" id="table_UniqueReportID"',
               '<a href="#" name="MicrosoftExcelButton" data-xl-buttonStyle="Standard" data-xl-dataTableID="table_UniqueReportID" data-xl-tableTitle="Citas"></a><table id="table_UniqueReportID"');
         p_content :=
            REPLACE (
               p_content,
               '</body>',
               '<script src="https://r.office.microsoft.com/r/rlidExcelButton?v=1&kip=1&locale=es-es" type="text/javascript"></script></body>');

         OWA_UTIL.mime_header ('text/html', FALSE);
         HTP.p ('Date: ' || TO_CHAR (SYSTIMESTAMP, 'Dy, DD Mon RRRR hh24:mi:ss') || ' GMT');
         HTP.p ('Last-Modified: ' || TO_CHAR (SYSTIMESTAMP, 'Dy, DD Mon YYYY  "00:00:00"') || ' GMT');
         HTP.p ('ETag: ' || l_file_etag);
         HTP.p ('Expires: ' || TO_CHAR (SYSTIMESTAMP + 1, 'Dy, DD Mon RRRR "00:00:00"') || ' GMT');
         HTP.p ('Cache-Control: max-age=300');
         --HTP.p ('Content-Length: ' || v_length);
         OWA_UTIL.http_header_close;

         -- HTP.p ('Content-Length: ' || v_length);

         deliver_chunks (p_content, l_file_etag);
      --DBMS_LOB.freetemporary (l_clob);
      END IF;

      DBMS_LOB.FREETEMPORARY (p_content);
      DBMS_APPLICATION_INFO.set_module ('REPORT_EXECUTE', NULL);
   EXCEPTION
      WHEN OTHERS
      THEN
         error_handler.jsp (SQLERRM, DBMS_UTILITY.format_error_backtrace);
         DBMS_APPLICATION_INFO.set_module ('REPORT_EXECUTE', NULL);
   END;

   PROCEDURE dataxml (reportId      IN VARCHAR2 DEFAULT '99A42538444D80F6B2EE58852E81BB0B',
                      projectName   IN VARCHAR2 DEFAULT const_intelligent_server_proj)
   IS
      l_url         VARCHAR2 (32000);
      p_content     CLOB;
      l_file_etag   VARCHAR2 (100);
   BEGIN
      DBMS_APPLICATION_INFO.set_client_info (OWA_UTIL.get_cgi_env ('HTTP_USER_AGENT'));
      DBMS_SESSION.set_identifier ('MicroStrategy Pandas Connector');
      DBMS_APPLICATION_INFO.set_module ('REPORT_EXECUTE', 'xml');
      l_file_etag := TO_CHAR (SYSTIMESTAMP, 'J') || reportId;

      l_url :=
            const_host_port
         || const_intelligent_server_wurl
         || 'taskId=reportDataService&taskEnv=xml&taskContentType=xml&server='
         || const_intelligent_server_name
         || '&project='
         || UTL_URL.escape (projectName)
         || '&userid='
         || const_intelligent_server_user
         || '&password='
         || UTL_URL.escape (const_intelligent_server_pass)
         /*ReportGridStyle-ForExportDocumentsExcel = Grid only*/
         --            || '&styleName=ReportGridStyle-ForExportDocumentsExcel&reportID='
         /*ReportGridiPhoneStyle = formatted*/
         || '&styleName=CustomXMLReportStyle&reportID='
         || reportId;
      --      l_url :=
      --         --         'http://fraterno/MicroStrategy/asp/TaskProc.aspx?taskId=reportDataService&taskEnv=xml&taskContentType=xml&server=FRATERNO&project=VALME+DIRECTO&userid=IUSR_WEBSERVICE&password=aumentanun4,9%&styleName=CustomXMLReportStyle&reportID=99A42538444D80F6B2EE58852E81BB0B';
      --         'http://fraterno/MicroStrategy/asp/TaskProc.aspx?taskId=reportDataService&taskEnv=xml&taskContentType=xml&server=FRATERNO&project=VALME+DIRECTO&userid=IUSR_WEBSERVICE&password=aumentanun4,9%&styleName=ReportGridStyle-ForExportDocumentsExcel&reportID=99A42538444D80F6B2EE58852E81BB0B';
      --
      /* For Windows based web services and IIS security use the NTLM package */
      p_content := sys.ntlm_http_pkg.get_response_clob (l_url, const_intelligent_server_ntus, const_intelligent_server_ntpw);
      --p_content := HTTPURITYPE.createuri (l_url).getclob ();
      /* For Windows based web services and IIS security use the NTLM package */
      p_content := REPLACE (SUBSTR (p_content, INSTR (p_content, '<?xml version="1.0" encoding="utf-8"?>')), '</taskResponse>');
      p_content := REPLACE (p_content, '<taskResponse statusCode="200">');

      --OWA_UTIL.mime_header ('text/html; charset=utf-8', FALSE);
      OWA_UTIL.mime_header ('application/xml; charset=utf-8', FALSE);
      HTP.p ('Date: ' || TO_CHAR (SYSTIMESTAMP, 'Dy, DD Mon RRRR hh24:mi:ss') || ' GMT');
      HTP.p ('Last-Modified: ' || TO_CHAR (SYSTIMESTAMP, 'Dy, DD Mon YYYY  "00:00:00"') || ' GMT');
      HTP.p ('ETag: ' || l_file_etag);
      HTP.p ('Expires: ' || TO_CHAR (SYSTIMESTAMP + 1, 'Dy, DD Mon RRRR "00:00:00"') || ' GMT');
      HTP.p ('Cache-Control: max-age=300');
      --HTP.p ('Content-Length: ' || v_length);
      OWA_UTIL.http_header_close;

      -- HTP.p ('Content-Length: ' || v_length);

      deliver_chunks (p_content, l_file_etag);

      DBMS_APPLICATION_INFO.set_module ('REPORT_EXECUTE', NULL);
   EXCEPTION
      WHEN OTHERS
      THEN
         error_handler.jsp (SQLERRM, DBMS_UTILITY.format_error_backtrace);
         DBMS_APPLICATION_INFO.set_module ('REPORT_EXECUTE', NULL);
   END;


   PROCEDURE xml (reportId      IN VARCHAR2 DEFAULT '99A42538444D80F6B2EE58852E81BB0B',
                  projectName   IN VARCHAR2 DEFAULT const_intelligent_server_proj)
   IS
      l_url             VARCHAR2 (32000);
      p_content         CLOB;
      l_file_etag       VARCHAR2 (100);
      l_header_etag     VARCHAR2 (100);
      l_http_request    UTL_HTTP.req;
      l_http_response   UTL_HTTP.resp;
      l_text            VARCHAR2 (32767);
   BEGIN
      DBMS_APPLICATION_INFO.set_client_info (OWA_UTIL.get_cgi_env ('HTTP_USER_AGENT'));
      DBMS_SESSION.set_identifier ('MicroStrategy Pandas Connector');
      DBMS_APPLICATION_INFO.set_module ('REPORT_EXECUTE', 'xml');
      l_file_etag := TO_CHAR (SYSTIMESTAMP, 'J') || reportId;
      l_header_etag := OWA_UTIL.get_cgi_env ('HTTP_IF_NONE_MATCH');

      IF l_file_etag = l_header_etag
      /* check if file is newer, if not returns status 304 = read from browser cache*/
      THEN
         OWA_UTIL.status_line (NSTATUS => 304, CREASON => 'Not Modified', BCLOSE_HEADER => TRUE);
         DBMS_APPLICATION_INFO.set_module ('REPORT_EXECUTE', NULL);
         RETURN;
      ELSE
         --http://fraterno:8080/MicroStrategy/servlet/taskProc?taskId=reportDataService&taskEnv=xml&taskContentType=xml&server=FRATERNO&project=AREA+QUIRURGICA&userid=Administrator&password=YamanakayGurdon&styleName=CustomoDataReportStyle&reportID=DD4A434548371B060E66EE82A63EE889
         l_url :=
               -- const_host_port
               'http://fraterno:8080/MicroStrategy/servlet/taskProc?'
            || 'taskId=reportDataService&taskEnv=xml&maxRows='
            || const_report_maxrows
            || '&taskContentType=xml&server='
            || const_intelligent_server_name
            || '&project='
            || UTL_URL.escape (projectName)
            || '&userid='
            || const_intelligent_server_user
            || '&password='
            || UTL_URL.escape (const_intelligent_server_pass)
            /*ReportGridStyle-ForExportDocumentsExcel = Grid only*/
            --            || '&styleName=ReportGridStyle-ForExportDocumentsExcel&reportID='
            /*ReportGridiPhoneStyle = formatted*/
            || '&styleName=CustomoDataReportStyle&reportID='
            || reportId;
         --htp.p(l_url);
         --return;
         --      l_url :=
         --         --         'http://fraterno/MicroStrategy/asp/TaskProc.aspx?taskId=reportDataService&taskEnv=xml&taskContentType=xml&server=FRATERNO&project=VALME+DIRECTO&userid=IUSR_WEBSERVICE&password=aumentanun4,9%&styleName=CustomXMLReportStyle&reportID=99A42538444D80F6B2EE58852E81BB0B';
         --         'http://fraterno/MicroStrategy/asp/TaskProc.aspx?taskId=reportDataService&taskEnv=xml&taskContentType=xml&server=FRATERNO&project=VALME+DIRECTO&userid=IUSR_WEBSERVICE&password=aumentanun4,9%&styleName=ReportGridStyle-ForExportDocumentsExcel&reportID=99A42538444D80F6B2EE58852E81BB0B';
         --
         /* For Windows based web services and IIS security use the NTLM package */
         --p_content := sys.ntlm_http_pkg.get_response_clob (l_url, const_intelligent_server_ntus, const_intelligent_server_ntpw);
         --p_content := HTTPURITYPE.createuri ('http://fraterno:8080/MicroStrategy/servlet/taskProc?taskId=reportDataService&taskEnv=xml&taskContentType=xml&server=FRATERNO&project=AREA+QUIRURGICA&userid=Administrator&password=YamanakayGurdon&styleName=CustomoDataReportStyle&reportID=DD4A434548371B060E66EE82A63EE889').getclob ();
         --p_content := HTTPURITYPE.createuri (l_url).getclob ();
         /* For Windows based web services and IIS security use the NTLM package */
         DBMS_LOB.createtemporary (p_content, FALSE);
         -- Make a HTTP request and get the response.
         l_http_request := UTL_HTTP.begin_request (l_url);
         l_http_response := UTL_HTTP.get_response (l_http_request);

         -- Copy the response into the CLOB.
         BEGIN
            LOOP
               UTL_HTTP.read_text (l_http_response, l_text, 32766);
               DBMS_LOB.writeappend (p_content, LENGTH (l_text), l_text);
            END LOOP;
         EXCEPTION
            WHEN UTL_HTTP.end_of_body
            THEN
               UTL_HTTP.end_response (l_http_response);
         END;


         p_content := REPLACE (SUBSTR (p_content, INSTR (p_content, '<?xml version="1.0" encoding="utf-8"?>')), '</taskResponse>');
         p_content := REPLACE (p_content, '<taskResponse statusCode="200">');
         p_content := REPLACE (p_content, CHR (13) || CHR (10));

         --OWA_UTIL.mime_header ('text/html; charset=utf-8', FALSE);
         OWA_UTIL.mime_header ('application/atom+xml; charset=utf-8', FALSE);
         HTP.p ('Date: ' || TO_CHAR (SYSTIMESTAMP, 'Dy, DD Mon RRRR hh24:mi:ss') || ' GMT');
         HTP.p ('Last-Modified: ' || TO_CHAR (SYSTIMESTAMP, 'Dy, DD Mon YYYY  "00:00:00"') || ' GMT');
         HTP.p ('ETag: ' || l_file_etag);
         HTP.p ('Expires: ' || TO_CHAR (SYSTIMESTAMP + 1, 'Dy, DD Mon RRRR "00:00:00"') || ' GMT');
         HTP.p ('Cache-Control: max-age=300');
         HTP.p ('Content-Disposition: attachment; filename="' || l_file_etag || '.xml"');
         HTP.p ('Content-Length: ' || DBMS_LOB.getlength (p_content));
         OWA_UTIL.http_header_close;


         --HTP.prn ('<?xml version="1.0" encoding="utf-8"?>');
         --      wpg_docload.download_file(p_content);

         deliver_chunks (p_content, l_file_etag);
         DBMS_LOB.freetemporary (p_content);
         DBMS_APPLICATION_INFO.set_module ('REPORT_EXECUTE', NULL);
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         error_handler.jsp (SQLERRM, DBMS_UTILITY.format_error_backtrace);
         DBMS_APPLICATION_INFO.set_module ('REPORT_EXECUTE', NULL);
         UTL_HTTP.end_response (l_http_response);
   END;

   PROCEDURE deliver_chunks (t_content IN CLOB, l_file_etag IN VARCHAR2)
   IS
      --      v_offset   NUMBER := 1;
      --      v_length   NUMBER;
      --      v_clob     CLOB;
      --      v_amount   NUMBER := 4000;
      --      v_buffer   VARCHAR2 (4002);
      l_offset   NUMBER := 1;
      v_xml      CLOB;
   BEGIN
      v_xml := t_content;

      LOOP
         EXIT WHEN l_offset > DBMS_LOB.getlength (v_xml);
         HTP.prn (DBMS_LOB.SUBSTR (v_xml, 8000, l_offset)); -- (REPLACE (REPLACE (DBMS_LOB.SUBSTR (v_xml, 255, l_offset), CHR (10)), CHR (13))); -- (DBMS_LOB.SUBSTR (v_xml, 255, l_offset));          --DBMS_OUTPUT.PUT_LINE (DBMS_LOB.SUBSTR (v_xml, 255, l_offset));
         l_offset := l_offset + 8000;
      END LOOP;
   /*
      DBMS_LOB.createtemporary (lob_loc => v_clob, cache => FALSE, dur => DBMS_LOB.session);
      v_clob := t_content;

      v_length := DBMS_LOB.getlength (v_clob);

      WHILE v_offset <= v_length
      LOOP
         BEGIN
            DBMS_LOB.read (v_clob,
                           v_amount,
                           v_offset,
                           v_buffer);
            HTP.p (v_buffer);
            v_offset := v_offset + v_amount;
         END;
      END LOOP;

      DBMS_LOB.freetemporary (lob_loc => v_clob);
      */
   END;
END;
/

