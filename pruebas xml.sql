select xmlelement("name", object_id), object_name/*, mod_time, locale*/ from METADATA.DSSMDOBJINFO
where parent_id in (
select object_id from METADATA.DSSMDOBJINFO
where object_type = 8 and object_name = 'My Reports'
);
/

<?xml version="1.0" encoding="UTF-8"?>
<service xmlns:atom="http://www.w3.org/2005/Atom" xmlns="http://www.w3.org/2007/app" xml:base="http://localhost:54603/ReportDataService.svc/">
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

/

select XMLRoot(
xmlelement("service"
, XMLAttributes('http://www.w3.org/2005/Atom' AS "xmlns:atom", 'http://www.w3.org/2007/app' AS "xmlns", 'http://localhost:54603/ReportDataService.svc/' AS "xml:base")
, xmlelement("workspace",XMLELEMENT("atom:title", 'Default'), XMLAGG (XMLELEMENT("collection",XMLAttributes(object_id as "href"),XMLELEMENT("atom:title", object_name) )) )), VERSION '1.0" encoding="UTF-8') xmlresultstring from METADATA.DSSMDOBJINFO
where parent_id in (
select object_id from METADATA.DSSMDOBJINFO
where object_type = 8 and object_name = 'My Reports' and rownum < 5
)
;