/* Formatted on 15/02/2014 17:55:40 (QP5 v5.163.1008.3004) PANDAS Copyright (c) 2013 -Davide Moraschi (davidem@eurostrategy.net)
Todos los derechos reservados. Prohibida su reproducción Total o Parcial. */
DECLARE
	l_result VARCHAR2 (200);
	l_clob CLOB
		:= '<table id="tblReportLayout" width="100%" cellpadding="0" border="0" cellspacing="0"><tr><td id="tdReportLayoutCenter" colspan="1" rowspan="1"><div class="report-center mstrWeb"><div id="UniqueReportID" style="position: relative;" styleid="0093522E47D354E31F19858FFE0C7C13" name="UniqueReportID" scriptclass="mstrGridReport" sty="tabl"><table summary="This table displays the requested report results" id="table_UniqueReportID" style="table-layout: auto;empty-cells:show;" cellpadding="0" class="cssDefault view-grid" border="0" cellspacing="0"><tr class=''r-h''><TD  id="UniqueReportID_1_1_1" oty="12" title="Country" AX="1" oid="1736F6394AB923A1ECEB81A0633EC499" STY="ATT" class="c2" DPT="1" >Country</TD><TD  id="UniqueReportID_2_1_1" MH="TRUE" title="Metrics" AX="2" STY="ATT" class="c6 Metrics-cell" nowrap="1" DPT="1" >Metrics</TD><TD  id="UniqueReportID_-1_1_1" oty="4" title="Sum SalesAmount from FactResellerSales" AX="2" acl="255" oid="7475B73E474009D70C2E1F94EAB3B566" STY="MV" class="c10" DPT="1" >Sum SalesAmount from FactResellerSales</TD></tr><tr o="2"><TD  colspan="2" class="c3" >Australia</TD><TD  class="c12 nw" >1,594,335</TD></tr><tr o="3"><TD  colspan="2" class="c3" >Canada</TD><TD  class="c12 nw" >14,377,926</TD></tr><tr o="4"><TD  colspan="2" class="c3" >Germany</TD><TD  class="c12 nw" >1,983,988</TD></tr><tr o="5"><TD  colspan="2" class="c3" >France</TD><TD  class="c12 nw" >4,607,538</TD></tr><tr o="6"><TD  colspan="2" class="c3" >United Kingdom</TD><TD  class="c12 nw" >4,279,009</TD></tr><tr o="7"><TD  colspan="2" class="c3" >United States</TD><TD  class="c12 nw" >53,607,801</TD></tr></table></div><div id="iPhDrMp" style="display:none" name="iPhDrMp"><!--<gdk kp="3" kt="3"><axs><ax n="1"/><ax n="2"/></axs></gdk>--></div><div id="iPhLkMp" style="display:none" name="iPhLkMp"><!--<gdl><axs/><attMap/></gdl>--></div><div id="iPhMeta" style="display:none" name="iPhMeta"><!--<report_info n="21 Reseller Sales by Country"/>--></div><div id="iPhDProps" style="display:none" name="iPhDProps"><!--<display><prs><pr n="allowZoom" v="-1"/></prs></display>--></div></div></td></tr></table>';
	--lt_report_clob CLOB;
	l_buffer VARCHAR2 (1024);
	l_infile UTL_FILE.file_type;
	l_filename VARCHAR2 (200) := '2014-02-15_3718B51011E3877400000080EFF51835.html';
	l_max_line_length INTEGER := 1024;
	f_filename VARCHAR2 (2048);
	l_notetitle VARCHAR2 (2048);
