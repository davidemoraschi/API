/* Formatted on 10/01/2014 11:51:12 (QP5 v5.163.1008.3004) PANDAS Copyright (c) 2013 -Davide Moraschi (davidem@eurostrategy.net)
Todos los derechos reservados. Prohibida su reproducción Total o Parcial. */
CREATE USER flipboard IDENTIFIED BY "galaxy-s5-to-have-iris-scanner";
GRANT CONNECT, RESOURCE, CREATE VIEW TO flipboard;
GRANT "TC_ADMIN_ROLE" TO FLIPBOARD;
ALTER USER FLIPBOARD DEFAULT ROLE "CONNECT", "RESOURCE", "TC_ADMIN_ROLE";

grant execute on UTL_TCP to flipboard;
grant execute on UTL_FILE to flipboard;
grant execute on UTL_HTTP to flipboard;
grant create job to flipboard;