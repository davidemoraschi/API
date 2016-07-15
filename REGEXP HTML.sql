/* Formatted on 11/02/2014 20:09:54 (QP5 v5.163.1008.3004) PANDAS Copyright (c) 2013 -Davide Moraschi (davidem@eurostrategy.net)
Todos los derechos reservados. Prohibida su reproducción Total o Parcial. */
declare
v_count number;
l_xml xmltype;
doc DBMS_XMLDOM.DOMDocument;
nl  DBMS_XMLDOM.DOMNodeList;
    n   DBMS_XMLDOM.DOMNode;
    len number;
testr varchar2(32000);    
l_clob clob := '<HTML><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd " ><html xmlns:v=3D"urn:schemas-microsoft-com:vml"
xmlns:o=3D"urn:schemas-microsoft-com:office:office"
xmlns:x=3D"urn:schemas-microsoft-com:office:excel"
xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8  ">
<style>
<!--table
br
.style21
    {color:blue;
    font-size:10.0pt;
    font-weight:400;
    font-style:normal;
    text-decoration:underline;
    text-underline-style:single;
    font-family:Arial;
}
.style0
{
    text-align:general;
    vertical-align:bottom;
    white-space:nowrap;
    color:windowtext;
    font-size:10.0pt;
    font-weight:400;
    font-style:normal;
    text-decoration:none;
    font-family:Arial;
    border:none;
}
td
    {
    mso-ignore:padding;
    color:windowtext;
    font-size:10.0pt;
    font-weight:400;
    font-style:normal;
    text-decoration:none;
    font-family:Arial;
    text-align:general;
    vertical-align:bottom;
    border:none;
    }
span
    {
    mso-ignore:padding;
    color:windowtext;
    font-size:10.0pt;
    font-weight:400;
    font-style:normal;
    text-decoration:none;
    font-family:Arial;
    text-align:general;
    vertical-align:bottom;
    border:none;
    }
.xl24
    {mso-style-parent:style0;
     white-space:normal;}
.xl26
    {
    text-align:left;
    vertical-align:top;
    padding-left:1.0pt;
    padding-right:1.0pt;
    padding-top:1.0pt;
    padding-bottom:1.0pt;
     }
.xl29
    {
    text-align:right;
    vertical-align:middle;
    background-color:transparent;
    border-left:.5pt solid #000000;
    border-top:.5pt solid #000000;
    border-right:.5pt solid #000000;
    border-bottom:.5pt solid #000000;
    padding-left:1.0pt;
    padding-right:1.0pt;
    padding-top:1.0pt;
    padding-bottom:1.0pt;
     }
.xl31
    {
    text-align:left;
    vertical-align:top;
    background-color:transparent;
    padding-left:1.0pt;
    padding-right:1.0pt;
    padding-top:1.0pt;
    padding-bottom:1.0pt;
     }
.xl32
    {
    text-align:left;
    vertical-align:middle;
    border-left:.5pt solid #ededed;
    border-top:.5pt solid #ededed;
    border-right:.5pt solid #ededed;
    border-bottom:.5pt solid #ededed;
    padding-left:1.0pt;
    padding-right:1.0pt;
    padding-top:1.0pt;
    padding-bottom:1.0pt;
     }
