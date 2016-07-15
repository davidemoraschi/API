/* Formatted on 15/12/2013 13:14:40 (QP5 v5.163.1008.3004) */
SELECT SUBSTR ('https://pandas.sharepoint.com/sites/development',
               1,
               INSTR ('https://pandas.sharepoint.com/sites/development',
                      '/',
                      1,
                      3)
               - 1)
       || '/sites/development/SiteAssets/2.gif'
          IMG
  FROM DUAL;
  
select utl_http.request ('https://app.healthcare.bi/token?authority=io', null,  'file:/u01/app/oracle/wallet',  'Lepanto1571') from dual;

select utl_http.request ('http://app.healthcare.bi/token?authority=io', null,  'file:/u01/app/oracle/wallet',  'Lepanto1571') from dual;