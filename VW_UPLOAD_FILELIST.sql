/* Formatted on 15/02/2014 18:11:30 (QP5 v5.163.1008.3004) PANDAS Copyright (c) 2013 -Davide Moraschi (davidem@eurostrategy.net)
Todos los derechos reservados. Prohibida su reproducci�n Total o Parcial. */
CREATE OR REPLACE FORCE VIEW VW_EVERNOTE_FILELIST
(
	ID
 ,FULLPATH
) AS
	SELECT ID, FULLPATH FROM TABLE (sys.tf_get_filelist ('/u01/app/oracle/evernote'));
