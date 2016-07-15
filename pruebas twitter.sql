     SELECT oauth_consumer_key
            ,oauth_consumer_secret
            ,oauth_access_token
            ,oauth_access_token_secret
--        --INTO oauth_consumer_key
--            ,oauth_consumer_secret
--            ,oauth_access_token
--            ,oauth_access_token_secret
        FROM pq_oauth_parameters
       WHERE oauth_account = 'valme_twit_05';

/* Formatted on 13/05/2013 11:19:06 (QP5 v5.163.1008.3004) */
DECLARE
   P_STATUS    VARCHAR2 (32767):='A2 #ProyectoPandas';
   P_ACCOUNT   VARCHAR2 (32767):= 'valme_twit_05';
BEGIN
--   P_STATUS := NULL;
--   P_ACCOUNT := NULL;

   CDM.PQ_OAUTH.TWITTER_004_UPDATE_STATUS (P_STATUS, P_ACCOUNT);
   COMMIT;
END;