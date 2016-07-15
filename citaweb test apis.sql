/* Formatted on 04/01/2013 13:07:13 (QP5 v5.163.1008.3004) */
SET DEFINE OFF;

create or replace procedure test_citaweb 
as
   SOAP_REQUEST   VARCHAR2 (30000);
   SOAP_RESPOND   VARCHAR2 (30000);
   XML_RESPOND    XMLTYPE;
   p_fechaCita    DATE := TRUNC (SYSDATE);
   HTTP_REQ       UTL_HTTP.REQ;
   HTTP_RESP      UTL_HTTP.RESP;
BEGIN
--   SOAP_REQUEST :=
--      '<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" SOAP-ENV:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/"><SOAP-ENV:Body><m:Solicitud xmlns:m="http://tempuri.org/usuarioBDU/message/"><sXML>&lt;?xml version="1.0" encoding="UTF-8"?&gt;&lt;diraya_solicitud&gt;&lt;cabecera_msj codigo="" fecha="21/04/2004" hora="12:06:22" conf_requerida="0" espec_contenido="CDUSU01" version="2.2" nivel_seguridad="" firma="" debug="" comprimido="" prioridad="0"&gt;&lt;entidad_origen&gt;&lt;centro codigo=""/&gt;&lt;operador codigo_diraya="" pwd="2BA972EB63E79399417B5A73C6328CE7" login="admvalme"/&gt;&lt;localizacion&gt;&lt;unidad codigo=""/&gt;&lt;modulo codigo="304"/&gt;&lt;perfil codigo=""/&gt;&lt;/localizacion&gt;&lt;/entidad_origen&gt;&lt;entidad_destino&gt;&lt;centro codigo=""/&gt;&lt;operador codigo_diraya="" pwd=""/&gt;&lt;localizacion&gt;&lt;unidad codigo=""/&gt;&lt;modulo codigo=""/&gt;&lt;perfil codigo=""/&gt;&lt;/localizacion&gt;&lt;/entidad_destino&gt;&lt;/cabecera_msj&gt;&lt;contenido_msj&gt;&lt;usuario_BDU&gt;&lt;solicitud_consulta_detallada NUSS="" NAF="" NUHSA="'
--      || p_fechaCita
--      || '" ano_nacimiento="" sexo=""&gt;&lt;documento_tipo&gt;&lt;tipo_doc id_tipo=""/&gt;&lt;identificador_doc/&gt;&lt;/documento_tipo&gt;&lt;nombre_usuario&gt;&lt;nombre/&gt;&lt;apellido1/&gt;&lt;apellido2/&gt;&lt;/nombre_usuario&gt;&lt;provincia id_prov=""/&gt;&lt;/solicitud_consulta_detallada&gt;&lt;/usuario_BDU&gt;&lt;/contenido_msj&gt;&lt;/diraya_solicitud&gt;</sXML></m:Solicitud></SOAP-ENV:Body></SOAP-ENV:Envelope>';

   --UTL_HTTP.SET_PROXY ('proxy02.sas.junta-andalucia.es:8080');
   --UTL_HTTP.set_transfer_timeout(180);
   --HTTP_REQ := UTL_HTTP.BEGIN_REQUEST ('http://bdu.sas.junta-andalucia.es/web_services/usuarioBDU.WSDL', 'POST', 'HTTP/1.1');
   SELECT xmltype (
             '<?xml version="1.0" encoding="UTF-16"?><diraya_solicitud><cabecera_msj codigo="numerounico" fecha="21/04/2004" hora="12:06:22" conf_requerida="0" espec_contenido="Citaslst_SELCitasPreAgendas" version="3" comprimido="0"><entidad_origen></entidad_origen></cabecera_msj><contenido_msj><solicitud_citasprevistas_dia codigo_unidad=""  fecha="04/01/2013" fichero_citas="S" fechahora_asigna =""><centro codigo ="10004"/></solicitud_citasprevistas_dia></contenido_msj></diraya_solicitud>').getstringval ()
      INTO SOAP_REQUEST
     FROM DUAL;

   HTTP_REQ := UTL_HTTP.BEGIN_REQUEST ('http://citacion.sas.junta-andalucia.es/ws_citaweb/ws_citaweb.WSDL', 'POST', 'HTTP/1.1');
   UTL_HTTP.SET_HEADER (HTTP_REQ, 'Content-Type', 'text/xml; charset=utf-8');
   UTL_HTTP.SET_HEADER (HTTP_REQ, 'Content-Length', LENGTH (SOAP_REQUEST));
   UTL_HTTP.SET_HEADER (HTTP_REQ, 'SOAPAction', 'http://tempuri.org/CitacionCentralizada/action/TratarMensaje.TratarMensaje');
   UTL_HTTP.WRITE_TEXT (HTTP_REQ, SOAP_REQUEST);
   HTTP_RESP := UTL_HTTP.GET_RESPONSE (HTTP_REQ);
   UTL_HTTP.READ_TEXT (HTTP_RESP, SOAP_RESPOND);
   UTL_HTTP.END_RESPONSE (HTTP_RESP);
   XML_RESPOND := XMLTYPE.CREATEXML (SOAP_RESPOND);
   XML_RESPOND :=
      XML_RESPOND.EXTRACT ('/soap:Envelope/soap:Body/child::node()', 'xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"');
   XML_RESPOND := XML_RESPOND.EXTRACT ('n:SolicitudResponse/Result/text()', 'xmlns:n="http://tempuri.org/usuarioBDU/message/"');
   SOAP_RESPOND := DBMS_XMLGEN.CONVERT (XML_RESPOND.GETSTRINGVAL (), DBMS_XMLGEN.entity_decode);
   XML_RESPOND := XMLTYPE.CREATEXML (SOAP_RESPOND);
END;