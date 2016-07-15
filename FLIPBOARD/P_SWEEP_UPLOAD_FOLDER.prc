/* Formatted on 15/01/2014 12:28:56 (QP5 v5.163.1008.3004) PANDAS Copyright (c) 2013 -Davide Moraschi (davidem@eurostrategy.net)
Todos los derechos reservados. Prohibida su reproducción Total o Parcial. */
CREATE OR REPLACE PROCEDURE P_SWEEP_UPLOAD_FOLDER AS
	v_found INTEGER := 0;
BEGIN
	FOR c1 IN (SELECT ID, FULLPATH FROM VW_UPLOAD_FILELIST) LOOP
		-- DBMS_OUTPUT.put_line (F_GET_FILENAME (c1.FULLPATH));
		SYS.p_ftp_put_binary (p_filename => F_GET_FILENAME (c1.FULLPATH));
		SELECT COUNT (ID)
			INTO v_found
			FROM VW_WWWROOT_FILELIST
		 WHERE F_GET_FILENAME (FULLPATH) = F_GET_FILENAME (c1.FULLPATH);
		IF v_found > 0 THEN
			UTL_FILE.FREMOVE (location => 'UPLOAD', filename => F_GET_FILENAME (c1.FULLPATH));
		END IF;
	END LOOP;
END;

--SELECT FULLPATH, RTRIM (REGEXP_SUBSTR (FULLPATH, '.*\/'), '\') PATH, REPLACE (FULLPATH, REGEXP_SUBSTR (FULLPATH, '.*\/')) file_name FROM VW_UPLOAD_FILELIST