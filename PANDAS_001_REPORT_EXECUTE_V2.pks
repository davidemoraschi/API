CREATE OR REPLACE PACKAGE MSTR.PANDAS_001_REPORT_EXECUTE_v2
AS
   --   const_host_port                 CONSTANT VARCHAR2 (1024) := 'http://fraterno:8080';
   const_host_port                 CONSTANT VARCHAR2 (1024) := 'http://fraterno';
   --   const_host_port                 CONSTANT VARCHAR2 (1024) := 'http://eurostrategy.net';
   const_intelligent_server_name   CONSTANT VARCHAR2 (1024) := 'FRATERNO';
   --   const_intelligent_server_name   CONSTANT VARCHAR2 (1024) := 'IP-10-14473-168';
   const_intelligent_server_proj   CONSTANT VARCHAR2 (1024) := 'VALME+DIRECTO';
   --   const_intelligent_server_proj   CONSTANT VARCHAR2 (1024) := 'EHSOUARE';
   const_intelligent_server_user   CONSTANT VARCHAR2 (1024) := 'IUSR_WEBSERVICE';
   --   const_intelligent_server_user   CONSTANT VARCHAR2 (1024) := 'ehsouare';
   const_intelligent_server_pass   CONSTANT VARCHAR2 (1024) := 'aumentanun4,9%';
   --   const_intelligent_server_pass   CONSTANT VARCHAR2 (1024) := 'Amazon';
   --   const_intelligent_server_wurl   CONSTANT VARCHAR2 (1024) := '/MicroStrategy/servlet/taskProc?';
   const_intelligent_server_wurl   CONSTANT VARCHAR2 (1024) := '/MicroStrategy/asp/TaskProc.aspx?';
   const_intelligent_server_ntus   CONSTANT VARCHAR2 (1024) := 'VALME\cueserval';
   const_intelligent_server_ntpw   CONSTANT VARCHAR2 (1024) := '.RO%DRI&GO.';
   const_report_maxrows            CONSTANT VARCHAR2 (10) := '64000';

   PROCEDURE png (reportId      IN VARCHAR2 DEFAULT '9C5AE6B84A50C46DC5E94FA18D95D925',
                  projectName   IN VARCHAR2 DEFAULT const_intelligent_server_proj,
                  rWidth        IN NUMBER DEFAULT 750,
                  rHeight       IN NUMBER DEFAULT 400);

   PROCEDURE htm (reportId      IN VARCHAR2 DEFAULT '99E6EA454EFE37373F2980A43323C92D',
                  projectName   IN VARCHAR2 DEFAULT const_intelligent_server_proj);

   PROCEDURE dataxml (reportId      IN VARCHAR2 DEFAULT '99A42538444D80F6B2EE58852E81BB0B',
                      projectName   IN VARCHAR2 DEFAULT const_intelligent_server_proj);

   PROCEDURE xml (reportId      IN VARCHAR2 DEFAULT '99A42538444D80F6B2EE58852E81BB0B',
                  projectName   IN VARCHAR2 DEFAULT const_intelligent_server_proj);

   PROCEDURE deliver_chunks (t_content IN CLOB, l_file_etag IN VARCHAR2);
END;
/

