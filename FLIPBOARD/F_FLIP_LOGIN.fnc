/* Formatted on 10/01/2014 14:46:38 (QP5 v5.163.1008.3004) PANDAS Copyright (c) 2013 -Davide Moraschi (davidem@eurostrategy.net)
Todos los derechos reservados. Prohibida su reproducción Total o Parcial. */
CREATE OR REPLACE FUNCTION FLIPBOARD.f_flip_login
	RETURN VARCHAR2 AS
	const_flipboard_login_url CONSTANT VARCHAR2 (1024) := 'https://share.flipboard.com/u/login';
	const_flipboard_login_user CONSTANT VARCHAR2 (1024) := 'davide_moraschi';
	const_flipboard_login_pass CONSTANT VARCHAR2 (1024) := 'Lepanto1571';
	con_str_wallet_path CONSTANT VARCHAR2 (50) := 'file:/u01/app/oracle/wallet';
	con_str_wallet_pass CONSTANT VARCHAR2 (50) := 'Lepanto1571';
	l_http_request UTL_HTTP.req;
	l_http_response UTL_HTTP.resp;
	name VARCHAR2 (1024);
	VALUE VARCHAR2 (1024);
	cookies UTL_HTTP.COOKIE_TABLE;
	n_cookie_count PLS_INTEGER;
	l_csrfkey VARCHAR2 (1024);
	l_csrf VARCHAR2 (1024);
	l_postdata VARCHAR2 (32767);
	l_response_body VARCHAR2 (32767);
