/* Formatted on 9/5/2012 11:08:19 AM (QP5 v5.163.1008.3004) */
DECLARE
   my_twitter                  twitter;
   p_callback                  VARCHAR2 (25);
   p_credentials_in_response   XMLTYPE;
   v_new_id                    VARCHAR2 (200);
BEGIN
   SELECT obj_twitter
     INTO my_twitter
     FROM objs_twitter
    WHERE account = 'TWIT_112395774';

   --DBMS_OUTPUT.put_line (my_twitter.id);

   my_twitter.get_account (p_callback, p_credentials_in_response);
   --v_new_id := ('TWIT_' || p_credentials_in_response.EXTRACT ('/user/id/text()').getstringval ());
DBMS_OUTPUT.put_line (p_credentials_in_response.getstringval());
   --my_twitter.id := v_new_id;

  -- my_twitter.save;

--   DELETE objs_twitter
--    WHERE account = '84Zfa5CAFxPgrRylG1VozKxjJiJYTRpAG3pgXE2Ls';
END;