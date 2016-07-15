/* Formatted on 15/02/2014 12:00:48 (QP5 v5.163.1008.3004) PANDAS Copyright (c) 2013 -Davide Moraschi (davidem@eurostrategy.net)
Todos los derechos reservados. Prohibida su reproducción Total o Parcial. */
DECLARE
	lt_report_clob CLOB;
	l_buffer VARCHAR2 (1024);
	l_infile UTL_FILE.file_type;
	l_filename VARCHAR2 (200) := '2014-02-15_3718B51011E3877400000080EFF51835.html';
	l_max_line_length INTEGER := 1024;
BEGIN
	l_infile := UTL_FILE.fopen ('EVERNOTE'
														 ,l_filename
														 ,'r'
														 ,l_max_line_length);

	-- initialise the empty clob
	DBMS_LOB.createtemporary (lt_report_clob, TRUE, DBMS_LOB.session);

	LOOP
		BEGIN
			UTL_FILE.get_line (l_infile, l_buffer);

			DBMS_LOB.append (lt_report_clob, l_buffer);
            
		EXCEPTION
			WHEN NO_DATA_FOUND THEN
				EXIT;
		END;
	END LOOP;
    DBMS_OUTPUT.put_line (lt_report_clob);
END;