/* Formatted on 17/01/2014 16:16:46 (QP5 v5.163.1008.3004) PANDAS Copyright (c) 2013 -Davide Moraschi (davidem@eurostrategy.net)
Todos los derechos reservados. Prohibida su reproducción Total o Parcial. */
SET DEFINE OFF

BEGIN
	DBMS_SCHEDULER.DROP_JOB (job_name => 'FLIP_FROM_GOOGLENEWS_P001');
END;

ALTER SESSION SET TIME_ZONE = 'Europe/Madrid';

BEGIN
	DBMS_SCHEDULER.create_job (
		job_name => 'FLIP_FROM_GOOGLENEWS_P001'
	 ,job_type => 'PLSQL_BLOCK'
	 --  ,job_action => 'BEGIN p_flip_from_rss (p_rss_url => ''http://news.google.es/news/feeds?cf=all&ned=es&hl=es&topic=m&output=rss'', p_user  => ''ProyectoPANDAS'', p_pass => ''PANDAS'', p_target_magazine =>''flipboard/mag-M4sfaY1mTfWWyp4EpnhHNQ%3Am%3A120774391-123011160''); END;'
	 -- 		,job_action => 'BEGIN p_flip_from_rss (p_rss_url => ''http://news.google.es/news/feeds?cf=all&ned=es&hl=es&topic=m&output=rss'', p_user  => ''EuroStrategy'', p_pass => ''3SamsungGalaxySII'', p_target_magazine =>''flipboard/mag-M4sfaY1mTfWWyp4EpnhHNQ%3Am%3A120774391-123011160''); END;'
	 ,job_action => 'BEGIN p_flip_from_rss (p_rss_url => ''http://news.google.es/news/feeds?cf=all&ned=es&hl=es&topic=m&output=rss'', p_user  => ''ProyectoPANDAS'', p_pass => ''pandas10'', p_target_magazine =>''flipboard/mag-%252DIsCtPNeTaqa36X_1UzZjA%3Am%3A120774391-122765517''); END;'
	 ,start_date => CURRENT_TIMESTAMP /*hay que hacerlo así por el tema del cambio de hora en verano*/
	 ,repeat_interval => 'freq=daily; byhour=01; byminute=11; bysecond=11'
	 ,end_date => NULL
	 ,enabled => TRUE
	 ,comments => 'Carga de noticias de Salud desde Google News a Flipboard');
END;