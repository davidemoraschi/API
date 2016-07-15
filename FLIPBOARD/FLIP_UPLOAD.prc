CREATE OR REPLACE PROCEDURE FLIPBOARD.flip_upload (p_url IN VARCHAR2, p_csrf IN VARCHAR2) AS
	const_flipboard_flip_url CONSTANT VARCHAR2 (1024) := 'https://share.flipboard.com/bookmarklet/flip';
	con_str_wallet_path CONSTANT VARCHAR2 (50) := 'file:/u01/app/oracle/wallet';
	con_str_wallet_pass CONSTANT VARCHAR2 (50) := 'Lepanto1571';
	l_http_request UTL_HTTP.req;
	l_http_response UTL_HTTP.resp;
    l_postdata VARCHAR2 (32767);
    name VARCHAR2 (1024);
    VALUE VARCHAR2 (1024);
    l_response_body VARCHAR2 (32767);
BEGIN
	-- Open wallet for HTTPS protocol
	UTL_HTTP.SET_WALLET (PATH => con_str_wallet_path, password => con_str_wallet_pass);
	-- DO NOT Clear cookies jar
	-- UTL_HTTP.CLEAR_COOKIES;
	-- Enables cookie support
	UTL_HTTP.SET_COOKIE_SUPPORT (enable => TRUE, max_cookies => 3000, max_cookies_per_site => 200);
    DBMS_OUTPUT.PUT_LINE ('cookie count: ' || UTL_HTTP.GET_COOKIE_COUNT);
    -- Prepares the data for the POST
    l_postdata := '{"url":"'||p_url||'","_csrf":"'||p_csrf||'"}';
    DBMS_OUTPUT.PUT_LINE (l_postdata);
    /*{"url":"http://ccaa.elpais.com/ccaa/2014/01/08/andalucia/1389191024_676317.html","_csrf":"OrYXdY88XklNvXSDILxxkbV/BNc=|Mu+dMH7/RRtUqWIxCnlm0gYH7CQu8r5q1subs0J9HrnAt9CiAZ0Nnkmm2ahpqJRIl9a/ufnvvacAxUMm3Kap5g=="}*/    
    -- Creates the POST request
	l_http_request := UTL_HTTP.BEGIN_REQUEST (url => const_flipboard_flip_url, method => 'POST', http_version => 'HTTP/1.1');
	-- Writes HTTP headers
	UTL_HTTP.SET_HEADER (r => l_http_request, name => 'Host', VALUE => 'share.flipboard.com');
	UTL_HTTP.SET_HEADER (r => l_http_request, name => 'Connection', VALUE => 'keep-alive');
	UTL_HTTP.SET_HEADER (r => l_http_request, name => 'Accept', VALUE => 'application/json, text/plain, */*');
    UTL_HTTP.SET_HEADER (r => l_http_request, name => 'Origin', VALUE => 'https://share.flipboard.com');
	UTL_HTTP.SET_HEADER (r => l_http_request, name => 'User-Agent', VALUE => 'Mozilla/5.0 (Windows NT 6.3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.63 Safari/537.36"');
    UTL_HTTP.SET_HEADER (r => l_http_request, name => 'Content-Type', VALUE => 'application/json;charset=UTF-8');
    UTL_HTTP.SET_HEADER (r => l_http_request, name => 'Referer', VALUE => 'https://share.flipboard.com/bookmarklet/popout?v=2
    &title=La%20dieta%20%27Dukan%27%20aumenta%20el%20riesgo%20de%20padecer%20problemas%20de%20ri%C3%B1%C3%B3n%20-%20Qu%C3%A9.es&url=http%3A%2F%2Fwww.que.es%2Fgranada%2F201401071423-dieta-dukan-aumenta-riesgo-padecer.html&t='||epoch);
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
    DBMS_OUTPUT.PUT_LINE (name || ': ' || VALUE);
    END LOOP;
    -- Reads all the content of the response body
    BEGIN
        LOOP
            UTL_HTTP.READ_LINE (r => l_http_response, data => l_response_body, remove_crlf => TRUE);
    DBMS_OUTPUT.PUT_LINE (l_response_body);
--            -- Finds the _csrf hidden input and stores the value in a variable
--            IF (INSTR (l_response_body, 'name="_csrf"') > 1) THEN
--                l_csrf := DBMS_XMLGEN.CONVERT (REPLACE (SUBSTR (l_response_body, 7 + INSTR (l_response_body, 'value=')), '" />', ''), DBMS_XMLGEN.ENTITY_DECODE);
--            END IF;
        END LOOP;
    EXCEPTION
        WHEN UTL_HTTP.end_of_body THEN
            -- Closes the response and request
            UTL_HTTP.END_RESPONSE (r => l_http_response);
    END;
    -- Closes the response and request
    --UTL_HTTP.END_RESPONSE (r => l_http_response);
END;
/

