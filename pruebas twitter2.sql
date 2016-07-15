/* Formatted on 13/05/2013 11:30:55 (QP5 v5.163.1008.3004) */
DECLARE
   v_obj_twitter          twitter.twitter;
   p_result_in_response   XMLTYPE;
BEGIN
   SELECT (obj_twitter)
     INTO v_obj_twitter
     FROM twitter.objs_twitter
    WHERE account = 'PANDAS_QUIRO';

   --      v_obj_twitter.get_account (p_credentials_in_response => p_result_in_response);

   v_obj_twitter.post_status ( 'A2 #ProyectoPandas', p_result_in_response);
END;