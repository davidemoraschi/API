/* Formatted on 02/09/2012 15:37:40 (QP5 v5.139.911.3011) */
CREATE OR REPLACE PACKAGE OAUTH.global_constants
AS
   CONST_ISERVER                  CONSTANT VARCHAR2 (50) := 'IP-10-34-95-214';
   --   CONST_NL_CHAR               CONSTANT VARCHAR2 (1) := CHR (10);
   --   con_str_http_get            CONSTANT VARCHAR2 (5) := 'GET';
   --   con_str_http_post           CONSTANT VARCHAR2 (5) := 'POST';
   --   con_str_http_proxy          CONSTANT VARCHAR2 (50) := NULL;
   con_str_wallet_path            CONSTANT VARCHAR2 (50) := 'file:/u01/app/oracle/wallet';
   con_str_wallet_pass            CONSTANT VARCHAR2 (50) := 'Lepanto1571';
   con_str_dad_name               CONSTANT VARCHAR2 (1024) := '/sso';
   con_str_hostname_port          CONSTANT VARCHAR2 (1024) := 'http://eurostrategy.net:8181';
   -- LinkedIn constants
   --   con_str_lnkd_consumer_key      CONSTANT VARCHAR2 (1024) := 'cf1gfgolxjx0';-- '86aje51nau2w';
   --  con_str_lnkd_consumer_secret   CONSTANT VARCHAR2 (1024) := 'j0RkwupAvqVs6v3b';--'JGSzuG0fn8TnumZV';
   con_str_lnkd_consumer_key      CONSTANT VARCHAR2 (1024) := '86aje51nau2w';
   con_str_lnkd_consumer_secret   CONSTANT VARCHAR2 (1024) := 'JGSzuG0fn8TnumZV';
   con_str_lnkd_callback          CONSTANT VARCHAR2 (1024) := con_str_hostname_port || con_str_dad_name || '/auth_lnkd_cb.jsp';
   -- Dropbox constants
   con_str_drbx_consumer_key      CONSTANT VARCHAR2 (1024) := '5dlgdhkctfn4ngq';
   con_str_drbx_consumer_secret   CONSTANT VARCHAR2 (1024) := 'dgkduksn1pdxltm';
   con_str_drbx_callback          CONSTANT VARCHAR2 (1024) := con_str_hostname_port || con_str_dad_name || '/auth_drbx_cb.jsp';
   -- Twitter constants
   con_str_twit_consumer_key      CONSTANT VARCHAR2 (1024) := 'okSQJwBryotn9GWrB1iPw';
   con_str_twit_consumer_secret   CONSTANT VARCHAR2 (1024) := 'wBEulz9R5z32At7lpcfm2OivJjiiuUERkA51rPk10';
   con_str_twit_callback          CONSTANT VARCHAR2 (1024) := con_str_hostname_port || '/twitter/authorize.callback';
   -- Google constants
   con_str_goog_consumer_key      CONSTANT VARCHAR2 (1024) := 'eurostrategy.net';
   con_str_goog_consumer_secret   CONSTANT VARCHAR2 (1024) := '_tuTrbjgVKdncmcKkz0Yg-7G';
   con_str_goog_callback          CONSTANT VARCHAR2 (1024) := con_str_hostname_port || con_str_dad_name || '/auth_goog_cb.jsp';
   con_str_goog_scope             CONSTANT VARCHAR2 (1024) := 'https://www.googleapis.com/auth/userinfo.profile';
   -- Google constants oauth 2.0
   --con_str_goog_auth_endpoint     CONSTANT VARCHAR2 (100) := 'https://accounts.google.com/o/oauth2/auth';
   con_str_goog_auth_scope        CONSTANT VARCHAR2 (100) := 'https://www.googleapis.com/auth/userinfo.profile';
   con_str_goog_client_id CONSTANT VARCHAR2 (100)
         := '560216110065-06hdtbni98g0ic2q6pj33e2677kad53k.apps.googleusercontent.com' ;
   con_str_goog_client_secret     CONSTANT VARCHAR2 (100) := 'mZITZc3eJLdWduhEn7vCryDp';
   con_str_goog_auth_callback     CONSTANT VARCHAR2 (100) := 'http://eurostrategy.net/sso/auth_goog_oauth2_cb.jsp';
   -- Live.com constants oauth 2.0
   con_str_live_auth_scope        CONSTANT VARCHAR2 (100) := 'wl.signin wl.basic';
   con_str_live_client_id         CONSTANT VARCHAR2 (100) := '000000004C082135';
   con_str_live_client_secret     CONSTANT VARCHAR2 (100) := 'bbf2xVUHONNSWB7B7kYWP3kbJIssaeH0';
   con_str_live_auth_callback     CONSTANT VARCHAR2 (100) := 'http://eurostrategy.net/sso/auth_live_oauth2_cb.jsp';
   --
   con_num_timestamp_tz_diff      CONSTANT NUMBER := 0;
   --
   con_str_AWSAccessKeyId         CONSTANT VARCHAR2 (1024) := '04RWSJQ86Z9RGQFHJM82';
   con_str_AWSSecretKeyId         CONSTANT VARCHAR2 (1024) := 'QOe+0daE61eF7qURmz87yaP8VSY3H54u5sAAYa+N';
END;
/
GRANT EXECUTE ON OAUTH.GLOBAL_CONSTANTS TO PUBLIC;