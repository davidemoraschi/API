CREATE OR REPLACE PACKAGE BODY MSTR.odata_001_service_workspace
AS
   PROCEDURE xml
   IS
      p_content       CLOB;
      t_clob          BLOB;
      l_file_etag     VARCHAR2 (100) := 'odata_001_service_workspace' || TO_CHAR (SYSTIMESTAMP, 'J');
      l_header_etag   VARCHAR2 (100) := OWA_UTIL.get_cgi_env ('HTTP_IF_NONE_MATCH');
   BEGIN
      DBMS_APPLICATION_INFO.set_client_info (OWA_UTIL.get_cgi_env ('HTTP_USER_AGENT'));
      DBMS_SESSION.set_identifier ('MicroStrategy oData Connector');
      DBMS_APPLICATION_INFO.set_module ('odata_001_service_workspace', 'xml');

      IF l_file_etag = l_header_etag
      /* check if file is newer, if not returns status 304 = read from browser cache*/
      THEN
         OWA_UTIL.status_line (NSTATUS => 304, CREASON => 'Not Modified', BCLOSE_HEADER => TRUE);
         DBMS_APPLICATION_INFO.set_module ('odata_001_service_workspace', NULL);
         RETURN;
      ELSE
         /* if file is newer returns content */
         SELECT XMLSERIALIZE (
                   CONTENT XMLROOT (
                              XMLELEMENT (
                                 "service",
                                 XMLAttributes ('http://www.w3.org/2005/Atom' AS "xmlns:atom",
                                                'http://www.w3.org/2007/app' AS "xmlns",
                                                'http://localhost:54603/ReportDataService.svc/' AS "xml:base"),
                                 XMLELEMENT (
                                    "workspace",
                                    XMLELEMENT ("atom:title", 'Default'),
                                    XMLAGG (
                                       XMLELEMENT ("collection",
                                                   XMLAttributes (object_id AS "href"),
                                                   XMLELEMENT ("atom:title", object_name))))),
                              VERSION '1.0" encoding="UTF-8'))
                   xmlresultclob
           INTO p_content
           FROM MICROSTRATEGY_METADATA.DSSMDOBJINFO
          WHERE parent_id IN (SELECT object_id
                                FROM MICROSTRATEGY_METADATA.DSSMDOBJINFO
                               WHERE object_type = 8 AND object_name = 'oData' AND ROWNUM < 5);

         OWA_UTIL.mime_header ('application/xml; charset=utf-8', FALSE);
         HTP.p ('Date: ' || TO_CHAR (SYSTIMESTAMP, 'Dy, DD Mon RRRR hh24:mi:ss') || ' GMT');
         HTP.p ('Last-Modified: ' || TO_CHAR (SYSTIMESTAMP, 'Dy, DD Mon YYYY  "00:00:00"') || ' GMT');
         HTP.p ('ETag: ' || l_file_etag);
         HTP.p ('Expires: ' || TO_CHAR (SYSTIMESTAMP + 1, 'Dy, DD Mon RRRR "00:00:00"') || ' GMT');
         HTP.p ('Cache-Control: max-age=300');


         IF OWA_UTIL.GET_CGI_ENV ('HTTP_ACCEPT_ENCODING') LIKE 'gzip,%'
         /* check if fbrowser admits gzipped content if so sends compressed version about 30% of the original */
         THEN
            t_clob := UTL_COMPRESS.lz_compress (UTL_RAW.cast_to_raw (p_content));
            HTP.p ('Content-Encoding: gzip');
            HTP.p ('Content-Length: ' || DBMS_LOB.GETLENGTH (t_clob));
            OWA_UTIL.http_header_close;
            WPG_DOCLOAD.download_file (t_clob);
         ELSE
            /* if  not sends uncompressed version */
            OWA_UTIL.http_header_close;
            HTP.p (p_content);
         END IF;

         DBMS_APPLICATION_INFO.set_module ('odata_001_service_workspace', NULL);
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         error_handler.jsp (SQLERRM, DBMS_UTILITY.format_error_backtrace);
         DBMS_APPLICATION_INFO.set_module ('odata_001_service_workspace', NULL);
   END;
END;
/

