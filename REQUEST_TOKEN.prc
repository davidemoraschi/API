/* Formatted on 10/08/2011 14:09:37 (QP5 v5.163.1008.3004) */
CREATE OR REPLACE PROCEDURE request_token
IS
	oauth_consumer_key				VARCHAR2 (500);
	oauth_consumer_secret			VARCHAR2 (500);
	oauth_access_token				VARCHAR2 (500);
	oauth_access_token_secret		VARCHAR2 (500);
	oauth_nonce 						VARCHAR2 (50);
	oauth_timestamp					VARCHAR2 (50);
	oauth_base_string 				VARCHAR2 (1000);
	http_method 			CONSTANT VARCHAR2 (5) := 'POST';
BEGIN
	HTP.p (
		'<img title="Log in with LinkedIn account" src="http://www.linkedin.com/scds/common/u/img/logos/logo_emails_132x32.png" onclick="alert(''login'')">');

	SELECT oauth_consumer_key, oauth_consumer_secret, oauth_access_token, oauth_access_token_secret
	INTO	 oauth_consumer_key, oauth_consumer_secret, oauth_access_token, oauth_access_token_secret
	FROM	 oauth_linkedin_parameters
	WHERE  account = 'eurostat.microstrategy@gmail.com';

	SELECT pkg_oauth.urlencode (oauth_nonce_seq.NEXTVAL) INTO oauth_nonce FROM DUAL;

	SELECT TO_CHAR ( (SYSDATE - TO_DATE ('01-01-1970', 'DD-MM-YYYY')) * (86400) - 6000) INTO oauth_timestamp FROM DUAL;

	oauth_base_string :=
		utl_linkedin.base_string_access_token (http_method
														  ,oauth_api_url
														  ,oauth_consumer_key
														  ,oauth_timestamp
														  ,oauth_nonce
														  ,oauth_access_token);

	HTP.p ('<table border="1">');
	HTP.p ('<tr><td>oauth_consumer_key: ' || oauth_consumer_key || '</td></tr>');
	HTP.p ('<tr><td>oauth_consumer_secret: ' || oauth_consumer_secret || '</td></tr>');
	HTP.p ('<tr><td>oauth_access_token: ' || oauth_access_token || '</td></tr>');
	HTP.p ('<tr><td>oauth_access_token_secret: ' || oauth_access_token_secret || '</td></tr>');
	HTP.p ('<tr><td>oauth_nonce: ' || oauth_nonce || '</td></tr>');
	HTP.p ('<tr><td>oauth_timestamp: ' || oauth_timestamp || '</td></tr>');
	HTP.p ('</table>');
END request_token;
/