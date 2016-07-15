/* Formatted on 1/10/2014 10:46:57 PM (QP5 v5.163.1008.3004) */
--select f_flip_login_and_upload('http://politica.elpais.com/politica/2014/01/10/actualidad/1389349830_196351.html') from dual;
--select chr(to_number('2F', 'xx')) from dual;
--
--select f_flip_login('davide_moraschi','Lepanto1571') from dual;

--select instr(f_flip_login_and_upload('http://politica.elpais.com/politica/2014/01/10/actualidad/1389349830_196351.html'), '#') N from dual;

BEGIN
   p_flip_upload (p_url    => 'http://politica.elpais.com/politica/2014/01/10/actualidad/1389349830_196351.html',
                  p_csrf   => f_flip_login ('davide_moraschi', 'Lepanto1571'));
END;