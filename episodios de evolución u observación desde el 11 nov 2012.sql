/* Formatted on 03/12/2012 15:12:20 (QP5 v5.163.1008.3004) */
  SELECT FECHA, COUNT (DISTINCT EUE_EPISODIO) PACIENTES_EN_EVO_OBS
    FROM (SELECT TRUNC (EUE_FHENTRADA) FECHA,
                 EUE_ACTIVO,
                 EUE_CENTROENTRADA,
                 EUE_EPISODIO,
                 EUE_ESTADO,
                 EUE_FHENTRADA,
                 EUE_FHSALIDA,
                 EUE_IDENTIFICADOR,
                 EUE_MOVILIDAD,
                 EUE_OPERENTRADA,
                 EUE_UBICACION
            FROM CAE_OWN.ESTADOS_EPISODIO_URG
           WHERE TRUNC (EUE_FHENTRADA) >= TO_DATE ('12-NOV-2012') AND EUE_ESTADO IN (8, 10))
GROUP BY FECHA
ORDER BY FECHA