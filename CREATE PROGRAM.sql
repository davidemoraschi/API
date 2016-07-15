/* Formatted on 11/02/2014 13:19:04 (QP5 v5.163.1008.3004) PANDAS Copyright (c) 2013 -Davide Moraschi (davidem@eurostrategy.net)
Todos los derechos reservados. Prohibida su reproducción Total o Parcial. */
BEGIN
	DBMS_SCHEDULER.DROP_JOB (job_name => 'EVER_CREATE_NOTE_JOB');
END;

EXEC DBMS_SCHEDULER.DROP_PROGRAM (program_name => 'EVER_CREATE_NOTE_PRG');

BEGIN
	--DBMS_SCHEDULER.DROP_PROGRAM (program_name => 'EVER_NOTE_PROGRAM_1');
	DBMS_SCHEDULER.CREATE_PROGRAM (program_name => 'EVER_CREATE_NOTE_PRG'
																,program_action => '/tmp/run.sh'
																,program_type => 'EXECUTABLE'
																,number_of_arguments => 4
																,enabled => FALSE
																,comments => 'Programa para crear una Note en Evernote');
END;
/
BEGIN
	DBMS_SCHEDULER.DEFINE_PROGRAM_ARGUMENT (program_name => 'EVER_CREATE_NOTE_PRG'
																				 ,argument_position => 1
																				 ,argument_name => 'Note_Title'
																				 ,argument_type => 'VARCHAR2'
																				 ,DEFAULT_VALUE => 'Title');
	DBMS_SCHEDULER.DEFINE_PROGRAM_ARGUMENT (program_name => 'EVER_CREATE_NOTE_PRG'
																				 ,argument_position => 2
																				 ,argument_name => 'Note_Content'
																				 ,argument_type => 'CLOB'
																				 ,DEFAULT_VALUE => 'Content');
	DBMS_SCHEDULER.DEFINE_PROGRAM_ARGUMENT (program_name => 'EVER_CREATE_NOTE_PRG'
																				 ,argument_position => 3
																				 ,argument_name => 'Access_Token'
																				 ,argument_type => 'VARCHAR2'
																				 ,DEFAULT_VALUE => 'S=s1:U=8de4e:E=14b6f6d4714:C=14417bc1b18:P=81:A=davidem:V=2:H=3e4f516d6fc42e0a575a748e776172c1');
	DBMS_SCHEDULER.DEFINE_PROGRAM_ARGUMENT (program_name => 'EVER_CREATE_NOTE_PRG'
																				 ,argument_position => 4
																				 ,argument_name => 'Log_File'
																				 ,argument_type => 'VARCHAR2'
																				 ,DEFAULT_VALUE => TO_CHAR (SYSTIMESTAMP, 'YYYYMMDDHH24MISSFF') || '.log');
END;
/
BEGIN
	DBMS_SCHEDULER.ENABLE ('EVER_CREATE_NOTE_PRG');
END;
/
ALTER SESSION SET TIME_ZONE = 'Europe/Madrid';

DECLARE
	l_clob CLOB := 'S=s1:U=8de4e:E=14b6f6d4714:C=14417bc1b18:P=81:A=davidem:V=2:H=3e4f516d6fc42e0a575a748e776172c1';
BEGIN
	DBMS_SCHEDULER.create_job (job_name => 'EVER_CREATE_NOTE_JOB'
														,program_name => 'EVER_CREATE_NOTE_PRG'
														,start_date => CURRENT_TIMESTAMP /*hay que hacerlo así por el tema del cambio de hora en verano*/
														,repeat_interval => 'freq=daily; byhour=02; byminute=22; bysecond=22'
														,end_date => NULL
														,enabled => TRUE
														,comments => 'Manda un Note a Evernote'
														,auto_Drop => FALSE);
	DBMS_SCHEDULER.set_job_argument_value ('EVER_CREATE_NOTE_JOB', 1, 'Autotest '||TO_CHAR(SYSDATE, 'DD-MM-YYYY'));
	DBMS_SCHEDULER.set_job_argument_value ('EVER_CREATE_NOTE_JOB', 2, 'ok');
	--DBMS_SCHEDULER.set_job_argument_value ('EVER_CREATE_NOTE_JOB', 3, l_clob);
	DBMS_SCHEDULER.set_job_argument_value (job_name => 'EVER_CREATE_NOTE_JOB', argument_position => 3, argument_value => l_clob);
	DBMS_SCHEDULER.set_job_argument_value ('EVER_CREATE_NOTE_JOB', 4, TO_CHAR (SYSDATE, 'YYYYMMDDHH24MISS') || '.log');
END;
/