BEGIN
	--l_clob := PANDAS_001_REPORT_EXECUTE_v8.html (projectName => 'COOKBOOK', reportId => 'E1E088D811E3955C00000080EF45B631');
	l_infile := UTL_FILE.fopen ('EVERNOTE'
														 ,l_filename
														 ,'r'
														 ,l_max_line_length);

	-- initialise the empty clob
	DBMS_LOB.createtemporary (l_clob, TRUE, DBMS_LOB.session);

	LOOP
		BEGIN
			UTL_FILE.get_line (l_infile, l_buffer);

			DBMS_LOB.append (l_clob, l_buffer);
		EXCEPTION
			WHEN NO_DATA_FOUND THEN
				EXIT;
		END;
	END LOOP;

	l_notetitle := REGEXP_SUBSTR (l_clob, '<title>[^>]*\/title>');
	l_notetitle := REGEXP_REPLACE (l_notetitle, '<title>');
	l_notetitle := REGEXP_REPLACE (l_notetitle, '<\/title>');

	--	DBMS_OUTPUT.put_line (l_notetitle);
	--	return;

	l_clob := REGEXP_REPLACE (l_clob, '<HTML[^>]?>');
	l_clob := REGEXP_REPLACE (l_clob, '</HTML[^>]?>');
	l_clob := REGEXP_REPLACE (l_clob, '<!DOCTYPE[^>]+>');

	l_clob := REGEXP_REPLACE (l_clob, '<html[^>]*>');
	l_clob := REGEXP_REPLACE (l_clob, '<head[^>]*>');
	l_clob := REGEXP_REPLACE (l_clob, '<meta[^>]*>');
	l_clob := REGEXP_REPLACE (l_clob, '<body[^>]*>');

	l_clob := REGEXP_REPLACE (l_clob
													 ,'<script.*>.*<\/script>'
													 ,NULL
													 ,1
													 ,1
													 ,'n');
	l_clob := REGEXP_REPLACE (l_clob
													 ,'<style.*>.*<\/style>'
													 ,NULL
													 ,1
													 ,1
													 ,'n');

	l_clob := REGEXP_REPLACE (l_clob, '<\/html.?>');
	l_clob := REGEXP_REPLACE (l_clob, '<\/head.?>');
	l_clob := REGEXP_REPLACE (l_clob, '<\/body.?>');

	--RETURN;

	l_clob := REPLACE (l_clob, 'TD', 'td');
	l_clob := REPLACE (l_clob, 'AX', 'ax');
	l_clob := REPLACE (l_clob, 'STY', 'sty');

	l_clob := REGEXP_REPLACE (l_clob, ' id="[^"]*"');
	l_clob := REGEXP_REPLACE (l_clob, ' class="[^"]*"');
	l_clob := REGEXP_REPLACE (l_clob, ' class=''[^'']*''');
	l_clob := REGEXP_REPLACE (l_clob, ' styleid="[^"]*"');
	l_clob := REGEXP_REPLACE (l_clob, ' name="[^"]*"');
	l_clob := REGEXP_REPLACE (l_clob, ' scriptclass="[^"]*"');
	l_clob := REGEXP_REPLACE (l_clob, ' sty="[^"]*"');
	l_clob := REGEXP_REPLACE (l_clob, ' oty="[^"]*"');
	l_clob := REGEXP_REPLACE (l_clob, ' ax="[^"]*"');
	l_clob := REGEXP_REPLACE (l_clob, ' o="[^"]*"');
	l_clob := REGEXP_REPLACE (l_clob, ' oid="[^"]*"');
	l_clob := REGEXP_REPLACE (l_clob, ' DPT="[^"]*"');
	l_clob := REGEXP_REPLACE (l_clob, ' MH="[^"]*"');
	l_clob := REGEXP_REPLACE (l_clob, ' acl="[^"]*"');

	l_clob := REGEXP_REPLACE (l_clob, ' class=[^ ]+');
	--l_clob := REPLACE (l_clob, '<title>', '<b>');
	--l_clob := REPLACE (l_clob, '</title>', '</b>');
	--l_clob := REGEXP_REPLACE (l_clob, '<title[^>]*>');
	l_clob := REGEXP_REPLACE (l_clob, '<title.*>.*<\/title>');

	l_clob := REGEXP_REPLACE (l_clob, 'height=([[:digit:]]+px)', 'height="\1"');
	l_clob := REGEXP_REPLACE (l_clob, 'width=([[:digit:]]+px)', 'width="\1"');
	l_clob := REGEXP_REPLACE (l_clob, '(<img[^>]+)', '\1 /');
	l_clob := REGEXP_REPLACE (l_clob, ' x:str');
	l_clob := REGEXP_REPLACE (l_clob, 'border=([[:digit:]]+)', 'border="\1"');
	l_clob := REGEXP_REPLACE (l_clob, 'cellspacing=([[:digit:]]+)', 'cellspacing="\1"');
	l_clob := REGEXP_REPLACE (l_clob, 'colspan=([[:digit:]]+)', 'colspan="\1"');

	--l_clob := REGEXP_REPLACE (l_clob, '(<img[^>]+)', '\1 /');
	f_filename := REPLACE (REGEXP_SUBSTR (REGEXP_SUBSTR (l_clob, '( src="[^"]+")'), '"[^"]+"'), '"', '');
	l_clob := REGEXP_REPLACE (l_clob, '(<img[^>]+ src=")', '\1http://pandas10.azurewebsites.net/');
	--l_clob := REPLACE ('<title>', '<h1>');
	--l_clob := REPLACE ('</title>', '</h1>');
	SYS.p_ftp_put_binary (p_filename => f_filename, p_location => 'EVERNOTE');

	--DBMS_OUTPUT.put_line (l_clob);
	--http://pandas10.azurewebsites.net/2BA62DA611E3944A00000080EF55D937_2014-02-13_3718B51011E3877400000080EFF51835_graph0.png
	--return;
	l_result := NOTESTORE.CREATENOTE (p_notetitle => l_notetitle
																	 ,p_notecontent => l_clob
																	 ,p_accesstoken => 'S=s1:U=8de4e:E=14b6f6d4714:C=14417bc1b18:P=81:A=davidem:V=2:H=3e4f516d6fc42e0a575a748e776172c1');
