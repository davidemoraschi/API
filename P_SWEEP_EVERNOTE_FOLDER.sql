/* Formatted on 15/02/2014 18:15:54 (QP5 v5.163.1008.3004) PANDAS Copyright (c) 2013 -Davide Moraschi (davidem@eurostrategy.net)
Todos los derechos reservados. Prohibida su reproducción Total o Parcial. */
CREATE OR REPLACE PROCEDURE P_SWEEP_EVERNOTE_FOLDER AS
	l_result VARCHAR2 (200);
	l_clob CLOB;
	l_buffer VARCHAR2 (1024);
	l_infile UTL_FILE.file_type;
	l_filename VARCHAR2 (200);-- := '2014-02-15_3718B51011E3877400000080EFF51835.html';
	l_max_line_length INTEGER := 1024;
	f_filename VARCHAR2 (2048);
	l_notetitle VARCHAR2 (2048);
BEGIN
	FOR c1 IN (SELECT ID, FULLPATH FROM VW_EVERNOTE_FILELIST WHERE INSTR (FULLPATH, '.html') > 1) LOOP
		l_filename := F_GET_FILENAME (c1.FULLPATH);
		l_infile := UTL_FILE.fopen ('EVERNOTE'
															 ,l_filename
															 ,'r'
															 ,l_max_line_length);

		DBMS_LOB.createtemporary (l_clob, TRUE, DBMS_LOB.session);

		LOOP
			BEGIN
				UTL_FILE.get_line (l_infile, l_buffer);

				DBMS_LOB.append (l_clob, l_buffer);
			EXCEPTION
				WHEN NO_DATA_FOUND THEN
					EXIT;
			END;
		END LOOP;

		l_notetitle := REGEXP_SUBSTR (l_clob, '<title>[^>]*\/title>');
		l_notetitle := REGEXP_REPLACE (l_notetitle, '<title>');
		l_notetitle := REGEXP_REPLACE (l_notetitle, '<\/title>');

		l_clob := REGEXP_REPLACE (l_clob, '<HTML[^>]?>');
		l_clob := REGEXP_REPLACE (l_clob, '</HTML[^>]?>');
		l_clob := REGEXP_REPLACE (l_clob, '<!DOCTYPE[^>]+>');

		l_clob := REGEXP_REPLACE (l_clob, '<html[^>]*>');
		l_clob := REGEXP_REPLACE (l_clob, '<head[^>]*>');
		l_clob := REGEXP_REPLACE (l_clob, '<meta[^>]*>');
		l_clob := REGEXP_REPLACE (l_clob, '<body[^>]*>');
		l_clob := REGEXP_REPLACE (l_clob, '<title.*>.*<\/title>');

		l_clob := REGEXP_REPLACE (l_clob
														 ,'<script.*>.*<\/script>'
														 ,NULL
														 ,1
														 ,1
														 ,'n');
		l_clob := REGEXP_REPLACE (l_clob
														 ,'<style.*>.*<\/style>'
														 ,NULL
														 ,1
														 ,1
														 ,'n');

		l_clob := REGEXP_REPLACE (l_clob, '<\/html.?>');
		l_clob := REGEXP_REPLACE (l_clob, '<\/head.?>');
		l_clob := REGEXP_REPLACE (l_clob, '<\/body.?>');

		l_clob := REPLACE (l_clob, 'TD', 'td');
		l_clob := REPLACE (l_clob, 'AX', 'ax');
		l_clob := REPLACE (l_clob, 'STY', 'sty');

		l_clob := REGEXP_REPLACE (l_clob, ' id="[^"]*"');
		l_clob := REGEXP_REPLACE (l_clob, ' class="[^"]*"');
		l_clob := REGEXP_REPLACE (l_clob, ' class=''[^'']*''');
		l_clob := REGEXP_REPLACE (l_clob, ' styleid="[^"]*"');
		l_clob := REGEXP_REPLACE (l_clob, ' name="[^"]*"');
		l_clob := REGEXP_REPLACE (l_clob, ' scriptclass="[^"]*"');
		l_clob := REGEXP_REPLACE (l_clob, ' sty="[^"]*"');
		l_clob := REGEXP_REPLACE (l_clob, ' oty="[^"]*"');
		l_clob := REGEXP_REPLACE (l_clob, ' ax="[^"]*"');
		l_clob := REGEXP_REPLACE (l_clob, ' o="[^"]*"');
		l_clob := REGEXP_REPLACE (l_clob, ' oid="[^"]*"');
		l_clob := REGEXP_REPLACE (l_clob, ' DPT="[^"]*"');
		l_clob := REGEXP_REPLACE (l_clob, ' MH="[^"]*"');
		l_clob := REGEXP_REPLACE (l_clob, ' acl="[^"]*"');

		l_clob := REGEXP_REPLACE (l_clob, ' class=[^ ]+');

		l_clob := REGEXP_REPLACE (l_clob, 'height=([[:digit:]]+px)', 'height="\1"');
		l_clob := REGEXP_REPLACE (l_clob, 'width=([[:digit:]]+px)', 'width="\1"');
		l_clob := REGEXP_REPLACE (l_clob, '(<img[^>]+)', '\1 /');
		l_clob := REGEXP_REPLACE (l_clob, ' x:str');
		l_clob := REGEXP_REPLACE (l_clob, 'border=([[:digit:]]+)', 'border="\1"');
		l_clob := REGEXP_REPLACE (l_clob, 'cellspacing=([[:digit:]]+)', 'cellspacing="\1"');
		l_clob := REGEXP_REPLACE (l_clob, 'colspan=([[:digit:]]+)', 'colspan="\1"');

		f_filename := REPLACE (REGEXP_SUBSTR (REGEXP_SUBSTR (l_clob, '( src="[^"]+")'), '"[^"]+"'), '"', '');
		l_clob := REGEXP_REPLACE (l_clob, '(<img[^>]+ src=")', '\1http://pandas10.azurewebsites.net/');

		SYS.p_ftp_put_binary (p_filename => f_filename, p_location => 'EVERNOTE');

		l_result := NOTESTORE.CREATENOTE (p_notetitle => l_notetitle
																		 ,p_notecontent => l_clob
																		 ,p_accesstoken => 'S=s1:U=8de4e:E=14b6f6d4714:C=14417bc1b18:P=81:A=davidem:V=2:H=3e4f516d6fc42e0a575a748e776172c1');
		UTL_FILE.FREMOVE (location => 'EVERNOTE', filename => l_filename);
		UTL_FILE.FREMOVE (location => 'EVERNOTE', filename => f_filename);
        DBMS_LOB.freetemporary (l_clob);
	END LOOP;
END P_SWEEP_EVERNOTE_FOLDER;
/