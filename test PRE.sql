/* Formatted on 19/02/2014 11:32:10 (QP5 v5.163.1008.3004) PANDAS Copyright (c) 2013 -Davide Moraschi (davidem@eurostrategy.net)
Todos los derechos reservados. Prohibida su reproducción Total o Parcial. */
DECLARE
	l_clob CLOB;
BEGIN
	l_clob := PANDAS_001_REPORT_EXECUTE_V9.HTML (projectName => 'Cuadro+de+Mando+SIGLO', reportId => 'A921426E40742431617FD2AE0ACBA7B8');
	DBMS_OUTPUT.put_line (l_clob);
END;

/
select PANDAS_001_REPORT_EXECUTE_V9.HTML (projectName => 'Cuadro+de+Mando+SIGLO', reportId => 'A921426E40742431617FD2AE0ACBA7B8')
from dual;