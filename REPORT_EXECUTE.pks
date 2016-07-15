CREATE OR REPLACE PACKAGE MSTR.REPORT_EXECUTE
AS
   const_host_port                 CONSTANT VARCHAR2 (1024) := 'http://fraterno:8080';
   const_intelligent_server_name   CONSTANT VARCHAR2 (1024) := 'FRATERNO';
   const_intelligent_server_proj   CONSTANT VARCHAR2 (1024) := 'CITAWEB';    --'CITAWEB';--'CUADRO%2BDE%2BMANDO';--CUADRO+DE+MANDO
   --   const_intelligent_server_proj   CONSTANT VARCHAR2 (1024) := 'VALME+DIRECTO';--CUADRO+DE+MANDO
   const_intelligent_server_user   CONSTANT VARCHAR2 (1024) := 'IUSR_WEBSERVICE';
   const_intelligent_server_pass   CONSTANT VARCHAR2 (1024) := 'aumentanun4,9%';
   const_intelligent_server_wurl   CONSTANT VARCHAR2 (1024) := '/MicroStrategy/servlet/taskProc?';
   const_intelligent_server_ntus   CONSTANT VARCHAR2 (1024) := 'VALME\cueserval';
   const_intelligent_server_ntpw   CONSTANT VARCHAR2 (1024) := '.RO%DRI&GO.';

   PROCEDURE png (reportId      IN VARCHAR2 DEFAULT '9C5AE6B84A50C46DC5E94FA18D95D925',
                  projectName   IN VARCHAR2 DEFAULT const_intelligent_server_proj,
                  rWidth        IN NUMBER DEFAULT 750,
                  rHeight       IN NUMBER DEFAULT 400);

   PROCEDURE htm (reportId      IN VARCHAR2 DEFAULT '99E6EA454EFE37373F2980A43323C92D',
                  projectName   IN VARCHAR2 DEFAULT const_intelligent_server_proj);

   PROCEDURE deliver_chunks  (t_content IN CLOB, l_file_etag IN VARCHAR2);
END;
/