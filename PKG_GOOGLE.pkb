CREATE OR REPLACE PACKAGE BODY ALMAGESTO."PKG_GOOGLE"
AS
/******************************************************************************
   NAME:       PKG_GOOGLE
   PURPOSE:

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        02/12/2009  dmoraschi  1. Created this package body.
******************************************************************************/
   PROCEDURE prepare_connection
   IS
   BEGIN                                                                                              --Parámetros de la conexión
      UTL_HTTP.set_proxy (proxy                         => con_str_http_proxy, no_proxy_domains => con_str_no_proxy);
      UTL_HTTP.set_wallet (PATH                          => con_str_wallet_path, PASSWORD => con_str_wallet_pass);
      UTL_HTTP.set_follow_redirect (max_redirects                 => 3);
   END prepare_connection;

   FUNCTION authorize (
      par_http_request_params    IN       VARCHAR2)
      RETURN VARCHAR2
   IS
      var_http_request              UTL_HTTP.req;
      var_http_response             UTL_HTTP.resp;
      var_http_value                VARCHAR2 (32767);
      var_http_value_raw            RAW (32767);
      ret_val                       VARCHAR2 (32767);
   BEGIN
      var_http_request := prepare_request (con_str_google_login, par_http_request_params);
      UTL_HTTP.write_text (var_http_request, par_http_request_params);
      var_http_response := UTL_HTTP.get_response (r                             => var_http_request);

      BEGIN
         IF var_http_response.status_code = UTL_HTTP.http_ok
         THEN
            LOOP
               UTL_HTTP.read_line (r                             => var_http_response
                                  ,DATA                          => var_http_value
                                  ,remove_crlf                   => TRUE);

               IF INSTR (var_http_value, 'Auth') > 0
               THEN
                  ret_val := SUBSTR (var_http_value, 6);
               END IF;
            END LOOP;
         ELSE
            ret_val := var_http_response.status_code || ' - ' || var_http_response.reason_phrase;

            LOOP
               UTL_HTTP.read_raw (r                             => var_http_response
                                 ,DATA                          => var_http_value_raw
                                 ,len                           => 32767);
            END LOOP;
         END IF;
      EXCEPTION
         WHEN UTL_HTTP.end_of_body
         THEN
            UTL_HTTP.end_response (r                             => var_http_response);
      END;

      RETURN ret_val;
   END authorize;

   FUNCTION get_calendar_url (
      par_authorization_token    IN       VARCHAR2
     ,par_calendar_entry         IN       XMLTYPE)
      RETURN VARCHAR2
   IS
      var_http_request              UTL_HTTP.req;
      var_http_response             UTL_HTTP.resp;
      var_resp_header_name          VARCHAR2 (1024);
      var_resp_header_value         VARCHAR2 (1024);
      var_http_value_raw            RAW (32767);
      ret_val                       VARCHAR2 (1024);
   BEGIN
      var_http_request := prepare_request (con_str_google_cal_url
                                          ,par_calendar_entry
                                          ,par_authorization_token);
      UTL_HTTP.write_text (var_http_request, par_calendar_entry.getstringval ());
      var_http_response := UTL_HTTP.get_response (r                             => var_http_request);

      BEGIN
         IF var_http_response.status_code = UTL_HTTP.http_found
         THEN
            FOR i IN 1 .. UTL_HTTP.get_header_count (var_http_response)
            LOOP
               UTL_HTTP.get_header (r                             => var_http_response
                                   ,n                             => i
                                   ,NAME                          => var_resp_header_name
                                   ,VALUE                         => var_resp_header_value);

               IF var_resp_header_name = 'Location'
               THEN
                  ret_val := var_resp_header_value;
               END IF;
            END LOOP;
         ELSE
            ret_val := var_http_response.status_code || ' - ' || var_http_response.reason_phrase;
         END IF;

         LOOP
            UTL_HTTP.read_raw (r                             => var_http_response
                              ,DATA                          => var_http_value_raw
                              ,len                           => 32767);
         END LOOP;
      EXCEPTION
         WHEN UTL_HTTP.end_of_body
         THEN
            UTL_HTTP.end_response (r                             => var_http_response);
      END;

      RETURN ret_val;
   END get_calendar_url;

   FUNCTION get_calendar_error_url (
      par_authorization_token    IN       VARCHAR2
     ,par_calendar_entry         IN       XMLTYPE)
      RETURN VARCHAR2
   IS
      var_http_request              UTL_HTTP.req;
      var_http_response             UTL_HTTP.resp;
      var_resp_header_name          VARCHAR2 (1024);
      var_resp_header_value         VARCHAR2 (1024);
      var_http_value_raw            RAW (32767);
      ret_val                       VARCHAR2 (1024);
   BEGIN
      var_http_request := prepare_request (con_str_google_error_cal
                                          ,par_calendar_entry
                                          ,par_authorization_token);
      UTL_HTTP.write_text (var_http_request, par_calendar_entry.getstringval ());
      var_http_response := UTL_HTTP.get_response (r                             => var_http_request);

      BEGIN
         IF var_http_response.status_code = UTL_HTTP.http_found
         THEN
            FOR i IN 1 .. UTL_HTTP.get_header_count (var_http_response)
            LOOP
               UTL_HTTP.get_header (r                             => var_http_response
                                   ,n                             => i
                                   ,NAME                          => var_resp_header_name
                                   ,VALUE                         => var_resp_header_value);

               IF var_resp_header_name = 'Location'
               THEN
                  ret_val := var_resp_header_value;
               END IF;
            END LOOP;
         ELSE
            ret_val := var_http_response.status_code || ' - ' || var_http_response.reason_phrase;
         END IF;

         LOOP
            UTL_HTTP.read_raw (r                             => var_http_response
                              ,DATA                          => var_http_value_raw
                              ,len                           => 32767);
         END LOOP;
      EXCEPTION
         WHEN UTL_HTTP.end_of_body
         THEN
            UTL_HTTP.end_response (r                             => var_http_response);
      END;

      RETURN ret_val;
   END get_calendar_error_url;

   FUNCTION add_calendar_entry (
      par_authorization_token    IN       VARCHAR2
     ,par_calendar_entry         IN       XMLTYPE
     ,par_con_str_google_cal_redir IN     VARCHAR2)
      RETURN VARCHAR2
   IS
      var_http_request              UTL_HTTP.req;
      var_http_response             UTL_HTTP.resp;
      var_http_value                VARCHAR2 (32767);
      var_http_value_raw            RAW (32767);
      ret_val                       VARCHAR2 (1024);
   BEGIN
      var_http_request := prepare_request (par_con_str_google_cal_redir
                                          ,par_calendar_entry
                                          ,par_authorization_token);
      UTL_HTTP.write_text (var_http_request, par_calendar_entry.getstringval ());
      var_http_response := UTL_HTTP.get_response (r                             => var_http_request);

      BEGIN
         ret_val := var_http_response.status_code || ' - ' || var_http_response.reason_phrase;

         LOOP
            UTL_HTTP.read_line (r                             => var_http_response
                               ,DATA                          => var_http_value
                               ,remove_crlf                   => TRUE);
         --dbms_output.put_line (VAR_HTTP_VALUE);
         END LOOP;
      EXCEPTION
         WHEN UTL_HTTP.end_of_body
         THEN
            UTL_HTTP.end_response (r                             => var_http_response);
      END;

      RETURN ret_val;
   END add_calendar_entry;

   FUNCTION prepare_request (
      par_url                    IN       VARCHAR2
     ,par_http_request_params    IN       VARCHAR2)
      RETURN UTL_HTTP.req
   IS
      var_http_request              UTL_HTTP.req;
   BEGIN
      var_http_request := UTL_HTTP.begin_request (url                           => par_url
                                                 ,method                        => 'POST'
                                                 ,http_version                  => UTL_HTTP.http_version_1_1);
      UTL_HTTP.set_header (r                             => var_http_request
                          ,NAME                          => 'Content-Type'
                          ,VALUE                         => 'application/x-www-form-urlencoded');
      UTL_HTTP.set_header (r                             => var_http_request
                          ,NAME                          => 'Content-Length'
                          ,VALUE                         => LENGTH (par_http_request_params));
      UTL_HTTP.set_header (r                             => var_http_request
                          ,NAME                          => 'GData-Version'
                          ,VALUE                         => '2.0');
      UTL_HTTP.set_header (r                             => var_http_request
                          ,NAME                          => 'Accept-Charset'
                          ,VALUE                         => 'iso-8859-1');
      UTL_HTTP.set_cookie_support (r                             => var_http_request, ENABLE => TRUE);
      RETURN var_http_request;
   END prepare_request;

   FUNCTION prepare_request (
      par_url                    IN       VARCHAR2
     ,par_calendar_entry         IN       XMLTYPE
     ,par_authorization_token    IN       VARCHAR2)
      RETURN UTL_HTTP.req
   IS
      var_http_request              UTL_HTTP.req;
      var_calendar_entry            VARCHAR2 (32767);
   BEGIN
      var_calendar_entry := par_calendar_entry.getstringval ();
      var_http_request := UTL_HTTP.begin_request (url                           => par_url
                                                 ,method                        => 'POST'
                                                 ,http_version                  => UTL_HTTP.http_version_1_1);
      UTL_HTTP.set_header (r                             => var_http_request
                          ,NAME                          => 'Content-Type'
                          ,VALUE                         => 'application/atom+xml;charset=iso-8859-1');
      UTL_HTTP.set_header (r                             => var_http_request
                          ,NAME                          => 'Content-Length'
                          ,VALUE                         => LENGTH (var_calendar_entry));
      UTL_HTTP.set_header (r                             => var_http_request
                          ,NAME                          => 'GData-Version'
                          ,VALUE                         => '2.0');
      UTL_HTTP.set_header (r                             => var_http_request
                          ,NAME                          => 'Accept-Charset'
                          ,VALUE                         => 'iso-8859-1');
      UTL_HTTP.set_header (r                             => var_http_request
                          ,NAME                          => 'Authorization'
                          ,VALUE                         => 'GoogleLogin auth=' || par_authorization_token);
      UTL_HTTP.set_cookie_support (r                             => var_http_request, ENABLE => TRUE);
      RETURN var_http_request;
   END prepare_request;

   PROCEDURE vigilante_de_seguridad
   IS
      var_http_request_params       VARCHAR2 (1024)
         :=    'accountType='
            || con_str_account_type
            || '&Email='
            || con_str_account_name
            || '&Passwd='
            || con_str_account_pass
            || '&service='
            || con_str_google_cal_serv
            || '&source='
            || con_str_google_sour;
      cal_entry                     XMLTYPE;
      cal_entry_type                NUMBER;
      cal_entry_select              VARCHAR2 (1024);
      current_year_folder           VARCHAR2 (25) := '/almagesto/' || TO_CHAR (CURRENT_DATE, 'YYYY');
      current_month_folder          VARCHAR2 (50) := current_year_folder || '/' || TO_CHAR (CURRENT_DATE, 'fmMonth');
      full_html_path                VARCHAR2 (255);
      html_content                  VARCHAR2 (32767);
      result_var                    VARCHAR2 (1024);
      auth_token                    VARCHAR2 (1024);
      c2                            sys_refcursor;
      retval                        BOOLEAN;
   BEGIN
      FOR c1 IN (SELECT view_name
                 FROM   user_views
                 WHERE  view_name LIKE 'CAL_%')
      LOOP
         DBMS_OUTPUT.put_line (c1.view_name);
         full_html_path := current_month_folder || '/' || c1.view_name || '_' || TO_CHAR (CURRENT_DATE, 'fmDD-DY') || '.html';

         EXECUTE IMMEDIATE 'SELECT ENTRY, TIPO, CONSULTA FROM ' || c1.view_name
         INTO              cal_entry
                          ,cal_entry_type
                          ,cal_entry_select;

         IF cal_entry_type = 2
         THEN
            IF NOT DBMS_XDB.existsresource (current_year_folder)
            THEN
               retval := DBMS_XDB.createfolder (current_year_folder);
            END IF;

            IF NOT DBMS_XDB.existsresource (current_month_folder)
            THEN
               retval := DBMS_XDB.createfolder (current_month_folder);
            END IF;

            EXECUTE IMMEDIATE 'alter session set nls_date_format =''fmDay DD Mon YYYY HH24:MI:SS''';

            OPEN c2 FOR cal_entry_select;

            html_content := gen_html_table (c2);
            DBMS_OUTPUT.put_line (full_html_path);

            IF NOT DBMS_XDB.existsresource (full_html_path)
            THEN
               retval := DBMS_XDB.createresource (full_html_path, html_content);
               -- IF RETVAL THEN
               -- END IF;
               COMMIT;
            END IF;
         END IF;

          /*        UTL_MAIL.SEND (SENDER =>                        'valme.almagesto@gmail.com'
                                ,RECIPIENTS =>                    'moraschi.davide.exts@juntadeandalucia.es'
                                ,CC =>                            NULL
                                ,BCC =>                           NULL
                                ,SUBJECT =>                       'UTL_MAIL Test'
                                ,MESSAGE =>                       HTML_CONTENT
                                ,MIME_TYPE =>                     'text/html;');
                  COMMIT;
         */
         pkg_google.prepare_connection;
         auth_token := pkg_google.authorize (par_http_request_params       => var_http_request_params);
         result_var :=
            pkg_google.add_calendar_entry
                              (par_authorization_token       => auth_token
                              ,par_calendar_entry            => cal_entry
                              ,par_con_str_google_cal_redir  => pkg_google.get_calendar_url
                                                                                           (par_authorization_token       => auth_token
                                                                                           ,par_calendar_entry            => cal_entry));
         DBMS_OUTPUT.put_line (result_var);
      END LOOP;
