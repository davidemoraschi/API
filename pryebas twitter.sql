/* Formatted on 13/05/2013 8:33:26 (QP5 v5.163.1008.3004) */
DECLARE
   v_obj_twitter          twitter.twitter;
   p_result_in_response   XMLTYPE;
   twitter_status  VARCHAR2(140) := TO_CHAR(SYSDATE,'yyyymmddhh24miss')||'myppa+yle';
BEGIN
   SELECT (obj_twitter)
     INTO v_obj_twitter
     FROM twitter.objs_twitter
    WHERE account = 'PANDAS_QUIRO';

   v_obj_twitter.get_account (p_credentials_in_response => p_result_in_response);

   v_obj_twitter.post_status ( (twitter_status), p_result_in_response);
END;