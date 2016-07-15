CREATE OR REPLACE PACKAGE BODY MSTR.home
IS
   PROCEDURE aspx (SPHostUrl IN VARCHAR2 DEFAULT NULL, SPLanguage IN VARCHAR2 DEFAULT NULL, SPClientTag IN VARCHAR2 DEFAULT NULL
     ,SPProductNumber IN VARCHAR2 DEFAULT NULL, SPAppWebUrl IN VARCHAR2 DEFAULT NULL, SPAppToken IN VARCHAR2 DEFAULT NULL
     ,SPSiteUrl IN VARCHAR2 DEFAULT NULL, SPSiteTitle IN VARCHAR2 DEFAULT NULL, SPSiteLogoUrl IN VARCHAR2 DEFAULT NULL
     ,SPSiteLanguage IN VARCHAR2 DEFAULT NULL, SPSiteCulture IN VARCHAR2 DEFAULT NULL, SPRedirectMessage IN VARCHAR2 DEFAULT NULL
     ,SPCorrelationId IN VARCHAR2 DEFAULT NULL, SPErrorCorrelationId IN VARCHAR2 DEFAULT NULL
     ,SPErrorInfo IN VARCHAR2 DEFAULT NULL)
   IS
      l_http_request UTL_HTTP.req;
      l_http_response UTL_HTTP.resp;
      p_content      CLOB;
      v_clob_chunk   VARCHAR2 (32000);
      l_text         VARCHAR2 (32767);
      h_name         VARCHAR2 (255);
      h_value        VARCHAR2 (1023);
      json_context_token json;
   BEGIN
      HTP.P ('<!DOCTYPE html><html lang="en" xmlns="http://www.w3.org/1999/xhtml"><head><title>' || SPSiteTitle || '</title>');
      HTP.p ('<script src="//ajax.aspnetcdn.com/ajax/4.0/1/MicrosoftAjax.js" type="text/javascript"></script>');
      HTP.p ('<script type="text/javascript" src="//ajax.aspnetcdn.com/ajax/jQuery/jquery-1.7.2.min.js"></script>');
      HTP.p ('<script type="text/javascript" src="ChromeLoader.js"></script>');
      HTP.p (
            '<script type="text/javascript">
                    "use strict";

                    var hostweburl;

                    //load the SharePoint resources
                    $(document).ready(function () {
                    //ExecuteOrDelayUntilScriptLoaded(setFullScreenMode, "core.js");
                        //Get the URI decoded URL.
                        hostweburl =
                            decodeURIComponent(
                                getQueryStringParameter("SPHostUrl")
                        );
                        //alert(getQueryStringParameter("SPSiteLogoUrl"));

                        // The SharePoint js files URL are in the form:
                        // web_url/_layouts/15/resource
                        var scriptbase = hostweburl + "/_layouts/15/";

                        // Load the js file and continue to the 
                        //   success handler
                        $.getScript(scriptbase + "SP.UI.Controls.js", renderChrome)
                        //$.getScript(scriptbase + "core.js", setFullScreenMode)
                    });
                        // Hides the title and navigation
                        function setFullScreenMode() 
                        {
                            SetFullScreenMode(true);
                            $(''#siteactiontd'').hide();
                            PreventDefaultNavigation();
                            $(''#fullscreenmodebox'').hide();
                            $(''#globalNavBox'').hide();
                            return false;
                        }
                        
                    // Callback for the onCssLoaded event defined
                    //  in the options object of the chrome control
                    function chromeLoaded() {
                        // When the page has loaded the required
                        //  resources for the chrome control,
                        //  display the page body.
                        $("body").show();
                    }

                    //Function to prepare the options and render the control
                    function renderChrome() {
                        // The Help, Account and Contact pages receive the 
                        //   same query string parameters as the main page
                        var options = {
                            "appIconUrl": "'
         || SUBSTR (SPHostUrl, 1, INSTR (SPHostUrl, '/', 1, 3) - 1)
         || SPSiteLogoUrl
         || '", "appTitle": "EuroStrategy",
                            "appHelpPageUrl": "Help.html?"
                                + document.URL.split("?")[1],
                            // The onCssLoaded event allows you to 
                            //  specify a callback to execute when the
                            //  chrome resources have been loaded.
                            "onCssLoaded": "chromeLoaded()",
                            "settingsLinks": [
                                {
                                    "linkUrl": "Account.html?"
                                        + document.URL.split("?")[1],
                                    "displayName": "Account settings"
                                },
                                {
                                    "linkUrl": "Contact.html?"
                                        + document.URL.split("?")[1],
                                    "displayName": "Contact us"
                                }
                            ]
                        };

                        var nav = new SP.UI.Controls.Navigation(
                                                "chrome_ctrl_placeholder",
                                                options
                                            );
                        nav.setVisible(true);
                    }

                    // Function to retrieve a query string value.
                    // For production purposes you may want to use
                    //  a library to handle the query string.
                    function getQueryStringParameter(paramToRetrieve) {
                        var params =
                            document.URL.split("?")[1].split("&");
                        var strParams = "";
                        for (var i = 0; i < params.length; i = i + 1) {
                            var singleParam = params[i].split("=");
                            if (singleParam[0] == paramToRetrieve)
                                return singleParam[1];
                        }
                    }
                    </script>');

      --      HTP.p (
      --         '<link rel="stylesheet" href="https://metroui.org.ua/css/metro-bootstrap.css"></script><script src="https://metroui.org.ua/js/jquery/jquery.widget.min.js"></script>');
      HTP.p ('</head>');
      HTP.p ('<body style="display: none; margin: 0; padding: 0; height: 100%; overflow: hidden;">
                        <!-- Chrome control placeholder -->
                        <div id="chrome_ctrl_placeholder"></div>
                        <!-- The chrome control also makes the SharePoint
                              Website stylesheet available to your page -->
                        <h1 class="ms-accentText">Context token</h1>
                        <div id="MainContent">
                        </div>');
      HTP.p ('<ul>');
      --      HTP.p ('<li>SPHostUrl: ' || SPHostUrl || '</li>');
      --      HTP.p ('<li>SPLanguage: ' || SPLanguage || '</li>');
      --      HTP.p ('<li>SPClientTag: ' || SPClientTag || '</li>');
      --      HTP.p ('<li>SPProductNumber: ' || SPProductNumber || '</li>');
      --      HTP.p ('<li>SPAppWebUrl: ' || SPAppWebUrl || '</li>');
      HTP.p ('<li> ' || SPAppToken || '</li>');
      --      HTP.p ('<li>SSPSiteUrl: ' || SPSiteUrl || '</li>');
      --      HTP.p ('<li>SPSiteTitle: ' || SPSiteTitle || '</li>');
      --      HTP.p ('<li>SPSiteLogoUrl: ' || SPSiteLogoUrl || '</li>');
      --      HTP.p ('<li>SPSiteLanguage: ' || SPSiteLanguage || '</li>');
      --      HTP.p ('<li>SPSiteCulture: ' || SPSiteCulture || '</li>');
      --      HTP.p ('<li>SPRedirectMessage: ' || SPRedirectMessage || '</li>');
      --      HTP.p ('<li>SPCorrelationId: ' || SPCorrelationId || '</li>');
      --      HTP.p ('<li>SPErrorCorrelationId: ' || SPErrorCorrelationId || '</li>');
      --      HTP.p ('<li>SPErrorInfo: ' || SPErrorInfo || '</li>');
      HTP.p ('</ul><h1 class="ms-accentText">Access Token</h1>');
      l_http_request :=
         UTL_HTTP.BEGIN_REQUEST (url => const_eurostrategy_url || '&sharepointUrl=' || get_base_domain (SPHostUrl)
        ,method => const_eurostrategy_method, http_version => const_eurostrategy_protocol);
      UTL_HTTP.SET_HEADER (r => l_http_request, name => 'Content-Type', VALUE => 'application/json');
      UTL_HTTP.SET_HEADER (r => l_http_request, name => 'Content-Length', VALUE => LENGTH ('"' || SPAppToken || '"'));
      UTL_HTTP.WRITE_TEXT (r => l_http_request, data => '"' || SPAppToken || '"');
      l_http_response := UTL_HTTP.GET_RESPONSE (l_http_request);

      HTP.p ('<ul>');
      --            FOR i IN 1 .. UTL_HTTP.get_header_count (l_http_response)
      --            LOOP
      --               UTL_HTTP.get_header (l_http_response,
      --                                    i,
      --                                    h_name,
      --                                    h_value);
      --               HTP.p ('<li>' || h_name || ': ' || h_value || '</li>');
      --            END LOOP;
      UTL_HTTP.READ_LINE (r => l_http_response, data => l_text, remove_crlf => FALSE);
      HTP.p ('<li>' || REPLACE (l_text, '"', '') || '</li>');
      HTP.p ('</ul>');

      -- DBMS_LOB.createtemporary (p_content, FALSE);

      --      BEGIN
      --         LOOP
      /*
     json_context_token := json (l_text);
     --HTP.p('Refresh token: ');
     --         END LOOP;
     --      EXCEPTION
     --         WHEN UTL_HTTP.end_of_body
     --         THEN
     UTL_HTTP.end_response (l_http_response);
     --      END;
     HTP.p ('<ul>');
     HTP.p ('<li>TargetPrincipalName: ');
     json_ext.pp_htp (json_context_token, 'TargetPrincipalName');
     HTP.p ('</li>');
     HTP.p ('<li>RefreshToken: ');
     json_ext.pp_htp (json_context_token, 'RefreshToken');
     HTP.p ('</li>');
     HTP.p ('<li>CacheKey: ');
     json_ext.pp_htp (json_context_token, 'CacheKey');
     HTP.p ('</li>');
     HTP.p ('<li>SecurityTokenServiceUri: ');
     json_ext.pp_htp (json_context_token, 'SecurityTokenServiceUri');
     HTP.p ('</li>');
     HTP.p ('<li>Realm: ');
     json_ext.pp_htp (json_context_token, 'Realm');
     HTP.p ('</li>');
     HTP.p ('<li>Audience: ');
     json_ext.pp_htp (json_context_token, 'Audience');
     HTP.p ('</li>');
     HTP.p ('</ul><h1 class="ms-accentText">Sending request</h1>');
     HTP.p(json_ext.get_string(json_context_token,'TargetPrincipalName') || '/' || get_base_domain(SPHostUrl) || SUBSTR (json_ext.get_string(json_context_token,'Audience'), INSTR (json_ext.get_string(json_context_token,'Audience'), '@')));
     */
      --HTP.p (SPHostUrl || '/_api/Web/currentUser');
      UTL_HTTP.set_wallet (PATH => con_str_wallet_path, PASSWORD => con_str_wallet_pass);
      l_http_request :=
         UTL_HTTP.BEGIN_REQUEST (url => SPHostUrl || '/_api/Web/currentUser', method => 'GET'
        ,http_version => const_eurostrategy_protocol);
      UTL_HTTP.SET_HEADER (r => l_http_request, name => 'Accept', VALUE => 'application/json;odata=verbose');
      --application/json;odata=light;q=1,application/json;odata=verbose;q=0.5
      --UTL_HTTP.SET_HEADER (r => l_http_request, name => 'MaxDataServiceVersion', VALUE => '3.0');
      -- UTL_HTTP.SET_HEADER (r => l_http_request, name => 'Accept', VALUE => 'application/json;odata=light;q=1,application/json;odata=verbose;q=0.5');
      UTL_HTTP.SET_HEADER (r => l_http_request, name => 'Authorization', VALUE => 'Bearer ' || REPLACE (l_text, '"', ''));
      --"Authorization", "Bearer " + accessToken headers: { "accept": "application/json;odata=verbose" }
      --UTL_HTTP.WRITE_TEXT (r => l_http_request, data => '"' || SPAppToken || '"');
      l_http_response := UTL_HTTP.GET_RESPONSE (l_http_request);
      UTL_HTTP.READ_LINE (r => l_http_response, data => l_text, remove_crlf => FALSE);
      HTP.p ('<pre><code>' || l_text || '</pre></code>');
      HTP.p ('</body></html>');
   /* Log the token into a table*/
   --      BEGIN
   --      INSERT INTO OAUTH_SHAREPOINT_TOKENS
   --      VALUES (json_ext.get_string(json_context_token,'RefreshToken'),
   --        SYSTIMESTAMP, json_ext.get_string(json_context_token,'CacheKey'),
   --        json_ext.get_string(json_context_token,'SecurityTokenServiceUri'),
   --        json_ext.get_string(json_context_token,'TargetPrincipalName'),
   --        json_ext.get_string(json_context_token,'Realm'),
   --        json_ext.get_string(json_context_token,'Audience'));
   --      EXCEPTION
   --      WHEN DUP_VAL_ON_INDEX THEN
   --        UPDATE OAUTH_SHAREPOINT_TOKENS SET RefreshToken = json_ext.get_string(json_context_token,'RefreshToken'), TS = SYSTIMESTAMP,
   --        SecurityTokenServiceUri = json_ext.get_string(json_context_token,'SecurityTokenServiceUri'), TargetPrincipalName = json_ext.get_string(json_context_token,'TargetPrincipalName'),
   --        Realm = json_ext.get_string(json_context_token,'Realm'), Audience = json_ext.get_string(json_context_token,'Audience');
   --      END;


   EXCEPTION
      WHEN OTHERS
      THEN
         error_handler.jsp (SQLERRM, DBMS_UTILITY.format_error_backtrace);
   -- DBMS_APPLICATION_INFO.set_module ('odata_001_service_workspace', NULL);
   END aspx;

   FUNCTION get_base_domain (SPHostUrl IN VARCHAR2)
      RETURN VARCHAR2
   IS
   BEGIN
      RETURN SUBSTR (SPHostUrl, INSTR (SPHostUrl, '//') + 2, INSTR (SPHostUrl, '/', 1, 3) - INSTR (SPHostUrl, '//') - 2);
   END get_base_domain;
END home;
/

