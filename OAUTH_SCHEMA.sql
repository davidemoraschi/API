/* Formatted on 02/09/2012 14:02:00 (QP5 v5.139.911.3011) */
--DROP PUBLIC SYNONYM OAUTH;
DROP USER OAUTH CASCADE;
CREATE USER OAUTH IDENTIFIED BY Dresden1813;
GRANT CONNECT, RESOURCE/*, CREATE VIEW, CREATE LIBRARY*/ TO OAUTH;
GRANT EXECUTE ON DBMS_CRYPTO TO OAUTH;