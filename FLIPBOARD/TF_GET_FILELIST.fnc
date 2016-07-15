/* Formatted on 15/01/2014 10:19:28 (QP5 v5.163.1008.3004) PANDAS Copyright (c) 2013 -Davide Moraschi (davidem@eurostrategy.net)
Todos los derechos reservados. Prohibida su reproducción Total o Parcial. */
-- Build the table function itself.
CREATE OR REPLACE FUNCTION tf_get_filelist (p_folder IN VARCHAR2)
	RETURN t_tf_filelist_tab AS
	l_tab t_tf_filelist_tab := t_tf_filelist_tab ();
	ns VARCHAR2 (1024);
	v_directory VARCHAR2 (1024);
	i INTEGER := 0;
BEGIN
	-- FOR i IN 1 .. p_rows LOOP
	-- l_tab.EXTEND;
	-- l_tab (l_tab.LAST) := t_tf_filelist_row (i, 'Description for ' || i);
	-- END LOOP;
	v_directory := p_folder;
	SYS.DBMS_BACKUP_RESTORE.SEARCHFILES (v_directory, ns);
	FOR each_file IN (SELECT fname_krbmsft AS name FROM x$krbmsft) LOOP
		l_tab.EXTEND;
		l_tab (l_tab.LAST) := t_tf_filelist_row (i, each_file.name);
		i := i + 1;
	-- DBMS_OUTPUT.PUT_LINE (each_file.name);
	END LOOP;

	RETURN l_tab;
END;
/
GRANT EXECUTE ON tf_get_filelist TO flipboard;