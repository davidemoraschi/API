/* Formatted on 13/02/2014 16:18:51 (QP5 v5.163.1008.3004) PANDAS Copyright (c) 2013 -Davide Moraschi (davidem@eurostrategy.net)
Todos los derechos reservados. Prohibida su reproducción Total o Parcial. */
DECLARE
	l_clob CLOB;
    l_xml xmltype;
BEGIN
	l_clob := PANDAS_001_REPORT_EXECUTE_v8.html (projectName => 'COOKBOOK', reportId => '913EFF964F29B72D4221AE9B1D6B5DA2');
	--l_clob := '<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE en-note SYSTEM "/public/enml2.dtd"><en-note>'||EVERNOTE.CLEAN_HTML_V2 (l_clob)||'</en-note>';
    --l_xml := xmltype(l_clob);
	--DBMS_OUTPUT.put_line (l_xml.getclobval());
    l_clob:= REGEXP_SUBSTR (l_clob,'<script.*>.*<\/script>', 1, 1, 'n');
    DBMS_OUTPUT.put_line (l_clob);
END;

--SELECT CLEAN_HTML (l_clob) FROM DUAL;

select clean_html from dual;