/* Formatted on 13/02/2014 13:11:42 (QP5 v5.163.1008.3004) PANDAS Copyright (c) 2013 -Davide Moraschi (davidem@eurostrategy.net)
Todos los derechos reservados. Prohibida su reproducción Total o Parcial. */
DECLARE
	l_token VARCHAR2 (250);
BEGIN
	l_token := Y360CN.GETTOKEN ();
	DBMS_OUTPUT.PUT_LINE ('l_token: ' || l_token);
	IF Y360CN.login360 (l_token) THEN
		DBMS_OUTPUT.PUT_LINE ('connected');
        Y360CN.loginYunpan;
	ELSE
		DBMS_OUTPUT.PUT_LINE ('not connected');
	END IF;
END;
/
EXEC Y360CN.login360 (null);

DECLARE
	l_json json;
BEGIN
	l_json := json (
							'{"errno":0,"errmsg":"","s":"et%23%2BJ%3Fo%7E%2CMe%23%5B%29rD%26FCKdO_%25w%2FSb%3FG%40%2BaaX%228J%22-s%25j%5D%28pv%25i%60.%3D%26%5C%3EO9nxQ.%5CW%3AFM5Irmu%28_D_%22p6VnxL%7B%26I01uZ%231i%7B.Gb%5B%25_%7D6LCb_vX%22%7Dse_s6x1%3AdO%25qmhRMEB%2CO8Yl7I8UG%2B%21%26%7D%3Ft0yun%2A%3CN%263q2FnFZHKGg%3AXhTg82-_4%7ErBar%7EvC%2AZVGe8%25%23%5D%3E%263%5CcPv%5D4n%5E%3Craw%5EL%26%28WShnjG%3BDk","userinfo":{"qid":"716904823","userName":"360U716904823","nickName":"","realName":"","imageId":"1_t03260a89065d651527","theme":"quc","src":"pcw_cloud","type":"formal","loginEmail":"davidem@hotmail.com","loginTime":"1392292922","lm":"","unSafeLogin":"0","isKeepAlive":"0","crumb":"9c12a4","imageUrl":"http:\/\/quc.qhimg.com\/dm\/48_48_80\/t03260a89065d651527.jpg"}}');
	DBMS_OUTPUT.PUT_LINE (json_ext.get_string (l_json, '.errno'));
END;
--SELECT REGEXP_SUBSTR('body:  QHPass.loginUtils.tokenCallback({"errno":0,"errmsg":"","token":"dcafe68bb460865a"})','{.*}') JSON FROM DUAL;