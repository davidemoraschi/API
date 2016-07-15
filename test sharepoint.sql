/* Formatted on 16/12/2013 13:21:22 (QP5 v5.163.1008.3004) PANDAS Copyright (c) 2013 -Davide Moraschi (davidem@eurostrategy.net)
Todos los derechos reservados. Prohibida su reproducción Total o Parcial. */
SELECT TargetPrincipalName || '/' || 'pandas.sharepoint.com' || SUBSTR (Audience, INSTR (Audience, '@')) FROM OAUTH_SHAREPOINT_TOKENS;

select home.get_base_domain('https://pandas.sharepoint.com/') from dual;

select leftstr('https://pandas.sharepoint.com') from dual;
select INSTR ('https://pandas.sharepoint.com'
                                             ,'/'
                                             ,1
                                             ,3) from dual;

SELECT SUBSTR ('https://pandas.sharepoint.com/sites/development'
							,INSTR ('https://pandas.sharepoint.com/sites/development', '//') + 2
							,  INSTR ('https://pandas.sharepoint.com/sites/development'
											 ,'/'
											 ,1
											 ,3)
							 - INSTR ('https://pandas.sharepoint.com/sites/development', '//')
							 - 2)
	FROM DUAL;