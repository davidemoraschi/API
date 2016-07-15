/* Formatted on 20/01/2014 14:46:55 (QP5 v5.163.1008.3004) PANDAS Copyright (c) 2013 -Davide Moraschi (davidem@eurostrategy.net)
Todos los derechos reservados. Prohibida su reproducción Total o Parcial. */
CREATE TABLE MSTR_MAE_SERVICIOS
NOLOGGING
NOMONITORING
NOPARALLEL AS
	SELECT ID NATID_SERVICIO
				--,VERSION
				,DESCRIPCION DESCR_SERVICIO
				,CODIGO LDESC_SERVICIO
				,ORGANOGESTOR NATID_ORGANOGESTOR
				--,RESPONSABLE
				,ESTADO DSCR_ESTADO_SERVICIO
		FROM REP_PRO_SIGLO.ORG_SERVICIO@SYG;
        
ALTER TABLE MSTR_SIGLO.MSTR_MAE_SERVICIOS ADD 
CONSTRAINT MSTR_MAE_SERVICIOS_PK
 PRIMARY KEY (NATID_SERVICIO)
 --NOLOGGING
 --NOMONITORING
 ENABLE
 VALIDATE
        