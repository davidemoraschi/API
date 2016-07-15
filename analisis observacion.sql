/* Formatted on 04/12/2012 10:39:11 (QP5 v5.163.1008.3004) */
  SELECT DISTINCT USU_BDU_NUSA,
         USU_APELLIDO1,
         USU_APELLIDO2,
         EUE_IDENTIFICADOR,
         EUE_EPISODIO,
         TRUNC (EUE_FHENTRADA) FECHA,
         EST_NOMBRE,
         NVL (UBI1, UBI2)
    FROM (SELECT USU_APELLIDO1,
                 USU_APELLIDO2,
                 USU_BDU_NUSA,
                 EST_NOMBRE,
                 UBI1.UBI_NOMBRE UBI1,
                 UBI2.UBI_NOMBRE UBI2,
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
                 LEFT JOIN CAE_OWN.UBICACIONES_AREAS UBI1
                    ON (EUE_UBICACION = UBI_IDENTIFICADOR)
                 LEFT JOIN REP_PRO_EST.UBICACIONES UBI2
                    ON (EUE_UBICACION = UBI_CODIGO)
                 LEFT JOIN CAE_OWN.ESTADOS_URGENCIAS
                    ON (EUE_ESTADO = EST_IDENTIFICADOR)
                 LEFT JOIN CAE_OWN.ADMISION
                    ON (EUE_EPISODIO = AU_EPISODIO)
                 LEFT JOIN CAE_OWN.USUARIO
                    ON (AU_USUARIO = USU_ID)
           WHERE EUE_FHENTRADA BETWEEN '02-dic-2012' AND '04-12-2012' AND UBI2.UBI_NOMBRE LIKE 'Observación%')
--GROUP BY TRUNC(EUE_FHENTRADA)
ORDER BY EUE_EPISODIO;

/* Formatted on 04/12/2012 10:39:11 (QP5 v5.163.1008.3004) */
  SELECT DISTINCT USU_BDU_NUSA,
         USU_APELLIDO1,
         USU_APELLIDO2,
         EUE_IDENTIFICADOR,
         EUE_EPISODIO,
         TRUNC (EUE_FHENTRADA) FECHA,
         EST_NOMBRE,
         NVL (UBI1, UBI2)
    FROM (SELECT USU_APELLIDO1,
                 USU_APELLIDO2,
                 USU_BDU_NUSA,
                 EST_NOMBRE,
                 UBI1.UBI_NOMBRE UBI1,
                 UBI2.UBI_NOMBRE UBI2,
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
                 LEFT JOIN CAE_OWN.UBICACIONES_AREAS UBI1
                    ON (EUE_UBICACION = UBI_IDENTIFICADOR)
                 LEFT JOIN REP_PRO_EST.UBICACIONES UBI2
                    ON (EUE_UBICACION = UBI_CODIGO)
                 LEFT JOIN CAE_OWN.ESTADOS_URGENCIAS
                    ON (EUE_ESTADO = EST_IDENTIFICADOR)
                 LEFT JOIN CAE_OWN.ADMISION
                    ON (EUE_EPISODIO = AU_EPISODIO)
                 LEFT JOIN CAE_OWN.USUARIO
                    ON (AU_USUARIO = USU_ID)
           WHERE EUE_FHENTRADA BETWEEN '02-dic-2012' AND '04-12-2012' AND UBI2.UBI_NOMBRE LIKE 'Evolución%')
--GROUP BY TRUNC(EUE_FHENTRADA)
ORDER BY EUE_EPISODIO;
