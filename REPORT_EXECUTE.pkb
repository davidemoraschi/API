/* Formatted on 10/01/2013 13:31:24 (QP5 v5.163.1008.3004) */
CREATE OR REPLACE PACKAGE BODY MSTR.REPORT_EXECUTE
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
      DBMS_SESSION.set_identifier ('MicroStrategy Report Connector');
      DBMS_APPLICATION_INFO.set_module ('REPORT_EXECUTE', 'png');

      l_url :=
            const_host_port
         || const_intelligent_server_wurl
         || 'taskId=login&taskEnv=xml&taskContentType=xml&server='
         || const_intelligent_server_name
         || '&project='
         || projectName
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
   --      ts_now          TIMESTAMP;
   BEGIN
      -- HTP.p (projectName);
      --     RETURN;
      --
      DBMS_APPLICATION_INFO.set_client_info (OWA_UTIL.get_cgi_env ('HTTP_USER_AGENT'));
      DBMS_SESSION.set_identifier ('MicroStrategy Report Connector');
      DBMS_APPLICATION_INFO.set_module ('REPORT_EXECUTE', 'htm');
      DBMS_LOB.createtemporary (p_content, TRUE);

      l_file_etag := TO_CHAR (SYSTIMESTAMP, 'J') || reportId;
      l_header_etag := OWA_UTIL.get_cgi_env ('HTTP_IF_NONE_MATCH');

      --
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
            || projectName
            || '&userid='
            || const_intelligent_server_user
            || '&password='
            || UTL_URL.escape (const_intelligent_server_pass)
            /*ReportGridStyle-ForExportDocumentsExcel = Grid only*/
            --            || '&styleName=ReportGridStyle-ForExportDocumentsExcel&reportID='
            /*ReportGridiPhoneStyle = formatted*/
            || '&styleName=ReportGridiPhoneStyle&reportID='
            || reportId;
         /* For Windows based web services and IIS security use the NTLM package */
         --p_content := sys.ntlm_http_pkg.get_response_clob (l_url, const_intelligent_server_ntus, const_intelligent_server_ntpw);
         p_content := HTTPURITYPE.createuri (l_url).getclob ();
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
      --         ts_now := SYSTIMESTAMP;
      --
      --         INSERT INTO ODATA_001_LOG_REQUESTS (TS, REQUEST, RESPONSE)
      --              VALUES (ts_now, OWA_UTIL.get_cgi_env ('QUERY_STRING'), p_content);
      --
      --         COMMIT;
      --
      --         OWA_UTIL.mime_header ('text/html', FALSE);
      --         HTP.p ('Date: ' || TO_CHAR (SYSTIMESTAMP, 'Dy, DD Mon RRRR hh24:mi:ss') || ' GMT');
      --         HTP.p ('Last-Modified: ' || TO_CHAR (SYSTIMESTAMP, 'Dy, DD Mon YYYY  "00:00:00"') || ' GMT');
      --         HTP.p ('ETag: ' || l_file_etag);
      --         HTP.p ('Expires: ' || TO_CHAR (SYSTIMESTAMP + 1, 'Dy, DD Mon RRRR "00:00:00"') || ' GMT');
      --         HTP.p ('Cache-Control: max-age=300');
      --
      --         IF OWA_UTIL.GET_CGI_ENV ('HTTP_ACCEPT_ENCODING') LIKE 'gzip,%'
      --         /* check if fbrowser admits gzipped content if so sends compressed version about 30% of the original */
      --         THEN
      --            t_clob := UTL_COMPRESS.lz_compress (UTL_RAW.cast_to_raw (p_content));
      --            HTP.p ('Content-Encoding: gzip');
      --            HTP.p ('Content-Length: ' || DBMS_LOB.GETLENGTH (t_clob));
      --            OWA_UTIL.http_header_close;
      --            WPG_DOCLOAD.download_file (t_clob);
      --         ELSE
      --            /* if  not sends uncompressed version */
      --            OWA_UTIL.http_header_close;
      --            HTP.p (p_content);
      END IF;

      --
      DBMS_LOB.FREETEMPORARY (p_content);
      DBMS_APPLICATION_INFO.set_module ('REPORT_EXECUTE', NULL);
   --      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         error_handler.jsp (SQLERRM, DBMS_UTILITY.format_error_backtrace);
         DBMS_APPLICATION_INFO.set_module ('REPORT_EXECUTE', NULL);
   END;

   PROCEDURE deliver_chunks (t_content IN CLOB, l_file_etag IN VARCHAR2)
   IS
      v_offset   NUMBER := 1;
      v_length   NUMBER;
      v_clob     CLOB;
      v_amount   NUMBER := 16000;
      v_buffer   VARCHAR2 (32000);
   --l_file_etag     VARCHAR2 (100);
   BEGIN
      DBMS_LOB.createtemporary (lob_loc => v_clob, cache => FALSE, dur => DBMS_LOB.session);
      v_clob := t_content;

      v_length := DBMS_LOB.getlength (v_clob);

      --            HTP.p ('--v_offset-: ' || v_offset);
      --            HTP.p ('--v_amount-: ' || v_amount);
      --            HTP.p ('--v_length-: ' || v_length);

      WHILE v_offset <= v_length
      LOOP
         BEGIN
            DBMS_LOB.read (v_clob,
                           v_amount,
                           v_offset,
                           v_buffer);
            HTP.p (v_buffer);
            v_offset := v_offset + v_amount;
         --                     HTP.p ('--v_offset-: ' || v_offset);
         --                     HTP.p ('--v_amount-: ' || v_amount);
         --                     HTP.p ('--v_length-: ' || v_length);
         --         EXCEPTION
         --            WHEN OTHERS
         --            THEN
         --               NULL;
         END;
      END LOOP;

      DBMS_LOB.freetemporary (lob_loc => v_clob);
   --      HTP.p ('<hr />ok');
   --   RETURN;

   END;
END;
/