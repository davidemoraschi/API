CREATE OR REPLACE PACKAGE BODY MSTR.home IS
	PROCEDURE aspx (SPHostUrl IN VARCHAR2 DEFAULT NULL,
									SPLanguage IN VARCHAR2 DEFAULT NULL,
									SPClientTag IN VARCHAR2 DEFAULT NULL,
									SPProductNumber IN VARCHAR2 DEFAULT NULL,
									SPAppWebUrl IN VARCHAR2 DEFAULT NULL,
									SPAppToken IN VARCHAR2 DEFAULT NULL,
									SPSiteUrl IN VARCHAR2 DEFAULT NULL,
									SPSiteTitle IN VARCHAR2 DEFAULT NULL,
									SPSiteLogoUrl IN VARCHAR2 DEFAULT NULL,
									SPSiteLanguage IN VARCHAR2 DEFAULT NULL,
									SPSiteCulture IN VARCHAR2 DEFAULT NULL,
									SPRedirectMessage IN VARCHAR2 DEFAULT NULL,
									SPCorrelationId IN VARCHAR2 DEFAULT NULL,
									SPErrorCorrelationId IN VARCHAR2 DEFAULT NULL,
									SPErrorInfo IN VARCHAR2 DEFAULT NULL) IS
	BEGIN
        HTP.P ('<!DOCTYPE html><html lang="en" xmlns="http://www.w3.org/1999/xhtml"><head><title>'||SPSiteTitle||'</title>');
        HTP.p ('<script src="//ajax.aspnetcdn.com/ajax/4.0/1/MicrosoftAjax.js" type="text/javascript"></script>');
        HTP.p ('<script type="text/javascript" src="//ajax.aspnetcdn.com/ajax/jQuery/jquery-1.7.2.min.js"></script>');
        HTP.p ('<script type="text/javascript" src="ChromeLoader.js"></script>');
        htp.p('<script type="text/javascript">
                    "use strict";

                    var hostweburl;

                    //load the SharePoint resources
                    $(document).ready(function () {
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
                    });

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
                            "appIconUrl": "'||SPSiteLogoUrl||'", //"https://eurostrategy.net/MicroStrategy/plugins/_Interface/style/images/logo_small.png", //decodeURIComponent(getQueryStringParameter("SPSiteLogoUrl")),
                            "appTitle": "PANDAStrategy",
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

        --                HTP.p (
        --     '<link rel="stylesheet" href="http://metroui.org.ua/css/metro-bootstrap.css"><script src="http://metroui.org.ua/js/jquery/jquery.min.js"></script><script src="http://metroui.org.ua/js/jquery/jquery.widget.min.js"></script>');
        HTP.p ('</head>');
        HTP.p('<body style="display: none; margin: 0; padding: 0; height: 100%; overflow: hidden;">
            <!-- Chrome control placeholder -->
            <div id="chrome_ctrl_placeholder"></div>
            <!-- The chrome control also makes the SharePoint
                  Website stylesheet available to your page -->
            <h1 class="ms-accentText">Passed arguments</h1>
            <div id="MainContent">
            </div>');
		HTP.p ('<ul>');
        HTP.p ('<li>SPHostUrl: ' || SPHostUrl ||'</li>');
        HTP.p ('<li>SPLanguage: ' || SPLanguage ||'</li>');
        HTP.p ('<li>SPClientTag: ' || SPClientTag ||'</li>');
        HTP.p ('<li>SPProductNumber: ' || SPProductNumber ||'</li>');
        HTP.p ('<li>SPAppWebUrl: ' || SPAppWebUrl ||'</li>');
        HTP.p ('<li>SPAppToken: ' || SPAppToken ||'</li>');
		HTP.p ('<li>SSPSiteUrl: ' || SPSiteUrl ||'</li>');
		HTP.p ('<li>SPSiteTitle: ' || SPSiteTitle ||'</li>');
		HTP.p ('<li>SPSiteLogoUrl: ' || SPSiteLogoUrl ||'</li>');
		HTP.p ('<li>SPSiteLanguage: ' || SPSiteLanguage ||'</li>');
		HTP.p ('<li>SPSiteCulture: ' || SPSiteCulture ||'</li>');
		HTP.p ('<li>SPRedirectMessage: ' || SPRedirectMessage ||'</li>');
        HTP.p ('<li>SPCorrelationId: ' || SPCorrelationId ||'</li>');
		HTP.p ('<li>SPErrorCorrelationId: ' || SPErrorCorrelationId ||'</li>');
        HTP.p ('<li>SPErrorInfo: ' || SPErrorInfo ||'</li>');
		-- OWA_UTIL.PRINT_CGI_ENV;
		HTP.p ('</ul></body></html>');
	END aspx;
END home;
/

