/* Formatted on 11/02/2014 10:24:16 (QP5 v5.163.1008.3004) PANDAS Copyright (c) 2013 -Davide Moraschi (davidem@eurostrategy.net)
Todos los derechos reservados. Prohibida su reproducción Total o Parcial. */

DECLARE
	f_in UTL_FILE.file_type;
	s_in VARCHAR2 (10000);
	f_name VARCHAR2 (100) := TO_CHAR (SYSDATE, 'YYYYMMDDHH24MISS') || '.log';
BEGIN
    DBMS_OUTPUT.put_line (f_name);
	DBMS_SCHEDULER.set_job_argument_value ('EVER_CREATE_NOTE_JOB', 1, 'titulo');
	DBMS_SCHEDULER.set_job_argument_value ('EVER_CREATE_NOTE_JOB', 2, 'contenido');
	DBMS_SCHEDULER.set_job_argument_value ('EVER_CREATE_NOTE_JOB', 3, 'S=s1:U=8de4e:E=14b6f6d4714:C=14417bc1b18:P=81:A=davidem:V=2:H=3e4f516d6fc42e0a575a748e776172c1');
	DBMS_SCHEDULER.set_job_argument_value ('EVER_CREATE_NOTE_JOB', 4, f_name);
	DBMS_SCHEDULER.RUN_JOB ('EVER_CREATE_NOTE_JOB', TRUE);
	f_in := UTL_FILE.fopen ('EVERNOTE', f_name, 'R');
	UTL_FILE.get_line (f_in, s_in);
	UTL_FILE.fclose (f_in);
	DBMS_OUTPUT.put_line (s_in);
END;