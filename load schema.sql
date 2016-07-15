/* Formatted on 13/02/2014 19:25:31 (QP5 v5.163.1008.3004) PANDAS Copyright (c) 2013 -Davide Moraschi (davidem@eurostrategy.net)
Todos los derechos reservados. Prohibida su reproducción Total o Parcial. */

BEGIN
	DBMS_XMLSCHEMA.registerSchema(
		SCHEMAURL => 'http://xml.evernote.com/pub/enml2.dtd',
		SCHEMADOC => bfilename('UPLOAD','enml2.dtd'),
		CSID => nls_charset_id('AL32UTF8'));
END;
/

select xmltype(CONTENT) from UTL_DTD;