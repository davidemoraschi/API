/* Formatted on 15/02/2014 18:09:19 (QP5 v5.163.1008.3004) PANDAS Copyright (c) 2013 -Davide Moraschi (davidem@eurostrategy.net)
Todos los derechos reservados. Prohibida su reproducción Total o Parcial. */
SET DEFINE OFF

BEGIN
	DBMS_SCHEDULER.DROP_JOB (job_name => 'SWEEP_EVERNOTE_FOLDER_P001');
END;

ALTER SESSION SET TIME_ZONE = 'Europe/Madrid';

BEGIN
	DBMS_SCHEDULER.create_job (job_name => 'SWEEP_EVERNOTE_FOLDER_P001'
														,job_type => 'PLSQL_BLOCK'
														-- ,job_action => 'BEGIN p_flip_from_rss (p_rss_url => ''http://news.google.es/news/feeds?cf=all&ned=es&hl=es&topic=m&output=rss'', p_user  => ''ProyectoPANDAS'', p_pass => ''PANDAS'', p_target_magazine =>''flipboard/mag-M4sfaY1mTfWWyp4EpnhHNQ%3Am%3A120774391-123011160''); END;'
														,job_action => 'BEGIN P_SWEEP_EVERNOTE_FOLDER; END;'
														,start_date => CURRENT_TIMESTAMP /*hay que hacerlo así por el tema del cambio de hora en verano*/
														,repeat_interval => 'freq=hourly; interval=1'
														,end_date => NULL
														,enabled => TRUE
														,comments => 'Crea notes a partir de los ficheros de la carpeta EVERNOTE');
END;