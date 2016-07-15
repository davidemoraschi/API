/* Formatted on 03/01/2013 8:41:17 (QP5 v5.163.1008.3004) */
--select dbms_xmlgen.getxml('

SELECT OBJECT_ID,
       OBJECT_NAME,
       MOD_TIME,
       PROJECT_ID,
       LOCALE
  FROM MICROSTRATEGY_METADATA.DSSMDOBJINFO
 WHERE PARENT_ID IN (SELECT OBJECT_ID
                       FROM MICROSTRATEGY_METADATA.DSSMDOBJINFO
                      WHERE OBJECT_TYPE = 8 AND OBJECT_NAME = 'oData')
--                      '
--                      ) from dual
;
/*
<service xmlns="http://www.w3.org/2007/app" xmlns:atom="http://www.w3.org/2005/Atom" xml:base="http://pandasodata.apphb.com/oData/">
<workspace>
<atom:title>Default</atom:title>
<collection href="Report1">
<atom:title>Report1</atom:title>
</collection>
<collection href="Report2">
<atom:title>Report2</atom:title>
</collection>
<collection href="Report3">
<atom:title>Report3</atom:title>
</collection>
</workspace>
</service>
*/

SELECT XMLELEMENT ("workspace", XMLELEMENT ("atom:title", 'Default'), XMLELEMENT ("collection href", OBJECT_ID)) xmlstring
  FROM MICROSTRATEGY_METADATA.DSSMDOBJINFO
 WHERE PARENT_ID IN (SELECT OBJECT_ID
                       FROM MICROSTRATEGY_METADATA.DSSMDOBJINFO
                      WHERE OBJECT_TYPE = 8 AND OBJECT_NAME = 'oData');

SELECT XMLROOT (
          XMLELEMENT (
             "service",
             XMLAttributes ('http://www.w3.org/2005/Atom' AS "xmlns:atom",
                            'http://www.w3.org/2007/app' AS "xmlns",
                            'http://localhost:54603/ReportDataService.svc/' AS "xml:base"),
             XMLELEMENT (
                "workspace",
                XMLELEMENT ("atom:title", 'Default'),
                XMLAGG (XMLELEMENT ("collection", XMLAttributes (object_id AS "href"), XMLELEMENT ("atom:title", object_name))))),
          VERSION '1.0" encoding="UTF-8')
          xmlresultstring
  --INTO l_str_xml
  FROM MICROSTRATEGY_METADATA.DSSMDOBJINFO
 WHERE parent_id IN (SELECT object_id
                       FROM MICROSTRATEGY_METADATA.DSSMDOBJINFO
                      WHERE object_type = 8 AND object_name = 'oData' AND ROWNUM < 5);

SELECT XMLSERIALIZE (
          CONTENT XMLROOT (
                     XMLELEMENT (
                        "service",
                        XMLAttributes ('http://www.w3.org/2005/Atom' AS "xmlns:atom",
                                       'http://www.w3.org/2007/app' AS "xmlns",
                                       'http://localhost:54603/ReportDataService.svc/' AS "xml:base"),
                        XMLELEMENT (
                           "workspace",
                           XMLELEMENT ("atom:title", 'Default'),
                           XMLAGG (
                              XMLELEMENT ("collection",
                                          XMLAttributes (object_id AS "href"),
                                          XMLELEMENT ("atom:title", object_name))))),
                     VERSION '1.0" encoding="UTF-8'))
          xmlresultclob
  FROM MICROSTRATEGY_METADATA.DSSMDOBJINFO
 WHERE parent_id IN (SELECT object_id
                       FROM MICROSTRATEGY_METADATA.DSSMDOBJINFO
                      WHERE object_type = 8 AND object_name = 'oData' AND ROWNUM < 5);