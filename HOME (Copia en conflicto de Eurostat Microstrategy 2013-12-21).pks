/* Formatted on 16/12/2013 13:22:25 (QP5 v5.163.1008.3004) PANDAS Copyright (c) 2013 -Davide Moraschi (davidem@eurostrategy.net)
Todos los derechos reservados. Prohibida su reproducción Total o Parcial. */
CREATE OR REPLACE PACKAGE MSTR.home IS
	const_eurostrategy_url CONSTANT VARCHAR2 (1024) := 'http://app.healthcare.bi/token?authority=eurostrategy.net'; --authority=eurostrategy.net&sharepointUrl=pandas.sharepoint.com
	const_eurostrategy_method CONSTANT VARCHAR2 (10) := 'POST';
	const_eurostrategy_protocol CONSTANT VARCHAR2 (10) := 'HTTP/1.1';
	con_str_wallet_path CONSTANT VARCHAR2 (50) := 'file:/u01/app/oracle/wallet';
	con_str_wallet_pass CONSTANT VARCHAR2 (50) := 'Lepanto1571';
	con_str_sharep_client_secret VARCHAR2 (255) := 'XA87WzX0oRnX5GL8jgVvo8lUMd8fkEXnPKe97SpC08Q=';

	PROCEDURE aspx (SPHostUrl IN VARCHAR2 DEFAULT NULL
								 ,SPLanguage IN VARCHAR2 DEFAULT NULL
								 ,SPClientTag IN VARCHAR2 DEFAULT NULL
								 ,SPProductNumber IN VARCHAR2 DEFAULT NULL
								 ,SPAppWebUrl IN VARCHAR2 DEFAULT NULL
								 ,SPAppToken IN VARCHAR2 DEFAULT NULL
								 ,SPSiteUrl IN VARCHAR2 DEFAULT NULL
								 ,SPSiteTitle IN VARCHAR2 DEFAULT NULL
								 ,SPSiteLogoUrl IN VARCHAR2 DEFAULT NULL
								 ,SPSiteLanguage IN VARCHAR2 DEFAULT NULL
								 ,SPSiteCulture IN VARCHAR2 DEFAULT NULL
								 ,SPRedirectMessage IN VARCHAR2 DEFAULT NULL
								 ,SPCorrelationId IN VARCHAR2 DEFAULT NULL
								 ,SPErrorCorrelationId IN VARCHAR2 DEFAULT NULL
								 ,SPErrorInfo IN VARCHAR2 DEFAULT NULL);

	FUNCTION get_base_domain (SPHostUrl IN VARCHAR2)
		RETURN VARCHAR2;
END home;
/