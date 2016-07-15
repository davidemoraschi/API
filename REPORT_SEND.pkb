CREATE OR REPLACE PACKAGE BODY MSTR.REPORT_SEND
AS
   PROCEDURE png (p_varchar_1 IN VARCHAR2 DEFAULT '1200A5684D156325A83AFBB158EB72FE')
   IS
      const_host_port   CONSTANT VARCHAR2 (1024) := 'http://eurostrategy.net:8080';
      v_sessionState    VARCHAR2 (4000)
                           := HTTPURITYPE.
                              createuri (
                                 const_host_port
                                 || '/MicroStrategy/servlet/taskProc?taskId=login&taskEnv=xml&taskContentType=xml&server=IP-10-34-95-214&project=INyDIA&userid=atorres&password=Amazon').
                              getxml ().EXTRACT ('taskResponse/root/sessionState/text()').getstringval ();
      v_msg_id          VARCHAR2 (1000)
                           := HTTPURITYPE.
                              createuri (
                                 const_host_port
                                 || '/MicroStrategy/servlet/taskProc?taskId=reportExecute&taskEnv=xml&taskContentType=xml&sessionState='
                                 || UTL_URL.escape (v_sessionState)
                                 || '&reportViewMode=2&reportID='
                                 || p_varchar_1).getxml ().EXTRACT ('taskResponse/msg/id/text()').getstringval ();
      v_image_clob      CLOB
                           := 
                                 HTTPURITYPE.
                                 createuri (
                                    const_host_port
                                    || '/MicroStrategy/servlet/taskProc?taskId=getReportGraphImage&taskEnv=xml&taskContentType=xml&sessionState='
                                    || UTL_URL.escape (v_sessionState)
                                    || '&messageID='
                                    || v_msg_id
                                    || '&width=500&height=300&imgType=2&availWidth=550&availHeight=350').getxml ().
                                 EXTRACT ('taskResponse/root/ib/eb/text()').getclobval ();
   BEGIN
      --OWA_UTIL.mime_header ('image/png', FALSE, NULL);
      --HTP.p ('<HR />Content-length: ' || DBMS_LOB.GETLENGTH (v_image_blob));
      --OWA_UTIL.http_header_close;
      --WPG_DOCLOAD.download_file (v_image_blob);
      /*
      p_Sender      IN VARCHAR2,
                  p_Recipient   IN VARCHAR2,
                  p_Subject     IN VARCHAR2,
                  p_Html_Body   IN CLOB
                  */
      AWS_SES.SENDMAIL.PHP(p_Sender => 'dmoraschi@gmail.com', p_Recipient => 'dmoraschi@gmail.com', p_Subject => 'test', p_Html_Body => 'To: dmoraschi@gmail.com
Subject: Mail Sending Options Test2
From: Davide Moraschi <dmoraschi@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="simple boundary 1"

--simple boundary 1
Content-Type: multipart/related; boundary="simple boundary 2"

--simple boundary 2
Content-Type: multipart/alternative; boundary="simple boundary 3"

--simple boundary 3
Content-Type: text/plain

Text without inline reference
--simple boundary 3
Content-Type: text/html

<h1>Text with inline reference</h1>
<img src="cid:Inline.png" />
--simple boundary 3--
--simple boundary 2
Content-Type: image/png; name="inline.PNG"
Content-Transfer-Encoding: base64
Content-ID: <6583CF49B56F42FEA6A4A118F46F96FB@example.com>
Content-Disposition: inline; filename="Inline.png"

'
||v_image_clob
||'
--simple boundary 2--

--simple boundary 1
Content-Type: image/png; name=" Attachment "
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="Attachment.png"

...Attachment data encoded with base64...
--simple boundary 1--');
      v_sessionState :=
         HTTPURITYPE.
         createuri (
               const_host_port
            || '/MicroStrategy/servlet/taskProc?taskId=logout&taskEnv=xml&taskContentType=xml&sessionState='
            || UTL_URL.escape (v_sessionState)).getxml ().EXTRACT ('taskResponse/text()').getstringval ();
   EXCEPTION
      WHEN OTHERS
      THEN
         error_handler.jsp (SQLERRM, DBMS_UTILITY.format_error_backtrace);
   END;

   PROCEDURE htm
   IS
   BEGIN
      HTP.p ('ok');
   END;
END;
/
