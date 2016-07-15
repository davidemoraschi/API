select xmltype(response) from ODATA_001_LOG_REQUESTS
where request like '1%';

     SELECT XMLSERIALIZE (
                CONTENT XMLROOT (
                           XMLELEMENT (
                              "feed",
                              XMLAttributes ('http://pandasodata.apphb.com/v1/' AS "xml:base",
                                             'http://www.w3.org/2005/Atom' AS "xmlns",
                                             'http://schemas.microsoft.com/ado/2007/08/dataservices' AS "xmlns:d",
                                             'http://schemas.microsoft.com/ado/2007/08/dataservices/metadata' AS "xmlns:m"),
                              XMLELEMENT ("id", 'http://fraterno:8080/apex/odata_002_feed_entries.xml?reportID=' || 'reportId'),
                              XMLELEMENT ("title", XMLAttributes ('text' AS "type"), 'Report' || 'reportId'),
                              XMLELEMENT ("updated", '2013-01-03T08:23:39Z'),
                              XMLELEMENT (
                                 "link",
                                 XMLAttributes ('self' AS "rel",
                                                'Report' || 'reportId' AS "title",
                                                '?reportId=' || 'reportId' AS "href")),
                              XMLAGG(
                              XMLELEMENT ("entry", XMLELEMENT("id", 'http://fraterno:8080/apex/odata_002_feed_entries.xml?reportID=' || 'reportId'||'(1)'),
                              XMLELEMENT("category", XMLAttributes('OPandas.Report1rowtype' as "term", 'http://schemas.microsoft.com/ado/2007/08/dataservices/scheme' AS "scheme")),
                              XMLELEMENT("link", XMLAttributes('edit' AS "rel",'Report1rowtype' AS "title",'?reportID=' || 'reportId'||'(1)' AS "href")),
                              XMLELEMENT("title"),
                              XMLELEMENT ("updated", '2013-01-03T08:23:39Z'),
                              XMLELEMENT("author", XMLELEMENT("name")),
                              XMLELEMENT("content", XMLAttributes('application/xml' AS "type"), XMLELEMENT("m:properties", 
                                    XMLELEMENT("d:rowindex", XMLAttributes ('Edm.Int32' AS "m:type"),1),
                                    XMLELEMENT("d:nuhsa", nuhsa),
                                    XMLELEMENT("d:Avgagenonexpinv", XMLAttributes ('Edm.Int32' AS "m:type"), 299)))
                              ))
                              ),
                           VERSION '1.0" encoding="UTF-8'))
                xmlresultclob
        --INTO t_content
        FROM MSTR_DET_CITAS_CITAWEB;