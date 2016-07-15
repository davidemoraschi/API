/* Formatted on 1/11/2014 9:55:59 PM (QP5 v5.163.1008.3004) */
SET DEFINE OFF

DECLARE
   con_str_wallet_path   CONSTANT VARCHAR2 (50) := 'file:/u01/app/oracle/wallet';
   con_str_wallet_pass   CONSTANT VARCHAR2 (50) := 'Lepanto1571';
   httpuri                        HTTPURITYPE;
   y                              CLOB;
   x                              BLOB;
BEGIN
   UTL_HTTP.SET_WALLET (PATH => con_str_wallet_path, password => con_str_wallet_pass);
   httpuri := HTTPURIType ('https://news.google.es/news/feeds?cf=all&ned=es&hl=es&topic=m&output=rss');
   DBMS_OUTPUT.put_line (httpuri.getContentType ());

   IF httpuri.getContentType () = 'text/html'
   THEN
      y := httpuri.getCLOB ();
   END IF;

   IF httpuri.getContentType () = 'application-x/bin'
   THEN
      x := httpuri.getBLOB ();
   END IF;
END;
/