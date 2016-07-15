/* Formatted on 15/01/2014 10:23:37 (QP5 v5.163.1008.3004) PANDAS Copyright (c) 2013 -Davide Moraschi (davidem@eurostrategy.net)
Todos los derechos reservados. Prohibida su reproducción Total o Parcial. */
CREATE OR REPLACE VIEW vw_upload_filelist AS
	SELECT ID, FULLPATH FROM TABLE (sys.tf_get_filelist ('/u01/app/oracle/upload'));