--   EXCEPTION
--      WHEN OTHERS THEN
--         RETURN FALSE;
   END vigilante_de_seguridad;

   PROCEDURE chivato_de_duplicados
   IS
      html_content                  VARCHAR2 (4000);
   BEGIN
      SELECT    '<HTML><BODY><IMG style="border:1px solid black" SRC="'
             || 'http://chart.apis.google.com/chart?cht=bvs&chs=650x300&chf=c,lg,0,76A4FB,1,FFFFFF,0|bg,s,FFFACD&chd=t:'
             || query_to_csv                                                                                          --calendario
                   ('SELECT TO_CHAR (COUNT (ID_TRANSACCION)) COL1
			FROM     DAE_TRANSACCIONES_HL7@VALME29
			WHERE    TRUNC (FECHA_TRANSACCION) BETWEEN TRUNC (SYSDATE) - 7 AND TRUNC (SYSDATE) - 1 
            AND ESTADO_TRANSACCION = 0
			GROUP BY TRUNC (FECHA_TRANSACCION)
			ORDER BY TRUNC (FECHA_TRANSACCION)')
             || '|'
             || query_to_csv                                                                                             --errores
                   ('SELECT TO_CHAR (COUNT (ID_TRANSACCION)) COL1
			FROM     DAE_TRANSACCIONES_HL7@VALME29 JOIN DAE_ERRORES_HL7@VALME29 ON ID_TRANSACCION = ID_CITA_ERROR
			WHERE    TRUNC (FECHA_TRANSACCION) BETWEEN TRUNC (SYSDATE) - 7 AND TRUNC (SYSDATE) - 1 
            AND ESTADO_TRANSACCION < 0  AND NUMERO_ERROR <> -20513
			GROUP BY TRUNC (FECHA_TRANSACCION)
			ORDER BY TRUNC (FECHA_TRANSACCION)')
             || '|'
             || query_to_csv                                                                                          --duplicados
                   (
                              /*'SELECT TO_CHAR (COUNT (ID_TRANSACCION)) COL1
                    FROM     DAE_TRANSACCIONES_HL7@VALME29 JOIN DAE_ERRORES_HL7@VALME29 ON ID_TRANSACCION = ID_CITA_ERROR
                    WHERE    TRUNC (FECHA_TRANSACCION) BETWEEN TRUNC (SYSDATE) - 7 AND TRUNC (SYSDATE) - 1
                       AND ESTADO_TRANSACCION < 0  AND NUMERO_ERROR = -20513
                    GROUP BY TRUNC (FECHA_TRANSACCION)
                    ORDER BY TRUNC (FECHA_TRANSACCION)'*/
                    'SELECT   NVL(col1,0)
                        FROM     (SELECT   TRUNC (fecha_transaccion) ft
                                          ,TO_CHAR (COUNT (id_transaccion)) col1
                                  FROM     dae_transacciones_hl7@valme29 JOIN dae_errores_hl7@valme29 ON id_transaccion = id_cita_error     --, calendario
                                  WHERE    TRUNC (fecha_transaccion) BETWEEN TRUNC (SYSDATE) - 7 AND TRUNC (SYSDATE) - 1
                                  AND      estado_transaccion < 0
                                  AND      numero_error = -20513
                                  GROUP BY TRUNC (fecha_transaccion)) a
                                 RIGHT JOIN
                                 (SELECT   TRUNC (fecha_transaccion) ft
                                  FROM     dae_transacciones_hl7@valme29
                                  WHERE    TRUNC (fecha_transaccion) BETWEEN TRUNC (SYSDATE) - 7 AND TRUNC (SYSDATE) - 1
                                  GROUP BY TRUNC (fecha_transaccion)) b USING (ft)
                        ORDER BY ft')
             || '&chxr=1,0,1200&chds=0,1200&chco=0A8C8A,EBB671,DE091A&chbh=45,30,15&chxt=x,y&chxl=0:|'
             || query_to_csv_sep                                                                              --fechas para el eje
                   ('SELECT TO_CHAR (TRUNC (FECHA_TRANSACCION),''dd Month'') COL1
			FROM     DAE_TRANSACCIONES_HL7@VALME29
			WHERE    TRUNC (FECHA_TRANSACCION) BETWEEN TRUNC (SYSDATE) - 7 AND TRUNC (SYSDATE) - 1 
			GROUP BY TRUNC (FECHA_TRANSACCION)
			ORDER BY TRUNC (FECHA_TRANSACCION)')
             || '&chdl=Correctos|Erróneos|Duplicados&chg=0,8.3,5,5&chxs=0,0000DD,12,0,t,FF0000&chm=N,000000,2,-1,12,0&chtt=Mensajes+DAE&chts=0000DD,20&chma=40,30,30,30|80,20'
             || '"></BODY></HTML>'
      INTO   html_content
      FROM   DUAL;

      UTL_MAIL.send (sender                        => 'Integrador DAE_HIS <valme.almagesto@gmail.com>'
                    ,recipients                    => 'Davide Moraschi <moraschi.davide.exts@juntadeandalucia.es>'
--                    ,cc                            => 'Isabel Pérez Pérez <isabel.perez.perez.sspa@juntadeandalucia.es>, Orta Muñoz, Diego Agustin <diegoa.orta.sspa@juntadeandalucia.es>, José María Pérez Gata<josem.perez.gata.sspa@juntadeandalucia.es>'
                    ,cc                            => 'isabel.perez.perez.sspa@juntadeandalucia.es, diegoa.orta.sspa@juntadeandalucia.es, josem.perez.gata.sspa@juntadeandalucia.es, david.garcia.jimenez.exts@juntadeandalucia.es, jantonio.guerrero.sspa@juntadeandalucia.es, ricardo.almagro@juntadeandalucia.es, jabraza@eservicios.indra.es, inmaculada.canela.sspa@juntadeandalucia.es'
                    ,bcc                           => NULL
                    ,subject                       => 'Mensajes DAE_HIS'
                    ,MESSAGE                       => html_content
                    ,mime_type                     => 'text/html;');
      COMMIT;
      DBMS_SCHEDULER.purge_log (log_history                   => 5
                               ,which_log                     => 'JOB_AND_WINDOW_LOG'
                               ,job_name                      => 'EL_CHIVATO');
   END chivato_de_duplicados;

   PROCEDURE chivato_de_mensajes
   IS
      cal_entry                     XMLTYPE;
      status                        NUMBER;
      auth_token                    VARCHAR2 (1024);
      var_http_request_params       VARCHAR2 (1024)
         :=    'accountType='
            || con_str_account_type
            || '&Email='
            || con_str_account_name
            || '&Passwd='
            || con_str_account_pass
            || '&service='
            || con_str_google_cal_serv
            || '&source='
            || con_str_google_sour;
      cal_url                       VARCHAR2 (1024);
      result_var                    VARCHAR2 (1024);
      v_ultima_transaccion_log      NUMBER;
      v_ultima_transaccion_dae      NUMBER;
   BEGIN
      BEGIN
         SELECT estado_transaccion
               ,XMLELEMENT ("entry"
                           ,xmlattributes ('http://www.w3.org/2005/Atom' AS "xmlns"
                                          ,'http://schemas.google.com/g/2005' AS "xmlns:gd")
                           ,XMLELEMENT ("category"
                                       ,xmlattributes ('http://schemas.google.com/g/2005#kind' AS "scheme"
                                                      ,'http://schemas.google.com/g/2005#event' AS "term"))
                           ,XMLELEMENT ("title"
                                       ,xmlattributes ('text' AS "type")
                                       , desc_mensaje || gen_html_table_title (tipo_transaccion, id_transaccion))
                           ,XMLELEMENT ("content"
                                       ,xmlattributes ('text' AS "type")
                                       ,NULL)
                           ,XMLELEMENT ("author", XMLELEMENT ("name", 'Vigilante de seguridad'))
                           ,XMLELEMENT ("gd:transparency"
                                       ,xmlattributes ('http://schemas.google.com/g/2005#event.opaque' AS "value"))
                           ,XMLELEMENT ("gd:eventStatus"
                                       ,xmlattributes ('http://schemas.google.com/g/2005#event.confirmed' AS "value"))
                           ,XMLELEMENT ("gd:where"
                                       ,xmlattributes (NVL (texto_error
                                                           ,    gen_html_lugar (tipo_transaccion, id_transaccion)
                                                             || ' - Trans. '
                                                             || id_transaccion) AS "valueString"))
                           ,XMLELEMENT ("gd:when"
                                       ,xmlattributes (TO_CHAR (fecha_recepcion, 'YYYY-MM-DD"T"HH24:MI:SS') AS "startTime"
                                                      ,TO_CHAR (fecha_recepcion + INTERVAL '1' MINUTE, 'YYYY-MM-DD"T"HH24:MI:SS') AS "endTime")))
         INTO   status
               ,cal_entry
         FROM   dae_transacciones_hl7@valme29 JOIN adm_m_tipo_mensajes@valme29 ON tipo_transaccion = id_mensaje
                LEFT JOIN dae_errores_hl7@valme29 ON id_transaccion = id_cita_error
         WHERE  id_transaccion = (SELECT id_ultima_transaccion + 1
                                  FROM   log_dae);
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            SELECT MAX (id_transaccion)
            INTO   v_ultima_transaccion_dae
            FROM   dae_transacciones_hl7@valme29;

            SELECT id_ultima_transaccion + 1
            INTO   v_ultima_transaccion_log
            FROM   log_dae;

            IF v_ultima_transaccion_dae > v_ultima_transaccion_log
            THEN
               UPDATE log_dae
                  SET id_ultima_transaccion = id_ultima_transaccion + 1
                     ,resultado = 'skipped'
                     ,entry = NULL;
            END IF;

            RETURN;
      END;

      pkg_google.prepare_connection;
      --dbms_output.put_line (VAR_HTTP_REQUEST_PARAMS);
      auth_token := pkg_google.authorize (var_http_request_params);

      --dbms_output.put_line (AUTH_TOKEN);
      IF status = 0
      THEN
         cal_url := pkg_google.get_calendar_url (auth_token, cal_entry);
      ELSE
         cal_url := pkg_google.get_calendar_error_url (auth_token, cal_entry);
      END IF;

      --dbms_output.put_line (CAL_URL);
      IF cal_url <> '201 - Created'
      THEN
         result_var := pkg_google.add_calendar_entry (auth_token
                                                     ,cal_entry
                                                     ,cal_url);
      ELSE
         result_var := cal_url;
      END IF;

      DBMS_OUTPUT.put_line (result_var);

      IF result_var = '201 - Created'
      THEN
         UPDATE log_dae
            SET id_ultima_transaccion = id_ultima_transaccion + 1
               ,resultado = result_var
               ,entry = cal_entry;
      ELSE
         UPDATE log_dae
            SET id_ultima_transaccion = id_ultima_transaccion
               ,resultado = result_var
               ,entry = cal_entry;
      END IF;

      COMMIT;
   END chivato_de_mensajes;

   FUNCTION gen_html_table (
      rf                         IN       sys_refcursor)
      RETURN VARCHAR2
   AS
      lhtmloutput                   XMLTYPE;
      lxsl                          LONG;
      lxmldata                      XMLTYPE;
      lcontext                      DBMS_XMLGEN.ctxhandle;
   BEGIN
      lcontext := DBMS_XMLGEN.newcontext (rf);
      -- setNullHandling to 1 (or 2) to allow null columns
      -- to be displayed
      DBMS_XMLGEN.setnullhandling (lcontext, 1);
      -- create XML from ref cursor --
      lxmldata := DBMS_XMLGEN.getxmltype (lcontext, DBMS_XMLGEN.NONE);
      -- this is a generic XSL for Oracle's default
      -- XML row and rowset tags --
      -- " " is a non-breaking space --
      lxsl :=
         '<?xml version="1.0" encoding="ISO-8859-1"?>
            <xsl:stylesheet version="1.0"
              xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
            <xsl:output method="html"/>
            <xsl:template match="/">
            <html>
             <head>
              <title>Resultado</title> 
              <link rel="stylesheet" href="http://valme_15:8080/almagesto/css/blute_table_styles.css" type="text/css" />
              </head>
              <body>
               <table border="0">
                 <tr>
                  <xsl:for-each select="/ROWSET/ROW[1]/*">
                   <th><xsl:value-of select="name()"/></th>
                  </xsl:for-each>
                 </tr>
                 <xsl:for-each select="/ROWSET/*">
                  <tr>
                   <xsl:for-each select="./*">
                    <td><xsl:value-of select="text()"/> </td>
                   </xsl:for-each>
                  </tr>
                 </xsl:for-each>
               </table>
               </body>
            </html>
              </xsl:template>
            </xsl:stylesheet>';        --  <link rel="stylesheet" href="http://rufiano/almagesto/css/Azul.css" type="text/css" />
      -- XSL transformation to convert XML to HTML --
      lhtmloutput := lxmldata.transform (XMLTYPE (lxsl));
      -- convert XMLType to Clob --
      DBMS_XMLGEN.closecontext (lcontext);
      RETURN DBMS_LOB.SUBSTR (lhtmloutput.getclobval ());
   END gen_html_table;

   FUNCTION gen_html_table_title (
      p_tipo_transaccion         IN       NUMBER
     ,p_id_transaccion           IN       NUMBER)
      RETURN VARCHAR2
   AS
      document                      VARCHAR2 (4000);
      v_td_episodio                 VARCHAR2 (100) := NULL;
      v_td_nuhsa                    VARCHAR2 (100) := NULL;
      v_td_nhc                      VARCHAR2 (100) := NULL;
      v_td_servicio                 VARCHAR2 (100) := NULL;
      v_td_habitacion               VARCHAR2 (100) := NULL;
      v_td_cama                     VARCHAR2 (100) := NULL;
   BEGIN
      document := document || HTF.tableOpen (cattributes                   => 'border=0 cellpadding=1 cellspacing=1');
      document := document || HTF.tableRowOpen;
      document :=
            document
         || HTF.tableheader (HTF.fontOpen ('#4f6b72'
                                          ,'Arial'
                                          ,'-2') || 'ID Episodio' || HTF.fontClose
                            ,''
                            ,''
                            ,''
                            ,''
                            ,''
                            ,'bgcolor=#CAE8EA');
      document :=
            document
         || HTF.tableheader (HTF.fontOpen ('#4f6b72'
                                          ,'Arial'
                                          ,'-2') || 'Nuhsa' || HTF.fontClose
                            ,''
                            ,''
                            ,''
                            ,''
                            ,''
                            ,'bgcolor=#CAE8EA');
      document :=
            document
         || HTF.tableheader (HTF.fontOpen ('#4f6b72'
                                          ,'Arial'
                                          ,'-2') || 'N. Historia' || HTF.fontClose
                            ,''
                            ,''
                            ,''
                            ,''
                            ,''
                            ,'bgcolor=#CAE8EA');
      document :=
            document
         || HTF.tableheader (HTF.fontOpen ('#4f6b72'
                                          ,'Arial'
                                          ,'-2') || 'Habitación' || HTF.fontClose
                            ,''
                            ,''
                            ,''
                            ,''
                            ,''
                            ,'bgcolor=#CAE8EA');
      document :=
            document
         || HTF.tableheader (HTF.fontOpen ('#4f6b72'
                                          ,'Arial'
                                          ,'-2') || 'Cama' || HTF.fontClose
                            ,''
                            ,''
                            ,''
                            ,''
                            ,''
                            ,'bgcolor=#CAE8EA');
      document := document || HTF.tableRowClose;
      document := document || HTF.tableRowOpen;

      CASE
         WHEN p_tipo_transaccion IN (0, 2, 4, 7)
         THEN
            SELECT d.mensaje.EXTRACT ('/ADT_A01/PV1/PV1.19/CX.1/text()', 'xmlns="urn:hl7-org:v2xml"').getstringval ()
                  ,d.mensaje.EXTRACT ('/ADT_A01/PID/PID.3[CX.5="JHN"]/CX.1/text()', 'xmlns="urn:hl7-org:v2xml"').getstringval ()
                  ,d.mensaje.EXTRACT ('/ADT_A01/PID/PID.3[CX.5="PI"]/CX.1/text()', 'xmlns="urn:hl7-org:v2xml"').getstringval ()
                  , (SELECT ubi_nombre
                     FROM   ubicaciones
                     WHERE  ubi_codigo =
                                 d.mensaje.EXTRACT ('/ADT_A01/PV1/PV1.3/PL.2/text()', 'xmlns="urn:hl7-org:v2xml"').getstringval
                                                                                                                               ())
                  , (SELECT ubi_nombre
                     FROM   ubicaciones
                     WHERE  ubi_codigo =
                                 d.mensaje.EXTRACT ('/ADT_A01/PV1/PV1.3/PL.3/text()', 'xmlns="urn:hl7-org:v2xml"').getstringval
                                                                                                                               ())
            INTO   v_td_episodio
                  ,v_td_nuhsa
                  ,v_td_nhc
                  ,v_td_habitacion
                  ,v_td_cama
            FROM   dae_adt_a01@valme29 d
            WHERE  id_transaccion = p_id_transaccion;
         WHEN p_tipo_transaccion = 5
         THEN
            SELECT d.mensaje.EXTRACT ('/ADT_A02/PV1/PV1.19/CX.1', 'xmlns="urn:hl7-org:v2xml"').getstringval ()
                  ,d.mensaje.EXTRACT ('/ADT_A02/PID/PID.3[CX.5="JHN"]/CX.1/text()', 'xmlns="urn:hl7-org:v2xml"').getstringval ()
                  ,d.mensaje.EXTRACT ('/ADT_A02/PID/PID.3[CX.5="PI"]/CX.1/text()', 'xmlns="urn:hl7-org:v2xml"').getstringval
                                                                                                               () --PV1/PV1.6/PL.3
                  , (SELECT ubi_nombre
                     FROM   ubicaciones
                     WHERE  ubi_codigo =
                                 d.mensaje.EXTRACT ('/ADT_A02/PV1/PV1.3/PL.2/text()', 'xmlns="urn:hl7-org:v2xml"').getstringval
                                                                                                                               ())
                  ,    (SELECT ubi_nombre
                        FROM   ubicaciones
                        WHERE  ubi_codigo =
                                  d.mensaje.EXTRACT ('/ADT_A02/PV1/PV1.6/PL.3/text()', 'xmlns="urn:hl7-org:v2xml"').getstringval
                                                                                                                               ())
                    || '->'
                    || (SELECT ubi_nombre
                        FROM   ubicaciones
                        WHERE  ubi_codigo =
                                  d.mensaje.EXTRACT ('/ADT_A02/PV1/PV1.3/PL.3/text()', 'xmlns="urn:hl7-org:v2xml"').getstringval
                                                                                                                               ())
            INTO   v_td_episodio
                  ,v_td_nuhsa
                  ,v_td_nhc
                  ,v_td_habitacion
                  ,v_td_cama
            FROM   dae_adt_a02@valme29 d
            WHERE  id_transaccion = p_id_transaccion;
         WHEN p_tipo_transaccion = 3
         THEN
            SELECT d.mensaje.EXTRACT ('/ADT_A03/PV1/PV1.19/CX.1', 'xmlns="urn:hl7-org:v2xml"').getstringval ()
                  ,d.mensaje.EXTRACT ('/ADT_A03/PID/PID.3[CX.5="JHN"]/CX.1/text()', 'xmlns="urn:hl7-org:v2xml"').getstringval ()
                  ,d.mensaje.EXTRACT ('/ADT_A03/PID/PID.3[CX.5="PI"]/CX.1/text()', 'xmlns="urn:hl7-org:v2xml"').getstringval ()
                  , (SELECT ubi_nombre
                     FROM   ubicaciones
                     WHERE  ubi_codigo =
                                 d.mensaje.EXTRACT ('/ADT_A03/PV1/PV1.3/PL.2/text()', 'xmlns="urn:hl7-org:v2xml"').getstringval
                                                                                                                               ())
                  , (SELECT ubi_nombre
                     FROM   ubicaciones
                     WHERE  ubi_codigo =
                                 d.mensaje.EXTRACT ('/ADT_A03/PV1/PV1.3/PL.3/text()', 'xmlns="urn:hl7-org:v2xml"').getstringval
                                                                                                                               ())
            INTO   v_td_episodio
                  ,v_td_nuhsa
                  ,v_td_nhc
                  ,v_td_habitacion
                  ,v_td_cama
            FROM   dae_adt_a03@valme29 d
            WHERE  id_transaccion = p_id_transaccion;
         WHEN p_tipo_transaccion IN (14, 15)
         THEN
            SELECT d.mensaje.EXTRACT ('/ADT_A05/PV1/PV1.19/CX.1', 'xmlns="urn:hl7-org:v2xml"').getstringval ()
                  ,d.mensaje.EXTRACT ('/ADT_A05/PID/PID.3[CX.5="JHN"]/CX.1/text()', 'xmlns="urn:hl7-org:v2xml"').getstringval ()
                  ,d.mensaje.EXTRACT ('/ADT_A05/PID/PID.3[CX.5="PI"]/CX.1/text()', 'xmlns="urn:hl7-org:v2xml"').getstringval ()
            INTO   v_td_episodio
                  ,v_td_nuhsa
                  ,v_td_nhc
            FROM   dae_adt_a05@valme29 d
            WHERE  id_transaccion = p_id_transaccion;
         WHEN p_tipo_transaccion = 1
         THEN
            SELECT d.mensaje.EXTRACT ('/ADT_A09/PV1/PV1.19/CX.1', 'xmlns="urn:hl7-org:v2xml"').getstringval ()
                  ,d.mensaje.EXTRACT ('/ADT_A09/PID/PID.3[CX.5="JHN"]/CX.1/text()', 'xmlns="urn:hl7-org:v2xml"').getstringval ()
                  ,d.mensaje.EXTRACT ('/ADT_A09/PID/PID.3[CX.5="PI"]/CX.1/text()', 'xmlns="urn:hl7-org:v2xml"').getstringval ()
                  , (SELECT ubi_nombre
                     FROM   ubicaciones
                     WHERE  ubi_codigo =
                                 d.mensaje.EXTRACT ('/ADT_A09/PV1/PV1.3/PL.2/text()', 'xmlns="urn:hl7-org:v2xml"').getstringval
                                                                                                                               ())
                  , (SELECT ubi_nombre
                     FROM   ubicaciones
                     WHERE  ubi_codigo =
                                 d.mensaje.EXTRACT ('/ADT_A09/PV1/PV1.3/PL.3/text()', 'xmlns="urn:hl7-org:v2xml"').getstringval
                                                                                                                               ())
            INTO   v_td_episodio
                  ,v_td_nuhsa
                  ,v_td_nhc
                  ,v_td_habitacion
                  ,v_td_cama
            FROM   dae_adt_a09@valme29 d
            WHERE  id_transaccion = p_id_transaccion;
         WHEN p_tipo_transaccion = 6
         THEN
            SELECT d.mensaje.EXTRACT ('/ADT_A17/PV1[1]/PV1.19/CX.1', 'xmlns="urn:hl7-org:v2xml"').getstringval ()
                  ,d.mensaje.EXTRACT ('/ADT_A17/PID[1]/PID.3[CX.5="JHN"]/CX.1/text()', 'xmlns="urn:hl7-org:v2xml"').getstringval
                                                                                                                               ()
                  ,d.mensaje.EXTRACT ('/ADT_A17/PID[1]/PID.3[CX.5="PI"]/CX.1/text()', 'xmlns="urn:hl7-org:v2xml"').getstringval
                                                                                                                               ()
            INTO   v_td_episodio
                  ,v_td_nuhsa
                  ,v_td_nhc
            FROM   dae_adt_a17@valme29 d
            WHERE  id_transaccion = p_id_transaccion;
--      WHEN 9 THEN
--         SELECT D.MENSAJE.GETCLOBVAL ()
--         INTO   V_TD_EPISODIO
--         FROM   DAE_ADT_A30@VALME29 D
--         WHERE  ID_TRANSACCION = (SELECT ID_ULTIMA_TRANSACCION + 1
--                                  FROM   log_dae);
--      WHEN 16 THEN
--         SELECT D.MENSAJE.GETCLOBVAL ()
--         INTO   V_TD_EPISODIO
--         FROM   DAE_ORU_R01@VALME29 D
--         WHERE  ID_TRANSACCION = (SELECT ID_ULTIMA_TRANSACCION + 1
--                                  FROM   log_dae);
--      WHEN 17 THEN
--         SELECT D.MENSAJE.GETCLOBVAL ()
--         INTO   V_TD_EPISODIO
--         FROM   DAE_ORU_R01@VALME29 D
--         WHERE  ID_TRANSACCION = (SELECT ID_ULTIMA_TRANSACCION + 1
--                                  FROM   log_dae);
      ELSE
            SELECT ' '
            INTO   v_td_episodio
            FROM   DUAL;
      END CASE;

      document :=
            document
         || HTF.tabledata (HTF.fontOpen ('#4f6b72'
                                        ,'Arial'
                                        ,'-2') || v_td_episodio || HTF.fontClose
                          ,''
                          ,''
                          ,''
                          ,''
                          ,''
                          ,'bgcolor=#F5FAFA');
      document :=
            document
         || HTF.tabledata (HTF.fontOpen ('#4f6b72'
                                        ,'Arial'
                                        ,'-2') || LPAD (SUBSTR (v_td_nuhsa, -4)
                                                       ,12
                                                       ,'*') || HTF.fontClose
                          ,''
                          ,''
                          ,''
                          ,''
                          ,''
                          ,'bgcolor=#F5FAFA');
      document :=
            document
         || HTF.tabledata (HTF.fontOpen ('#4f6b72'
                                        ,'Arial'
                                        ,'-2') || v_td_nhc || HTF.fontClose
                          ,''
                          ,''
                          ,''
                          ,''
                          ,''
                          ,'bgcolor=#F5FAFA');
      document :=
            document
         || HTF.tabledata (HTF.fontOpen ('#4f6b72'
                                        ,'Arial'
                                        ,'-2') || v_td_habitacion || HTF.fontClose
                          ,''
                          ,''
                          ,''
                          ,''
                          ,''
                          ,'bgcolor=#F5FAFA');
      document :=
            document
         || HTF.tabledata (HTF.fontOpen ('#4f6b72'
                                        ,'Arial'
                                        ,'-2') || v_td_cama || HTF.fontClose
                          ,''
                          ,''
                          ,''
                          ,''
                          ,''
                          ,'bgcolor=#F5FAFA');
      document := document || HTF.tableRowClose;
      document := document || HTF.tableClose;
      RETURN document;
   END gen_html_table_title;

   FUNCTION gen_html_lugar (
      p_tipo_transaccion         IN       NUMBER
     ,p_id_transaccion           IN       NUMBER)
      RETURN VARCHAR2
   IS
      document                      VARCHAR2 (4000);
      v_td_serv                     VARCHAR2 (100) := NULL;
      v_td_habi                     VARCHAR2 (100) := NULL;
      v_td_cama                     VARCHAR2 (100) := NULL;
   BEGIN
      CASE
         WHEN p_tipo_transaccion IN (0, 2, 4, 7)
         THEN
            SELECT (SELECT uf_nombre
                    FROM   com_m_unidad_funcional
                    WHERE  uf_codigo =
                                     d.mensaje.EXTRACT ('/ADT_A01/PV1/PV1.10/text()', 'xmlns="urn:hl7-org:v2xml"').getstringval
                                                                                                                               ())
            INTO   v_td_serv
            FROM   dae_adt_a01@valme29 d
            WHERE  id_transaccion = p_id_transaccion;
         WHEN p_tipo_transaccion = 5
         THEN
            SELECT (SELECT uf_nombre
                    FROM   com_m_unidad_funcional
                    WHERE  uf_codigo =
                                     d.mensaje.EXTRACT ('/ADT_A02/PV1/PV1.10/text()', 'xmlns="urn:hl7-org:v2xml"').getstringval
                                                                                                                               ())
            INTO   v_td_serv
            FROM   dae_adt_a02@valme29 d
            WHERE  id_transaccion = p_id_transaccion;
         WHEN p_tipo_transaccion = 3
         THEN
            SELECT (SELECT uf_nombre
                    FROM   com_m_unidad_funcional
                    WHERE  uf_codigo =
                                     d.mensaje.EXTRACT ('/ADT_A03/PV1/PV1.10/text()', 'xmlns="urn:hl7-org:v2xml"').getstringval
                                                                                                                               ())
            INTO   v_td_serv
            FROM   dae_adt_a03@valme29 d
            WHERE  id_transaccion = p_id_transaccion;
         WHEN p_tipo_transaccion IN (14, 15)
         THEN
            SELECT (SELECT uf_nombre
                    FROM   com_m_unidad_funcional
                    WHERE  uf_codigo =
                                     d.mensaje.EXTRACT ('/ADT_A05/PV1/PV1.10/text()', 'xmlns="urn:hl7-org:v2xml"').getstringval
                                                                                                                               ())
            INTO   v_td_serv
            FROM   dae_adt_a05@valme29 d
            WHERE  id_transaccion = p_id_transaccion;
         ELSE
            NULL;
      END CASE;

      --document := document || HTF.BR ();
      --document := document || HTF.TABLEDATA (HTF.FONTOPEN ('#4f6b72', 'Arial', '1', '') || V_TD_HABI || HTF.FONTCLOSE, '', '', '', '', '', 'bgcolor=#F5FAFA');
      --document := document || HTF.TABLEDATA (HTF.FONTOPEN ('#4f6b72', 'Arial', '1', '') || V_TD_CAMA || HTF.FONTCLOSE, '', '', '', '', '', 'bgcolor=#F5FAFA');
      document := v_td_serv;                                  --,'N/A')||': '||NVL(V_TD_HABI,'N/A') || '-'|| NVL(V_TD_CAMA,'N/A');
      RETURN document;
   END gen_html_lugar;

   PROCEDURE consulta_mensajes_antiguos
   IS
      con_date_clear_from  CONSTANT DATE := TO_DATE ('01/01/2009', 'DD/MM/YYYY');
      con_date_clear_to    CONSTANT DATE := ADD_MONTHS (TRUNC (SYSDATE), -1);
      var_http_request              UTL_HTTP.req;
      var_http_response             UTL_HTTP.resp;
      var_http_request_params       VARCHAR2 (1024)
         :=    'accountType='
            || pkg_google.con_str_account_type
            || '&Email='
            || pkg_google.con_str_account_name
            || '&Passwd='
            || pkg_google.con_str_account_pass
            || '&service='
            || pkg_google.con_str_google_cal_serv
            || '&source='
            || pkg_google.con_str_google_sour;
      var_http_value                VARCHAR2 (32767);
      var_authorization_token       VARCHAR2 (1024);
      var_http_value_raw            RAW (32767);
      var_cal_query_url             VARCHAR2 (1024)
         :=    'http://www.google.com/calendar/feeds/default/private/full?'
            || 'start-min='
            || TO_CHAR (con_date_clear_from, 'YYYY-MM-DD"T00:00:00"')
            || '&start-max='
            || TO_CHAR (con_date_clear_to, 'YYYY-MM-DD"T23:59:59"')
            || '&orderby=starttime&max-results=10&sortorder=ascending';
      var_http_xml_resp             VARCHAR2 (32767);
      var_xml_feed                  XMLTYPE;
   BEGIN
      UTL_HTTP.set_proxy (proxy                         => pkg_google.con_str_http_proxy
                         ,no_proxy_domains              => pkg_google.con_str_no_proxy);
      UTL_HTTP.set_wallet (PATH                          => pkg_google.con_str_wallet_path
                          ,PASSWORD                      => pkg_google.con_str_wallet_pass);
      UTL_HTTP.set_follow_redirect (max_redirects                 => 3);
      var_http_request := pkg_google.prepare_request (pkg_google.con_str_google_login, var_http_request_params);
      UTL_HTTP.write_text (var_http_request, var_http_request_params);
      var_http_response := UTL_HTTP.get_response (r                             => var_http_request);

      BEGIN
         IF var_http_response.status_code = UTL_HTTP.http_ok
         THEN
            LOOP
               UTL_HTTP.read_line (r                             => var_http_response
                                  ,DATA                          => var_http_value
                                  ,remove_crlf                   => TRUE);

               IF INSTR (var_http_value, 'Auth') > 0
               THEN
                  var_authorization_token := SUBSTR (var_http_value, 6);
               END IF;
            END LOOP;
         ELSE
            DBMS_OUTPUT.put_line (var_http_response.status_code || ' - ' || var_http_response.reason_phrase);

            LOOP
               UTL_HTTP.read_raw (r                             => var_http_response
                                 ,DATA                          => var_http_value_raw
                                 ,len                           => 32767);
            END LOOP;
         END IF;
      EXCEPTION
         WHEN UTL_HTTP.end_of_body
         THEN
            UTL_HTTP.end_response (r                             => var_http_response);
      END;

      var_http_request :=
                     UTL_HTTP.begin_request (url                           => var_cal_query_url
                                            ,method                        => 'GET'
                                            ,http_version                  => UTL_HTTP.http_version_1_1);
      UTL_HTTP.set_header (r                             => var_http_request
                          ,NAME                          => 'Content-Type'
                          ,VALUE                         => 'application/atom+xml');
      UTL_HTTP.set_header (r                             => var_http_request
                          ,NAME                          => 'GData-Version'
                          ,VALUE                         => '2.0');
      UTL_HTTP.set_header (r                             => var_http_request
                          ,NAME                          => 'Accept-Charset'
                          ,VALUE                         => 'iso-8859-1');
      UTL_HTTP.set_header (r                             => var_http_request
                          ,NAME                          => 'Authorization'
                          ,VALUE                         => 'GoogleLogin auth=' || var_authorization_token);
      UTL_HTTP.set_cookie_support (r                             => var_http_request, ENABLE => TRUE);
      var_http_response := UTL_HTTP.get_response (r                             => var_http_request);

      BEGIN
         IF var_http_response.status_code = UTL_HTTP.http_ok
         THEN
            LOOP
               UTL_HTTP.read_line (r                             => var_http_response
                                  ,DATA                          => var_http_value
                                  ,remove_crlf                   => TRUE);
               var_http_xml_resp := var_http_xml_resp || var_http_value;
            END LOOP;
         ELSE
            DBMS_OUTPUT.put_line (var_http_response.status_code || ' - ' || var_http_response.reason_phrase);
         END IF;

         LOOP
            UTL_HTTP.read_raw (r                             => var_http_response
                              ,DATA                          => var_http_value_raw
                              ,len                           => 32767);
         END LOOP;
      EXCEPTION
         WHEN UTL_HTTP.end_of_body
         THEN
            UTL_HTTP.end_response (r                             => var_http_response);
      END;

      BEGIN
         var_xml_feed := XMLTYPE (var_http_xml_resp);

         UPDATE log_google
            SET entry = var_xml_feed
               ,resultado =
                   (SELECT COUNT (1)
                    FROM   log_google
                          ,TABLE (XMLSEQUENCE (EXTRACT (log_google.entry
                                                       ,'/feed/entry'
                                                       ,'xmlns="http://www.w3.org/2005/Atom"'))));
      EXCEPTION
         WHEN SELF_IS_NULL
         THEN
            UPDATE log_google
               SET resultado = 0;
      END;

      COMMIT;
   END consulta_mensajes_antiguos;

   PROCEDURE elimina_mensajes_antiguos
   IS
      var_tobedeleted               NUMBER;
      var_xml_batch                 XMLTYPE;
      var_http_request              UTL_HTTP.req;
      var_http_request_params       VARCHAR2 (1024)
         :=    'accountType='
            || pkg_google.con_str_account_type
            || '&Email='
            || pkg_google.con_str_account_name
            || '&Passwd='
            || pkg_google.con_str_account_pass
            || '&service='
            || pkg_google.con_str_google_cal_serv
            || '&source='
            || pkg_google.con_str_google_sour;
      var_http_response             UTL_HTTP.resp;
      var_http_value                VARCHAR2 (32767);
      var_authorization_token       VARCHAR2 (1024);
      var_http_value_raw            RAW (32767);
      var_http_xml_resp             VARCHAR2 (32767);
      var_xml_feed                  XMLTYPE;
   BEGIN
      SELECT resultado
      INTO   var_tobedeleted
      FROM   log_google;

      IF var_tobedeleted > 0
      THEN
         SELECT XMLELEMENT ("feed"
                           ,xmlattributes ('http://www.w3.org/2005/Atom' AS "xmlns"
                                          ,'http://a9.com/-/spec/opensearchrss/1.0/' AS "xmlns:openSearch"
                                          ,'http://base.google.com/ns/1.0' AS "xmlns:g"
                                          ,'http://schemas.google.com/gdata/batch' AS "xmlns:batch")
                           ,XMLAGG (XMLELEMENT ("entry"
                                               ,XMLELEMENT ("id"
                                                           ,EXTRACTVALUE (VALUE (em)
                                                                         ,'/entry/id'
                                                                         ,'xmlns="http://www.w3.org/2005/Atom"'))
                                               ,XMLELEMENT ("batch:operation", xmlattributes ('delete' AS "type"))))) x
         INTO   var_xml_batch
         FROM   log_google
               ,TABLE (XMLSEQUENCE (EXTRACT (log_google.entry
                                            ,'/feed/entry'
                                            ,'xmlns="http://www.w3.org/2005/Atom"'))) em;

         UTL_HTTP.set_proxy (proxy                         => pkg_google.con_str_http_proxy
                            ,no_proxy_domains              => pkg_google.con_str_no_proxy);
         UTL_HTTP.set_wallet (PATH                          => pkg_google.con_str_wallet_path
                             ,PASSWORD                      => pkg_google.con_str_wallet_pass);
         UTL_HTTP.set_follow_redirect (max_redirects                 => 3);
         var_http_request := pkg_google.prepare_request (pkg_google.con_str_google_login, var_http_request_params);
         UTL_HTTP.write_text (var_http_request, var_http_request_params);
         var_http_response := UTL_HTTP.get_response (r                             => var_http_request);

         BEGIN
            IF var_http_response.status_code = UTL_HTTP.http_ok
            THEN
               LOOP
                  UTL_HTTP.read_line (r                             => var_http_response
                                     ,DATA                          => var_http_value
                                     ,remove_crlf                   => TRUE);

                  IF INSTR (var_http_value, 'Auth') > 0
                  THEN
                     var_authorization_token := SUBSTR (var_http_value, 6);
                  END IF;
               END LOOP;
            ELSE
               DBMS_OUTPUT.put_line (var_http_response.status_code || ' - ' || var_http_response.reason_phrase);

               LOOP
                  UTL_HTTP.read_raw (r                             => var_http_response
                                    ,DATA                          => var_http_value_raw
                                    ,len                           => 32767);
               END LOOP;
            END IF;
         EXCEPTION
            WHEN UTL_HTTP.end_of_body
            THEN
               UTL_HTTP.end_response (r                             => var_http_response);
         END;

         var_http_request :=
            UTL_HTTP.begin_request (url                           => pkg_google.con_str_google_batch_url
                                   ,method                        => 'POST'
                                   ,http_version                  => UTL_HTTP.http_version_1_1);
         UTL_HTTP.set_header (r                             => var_http_request
                             ,NAME                          => 'Content-Type'
                             ,VALUE                         => 'application/x-www-form-urlencoded');
         UTL_HTTP.set_header (r                             => var_http_request
                             ,NAME                          => 'Content-Length'
                             ,VALUE                         => LENGTH (var_xml_batch.getstringval ()));
         UTL_HTTP.set_header (r                             => var_http_request
                             ,NAME                          => 'GData-Version'
                             ,VALUE                         => '2.0');
         UTL_HTTP.set_header (r                             => var_http_request
                             ,NAME                          => 'Accept-Charset'
                             ,VALUE                         => 'iso-8859-1');
         UTL_HTTP.set_header (r                             => var_http_request
                             ,NAME                          => 'If-Match'
                             ,VALUE                         => '*');
         UTL_HTTP.set_header (r                             => var_http_request
                             ,NAME                          => 'Authorization'
                             ,VALUE                         => 'GoogleLogin auth=' || var_authorization_token);
         UTL_HTTP.set_cookie_support (r                             => var_http_request, ENABLE => TRUE);
         UTL_HTTP.write_text (var_http_request, var_xml_batch.getstringval ());
         var_http_response := UTL_HTTP.get_response (r                             => var_http_request);

         BEGIN
            IF var_http_response.status_code = UTL_HTTP.http_ok
            THEN
               LOOP
                  UTL_HTTP.read_line (r                             => var_http_response
                                     ,DATA                          => var_http_value
                                     ,remove_crlf                   => TRUE);
                  var_http_xml_resp := var_http_xml_resp || var_http_value;
               END LOOP;
            ELSE
               DBMS_OUTPUT.put_line (var_http_response.status_code || ' - ' || var_http_response.reason_phrase);
            END IF;

            LOOP
               UTL_HTTP.read_raw (r                             => var_http_response
                                 ,DATA                          => var_http_value_raw
                                 ,len                           => 32767);
            END LOOP;
         EXCEPTION
            WHEN UTL_HTTP.end_of_body
            THEN
               UTL_HTTP.end_response (r                             => var_http_response);
         END;

         BEGIN
            var_xml_feed := XMLTYPE (var_http_xml_resp);

            UPDATE log_google
               SET entry = var_xml_batch
                  ,RESULT = var_xml_feed
                  ,last_result = NULL
                  ,last_execution = SYSTIMESTAMP;
         EXCEPTION
            WHEN OTHERS
            THEN
               UPDATE log_google
                  SET entry = var_xml_batch
                     ,RESULT = NULL
                     ,last_result = var_http_response.status_code || ' - ' || var_http_response.reason_phrase
                     ,last_execution = SYSTIMESTAMP;
         END;

         COMMIT;
      ELSE
         NULL;
      END IF;
   END elimina_mensajes_antiguos;

   PROCEDURE borra_5_antiguos
   IS
      test_google_calendar          google_calendar;
      var_output                    VARCHAR2 (1024);
      var_batch_feed                XMLTYPE;
   BEGIN
      EXECUTE IMMEDIATE 'TRUNCATE TABLE GOOGLE_LOG';

      test_google_calendar := NEW google_calendar (con_str_google_cal_url);
      test_google_calendar."ClientLogin" (con_str_account_name, con_str_account_pass);
--   TEST_GOOGLE_CALENDAR."QuickAdd"
--      (XMLTYPE
--          (   '<entry xmlns="http://www.w3.org/2005/Atom" xmlns:gCal="http://schemas.google.com/gCal/2005" >
--            <link rel="http://schemas.google.com/gCal/2005/webContent"
--                  href="http://www.google.com/calendar/images/google-holiday.gif"
--                  title="'
--           || TO_CHAR (SYSDATE, 'dd month, hh24:mi:ss')
--           || '"
--                   type="image/gif">
--            <gCal:webContent url="http://www.google.com/logos/worldcup06.gif" width="276" height="120" />
--            </link>
--         </entry>'));
--   TEST_GOOGLE_CALENDAR."CreateElement"
--      (XMLTYPE
--          (   '<entry xmlns="http://www.w3.org/2005/Atom" xmlns:gCal="http://schemas.google.com/gCal/2005" >
--            <link rel="http://schemas.google.com/gCal/2005/webContent"
--                  href="http://www.google.com/calendar/images/google-holiday.gif"
--                  title="'
--           || TO_CHAR (SYSDATE, 'dd month, hh24:mi:ss')
--           || '"
--                   type="image/gif">
--            <gCal:webContent url="http://www.google.com/logos/worldcup06.gif" width="276" height="120" />
--            </link>
--         </entry>')
--      ,VAR_OUTPUT);
--   dbms_output.put_line ('OUT =' || VAR_OUTPUT);
--   dbms_output.put_line ('Auth=' || TEST_GOOGLE_CALENDAR.GDATA_AUTH_TOKEN);
--   dbms_output.put_line ('Len =' || LENGTH (TEST_GOOGLE_CALENDAR.GDATA_AUTH_TOKEN));
      test_google_calendar."GetElements" (ADD_MONTHS (TRUNC (SYSDATE), -12)
                                         , TRUNC (SYSDATE) - 7
                                         ,5
                                         ,var_output);

      SELECT XMLELEMENT ("feed"
                        ,xmlattributes ('http://www.w3.org/2005/Atom' AS "xmlns"
                                       ,'http://a9.com/-/spec/opensearchrss/1.0/' AS "xmlns:openSearch"
                                       ,'http://base.google.com/ns/1.0' AS "xmlns:g"
                                       ,'http://schemas.google.com/gdata/batch' AS "xmlns:batch")
                        ,XMLAGG (XMLELEMENT ("entry"
                                            ,XMLELEMENT ("id"
                                                        ,EXTRACTVALUE (VALUE (em)
                                                                      ,'/entry/id'
                                                                      ,'xmlns="http://www.w3.org/2005/Atom"'))
                                            ,XMLELEMENT ("batch:operation", xmlattributes ('delete' AS "type"))))) x
      INTO   var_batch_feed
      FROM   google_log, TABLE (XMLSEQUENCE (EXTRACT (XMLTYPE (DATA)
                                                     ,'/feed/entry'
                                                     ,'xmlns="http://www.w3.org/2005/Atom"'))) em
      WHERE  ID = var_output;

      test_google_calendar."BatchProcess" (var_batch_feed, var_output);
   EXCEPTION
      WHEN ACCESS_INTO_NULL
      THEN
         DBMS_OUTPUT.put_line ('Objeto no inicializado');
   END borra_5_antiguos;
END pkg_google;
/
