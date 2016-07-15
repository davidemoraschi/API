/* Formatted on 10/01/2013 8:28:14 (QP5 v5.163.1008.3004) */
CREATE OR REPLACE PACKAGE BODY MSTR.odata_002_feed_entries
AS
   PROCEDURE xml (reportID IN VARCHAR2)
   IS
      C_DEBUG         BOOLEAN := FALSE;
      P_LENGTH        NUMBER;
      P_CLOB_BUFFER   BINARY_INTEGER := 32000;
      P_POS           INTEGER := 1;
      P_SET           VARCHAR2 (32000);
      P_LOOP          NUMBER;
      --      l_limit         NUMBER := 32000;
      --      v_text_amt      BINARY_INTEGER := l_limit;
      --      v_text_pos      NUMBER := 1;
      --      v_text_buffer   VARCHAR2 (32000);
      ts_now          TIMESTAMP;
      --      t_clob          BLOB;
      t_content       CLOB;
      p_content       CLOB
         := '<?xml version="1.0" encoding="utf-8"?><feed xml:base="http://pandasodata.apphb.com/v1/" xmlns="http://www.w3.org/2005/Atom" xmlns:d="http://schemas.microsoft.com/ado/2007/08/dataservices" xmlns:m="http://schemas.microsoft.com/ado/2007/08/dataservices/metadata"><id>http://pandasodata.apphb.com/v1/Report1</id><title type="text">Report1</title><updated>2013-01-03T08:23:39Z</updated><link rel="self" title="Report1" href="Report1" /><entry><id>http://pandasodata.apphb.com/v1/Report1(1)</id><category term="OPandas.Report1rowtype" scheme="http://schemas.microsoft.com/ado/2007/08/dataservices/scheme" /><link rel="edit" title="Report1rowtype" href="Report1(1)" /><title /><updated>2013-01-03T08:23:39Z</updated><author><name /></author><content type="application/xml"><m:properties><d:rowindex m:type="Edm.Int32">1</d:rowindex><d:Country>(formerly Tanana</d:Country><d:Avgagenonexpinv m:type="Edm.Int32">299</d:Avgagenonexpinv></m:properties></content></entry><entry><id>http://pandasodata.apphb.com/v1/Report1(2)</id><category term="OPandas.Report1rowtype" scheme="http://schemas.microsoft.com/ado/2007/08/dataservices/scheme" /><link rel="edit" title="Report1rowtype" href="Report1(2)" /><title /><updated>2013-01-03T08:23:39Z</updated><author><name /></author><content type="application/xml"><m:properties><d:rowindex m:type="Edm.Int32">2</d:rowindex><d:Country>Angola</d:Country><d:Avgagenonexpinv m:type="Edm.Int32">520</d:Avgagenonexpinv></m:properties></content></entry><entry><id>http://pandasodata.apphb.com/v1/Report1(3)</id><category term="OPandas.Report1rowtype" scheme="http://schemas.microsoft.com/ado/2007/08/dataservices/scheme" /><link rel="edit" title="Report1rowtype" href="Report1(3)" /><title /><updated>2013-01-03T08:23:39Z</updated><author><name /></author><content type="application/xml"><m:properties><d:rowindex m:type="Edm.Int32">3</d:rowindex><d:Country>ar es Salaam Tanzania</d:Country><d:Avgagenonexpinv m:type="Edm.Int32">182</d:Avgagenonexpinv></m:properties></content></entry><entry><id>http://pandasodata.apphb.com/v1/Report1(4)</id><category term="OPandas.Report1rowtype" scheme="http://schemas.microsoft.com/ado/2007/08/dataservices/scheme" /><link rel="edit" title="Report1rowtype" href="Report1(4)" /><title /><updated>2013-01-03T08:23:39Z</updated><author><name /></author><content type="application/xml"><m:properties><d:rowindex m:type="Edm.Int32">4</d:rowindex><d:Country>Benin, Republic of</d:Country><d:Avgagenonexpinv m:type="Edm.Int32">507</d:Avgagenonexpinv></m:properties></content></entry><entry><id>http://pandasodata.apphb.com/v1/Report1(5)</id><category term="OPandas.Report1rowtype" scheme="http://schemas.microsoft.com/ado/2007/08/dataservices/scheme" /><link rel="edit" title="Report1rowtype" href="Report1(5)" /><title /><updated>2013-01-03T08:23:39Z</updated><author><name /></author><content type="application/xml"><m:properties><d:rowindex m:type="Edm.Int32">5</d:rowindex><d:Country>Botswana</d:Country><d:Avgagenonexpinv m:type="Edm.Int32">377</d:Avgagenonexpinv></m:properties></content></entry><entry><id>http://pandasodata.apphb.com/v1/Report1(6)</id><category term="OPandas.Report1rowtype" scheme="http://schemas.microsoft.com/ado/2007/08/dataservices/scheme" /><link rel="edit" title="Report1rowtype" href="Report1(6)" /><title /><updated>2013-01-03T08:23:39Z</updated><author><name /></author><content type="application/xml"><m:properties><d:rowindex m:type="Edm.Int32">6</d:rowindex><d:Country>Burkina Faso</d:Country><d:Avgagenonexpinv m:type="Edm.Int32">91</d:Avgagenonexpinv></m:properties></content></entry><entry><id>http://pandasodata.apphb.com/v1/Report1(7)</id><category term="OPandas.Report1rowtype" scheme="http://schemas.microsoft.com/ado/2007/08/dataservices/scheme" /><link rel="edit" title="Report1rowtype" href="Report1(7)" /><title /><updated>2013-01-03T08:23:39Z</updated><author><name /></author><content type="application/xml"><m:properties><d:rowindex m:type="Edm.Int32">7</d:rowindex><d:Country>Burkina Faso (New</d:Country><d:Avgagenonexpinv m:type="Edm.Int32">260</d:Avgagenonexpinv></m:properties></content></entry><entry><id>http://pandasodata.apphb.com/v1/Report1(8)</id><category term="OPandas.Report1rowtype" scheme="http://schemas.microsoft.com/ado/2007/08/dataservices/scheme" /><link rel="edit" title="Report1rowtype" href="Report1(8)" /><title /><updated>2013-01-03T08:23:39Z</updated><author><name /></author><content type="application/xml"><m:properties><d:rowindex m:type="Edm.Int32">8</d:rowindex><d:Country>Burundi</d:Country><d:Avgagenonexpinv m:type="Edm.Int32">325</d:Avgagenonexpinv></m:properties></content></entry><entry><id>http://pandasodata.apphb.com/v1/Report1(9)</id><category term="OPandas.Report1rowtype" scheme="http://schemas.microsoft.com/ado/2007/08/dataservices/scheme" /><link rel="edit" title="Report1rowtype" href="Report1(9)" /><title /><updated>2013-01-03T08:23:39Z</updated><author><name /></author><content type="application/xml"><m:properties><d:rowindex m:type="Edm.Int32">9</d:rowindex><d:Country>Cameroon</d:Country><d:Avgagenonexpinv m:type="Edm.Int32">221</d:Avgagenonexpinv></m:properties></content></entry><entry><id>http://pandasodata.apphb.com/v1/Report1(10)</id><category term="OPandas.Report1rowtype" scheme="http://schemas.microsoft.com/ado/2007/08/dataservices/scheme" /><link rel="edit" title="Report1rowtype" href="Report1(10)" /><title /><updated>2013-01-03T08:23:39Z</updated><author><name /></author><content type="application/xml"><m:properties><d:rowindex m:type="Edm.Int32">10</d:rowindex><d:Country>Cape Verde</d:Country><d:Avgagenonexpinv m:type="Edm.Int32">442</d:Avgagenonexpinv></m:properties></content></entry><entry><id>http://pandasodata.apphb.com/v1/Report1(11)</id><category term="OPandas.Report1rowtype" scheme="http://schemas.microsoft.com/ado/2007/08/dataservices/scheme" /><link rel="edit" title="Report1rowtype" href="Report1(11)" /><title /><updated>2013-01-03T08:23:39Z</updated><author><name /></author><content type="application/xml"><m:properties><d:rowindex m:type="Edm.Int32">11</d:rowindex><d:Country>Central African Republ</d:Country><d:Avgagenonexpinv m:type="Edm.Int32">247</d:Avgagenonexpinv></m:properties></content></entry><entry><id>http://pandasodata.apphb.com/v1/Report1(12)</id><category term="OPandas.Report1rowtype" scheme="http://schemas.microsoft.com/ado/2007/08/dataservices/scheme" /><link rel="edit" title="Report1rowtype" href="Report1(12)" /><title /><updated>2013-01-03T08:23:39Z</updated><author><name /></author><content type="application/xml"><m:properties><d:rowindex m:type="Edm.Int32">12</d:rowindex><d:Country>Chad</d:Country><d:Avgagenonexpinv m:type="Edm.Int32">416</d:Avgagenonexpinv></m:properties></content></entry><entry><id>http://pandasodata.apphb.com/v1/Report1(13)</id><category term="OPandas.Report1rowtype" scheme="http://schemas.microsoft.com/ado/2007/08/dataservices/scheme" /><link rel="edit" title="Report1rowtype" href="Report1(13)" /><title /><updated>2013-01-03T08:23:39Z</updated><author><name /></author><content type="application/xml"><m:properties><d:rowindex m:type="Edm.Int32">13</d:rowindex><d:Country>Congo</d:Country><d:Avgagenonexpinv m:type="Edm.Int32">286</d:Avgagenonexpinv></m:properties></content></entry><entry><id>http://pandasodata.apphb.com/v1/Report1(14)</id><category term="OPandas.Report1rowtype" scheme="http://schemas.microsoft.com/ado/2007/08/dataservices/scheme" /><link rel="edit" title="Report1rowtype" href="Report1(14)" /><title /><updated>2013-01-03T08:23:39Z</updated><author><name /></author><content type="application/xml"><m:properties><d:rowindex m:type="Edm.Int32">14</d:rowindex><d:Country>Congo, Democratic</d:Country><d:Avgagenonexpinv m:type="Edm.Int32">221</d:Avgagenonexpinv></m:properties></content></entry><entry><id>http://pandasodata.apphb.com/v1/Report1(15)</id><category term="OPandas.Report1rowtype" scheme="http://schemas.microsoft.com/ado/2007/08/dataservices/scheme" /><link rel="edit" title="Report1rowtype" href="Report1(15)" /><title /><updated>2013-01-03T08:23:39Z</updated><author><name /></author><content type="application/xml"><m:properties><d:rowindex m:type="Edm.Int32">15</d:rowindex><d:Country>Congo, Democratic Re</d:Country><d:Avgagenonexpinv m:type="Edm.Int32">195</d:Avgagenonexpinv></m:properties></content></entry><entry><id>http://pandasodata.apphb.com/v1/Report1(16)</id><category term="OPandas.Report1rowtype" scheme="http://schemas.microsoft.com/ado/2007/08/dataservices/scheme" /><link rel="edit" title="Report1rowtype" href="Report1(16)" /><title /><updated>2013-01-03T08:23:39Z</updated><author><name /></author><content type="application/xml"><m:properties><d:rowindex m:type="Edm.Int32">16</d:rowindex><d:Country>Cote D''Ivoire (Ivory)</d:Country><d:Avgagenonexpinv m:type="Edm.Int32">156</d:Avgagenonexpinv></m:properties></content></entry><entry><id>http://pandasodata.apphb.com/v1/Report1(17)</id><category term="OPandas.Report1rowtype" scheme="http://schemas.microsoft.com/ado/2007/08/dataservices/scheme" /><link rel="edit" title="Report1rowtype" href="Report1(17)" /><title /><updated>2013-01-03T08:23:39Z</updated><author><name /></author><content type="application/xml"><m:properties><d:rowindex m:type="Edm.Int32">17</d:rowindex><d:Country>Cote DIvoire (Ivory</d:Country><d:Avgagenonexpinv m:type="Edm.Int32">169</d:Avgagenonexpinv></m:properties></content></entry><entry><id>http://pandasodata.apphb.com/v1/Report1(18)</id><category term="OPandas.Report1rowtype" scheme="http://schemas.microsoft.com/ado/2007/08/dataservices/scheme" /><link rel="edit" title="Report1rowtype" href="Report1(18)" /><title /><updated>2013-01-03T08:23:39Z</updated><author><name /></author><content type="application/xml"><m:properties><d:rowindex m:type="Edm.Int32">18</d:rowindex><d:Country>Eritrea</d:Country><d:Avgagenonexpinv m:type="Edm.Int32">247</d:Avgagenonexpinv></m:properties></content></entry><entry><id>http://pandasodata.apphb.com/v1/Report1(19)</id><category term="OPandas.Report1rowtype" scheme="http://schemas.microsoft.com/ado/2007/08/dataservices/scheme" /><link rel="edit" title="Report1rowtype" href="Report1(19)" /><title /><updated>2013-01-03T08:23:39Z</updated><author><name /></author><content type="application/xml"><m:properties><d:rowindex m:type="Edm.Int32">19</d:rowindex><d:Country>Ethiopia</d:Country><d:Avgagenonexpinv m:type="Edm.Int32">520</d:Avgagenonexpinv></m:properties></content></entry><entry><id>http://pandasodata.apphb.com/v1/Report1(20)</id><category term="OPandas.Report1rowtype" scheme="http://schemas.microsoft.com/ado/2007/08/dataservices/scheme" /><link rel="edit" title="Report1rowtype" href="Report1(20)" /><title /><updated>2013-01-03T08:23:39Z</updated><author><name /></author><content type="application/xml"><m:properties><d:rowindex m:type="Edm.Int32">20</d:rowindex><d:Country>Gabon</d:Country><d:Avgagenonexpinv m:type="Edm.Int32">390</d:Avgagenonexpinv></m:properties></content></entry><entry><id>http://pandasodata.apphb.com/v1/Report1(21)</id><category term="OPandas.Report1rowtype" scheme="http://schemas.microsoft.com/ado/2007/08/dataservices/scheme" /><link rel="edit" title="Report1rowtype" href="Report1(21)" /><title /><updated>2013-01-03T08:23:39Z</updated><author><name /></author><content type="application/xml"><m:properties><d:rowindex m:type="Edm.Int32">21</d:rowindex><d:Country>Ghana</d:Country><d:Avgagenonexpinv m:type="Edm.Int32">351</d:Avgagenonexpinv></m:properties></content></entry><entry><id>http://pandasodata.apphb.com/v1/Report1(22)</id><category term="OPandas.Report1rowtype" scheme="http://schemas.microsoft.com/ado/2007/08/dataservices/scheme" /><link rel="edit" title="Report1rowtype" href="Report1(22)" /><title /><updated>2013-01-03T08:23:39Z</updated><author><name /></author><content type="application/xml"><m:properties><d:rowindex m:type="Edm.Int32">22</d:rowindex><d:Country>Guinea</d:Country><d:Avgagenonexpinv m:type="Edm.Int32">221</d:Avgagenonexpinv></m:properties></content></entry><entry><id>http://pandasodata.apphb.com/v1/Report1(23)</id><category term="OPandas.Report1rowtype" scheme="http://schemas.microsoft.com/ado/2007/08/dataservices/scheme" /><link rel="edit" title="Report1rowtype" href="Report1(23)" /><title /><updated>2013-01-03T08:23:39Z</updated><author><name /></author><content type="application/xml"><m:properties><d:rowindex m:type="Edm.Int32">23</d:rowindex><d:Country>Guinea-Bissau</d:Country><d:Avgagenonexpinv m:type="Edm.Int32">247</d:Avgagenonexpinv></m:properties></content></entry><entry><id>http://pandasodata.apphb.com/v1/Report1(24)</id><category term="OPandas.Report1rowtype" scheme="http://schemas.microsoft.com/ado/2007/08/dataservices/scheme" /><link rel="edit" title="Report1rowtype" href="Report1(24)" /><title /><updated>2013-01-03T08:23:39Z</updated><author><name /></author><content type="application/xml"><m:properties><d:rowindex m:type="Edm.Int32">24</d:rowindex><d:Country>Kenya</d:Country><d:Avgagenonexpinv m:type="Edm.Int32">416</d:Avgagenonexpinv></m:properties></content></entry><entry><id>http://pandasodata.apphb.com/v1/Report1(25)</id><category term="OPandas.Report1rowtype" scheme="http://schemas.microsoft.com/ado/2007/08/dataservices/scheme" /><link rel="edit" title="Report1rowtype" href="Report1(25)" /><title /><updated>2013-01-03T08:23:39Z</updated><author><name /></author><content type="application/xml"><m:properties><d:rowindex m:type="Edm.Int32">25</d:rowindex><d:Country>Lesotho</d:Country><d:Avgagenonexpinv m:type="Edm.Int32">455</d:Avgagenonexpinv></m:properties></content></entry><entry><id>http://pandasodata.apphb.com/v1/Report1(26)</id><category term="OPandas.Report1rowtype" scheme="http://schemas.microsoft.com/ado/2007/08/dataservices/scheme" /><link rel="edit" title="Report1rowtype" href="Report1(26)" /><title /><updated>2013-01-03T08:23:39Z</updated><author><name /></author><content type="application/xml"><m:properties><d:rowindex m:type="Edm.Int32">26</d:rowindex><d:Country>Liberia</d:Country><d:Avgagenonexpinv m:type="Edm.Int32">442</d:Avgagenonexpinv></m:properties></content></entry><entry><id>http://pandasodata.apphb.com/v1/Report1(27)</id><category term="OPandas.Report1rowtype" scheme="http://schemas.microsoft.com/ado/2007/08/dataservices/scheme" /><link rel="edit" title="Report1rowtype" href="Report1(27)" /><title /><updated>2013-01-03T08:23:39Z</updated><author><name /></author><content type="application/xml"><m:properties><d:rowindex m:type="Edm.Int32">27</d:rowindex><d:Country>Madagascar</d:Country><d:Avgagenonexpinv m:type="Edm.Int32">117</d:Avgagenonexpinv></m:properties></content></entry><entry><id>http://pandasodata.apphb.com/v1/Report1(28)</id><category term="OPandas.Report1rowtype" scheme="http://schemas.microsoft.com/ado/2007/08/dataservices/scheme" /><link rel="edit" title="Report1rowtype" href="Report1(28)" /><title /><updated>2013-01-03T08:23:39Z</updated><author><name /></author><content type="application/xml"><m:properties><d:rowindex m:type="Edm.Int32">28</d:rowindex><d:Country>Malawi</d:Country><d:Avgagenonexpinv m:type="Edm.Int32">520</d:Avgagenonexpinv></m:properties></content></entry><entry><id>http://pandasodata.apphb.com/v1/Report1(29)</id><category term="OPandas.Report1rowtype" scheme="http://schemas.microsoft.com/ado/2007/08/dataservices/scheme" /><link rel="edit" title="Report1rowtype" href="Report1(29)" /><title /><updated>2013-01-03T08:23:39Z</updated><author><name /></author><content type="application/xml"><m:properties><d:rowindex m:type="Edm.Int32">29</d:rowindex><d:Country>Mali</d:Country><d:Avgagenonexpinv m:type="Edm.Int32">377</d:Avgagenonexpinv></m:properties></content></entry><entry><id>http://pandasodata.apphb.com/v1/Report1(30)</id><category term="OPandas.Report1rowtype" scheme="http://schemas.microsoft.com/ado/2007/08/dataservices/scheme" /><link rel="edit" title="Report1rowtype" href="Report1(30)" /><title /><updated>2013-01-03T08:23:39Z</updated><author><name /></author><content type="application/xml"><m:properties><d:rowindex m:type="Edm.Int32">30</d:rowindex><d:Country>Mauritania</d:Country><d:Avgagenonexpinv m:type="Edm.Int32">338</d:Avgagenonexpinv></m:properties></content></entry><entry><id>http://pandasodata.apphb.com/v1/Report1(31)</id><category term="OPandas.Report1rowtype" scheme="http://schemas.microsoft.com/ado/2007/08/dataservices/scheme" /><link rel="edit" title="Report1rowtype" href="Report1(31)" /><title /><updated>2013-01-03T08:23:39Z</updated><author><name /></author><content type="application/xml"><m:properties><d:rowindex m:type="Edm.Int32">31</d:rowindex><d:Country>Mauritius</d:Country><d:Avgagenonexpinv m:type="Edm.Int32">390</d:Avgagenonexpinv></m:properties></content></entry><entry><id>http://pandasodata.apphb.com/v1/Report1(32)</id><category term="OPandas.Report1rowtype" scheme="http://schemas.microsoft.com/ado/2007/08/dataservices/scheme" /><link rel="edit" title="Report1rowtype" href="Report1(32)" /><title /><updated>2013-01-03T08:23:39Z</updated><author><name /></author><content type="application/xml"><m:properties><d:rowindex m:type="Edm.Int32">32</d:rowindex><d:Country>Mozambique</d:Country><d:Avgagenonexpinv m:type="Edm.Int32">390</d:Avgagenonexpinv></m:properties></content></entry><entry><id>http://pandasodata.apphb.com/v1/Report1(33)</id><category term="OPandas.Report1rowtype" scheme="http://schemas.microsoft.com/ado/2007/08/dataservices/scheme" /><link rel="edit" title="Report1rowtype" href="Report1(33)" /><title /><updated>2013-01-03T08:23:39Z</updated><author><name /></author><content type="application/xml"><m:properties><d:rowindex m:type="Edm.Int32">33</d:rowindex><d:Country>Namibia</d:Country><d:Avgagenonexpinv m:type="Edm.Int32">338</d:Avgagenonexpinv></m:properties></content></entry><entry><id>http://pandasodata.apphb.com/v1/Report1(34)</id><category term="OPandas.Report1rowtype" scheme="http://schemas.microsoft.com/ado/2007/08/dataservices/scheme" /><link rel="edit" title="Report1rowtype" href="Report1(34)" /><title /><updated>2013-01-03T08:23:39Z</updated><author><name /></author><content type="application/xml"><m:properties><d:rowindex m:type="Edm.Int32">34</d:rowindex><d:Country>Niger</d:Country><d:Avgagenonexpinv m:type="Edm.Int32">364</d:Avgagenonexpinv></m:properties></content></entry><entry><id>http://pandasodata.apphb.com/v1/Report1(35)</id><category term="OPandas.Report1rowtype" scheme="http://schemas.microsoft.com/ado/2007/08/dataservices/scheme" /><link rel="edit" title="Report1rowtype" href="Report1(35)" /><title /><updated>2013-01-03T08:23:39Z</updated><author><name /></author><content type="application/xml"><m:properties><d:rowindex m:type="Edm.Int32">35</d:rowindex><d:Country>Nigeria</d:Country><d:Avgagenonexpinv m:type="Edm.Int32">273</d:Avgagenonexpinv></m:properties></content></entry><entry><id>http://pandasodata.apphb.com/v1/Report1(36)</id><category term="OPandas.Report1rowtype" scheme="http://schemas.microsoft.com/ado/2007/08/dataservices/scheme" /><link rel="edit" title="Report1rowtype" href="Report1(36)" /><title /><updated>2013-01-03T08:23:39Z</updated><author><name /></author><content type="application/xml"><m:properties><d:rowindex m:type="Edm.Int32">36</d:rowindex><d:Country>Nigeria (US Consulate G</d:Country><d:Avgagenonexpinv m:type="Edm.Int32">312</d:Avgagenonexpinv></m:properties></content></entry><entry><id>http://pandasodata.apphb.com/v1/Report1(37)</id><category term="OPandas.Report1rowtype" scheme="http://schemas.microsoft.com/ado/2007/08/dataservices/scheme" /><link rel="edit" title="Report1rowtype" href="Report1(37)" /><title /><updated>2013-01-03T08:23:39Z</updated><author><name /></author><content type="application/xml"><m:properties><d:rowindex m:type="Edm.Int32">37</d:rowindex><d:Country>Nigeria (US Embassy)</d:Country><d:Avgagenonexpinv m:type="Edm.Int32">208</d:Avgagenonexpinv></m:properties></content></entry><entry><id>http://pandasodata.apphb.com/v1/Report1(38)</id><category term="OPandas.Report1rowtype" scheme="http://schemas.microsoft.com/ado/2007/08/dataservices/scheme" /><link rel="edit" title="Report1rowtype" href="Report1(38)" /><title /><updated>2013-01-03T08:23:39Z</updated><author><name /></author><content type="application/xml"><m:properties><d:rowindex m:type="Edm.Int32">38</d:rowindex><d:Country>ome RIMC</d:Country><d:Avgagenonexpinv m:type="Edm.Int32">117</d:Avgagenonexpinv></m:properties></content></entry><entry><id>http://pandasodata.apphb.com/v1/Report1(39)</id><category term="OPandas.Report1rowtype" scheme="http://schemas.microsoft.com/ado/2007/08/dataservices/scheme" /><link rel="edit" title="Report1rowtype" href="Report1(39)" /><title /><updated>2013-01-03T08:23:39Z</updated><author><name /></author><content type="application/xml"><m:properties><d:rowindex m:type="Edm.Int32">39</d:rowindex><d:Country>Rep of Djibouti</d:Country><d:Avgagenonexpinv m:type="Edm.Int32">182</d:Avgagenonexpinv></m:properties></content></entry><entry><id>http://pandasodata.apphb.com/v1/Report1(40)</id><category term="OPandas.Report1rowtype" scheme="http://schemas.microsoft.com/ado/2007/08/dataservices/scheme" /><link rel="edit" title="Report1rowtype" href="Report1(40)" /><title /><updated>2013-01-03T08:23:39Z</updated><author><name /></author><content type="application/xml"><m:properties><d:rowindex m:type="Edm.Int32">40</d:rowindex><d:Country>Rep of Sout</d:Country><d:Avgagenonexpinv m:type="Edm.Int32">91</d:Avgagenonexpinv></m:properties></content></entry><entry><id>http://pandasodata.apphb.com/v1/Report1(41)</id><category term="OPandas.Report1rowtype" scheme="http://schemas.microsoft.com/ado/2007/08/dataservices/scheme" /><link rel="edit" title="Report1rowtype" href="Report1(41)" /><title /><updated>2013-01-03T08:23:39Z</updated><author><name /></author><content type="application/xml"><m:properties><d:rowindex m:type="Edm.Int32">41</d:rowindex><d:Country>Republic of Djibouti</d:Country><d:Avgagenonexpinv m:type="Edm.Int32">273</d:Avgagenonexpinv></m:properties></content></entry><entry><id>http://pandasodata.apphb.com/v1/Report1(42)</id><category term="OPandas.Report1rowtype" scheme="http://schemas.microsoft.com/ado/2007/08/dataservices/scheme" /><link rel="edit" title="Report1rowtype" href="Report1(42)" /><title /><updated>2013-01-03T08:23:39Z</updated><author><name /></author><content type="application/xml"><m:properties><d:rowindex m:type="Edm.Int32">42</d:rowindex><d:Country>Republic of Equitorial</d:Country><d:Avgagenonexpinv m:type="Edm.Int32">234</d:Avgagenonexpinv></m:properties></content></entry><entry><id>http://pandasodata.apphb.com/v1/Report1(43)</id><category term="OPandas.Report1rowtype" scheme="http://schemas.microsoft.com/ado/2007/08/dataservices/scheme" /><link rel="edit" title="Report1rowtype" href="Report1(43)" /><title /><updated>2013-01-03T08:23:39Z</updated><author><name /></author><content type="application/xml"><m:properties><d:rowindex m:type="Edm.Int32">43</d:rowindex><d:Country>Republic of Sout</d:Country><d:Avgagenonexpinv m:type="Edm.Int32">286</d:Avgagenonexpinv></m:properties></content></entry><entry><id>http://pandasodata.apphb.com/v1/Report1(44)</id><category term="OPandas.Report1rowtype" scheme="http://schemas.microsoft.com/ado/2007/08/dataservices/scheme" /><link rel="edit" title="Report1rowtype" href="Report1(44)" /><title /><updated>2013-01-03T08:23:39Z</updated><author><name /></author><content type="application/xml"><m:properties><d:rowindex m:type="Edm.Int32">44</d:rowindex><d:Country>Republic of South A</d:Country><d:Avgagenonexpinv m:type="Edm.Int32">429</d:Avgagenonexpinv></m:properties></content></entry><entry><id>http://pandasodata.apphb.com/v1/Report1(45)</id><category term="OPandas.Report1rowtype" scheme="http://schemas.microsoft.com/ado/2007/08/dataservices/scheme" /><link rel="edit" title="Report1rowtype" href="Report1(45)" /><title /><updated>2013-01-03T08:23:39Z</updated><author><name /></author><content type="application/xml"><m:properties><d:rowindex m:type="Edm.Int32">45</d:rowindex><d:Country>Republic of South Afri</d:Country><d:Avgagenonexpinv m:type="Edm.Int32">169</d:Avgagenonexpinv></m:properties></content></entry><entry><id>http://pandasodata.apphb.com/v1/Report1(46)</id><category term="OPandas.Report1rowtype" scheme="http://schemas.microsoft.com/ado/2007/08/dataservices/scheme" /><link rel="edit" title="Report1rowtype" href="Report1(46)" /><title /><updated>2013-01-03T08:23:39Z</updated><author><name /></author><content type="application/xml"><m:properties><d:rowindex m:type="Edm.Int32">46</d:rowindex><d:Country>retoria RIMC</d:Country><d:Avgagenonexpinv m:type="Edm.Int32">377</d:Avgagenonexpinv></m:properties></content></entry><entry><id>http://pandasodata.apphb.com/v1/Report1(47)</id><category term="OPandas.Report1rowtype" scheme="http://schemas.microsoft.com/ado/2007/08/dataservices/scheme" /><link rel="edit" title="Report1rowtype" href="Report1(47)" /><title /><updated>2013-01-03T08:23:39Z</updated><author><name /></author><content type="application/xml"><m:properties><d:rowindex m:type="Edm.Int32">47</d:rowindex><d:Country>Rwanda</d:Country><d:Avgagenonexpinv m:type="Edm.Int32">338</d:Avgagenonexpinv></m:properties></content></entry><entry><id>http://pandasodata.apphb.com/v1/Report1(48)</id><category term="OPandas.Report1rowtype" scheme="http://schemas.microsoft.com/ado/2007/08/dataservices/scheme" /><link rel="edit" title="Report1rowtype" href="Report1(48)" /><title /><updated>2013-01-03T08:23:39Z</updated><author><name /></author><content type="application/xml"><m:properties><d:rowindex m:type="Edm.Int32">48</d:rowindex><d:Country>Senegal</d:Country><d:Avgagenonexpinv m:type="Edm.Int32">429</d:Avgagenonexpinv></m:properties></content></entry><entry><id>http://pandasodata.apphb.com/v1/Report1(49)</id><category term="OPandas.Report1rowtype" scheme="http://schemas.microsoft.com/ado/2007/08/dataservices/scheme" /><link rel="edit" title="Report1rowtype" href="Report1(49)" /><title /><updated>2013-01-03T08:23:39Z</updated><author><name /></author><content type="application/xml"><m:properties><d:rowindex m:type="Edm.Int32">49</d:rowindex><d:Country>Seychelles</d:Country><d:Avgagenonexpinv m:type="Edm.Int32">299</d:Avgagenonexpinv></m:properties></content></entry><entry><id>http://pandasodata.apphb.com/v1/Report1(50)</id><category term="OPandas.Report1rowtype" scheme="http://schemas.microsoft.com/ado/2007/08/dataservices/scheme" /><link rel="edit" title="Report1rowtype" href="Report1(50)" /><title /><updated>2013-01-03T08:23:39Z</updated><author><name /></author><content type="application/xml"><m:properties><d:rowindex m:type="Edm.Int32">50</d:rowindex><d:Country>Sierra Leone</d:Country><d:Avgagenonexpinv m:type="Edm.Int32">325</d:Avgagenonexpinv></m:properties></content></entry><entry><id>http://pandasodata.apphb.com/v1/Report1(51)</id><category term="OPandas.Report1rowtype" scheme="http://schemas.microsoft.com/ado/2007/08/dataservices/scheme" /><link rel="edit" title="Report1rowtype" href="Report1(51)" /><title /><updated>2013-01-03T08:23:39Z</updated><author><name /></author><content type="application/xml"><m:properties><d:rowindex m:type="Edm.Int32">51</d:rowindex><d:Country>South Africa</d:Country><d:Avgagenonexpinv m:type="Edm.Int32">416</d:Avgagenonexpinv></m:properties></content></entry><entry><id>http://pandasodata.apphb.com/v1/Report1(52)</id><category term="OPandas.Report1rowtype" scheme="http://schemas.microsoft.com/ado/2007/08/dataservices/scheme" /><link rel="edit" title="Report1rowtype" href="Report1(52)" /><title /><updated>2013-01-03T08:23:39Z</updated><author><name /></author><content type="application/xml"><m:properties><d:rowindex m:type="Edm.Int32">52</d:rowindex><d:Country>Sudan</d:Country><d:Avgagenonexpinv m:type="Edm.Int32">533</d:Avgagenonexpinv></m:properties></content></entry><entry><id>http://pandasodata.apphb.com/v1/Report1(53)</id><category term="OPandas.Report1rowtype" scheme="http://schemas.microsoft.com/ado/2007/08/dataservices/scheme" /><link rel="edit" title="Report1rowtype" href="Report1(53)" /><title /><updated>2013-01-03T08:23:39Z</updated><author><name /></author><content type="application/xml"><m:properties><d:rowindex m:type="Edm.Int32">53</d:rowindex><d:Country>Swaziland</d:Country><d:Avgagenonexpinv m:type="Edm.Int32">364</d:Avgagenonexpinv></m:properties></content></entry><entry><id>http://pandasodata.apphb.com/v1/Report1(54)</id><category term="OPandas.Report1rowtype" scheme="http://schemas.microsoft.com/ado/2007/08/dataservices/scheme" /><link rel="edit" title="Report1rowtype" href="Report1(54)" /><title /><updated>2013-01-03T08:23:39Z</updated><author><name /></author><content type="application/xml"><m:properties><d:rowindex m:type="Edm.Int32">54</d:rowindex><d:Country>Tanzania</d:Country><d:Avgagenonexpinv m:type="Edm.Int32">390</d:Avgagenonexpinv></m:properties></content></entry><entry><id>http://pandasodata.apphb.com/v1/Report1(55)</id><category term="OPandas.Report1rowtype" scheme="http://schemas.microsoft.com/ado/2007/08/dataservices/scheme" /><link rel="edit" title="Report1rowtype" href="Report1(55)" /><title /><updated>2013-01-03T08:23:39Z</updated><author><name /></author><content type="application/xml"><m:properties><d:rowindex m:type="Edm.Int32">55</d:rowindex><d:Country>The Gambia</d:Country><d:Avgagenonexpinv m:type="Edm.Int32">455</d:Avgagenonexpinv></m:properties></content></entry><entry><id>http://pandasodata.apphb.com/v1/Report1(56)</id><category term="OPandas.Report1rowtype" scheme="http://schemas.microsoft.com/ado/2007/08/dataservices/scheme" /><link rel="edit" title="Report1rowtype" href="Report1(56)" /><title /><updated>2013-01-03T08:23:39Z</updated><author><name /></author><content type="application/xml"><m:properties><d:rowindex m:type="Edm.Int32">56</d:rowindex><d:Country>Togo</d:Country><d:Avgagenonexpinv m:type="Edm.Int32">416</d:Avgagenonexpinv></m:properties></content></entry><entry><id>http://pandasodata.apphb.com/v1/Report1(57)</id><category term="OPandas.Report1rowtype" scheme="http://schemas.microsoft.com/ado/2007/08/dataservices/scheme" /><link rel="edit" title="Report1rowtype" href="Report1(57)" /><title /><updated>2013-01-03T08:23:39Z</updated><author><name /></author><content type="application/xml"><m:properties><d:rowindex m:type="Edm.Int32">57</d:rowindex><d:Country>Uganda</d:Country><d:Avgagenonexpinv m:type="Edm.Int32">364</d:Avgagenonexpinv></m:properties></content></entry><entry><id>http://pandasodata.apphb.com/v1/Report1(58)</id><category term="OPandas.Report1rowtype" scheme="http://schemas.microsoft.com/ado/2007/08/dataservices/scheme" /><link rel="edit" title="Report1rowtype" href="Report1(58)" /><title /><updated>2013-01-03T08:23:39Z</updated><author><name /></author><content type="application/xml"><m:properties><d:rowindex m:type="Edm.Int32">58</d:rowindex><d:Country>Zambia</d:Country><d:Avgagenonexpinv m:type="Edm.Int32">442</d:Avgagenonexpinv></m:properties></content></entry><entry><id>http://pandasodata.apphb.com/v1/Report1(59)</id><category term="OPandas.Report1rowtype" scheme="http://schemas.microsoft.com/ado/2007/08/dataservices/scheme" /><link rel="edit" title="Report1rowtype" href="Report1(59)" /><title /><updated>2013-01-03T08:23:39Z</updated><author><name /></author><content type="application/xml"><m:properties><d:rowindex m:type="Edm.Int32">59</d:rowindex><d:Country>Zimbabwe</d:Country><d:Avgagenonexpinv m:type="Edm.Int32">130</d:Avgagenonexpinv></m:properties></content></entry><entry><id>http://pandasodata.apphb.com/v1/Report1(60)</id><category term="OPandas.Report1rowtype" scheme="http://schemas.microsoft.com/ado/2007/08/dataservices/scheme" /><link rel="edit" title="Report1rowtype" href="Report1(60)" /><title /><updated>2013-01-03T08:23:39Z</updated><author><name /></author><content type="application/xml"><m:properties><d:rowindex m:type="Edm.Int32">60</d:rowindex><d:Country>Zimbabwe (was Salisbur</d:Country><d:Avgagenonexpinv m:type="Edm.Int32">195</d:Avgagenonexpinv></m:properties></content></entry></feed>';
   BEGIN
      SELECT XMLSERIALIZE (
                CONTENT XMLROOT (
                           XMLELEMENT (
                              "feed",
                              XMLAttributes ('http://fraterno:8080/apex/odata_002_feed_entries.xml' AS "xml:base",
                                             'http://www.w3.org/2005/Atom' AS "xmlns",
                                             'http://schemas.microsoft.com/ado/2007/08/dataservices' AS "xmlns:d",
                                             'http://schemas.microsoft.com/ado/2007/08/dataservices/metadata' AS "xmlns:m"),
                              XMLELEMENT ("id", 'http://fraterno:8080/apex/odata_002_feed_entries.xml?reportID=' || reportId),
                              XMLELEMENT ("title", XMLAttributes ('text' AS "type"), 'Report' || reportId),
                              XMLELEMENT ("updated", '2013-01-03T08:23:39Z'),
                              XMLELEMENT (
                                 "link",
                                 XMLAttributes ('self' AS "rel",
                                                'Report' || reportId AS "title",
                                                '?reportId=' || reportId AS "href")),
                              XMLAGG (
                                 XMLELEMENT (
                                    "entry",
                                    XMLELEMENT (
                                       "id",
                                       'http://fraterno:8080/apex/odata_002_feed_entries.xml?reportID=' || reportId || '(1)'),
                                    XMLELEMENT (
                                       "category",
                                       XMLAttributes ('OPandas.Report1rowtype' AS "term",
                                                      'http://schemas.microsoft.com/ado/2007/08/dataservices/scheme' AS "scheme")),
                                    XMLELEMENT (
                                       "link",
                                       XMLAttributes ('edit' AS "rel",
                                                      'Report1rowtype' AS "title",
                                                      '?reportID=' || reportId || '(1)' AS "href")),
                                    XMLELEMENT ("title"),
                                    XMLELEMENT ("updated", '2013-01-03T08:23:39Z'),
                                    XMLELEMENT ("author", XMLELEMENT ("name")),
                                    XMLELEMENT (
                                       "content",
                                       XMLAttributes ('application/xml' AS "type"),
                                       XMLELEMENT (
                                          "m:properties",
                                          XMLELEMENT ("d:rowindex", XMLAttributes ('Edm.Int32' AS "m:type"), ROWNUM),
                                          XMLELEMENT ("d:nuhsa", NUHSA),
                                          XMLELEMENT ("d:tarea", XMLAttributes ('Edm.Int32' AS "m:type"), SUBID_TAREA_CITA)))))),
                           VERSION '1.0" encoding="UTF-8'))
        INTO t_content
        FROM MSTR_DET_CITAS_CITAWEB
       WHERE                                                                                          --OBSERVACIONES_CITA IS NULL
             --AND
             ROWNUM < 50;

      --t_content := MY_PACKAGE.F_APEX_GANTT_COMPLETE (P_USER);

      --DBMS_LOB.open (t_content, DBMS_LOB.lob_readonly);

      P_LENGTH := DBMS_LOB.getlength (t_content);

      IF C_DEBUG
      THEN
         HTP.p (P_LENGTH);
      ELSE
         WHILE P_LENGTH > 0
         LOOP
            /* Read 32000 characters from CLOB */
            --            DBMS_LOB.read (lob_loc   => t_content,
            --                           amount    => P_CLOB_BUFFER,
            --                           offset    => P_POS,
            --                           buffer    => P_SET);

            --            /* Write code in APEX */
            --            HTP.p (P_SET);
            HTP.p (P_POS);

            /* Increase Counter */
            P_POS := P_POS + P_CLOB_BUFFER;
            P_LOOP := P_LOOP + 1;

            /* Resize CLOB length */
            P_LENGTH := P_LENGTH - P_CLOB_BUFFER;
         END LOOP;
      END IF;
   --      DBMS_LOB.close (t_content);

   --      ts_now := SYSTIMESTAMP;
   --
   --      INSERT INTO ODATA_001_LOG_REQUESTS (TS, RESPONSE)
   --           VALUES (ts_now, t_content);
   --
   --      COMMIT;
   --
   --OWA_UTIL.mime_header ('application/atom+xml;type=feed;charset=utf-8', FALSE);
   --OWA_UTIL.http_header_close;
   --         OWA_UTIL.mime_header ('application/xml; charset=utf-8', FALSE);

   --IF reportID = 3
   --THEN
   --OWA_UTIL.mime_header ('application/xml; charset=utf-8', FALSE);
   --HTP.p ('Content-Length: ' || DBMS_LOB.GETLENGTH (t_content));
   --OWA_UTIL.http_header_close;
   --WPG_DOCLOAD.download_file (t_content);
   --HTP.p (DBMS_LOB.getlength (t_content));
   --Create a tempory LOB to place our xml in
   --DBMS_LOB.CREATETEMPORARY (lob_loc => l_clob, cache => FALSE, dur => DBMS_LOB.session);
   --OWA_UTIL.mime_header ('application/atom+xml;type=feed;charset=utf-8', FALSE);
   --HTP.p ('Cache-Control: no-cache');
   --HTP.p ('Content-Length: ' || DBMS_LOB.GETLENGTH (t_content));
   --HTP.p ('Pragma: no-cache');
   --OWA_UTIL.http_header_close ();
   /*
            LOOP
               v_text_buffer := DBMS_LOB.SUBSTR (t_content, v_text_amt, v_text_pos);
               EXIT WHEN v_text_buffer IS NULL;
               -- process the text and prepare to read again
               HTP.p (v_text_buffer);
               v_text_pos := v_text_pos + v_text_amt;
            END LOOP;
   */
   --Kill the temporary LOB
   --   DBMS_LOB.FREETEMPORARY(lob_loc => l_clob);

   --      HTP.p (t_content);
   --            t_clob := UTL_COMPRESS.lz_compress (UTL_RAW.cast_to_raw (t_content));
   --            HTP.p ('Content-Encoding: gzip');
   --            HTP.p ('Content-Length: ' || DBMS_LOB.GETLENGTH (t_clob));
   --            OWA_UTIL.http_header_close;
   --            WPG_DOCLOAD.download_file (t_clob);
   --HTP.p (t_content.getstringval());
   --         SELECT  (response)
   --           INTO p_content
   --           FROM ODATA_001_LOG_REQUESTS
   --          WHERE ts = ts_now;

   --WPG_DOCLOAD.download_file (t_content.getclobval());
   --      ELSE
   --         HTP.p (p_content);
   --END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         error_handler.jsp (SQLERRM, DBMS_UTILITY.format_error_backtrace);
         DBMS_APPLICATION_INFO.set_module ('odata_002_feed_entries', NULL);
   END;
END;
/