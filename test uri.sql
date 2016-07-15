/* Formatted on 14/09/2012 16:36:17 (QP5 v5.139.911.3011) */
set define off

SELECT HTTPURITYPE.
       createuri (
          'http://eurostrategy.net:8080/MicroStrategy/servlet/taskProc?taskId=login&taskEnv=xml&taskContentType=xml&server=IP-10-34-95-214&project=INyDIA&userid=atorres&password=Amazon').
       getxml ().EXTRACT ('taskResponse/root/sessionState/text()').getstringval ()
  FROM DUAL;