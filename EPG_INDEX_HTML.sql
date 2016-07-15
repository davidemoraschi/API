/* Formatted on 9/5/2012 9:27:54 AM (QP5 v5.163.1008.3004) */
-- Delete resource

EXEC DBMS_XDB.deleteresource('/index.html');

-- Create resource

DECLARE
   v_xml      VARCHAR2 (32000);
   v_result   BOOLEAN;
BEGIN
   v_xml := ('<html />');

   -- Using DBMS_XDB
   v_result := DBMS_XDB.createResource ('/index.html', v_xml);

   COMMIT;
END;
/