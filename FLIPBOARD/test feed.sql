/* Formatted on 1/11/2014 10:33:51 PM (QP5 v5.163.1008.3004) */
SET DEFINE OFF
EXEC p_get_url_list_from_rss('http://news.google.es/news/feeds?cf=all&ned=es&hl=es&topic=m&output=rss');

/

SELECT CHR (38) FROM DUAL;

/

SELECT UTL_HTTP.request (
             'http://news.google.es/news/feeds?cf=all'
          || CHR (38)
          || 'ned=es'
          || CHR (38)
          || 'hl=es'
          || CHR (38)
          || 'topic=m'
          || CHR (38)
          || 'output=rss')
  FROM DUAL;

/

DECLARE
   l_content    CLOB;
   l_rss_feed   XMLTYPE;
   l_link       VARCHAR2 (2048);
BEGIN
   l_content :=
      (HTTPURIType (
             'http://news.google.es/news/feeds?cf=all'
          || CHR (38)
          || 'ned=es'
          || CHR (38)
          || 'hl=es'
          || CHR (38)
          || 'topic=m'
          || CHR (38)
          || 'output=rss').getCLOB ());
   l_rss_feed := xmltype (l_content);

   --DBMS_OUTPUT.put_line (l_rss_feed.EXTRACT ('//rss/channel/item[1]').getstringval ());

   FOR c1 IN (SELECT * FROM TABLE (XMLSEQUENCE (l_rss_feed.EXTRACT ('//rss/channel/item'))))
   LOOP
      --DBMS_OUTPUT.put_line (c1.COLUMN_VALUE.EXTRACT ('/item/title/text()').getstringval ());
      l_link := (c1.COLUMN_VALUE.EXTRACT ('/item/link/text()').getstringval ());
      l_link := SUBSTR(l_link, INSTR(l_link, ';url=')+5);
      --DBMS_OUTPUT.put_line(l_link);
   END LOOP;
END;