.xl35
    {
    font-family:Verdana;
    font-size:8.0pt;
    font-weight:700;
    color:#ffffff;
    text-align:center;
    vertical-align:middle;
    background-color:#7b7b7b;
    white-space:normal;
    border-left:.5pt solid #ededed;
    border-top:none;
    border-right:none;
    border-bottom:.5pt solid #ededed;
    filter: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr=''#7b7b7b'', EndColorStr=''#393939'') 
     progid:DXImageTransform.Microsoft.dropshadow(Color=''#66000000'', Positive=''true'', OffX=0.000, OffY=0.000) ; 
    padding-left:5.0pt;
    padding-right:1.0pt;
    padding-top:1.0pt;
    padding-bottom:1.0pt;
     }
.xl36
    {
    font-family:Verdana;
    font-size:8.0pt;
    font-weight:700;
    color:#ffffff;
    text-align:center;
    background-color:#7b7b7b;
    white-space:normal;
    border-left:.5pt solid #ededed;
    border-top:none;
    border-right:none;
    border-bottom:.5pt solid #ededed;
    filter: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr=''#7b7b7b'', EndColorStr=''#393939'') 
     progid:DXImageTransform.Microsoft.dropshadow(Color=''#66000000'', Positive=''true'', OffX=0.000, OffY=0.000) ; 
    padding-left:1.0pt;
    padding-right:1.0pt;
    padding-top:1.0pt;
    padding-bottom:1.0pt;
     }
.xl37
    {
    font-family:Verdana;
    font-size:8.0pt;
    font-weight:700;
    color:#333333;
    text-align:left;
    vertical-align:middle;
    background-color:#dbdbdb;
    white-space:normal;
    border-left:.5pt solid #f5f5f2;
    border-top:none;
    border-right:none;
    border-bottom:.5pt solid #f5f5f2;
    padding-left:5.0pt;
    padding-right:5.0pt;
    padding-top:1.0pt;
    padding-bottom:1.0pt;
     }
.xl38
    {
    font-family:Verdana;
    font-size:8.0pt;
    text-align:right;
    vertical-align:middle;
    background-color:#d0dbbb;
    border-left:.5pt solid #ededed;
    border-top:none;
    border-right:none;
    border-bottom:.5pt solid #ededed;
    padding-left:5.0pt;
    padding-right:5.0pt;
    padding-top:1.0pt;
    padding-bottom:1.0pt;
     }
-->
</style>
</head>
<body link=blue vlink=purple style=''zoom:100.00%''>
<div class=xl26 style=''width:3262pt;''>
<!--Start of Section-->
<div class=xl29 style=''overflow:hidden; position:relative; border:none;height:92pt;''>
 <!-- Start of grid-graph container --><span class=xl31 style=''overflow: hidden; position:absolute; top:0pt; left:0pt; z-index:3; width:auto; height:648pt; ''><!--Start of Grid-->
<div style=''overflow:hidden; table-layout: fixed; top:0pt; left:0pt; z-index:3; width:269pt; height:648pt; ''>
<table x:str border=0 cellspacing=0 class=xl32 >
 <col style=''width:115pt;''>
 <col style=''width:154pt;''>
<tr>
 <td class=xl35 style=''background:#7b7b7b;''>Country</td>
 <td class=xl36 style=''background:#7b7b7b;''>SalesAmount</td>
</tr>
<tr>
 <td class=xl37 style=''background:#dbdbdb;''>Australia</td>
 <td class=xl38 style=''background:#d0dbbb;''>1,594,335</td>
</tr>
<tr>
 <td class=xl37 style=''background:#dbdbdb;''>Canada</td>
 <td class=xl38 style=''background:#d0dbbb;''>14,377,926</td>
</tr>
<tr>
 <td class=xl37 style=''background:#dbdbdb;''>Germany</td>
 <td class=xl38 style=''background:#d0dbbb;''>1,983,988</td>
</tr>
<tr>
 <td class=xl37 style=''background:#dbdbdb;''>France</td>
 <td class=xl38 style=''background:#d0dbbb;''>4,607,538</td>
</tr>
<tr>
 <td class=xl37 style=''background:#dbdbdb;''>United Kingdom</td>
 <td class=xl38 style=''background:#d0dbbb;''>4,279,009</td>
</tr>
<tr>
 <td class=xl37 style=''background:#dbdbdb;''>United States</td>
 <td class=xl38 style=''background:#d0dbbb;''>53,607,801</td>
</tr>
</table>
</div>
<!--End of Grid-->
 </span>
<!-- End of Container -->
</div>
<!--End of Section-->
</div>
</body>
</html>
</HTML>';
begin
-- Elimina el primer <HTML>
l_clob:= REGEXP_REPLACE (l_clob,'<HTML.?>');
-- Elimina el último </HTML>
l_clob:= REGEXP_REPLACE (l_clob,'<\/HTML.?>');
-- Elimina el el DOCTYPE
l_clob:= REGEXP_REPLACE (l_clob,'<!DOCTYPE.*>');
-- Elimina el segundo <html>
l_clob:= REGEXP_REPLACE (l_clob,'<html[^>]+>');
-- Elimina el último </html>
l_clob:= REGEXP_REPLACE (l_clob,'<\/html.?>');
-- Elimina el <head>
l_clob:= REGEXP_REPLACE (l_clob,'<head.*+\/head>', NULL, 1, 1, 'n');
-- Elimina el primer <body>
l_clob:= REGEXP_REPLACE (l_clob,'<body.*>');
-- Elimina el último </body>
l_clob:= REGEXP_REPLACE (l_clob,'<\/body.?>');
-- Elimina el atributo class
l_clob:= REGEXP_REPLACE (l_clob,' class=[^ ]+');

-- Elimina x:str
l_clob:= REGEXP_REPLACE (l_clob,' x:str');

-- Corrige border sin comillas
l_clob:= REGEXP_REPLACE (l_clob, 'border=([[:digit:]]+)', 'border="\1"');

-- Corrige cellspacing sin comillas
l_clob:= REGEXP_REPLACE (l_clob, 'cellspacing=([[:digit:]]+)', 'cellspacing="\1"');

-- Corrige col sin cierre
l_clob:= REGEXP_REPLACE (l_clob, '(<col[^>]+)', '\1 /') ;

-- Convierte en XML
l_xml:= xmltype (l_clob);

dbms_output.put_line(l_xml.extract('/').getstringval());
doc := XmlDom.NewDomDocument(l_clob);
nl   := DBMS_XMLDOM.getElementsByTagName(doc, '*');
--v_RootNode := XmlDom.MakeNode(XmlDom.GetDocumentElement(v_Doc));
len  := DBMS_XMLDOM.getLength(nl);
    -- loop through elements
    FOR i IN 0 .. len - 1 LOOP
        n := DBMS_XMLDOM.item(nl, i);

        testr := DBMS_XMLDOM.getNodeName(n) || ' ' || DBMS_XMLDOM.getNodeValue(n);

        --DBMS_OUTPUT.PUT_LINE (testr);
    END LOOP;

end;