/* Formatted on 27/11/2012 14:08:15 (QP5 v5.163.1008.3004) */
SET DEFINE OFF

DECLARE
   l_clob           CLOB;
   l_xml            XMLTYPE;
   l_sessionState   VARCHAR2 (4000);
BEGIN
   --sys.debug_pkg.debug_off;
   l_clob :=
      sys.ntlm_http_pkg.get_response_clob (
         'http://fraterno/MicroStrategy/asp/TaskProc.aspx?taskId=login&taskEnv=xml&taskContentType=xml&server=FRATERNO&project=VALME+DIRECTO&userid=IUSR_WEBSERVICE&password=aumentanun4,9%',
         'VALME\upddm0',
         'vhjz342');
   l_xml := xmltype (l_clob);
   l_sessionState := l_xml.EXTRACT ('taskResponse/root/sessionState/text()').getstringval ();
--sys.debug_pkg.PRINT (SUBSTR (l_clob, 1, 32000));
END;