--	l_content CLOB;
--	l_epoch NUMBER;
BEGIN
	-- Open wallet for HTTPS protocol
	UTL_HTTP.SET_WALLET (PATH => con_str_wallet_path, password => con_str_wallet_pass);
	-- Clear cookies jar
	UTL_HTTP.CLEAR_COOKIES;
	-- Enables cookie support
	UTL_HTTP.SET_COOKIE_SUPPORT (enable => TRUE, max_cookies => 3000, max_cookies_per_site => 200);
	-- Creates the GET request
	l_http_request := UTL_HTTP.BEGIN_REQUEST (url => const_flipboard_login_url, method => 'GET', http_version => 'HTTP/1.1');
	-- Writes HTTP headers
	UTL_HTTP.SET_HEADER (r => l_http_request, name => 'Host', VALUE => 'share.flipboard.com');
	UTL_HTTP.SET_HEADER (r => l_http_request, name => 'Connection', VALUE => 'keep-alive');
	UTL_HTTP.SET_HEADER (r => l_http_request, name => 'Accept', VALUE => 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"');
	UTL_HTTP.SET_HEADER (r => l_http_request, name => 'User-Agent', VALUE => 'Mozilla/5.0 (Windows NT 6.3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.63 Safari/537.36"');
	UTL_HTTP.SET_HEADER (r => l_http_request, name => 'Accept-Language', VALUE => 'en-US,en;q=0.8,es;q=0.6"');
	-- Opens the communication and gets the response
	l_http_response := UTL_HTTP.GET_RESPONSE (r => l_http_request);
	--DBMS_OUTPUT.PUT_LINE ('==========================================================');
	-- Loops thru' the response headers and prints them out
	FOR i IN 1 .. UTL_HTTP.GET_HEADER_COUNT (l_http_response) LOOP
		UTL_HTTP.GET_HEADER (r => l_http_response
												,n => i
												,name => name
												,VALUE => VALUE);
	--DBMS_OUTPUT.PUT_LINE (name || ': ' || VALUE);
	END LOOP;
	-- Reads all the content of the response body
	BEGIN
		LOOP
			UTL_HTTP.READ_LINE (r => l_http_response, data => l_response_body, remove_crlf => TRUE);
			-- Finds the _csrf hidden input and stores the value in a variable
			IF (INSTR (l_response_body, 'name="_csrf"') > 1) THEN
				l_csrf := DBMS_XMLGEN.CONVERT (REPLACE (SUBSTR (l_response_body, 7 + INSTR (l_response_body, 'value=')), '" />', ''), DBMS_XMLGEN.ENTITY_DECODE);
			END IF;
		END LOOP;
	EXCEPTION
		WHEN UTL_HTTP.end_of_body THEN
			-- Closes the response and request
			UTL_HTTP.END_RESPONSE (r => l_http_response);
	END;
	-- Prints the _csrf value
	--DBMS_OUTPUT.put_line ('_csrf: ' || l_csrf);
	-- Gets the cookie count and prints it out
	n_cookie_count := UTL_HTTP.GET_COOKIE_COUNT;
	--DBMS_OUTPUT.PUT_LINE ('cookie count: ' || n_cookie_count);
	-- Retrieves all the cookies
	UTL_HTTP.GET_COOKIES (cookies);
	-- Reads all the cookies and their values, and stores the _csrfkey
	FOR i IN 1 .. cookies.COUNT LOOP
		--DBMS_OUTPUT.PUT_LINE (cookies (i).name || ': ' || cookies (i).VALUE);
		IF (cookies (i).name = '_csrfKey') THEN
			l_csrfkey := UTL_URL.UNESCAPE (url => cookies (i).VALUE);
		--DBMS_OUTPUT.PUT_LINE (l_csrfkey);
		END IF;
	END LOOP;
	-- Prepares the data for the POST
	l_postdata := '_csrf=' || UTL_URL.UNESCAPE (url => l_csrfkey) || '&username=' || const_flipboard_login_user || '&password=' || const_flipboard_login_pass;
	-- Creates the POST request
	l_http_request := UTL_HTTP.BEGIN_REQUEST (url => const_flipboard_login_url, method => 'POST', http_version => 'HTTP/1.1');
	-- Writes HTTP headers
	UTL_HTTP.SET_HEADER (r => l_http_request, name => 'Host', VALUE => 'share.flipboard.com');
	UTL_HTTP.SET_HEADER (r => l_http_request, name => 'Connection', VALUE => 'keep-alive');
	UTL_HTTP.SET_HEADER (r => l_http_request, name => 'Cache-Control', VALUE => 'max-age=0');
	UTL_HTTP.SET_HEADER (r => l_http_request, name => 'Accept', VALUE => 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"');
	UTL_HTTP.SET_HEADER (r => l_http_request, name => 'Origin', VALUE => 'https://share.flipboard.com');
	UTL_HTTP.SET_HEADER (r => l_http_request, name => 'User-Agent', VALUE => 'Mozilla/5.0 (Windows NT 6.3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.63 Safari/537.36"');
	UTL_HTTP.SET_HEADER (r => l_http_request, name => 'Content-Type', VALUE => 'application/x-www-form-urlencoded');
	UTL_HTTP.SET_HEADER (r => l_http_request, name => 'Referer', VALUE => 'https://share.flipboard.com/u/login');
	UTL_HTTP.SET_HEADER (r => l_http_request, name => 'Accept-Language', VALUE => 'en-US,en;q=0.8,es;q=0.6"');
	UTL_HTTP.SET_HEADER (r => l_http_request, name => 'Content-Length', VALUE => LENGTH (l_postdata));
	-- Writes the body of the POST request
	UTL_HTTP.WRITE_TEXT (r => l_http_request, data => l_postdata);
	-- Opens the communication and gets the response
	l_http_response := UTL_HTTP.GET_RESPONSE (r => l_http_request);
	--DBMS_OUTPUT.PUT_LINE ('==========================================================');
	-- loops thru' the response headers and prints them out
	FOR i IN 1 .. UTL_HTTP.GET_HEADER_COUNT (l_http_response) LOOP
		UTL_HTTP.GET_HEADER (l_http_response
												,i
												,name
												,VALUE);
	--DBMS_OUTPUT.PUT_LINE (name || ': ' || VALUE);
	END LOOP;
	-- Reads all the content of the response body
	UTL_HTTP.READ_LINE (r => l_http_response, data => l_response_body, remove_crlf => TRUE);
	--DBMS_OUTPUT.PUT_LINE ('response body: ' || l_response_body);
	-- Closes the response and request
	UTL_HTTP.END_RESPONSE (r => l_http_response);
	RETURN l_csrf;
END;
/