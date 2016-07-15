CREATE OR REPLACE PACKAGE ALMAGESTO."PKG_GOOGLE" 
AS
/******************************************************************************
   NAME:       PKG_GOOGLE
   PURPOSE:

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        02/12/2009  dmoraschi  1. Created this package.
******************************************************************************/
   con_str_http_proxy         CONSTANT VARCHAR2 (50)  := 'proxy02.sas.junta-andalucia.es:8080';
   con_str_no_proxy           CONSTANT VARCHAR2 (15)  := '*.valme.net';
   con_str_wallet_path        CONSTANT VARCHAR2 (50)  := 'file:/u01/app/oracle/product/11.2.0/wallet';
   con_str_wallet_pass        CONSTANT VARCHAR2 (50)  := 'Lepanto1571';
   con_str_google_login       CONSTANT VARCHAR2 (50)  := 'https://www.google.com/accounts/ClientLogin';
   con_str_account_type       CONSTANT VARCHAR2 (10)  := 'GOOGLE';
--   CON_STR_ACCOUNT_NAME       CONSTANT VARCHAR2 (25)  := 'hvalme@gmail.com';
   con_str_account_name       CONSTANT VARCHAR2 (25)  := 'valme.almagesto@gmail.com';
--   CON_STR_ACCOUNT_PASS       CONSTANT VARCHAR2 (30)  := 'Lepanto1571';
   con_str_account_pass       CONSTANT VARCHAR2 (30)  := USERENV ('LANGUAGE');
   con_str_google_cal_serv    CONSTANT VARCHAR2 (10)  := 'cl';
   con_str_google_sour        CONSTANT VARCHAR2 (20)  := 'VALME-ALmagesto-1.0';
   con_str_google_cal_url     CONSTANT VARCHAR2 (255) := 'http://www.google.com/calendar/feeds/default/private/full';
--   CON_STR_GOOGLE_ERROR_CAL   CONSTANT VARCHAR2 (255) := 'http://www.google.com/calendar/feeds/i57hi6pir7p9hjeblis8ki5km8@group.calendar.google.com/private/full';
   con_str_google_error_cal   CONSTANT VARCHAR2 (255) := 'http://www.google.com/calendar/feeds/k3r3j4rp27vb02rfp5c8v79ncc@group.calendar.google.com/private/full';
   con_str_image_url_ok       CONSTANT VARCHAR2 (65)  := 'http://constantino/templates/Junta1_V2/images/gaugeGreen.gif';
   con_str_image_url_nok      CONSTANT VARCHAR2 (65)  := 'http://constantino/templates/Junta1_V2/images/gaugeRed.gif';
   con_str_google_batch_url   CONSTANT VARCHAR2 (255) := 'http://www.google.com/calendar/feeds/default/private/full/batch';

   PROCEDURE prepare_connection;

   FUNCTION authorize (par_http_request_params IN VARCHAR2)
      RETURN VARCHAR2;

   FUNCTION get_calendar_url (par_authorization_token IN VARCHAR2, par_calendar_entry IN XMLTYPE)
      RETURN VARCHAR2;

   FUNCTION get_calendar_error_url (par_authorization_token IN VARCHAR2, par_calendar_entry IN XMLTYPE)
      RETURN VARCHAR2;

   FUNCTION add_calendar_entry (par_authorization_token IN VARCHAR2, par_calendar_entry IN XMLTYPE, par_con_str_google_cal_redir IN VARCHAR2)
      RETURN VARCHAR2;

   FUNCTION prepare_request (par_url IN VARCHAR2, par_http_request_params IN VARCHAR2)
      RETURN utl_http.req;

   FUNCTION prepare_request (par_url IN VARCHAR2, par_calendar_entry IN XMLTYPE, par_authorization_token IN VARCHAR2)
      RETURN utl_http.req;

   PROCEDURE vigilante_de_seguridad;

   PROCEDURE chivato_de_mensajes;

   PROCEDURE chivato_de_duplicados;

   FUNCTION gen_html_table (rf IN sys_refcursor)
      RETURN VARCHAR2;

   FUNCTION gen_html_table_title (p_tipo_transaccion IN NUMBER, p_id_transaccion IN NUMBER)
      RETURN VARCHAR2;

   FUNCTION gen_html_lugar (p_tipo_transaccion IN NUMBER, p_id_transaccion IN NUMBER)
      RETURN VARCHAR2;

   PROCEDURE consulta_mensajes_antiguos;

   PROCEDURE elimina_mensajes_antiguos;

   PROCEDURE borra_5_antiguos;
END pkg_google; 
/