END;
/
--ALTER INDEX EVERNOTE.UTL_LOG_CREATE_NOTE_PK REBUILD REVERSE;

--		EXEC UTL_FILE.FREMOVE (location => ''EVERNOTE'', filename => ''20140211125432689349000.log'');
--
--SELECT REGEXP_SUBSTR ('<table width="100%" cellpadding="0" border="0" cellspacing="0">
--		<tr>
--				<td colspan="1" rowspan="1">
--						<div>
--								<div style="position: relative;">
--										<table summary="This table displays the requested report results" style="table-layout: auto;empty-cells:show;" cellpadding="0" border="0" cellspacing="0">
--												<tr>
--														<td title="Country" ax="1" oid="1736F6394AB923A1ECEB81A0633EC499" dpt="1">Country</td>
--														<td mh="TRUE" title="Metrics" ax="2" nowrap="1" dpt="1">Metrics</td>
--														<td title="Sum SalesAmount from FactResellerSales" ax="2" acl="255" oid="7475B73E474009D70C2E1F94EAB3B566"  dpt="1">Sum SalesAmount from FactResellerSales</td>
--												</tr>
--												<tr o="2">
--														<td colspan="2">Australia</td>
--														<td>1,594,335</td>
--												</tr>
--												<tr o="3"><td colspan="2">Canada</td><td>14,377,926</td></tr>
--												<tr o="4"><td colspan="2">Germany</td><td>1,983,988</td></tr>
--												<tr o="5"><td colspan="2">France</td><td>4,607,538</td></tr>
--												<tr o="6"><td colspan="2">United Kingdom</td><td>4,279,009</td></tr>
--												<tr o="7">
--														<td colspan="2">United States</td>
--														<td>53,607,801</td>
--												</tr>
--										</table>
--								</div><div style="display:none"><!--<gdk kp="3" kt="3"><axs><ax n="1"/><ax n="2"/></axs></gdk>--></div><div style="display:none">
--										<!--<gdl><axs/><attMap/></gdl>-->
--								</div><div style="display:none">
--										<!--<report_info n="21 Reseller Sales by Country"/>-->
--								</div><div style="display:none">
--										<!--<display><prs><pr n="allowZoom" v="-1"/></prs></display>-->
--								</div>
--						</div>
--				</td>
--		</tr>
--</table>','ax="[^"]*"') v
--from dual;