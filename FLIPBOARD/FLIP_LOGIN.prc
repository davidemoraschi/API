/* Formatted on 10/01/2014 11:53:09 (QP5 v5.163.1008.3004) PANDAS Copyright (c) 2013 -Davide Moraschi (davidem@eurostrategy.net)
Todos los derechos reservados. Prohibida su reproducción Total o Parcial. */
CREATE OR REPLACE PROCEDURE FLIPBOARD.flip_login AS
	l_http_request UTL_HTTP.req;
	l_http_response UTL_HTTP.resp;
BEGIN
	l_http_request := UTL_HTTP.BEGIN_REQUEST ('https://' || p_domain || '.sharepoint.com/_forms/default.aspx?wa=wsignin1.0'
																					 ,const_sharepoint_service_meth
																					 ,const_sharepoint_service_prot);
--	UTL_HTTP.set_header (l_http_request, 'Content-Length', LENGTH (p_BinarySecurityToken));
--	UTL_HTTP.WRITE_TEXT (l_http_request, p_BinarySecurityToken);
--	l_http_response := UTL_HTTP.GET_RESPONSE (l_http_request);
END;
/