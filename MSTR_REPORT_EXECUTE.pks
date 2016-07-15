CREATE OR REPLACE PACKAGE MSTR.REPORT_EXECUTE
AS
   const_host_port                 CONSTANT VARCHAR2 (1024) := 'http://eurostrategy.net:8080';
   const_intelligent_server_name   CONSTANT VARCHAR2 (1024) := 'IP-10-144-73-168';
   const_intelligent_server_proj   CONSTANT VARCHAR2 (1024) := 'EHSOUARE';
   const_intelligent_server_user   CONSTANT VARCHAR2 (1024) := 'ehsouare';
   const_intelligent_server_pass   CONSTANT VARCHAR2 (1024) := 'Amazon';
   const_intelligent_server_wurl   CONSTANT VARCHAR2 (1024) := '/MicroStrategy/servlet/taskProc?';

   --const_intelligent_server_ntus   CONSTANT VARCHAR2 (1024) := '';
   --const_intelligent_server_ntpw   CONSTANT VARCHAR2 (1024) := '';

   PROCEDURE png (reportId   IN VARCHAR2 DEFAULT '114B1D5C11E249CF47370080EFF51A55',
                  rWidth     IN NUMBER DEFAULT 750,
                  rHeight    IN NUMBER DEFAULT 400);

   PROCEDURE htm;
END;
/

