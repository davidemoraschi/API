/* Formatted on 15/01/2014 10:01:38 (QP5 v5.163.1008.3004) PANDAS Copyright (c) 2013 -Davide Moraschi (davidem@eurostrategy.net)
Todos los derechos reservados. Prohibida su reproducción Total o Parcial. */
DROP TYPE t_tf_filelist_tab;
DROP TYPE t_tf_filelist_row;

CREATE TYPE t_tf_filelist_row AS OBJECT
			 (id NUMBER, fullpath VARCHAR2 (2048));
/

CREATE TYPE t_tf_filelist_tab IS TABLE OF t_tf_filelist_row;
/
SHOW ERRORS
/