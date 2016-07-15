/* Formatted on 03/12/2012 15:12:25 (QP5 v5.163.1008.3004) */
  SELECT FECHA, AVG (TIEMPO_EN_URGENCIAS)
    FROM (SELECT TRUNC (AU_FECHA) FECHA,
                 (AU_FECHASALIDA - AU_FECHA) * 24 TIEMPO_EN_URGENCIAS,
                 AU_ACTIVA,
                 AU_BLOQUEADA,
                 AU_BLOQUEADA_OPER,
                 AU_CENTRO,
                 AU_COD_LUGAR_ASISTENCIA_URG,
                 AU_COD_MOTIVO_CONSULTA_URG,
                 AU_COD_ORIGEN_INTERNO_URG,
                 AU_COD_PROCEDENCIA_URG,
                 AU_COD_TIPO_PROCESO_URG,
                 AU_CONFIDENCIAL,
                 AU_DESTINO,
                 AU_EPISODIO,
                 AU_EPISODIO_EXT,
                 AU_ESTADOEPI,
                 AU_FECHA,
                 AU_FECHA_ESTABLECIDA,
                 AU_FECHASALIDA,
                 AU_FINANCIACION,
                 AU_ID,
                 AU_LIBERA72H,
                 AU_MALTAAD,
                 AU_MOTIVOCONSULTA,
                 AU_OPERADOR,
                 AU_PROCEDENCIA,
                 AU_PROCEDENCIA2_COD,
                 AU_PROCEDENCIA2_TXT,
                 AU_SALIDAEPI,
                 AU_SIDCA,
                 AU_USUARIO
            FROM CAE_OWN.ADMISION
           WHERE TRUNC (AU_FECHA) >= TO_DATE ('12-NOV-2012'))
GROUP BY FECHA
ORDER BY FECHA