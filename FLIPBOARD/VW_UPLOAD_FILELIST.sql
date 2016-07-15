DROP VIEW VW_UPLOAD_FILELIST;

/* Formatted on 15/01/2014 11:53:40 (QP5 v5.163.1008.3004) PANDAS Copyright (c) 2013 -Davide Moraschi (davidem@eurostrategy.net)
Todos los derechos reservados. Prohibida su reproducción Total o Parcial. */
CREATE OR REPLACE FORCE VIEW VW_UPLOAD_FILELIST
(
	ID
 ,FULLPATH
) AS
	SELECT ID, FULLPATH FROM TABLE (sys.tf_get_filelist ('/u01/app/oracle/upload'));
