/* Formatted on 11/02/2014 12:52:59 (QP5 v5.163.1008.3004) PANDAS Copyright (c) 2013 -Davide Moraschi (davidem@eurostrategy.net)
Todos los derechos reservados. Prohibida su reproducción Total o Parcial. */
BEGIN
	DBMS_SCHEDULER.DROP_JOB (job_name => 'EVER_CREATE_NOTE');
END;

ALTER SESSION SET TIME_ZONE = 'Europe/Madrid';

BEGIN
	DBMS_SCHEDULER.CREATE_JOB (job_name => 'EVER_CREATE_NOTE'
														,job_type => 'EXECUTABLE'
														,number_of_arguments => 4
														,job_action => '/tmp/run.sh'
														,start_date => CURRENT_TIMESTAMP /*hay que hacerlo así por el tema del cambio de hora en verano*/
														,repeat_interval => 'freq=daily; byhour=02; byminute=22; bysecond=22'
														,end_date => NULL
														,enabled => FALSE
														,comments => 'Manda un Note a Evernote');
END;

BEGIN
	DBMS_SCHEDULER.set_job_argument_value ('EVER_CREATE_NOTE', 1, 'titulo');
	DBMS_SCHEDULER.set_job_argument_value ('EVER_CREATE_NOTE', 2, 'contenido');
	DBMS_SCHEDULER.set_job_argument_value ('EVER_CREATE_NOTE', 3, 'S=s1:U=8de4e:E=14b6f6d4714:C=14417bc1b18:P=81:A=davidem:V=2:H=3e4f516d6fc42e0a575a748e776172c1');
	DBMS_SCHEDULER.set_job_argument_value ('EVER_CREATE_NOTE', 4, TO_CHAR (SYSDATE, 'YYYYMMDDHH24MISS') || '.log');
	--DBMS_SCHEDULER.SET_ATTRIBUTE('EVER_CREATE_NOTE', 'credential_name', 'externaljob');
	DBMS_SCHEDULER.enable ('EVER_CREATE_NOTE');
END;

EXEC DBMS_SCHEDULER.RUN_JOB('EVER_CREATE_NOTE');