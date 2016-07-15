/* Formatted on 09/02/2011 12:40:06 (QP5 v5.163.1008.3004) */
/*
  SUBID_AÑO                       NUMBER,
  SUBID_MES                       NUMBER,
  NATID_CENTRO                    NUMBER(5),
  SUBID_UNIDAD_FUNCIONAL          NUMBER,
  IND_CAMAS_DISPONIBLES           NUMBER,
  IND_SESIO_QUIRU_CIR_MAYOR       NUMBER,
  IND_SESIO_QUIRU_CONTI_ASISTEN   NUMBER,
  IND_SESIO_QUIRU_CIR_MENOR       NUMBER,
  IND_SESIO_CONSU_HOSPITAL        NUMBER,
  IND_SESIO_PRUEB_HOSPITAL        NUMBER,
  IND_SESIO_CONSU_CPE             NUMBER,
  IND_SESIO_PRUEB_CPE             NUMBER,
  IND_RECHU_FACULTATIVOS          NUMBER,
  IND_RECHU_DUE                   NUMBER,
  IND_RECHU_RESTO_ENFERMERIA      NUMBER,
  IND_RECHU_OTRO_PERSONAL         NUMBER,
  IND_INGRE_URGENTES              NUMBER,
  IND_INGRE_PROGRAMADOS           NUMBER,
  IND_INGRE_TOTALES               NUMBER,
  IND_TRASL_RECIBIDOS             NUMBER,
  IND_ESTAN_CENSALES              NUMBER,
  IND_ESTAN_MEDIA_CENSAL          NUMBER(3,2),
  IND_X100E_OCUPACION             NUMBER(3,2),
  IND_ESTAN_PORDIA                NUMBER(3,2),
  IND_PRESI_URGENCIAS             NUMBER(3,2),
  IND_EXITUS                      NUMBER,
  IND_ALTAS_CLINICAS              NUMBER,
  IND_ALTAS_TOTALES               NUMBER,
  IND_TRASL_EMITIDOS              NUMBER,
  IND_INTER_PROGR_INGRE_AGD       NUMBER,
  IND_INTER_PROGR_INGRE_NOAGD     NUMBER,
  IND_INTER_PROGR_INGRE_TOTALES   NUMBER,
  IND_INTER_CMA_AGD               NUMBER,
  IND_INTER_CMA_NOAGD             NUMBER,
  IND_INTER_CMA_TOTALES           NUMBER,
  IND_INTER_CIR_MENOR_PROGRAM     NUMBER,
  IND_INTER_CIR_MENOR_URGENTES    NUMBER,
  IND_INTER_URGEN_CON_INGRESO     NUMBER,
  IND_X100E_PROGR_CIR_MAYOR_AGD   NUMBER(3,2),
  IND_TOTAL_CIR_MAYOR             NUMBER,
  IND_X100E_CMA_CIR_MAYOR_PROGR   NUMBER(3,2),
  IND_INTER_CMA_SUSPENDIDAS       NUMBER,
  IND_INTER_PROGR_INGRE_SUSPEND   NUMBER,
  IND_INTER_CIR_MAYOR_SUSPEND     NUMBER,
  IND_X100E_SUSPENCION_CIR_MAYOR  NUMBER(3,2),
  IND_TIEMP_OCUPACION_QUIROFANOS  NUMBER(3,2),
  IND_X100E_OCUPACION_QUIRURGICA  NUMBER(3,2),
  IND_ENTRA_AGD                   NUMBER,
  IND_ENTRA_ANEXO_I               NUMBER,
  IND_ENTRA_PROCE_120_DIAS        NUMBER,
  IND_SALID_AGD                   NUMBER,
  IND_SALID_ANEXO_I               NUMBER,
  IND_SALID_PROCE_120_DIAS        NUMBER,
  IND_DEMOR_MEDIA                 NUMBER,
  IND_DEMOR_MAXIMA                NUMBER,
  IND_X100E_PROCE_60_CUMPL_GARAN  NUMBER(3,2),
  IND_PRIME_CONSU_AP_HOSPITAL     NUMBER,
  IND_INTER_CONSU_HOSPITAL        NUMBER,
  IND_REVIS_HOSPITAL              NUMBER,
  IND_PRIME_CONSU_AP_CPE          NUMBER,
  IND_INTER_CONSU_CPE             NUMBER,
  IND_REVIS_CPE                   NUMBER,
  IND_PRIME_CONSU_AP_TOTALES      NUMBER,
  IND_INTER_CONSU_TOTALES         NUMBER,
  IND_REVIS_TOTALES               NUMBER,
  IND_X100E_PRIME_AP_TOTALES      NUMBER(3,2),
  IND_X100E_ACTIV_JERARQUIZADA    NUMBER(3,2),
  IND_DEMOR_MEDIA_PRIME_AP        NUMBER(3,2),
  IND_X100E_PRIME_AP_MAS_40_DIAS  NUMBER(3,2),
  IND_ERROR                       NUMBER(1)     DEFAULT 0

*/

SELECT subid_año
		,subid_mes
		,"Centro" natid_centro
		,uf_3
		,subid_unidad_funcional
		,"Camas" ind_camas_disponibles
		,"Adm_prog" ind_ingre_programados
		,"Adm_Urg" ind_ingre_urgentes
		,"Trasl_desde_otro_svc" ind_trasl_recibidos
		,"Ing_Total" ind_ingre_totales
		,"Altas_Clinicas" ind_altas_clinicas
		,"Trasl_a_otro_svc" ind_trasl_emitidos
		,"Exitus" ind_exitus
		,"Altas_Total" ind_altas_totales
		,"Estancias_Censales" ind_estan_censales
		,"E_M_Censal" ind_estan_media_censal
		,"Indice_Ocupacion" ind_x100e_ocupacion
FROM	 mstr_agr_src_uf
		 JOIN mstr_mae_tiempo_meses
			 ON ("mes_año" = natid_mes)
		 JOIN mstr_mae_unidades_funcionales
			 ON ("Centro" = natid_centro AND uf_3 = natid_unidad_funcional)