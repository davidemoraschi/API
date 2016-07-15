/* Formatted on 15/01/2014 10:10:02 (QP5 v5.163.1008.3004) PANDAS Copyright (c) 2013 -Davide Moraschi (davidem@eurostrategy.net)
Todos los derechos reservados. Prohibida su reproducción Total o Parcial. */
CREATE OR REPLACE PROCEDURE list_directory (p_folder IN VARCHAR2) IS
	ns VARCHAR2 (1024);
	v_directory VARCHAR2 (1024);
    --i integer := 0;
BEGIN
	v_directory := p_folder;
	SYS.DBMS_BACKUP_RESTORE.SEARCHFILES (v_directory, ns);
	FOR each_file IN (SELECT fname_krbmsft AS name FROM x$krbmsft) LOOP
		DBMS_OUTPUT.PUT_LINE (each_file.name);
	END LOOP;
END;
/
GRANT EXECUTE ON list_directory TO flipboard;