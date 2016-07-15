/* Formatted on 10/01/2014 14:42:01 (QP5 v5.163.1008.3004) PANDAS Copyright (c) 2013 -Davide Moraschi (davidem@eurostrategy.net)
Todos los derechos reservados. Prohibida su reproducción Total o Parcial. */
DECLARE
	l_csrf VARCHAR2 (1024);
BEGIN
	l_csrf := (f_flip_login);

	flip_upload (p_url => 'http://stackoverflow.com/questions/17485228/html-entity-decoding-to-special-characters', p_csrf => l_csrf);
END;

--select f_flip_login from dual;