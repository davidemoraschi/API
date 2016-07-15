--DROP TYPE OAUTH;

CREATE OR REPLACE TYPE     OAUTH.OAUTH AUTHID CURRENT_USER AS OBJECT
                  (id VARCHAR2 (250),
                   descr VARCHAR2 (1000),
                   oauth_api_request_token_url VARCHAR2 (2000),
                   oauth_api_authorization_url VARCHAR2 (2000),
                   oauth_api_access_token_url VARCHAR2 (2000),
                   oauth_consumer_key VARCHAR2 (500),
                   oauth_consumer_secret VARCHAR2 (500),
                   oauth_request_token VARCHAR2 (2000),
                   oauth_request_token_secret VARCHAR2 (500),
                   oauth_access_token VARCHAR2 (2000),
                   oauth_access_token_secret VARCHAR2 (500),
                   oauth_verifier VARCHAR2 (50),
                   oauth_nonce VARCHAR2 (50),
                   oauth_timestamp VARCHAR2 (50),
                   oauth_base_string VARCHAR2 (1000),
                   oauth_signature VARCHAR2 (100),
                   var_http_authorization_header VARCHAR2 (2000),
                   con_num_timestamp_tz_diff NUMBER,
                   MEMBER FUNCTION base_string (p_http_method         IN VARCHAR2 DEFAULT 'GET',
                                                p_request_token_url   IN VARCHAR2,
                                                p_callback_url        IN VARCHAR2 DEFAULT 'oob',
                                                p_consumer_key        IN VARCHAR2,
                                                p_timestamp           IN VARCHAR2,
                                                p_nonce               IN VARCHAR2,
                                                p_token               IN VARCHAR2 DEFAULT NULL,
                                                p_token_verifier      IN VARCHAR2 DEFAULT NULL)
                      RETURN VARCHAR2,
                   MEMBER FUNCTION base_string2 (p_http_method         IN VARCHAR2 DEFAULT 'GET',
                                                 p_request_token_url   IN VARCHAR2,
                                                 p_callback_url        IN VARCHAR2 DEFAULT NULL,
                                                 p_consumer_key        IN VARCHAR2,
                                                 p_timestamp           IN VARCHAR2,
                                                 p_nonce               IN VARCHAR2,
                                                 p_token               IN VARCHAR2 DEFAULT NULL,
                                                 p_token_verifier      IN VARCHAR2 DEFAULT NULL)
                      RETURN VARCHAR2,
                   MEMBER FUNCTION signature (p_oauth_base_string IN VARCHAR2, p_oauth_key IN VARCHAR2)
                      RETURN VARCHAR2,
                   MEMBER FUNCTION key_token (p_consumer_secret IN VARCHAR2, p_token_secret IN VARCHAR2)
                      RETURN VARCHAR2,
                   MEMBER FUNCTION authorization_header (p_callback_url   IN VARCHAR2 DEFAULT NULL,
                                                         p_consumer_key   IN VARCHAR2,
                                                         p_timestamp      IN VARCHAR2,
                                                         p_nonce          IN VARCHAR2,
                                                         p_signature      IN VARCHAR2,
                                                         p_token          IN VARCHAR2 DEFAULT NULL,
                                                         p_verifier       IN VARCHAR2 DEFAULT NULL)
                      RETURN VARCHAR2,
                   MEMBER FUNCTION urlencode (p_str IN VARCHAR2)
                      RETURN VARCHAR2,
                   MEMBER FUNCTION token_extract (p_str IN VARCHAR2, p_pat IN VARCHAR2, p_delim IN VARCHAR2 := '&')
                      RETURN VARCHAR2,
                   MEMBER FUNCTION VERSION
                      RETURN VARCHAR2)
                     NOT INSTANTIABLE
                     NOT FINAL;
/
--DROP TYPE BODY OAUTH;

CREATE OR REPLACE TYPE BODY     OAUTH.OAUTH wrapped
a000000
1
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
e
2ffb a68
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
DTZ5MAmS7UimGhWuVsWHPJH3E3P4/CRM7wo1
/

--CREATE PUBLIC SYNONYM OAUTH FOR OAUTH.OAUTH;
GRANT EXECUTE ON OAUTH.OAUTH TO PUBLIC;
GRANT UNDER ON OAUTH.OAUTH TO PUBLIC;