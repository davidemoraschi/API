/* Formatted on 20/01/2014 8:49:25 (QP5 v5.163.1008.3004) PANDAS Copyright (c) 2013 -Davide Moraschi (davidem@eurostrategy.net)
Todos los derechos reservados. Prohibida su reproducción Total o Parcial. */
--Centros de consumos que están repartidos en más de un servicio
	SELECT cc.id, COUNT (*)
		FROM REP_PRO_SIGLO.org_centroconsumo cc
				 JOIN REP_PRO_SIGLO.org_serviciocc sc
					 ON sc.centroconsumo = cc.id
				 -- ¿Y el estado 'CONFIRMADO' de org_centroconsumo?
				 JOIN REP_PRO_SIGLO.org_servicio s
					 ON s.id = sc.servicio AND s.estado = 'CONFIRMADO'
	 -- ¿Y el estado 'CONFIRMADO' de la tabla org_serviciocc ?
	 WHERE /*organica IN (SELECT id
	 FROM REP_PRO_SIGLO.org_organogestor
	 WHERE plataforma = 17550)
	 AND*/
				sc.estado = 'CONFIRMADO'
GROUP BY cc.id
	HAVING COUNT (*) > 1;