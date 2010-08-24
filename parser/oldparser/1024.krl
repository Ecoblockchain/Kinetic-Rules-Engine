{"global":[{"content":"#spotlight-reminders-wrapper{\n\theight:24px;\n\tbackground:#e4effd;\n\tpadding:0 0 0 9px;\n\tmargin:15px 0;\n\tfont-size:small;\n}\n\n.remindme-reminders-wrapper{\n\theight:24px;\n\tbackground:white;\n\tpadding:0;\n\tmargin:0;\n\tfont-size:small;\n\twidth:450px;\n}\n\np.descriptive-text{\n\tfloat:right;\n\tmargin:4px 9px 0 0;\n\tpadding:0;\n\tcolor:#7a7a7a;\n\tfont-size:small;\n}\n\nul.spotlightReminders{\n\tfloat:left;\n\tmargin:0;\n\tpadding:0;\n\tlist-style:none;\n\theight:24px;\n}\n\nul.spotlightReminders li{\n\tdisplay:block;\n\tfloat:left !important;\n\tmargin:3px 3px 0 0;\n}\n\nul.spotlightReminders li.azigo-logo{\n\tmargin:4px 0 0 0;\n}\n\nul.spotlightReminders li.txt-reminder{\n\tpadding:0 0 0 4px;\n\tmargin:4px 3px 0 0;\n\tcolor:#2b30d1;\n}\n\n.clear{\n\tclear:both;\n}       \n\n.remindme-flyout-wrapper{\n\tborder: 3px solid #e471ac;\n\twidth:450px;\n\tmargin:0 0 0 20px;\n\tposition: absolute;\n        background-color: white;\n\tdisplay: none;\n\tz-index: 1;\n\ttext-align:left;\n}\n\n.flyout-pointer{\n\tbackground:url(\"http://www.azigo.com/images/rm/FlyoutPoint.png\") no-repeat;\n\theight:11px;\n\twidth:15px;\n\tposition:relative;\n\tmargin:-11px 0 0 20px;\n}\n\n.flyout-reminder-details{\n\tpadding:8px 10px;\n\tborder-bottom:1px solid #c2c2c2;\n        color: black;\n\tfloat: left;\n}\n\np.flyout-reminder-url{\n\tmargin:0 0 5px 0;\n\tpadding:0;\n}\n\n.flyout-reminder-details ul{\n\tmargin:0;\n\tpadding:0;\n\tlist-style:none;\n\tline-height:14px;\n}\n\n.flyout-reminder-details ul li{\n\tdisplay:block;\n\tfloat:left !important;\n\tmargin:0 4px 0 0;\n\tpadding:0;\n}\n\n.flyout-reminder-details ul li.flyout-reminder-url{\n\tmargin:0 0 5px 0;\n\tpadding:0;\n\twidth:250px;\n}\n\n.flyout-reminder-details ul li.flyout-reminder-text{\n\twidth:230px;\n}\n\n.flyout-reminder-details ul li.flyout-reminder-button{\n\tmargin:0;\n}\n\na.flyout-reminder-button{\n\tdisplay:block;\n\tfont-size:10px;\n\tfont-weight:bold;\n\tfont-family:Verdana, sans-serif, Arial, Helvetica;\n\tbackground:#57b6e3;\n\ttext-align:center;\n\ttext-decoration:none;\n\theight:16px;\n\twidth:96px;\n\tcolor:#fff;\n\tpadding:2px 0 0 0;\n\tmargin:0;\n}\n\n\n.clearfix:after {\n    content: \".\";\n    display: block;\n    clear: both;\n    visibility: hidden;\n    line-height: 0;\n    height: 0;\n}\n\n.clearfix {\n    display: inline-block;\n}\n\nhtml[xmlns] .clearfix {\n    display: block;\n}\n\n* html .clearfix {\n    height: 1%;\n}   \n\n.flyout-wrapper{\n\tborder: 3px solid #e471ac;\n\twidth:450px;\n\tmargin:-15px 0 0 29px;\n\tposition: absolute;\n        background-color: white;\n\tdisplay: none;\n\tz-index: 1;\n}\n\n\n\n.flyout-reminder-details{\n\tpadding:8px 10px;\n\tborder-bottom:1px solid #c2c2c2;\n\tfont-size: small;\n        width:430px;\n}\n","type":"css"},{"emit":"var globalData = {\n                                \"Source\" : \"ebates\",\n\t\t\t\t\"RemindMeIconUrl\" : \"http://www.azigo.com/images/rm/crd/ebates_18x24.png\",\n                                \"FlyoutIconUrl\" : \"http://www.azigo.com/images/rm/crd/ebates_60x90.png\"\n\t\t\t };\n\n\tfunction remindMeSelector(obj) {\n                var annotationContent;\n\t\tvar remindMeDomain = obj.domain.replace(/http:\\/\\/([A-Za-z0-9.-]+)\\/.*/,\"$1\");\n        \tremindMeDomain = remindMeDomain.replace(\"http://\",\"\");\n\t\tremindMeDomain = remindMeDomain.replace(\"www.\",\"\");\n\t\tremindMeDomain = remindMeDomain.replace(\"www1.\",\"\");\n\t\tremindMeDomain = remindMeDomain.replace(/\\./, \"\");\n\t\tremindMeDomain = remindMeDomain.replace(/\\.[^.]+$/,\"\");\n                remindMeDomain = remindMeDomain.replace(/[&]/g,\"and\");\n                remindMeDomain = remindMeDomain.replace(/\\s+/g,\"\");\n\t\tremindMeDomain = remindMeDomain.replace(/[']/g,\"\");\n\t\tremindMeDomain = remindMeDomain.replace(/[-]/g,\"\");\n                remindMeDomain = remindMeDomain.toLowerCase();\n\n                var remindMeDivId = \"remindMe_\"+remindMeDomain;\n                var remindMeFlyoutDivId = \"remindMeFlyout_\"+remindMeDomain;\n\t\tvar remindMeWrapper = \"remindMeWrapper_\"+remindMeDomain;\n\n\t\tif($K(\"#\"+remindMeDivId).length == 0) {\n\t\t   var remindMeMainDiv = createRemindMeDiv(remindMeDivId);\n                   var remindMeFlyoutDiv = createRemindMeFlyoutDiv(remindMeFlyoutDivId);\n\n\t\t   remindMeFlyoutDiv.append(\n\t\t\tgetFlyoutDetails(\n                                                 obj.name,\n                                                 obj.link, \n                                                 globalData.FlyoutIconUrl, \n                                                 obj.text, \n                                                 obj.icon\n                                          )\n\t\t   );\n\n \t           var remindMeDiv = $K(\"<div></div>\");\n\n                   var wrapperDiv = $K(\"<div id='\"+remindMeWrapper+\"' class='remindme-reminders-wrapper'></div>\");\n\t\t   wrapperDiv.append(remindMeMainDiv);\n\n\t\t   remindMeDiv.append(wrapperDiv);\n\n\t           remindMeDiv.append(remindMeFlyoutDiv);\n\n                   annotationContent = remindMeDiv;\n                   registerEvents(remindMeDivId, remindMeFlyoutDivId, false);\n                }\n                else { \n                   if($K(\"#\"+remindMeDivId).find(\"#img_\"+globalData.Source+\"_remindMe\").length) {\n                        return false;\n                   }\n\n\t\t   if($K(\"#\"+remindMeDivId).children(\".txt-reminder\").length) {\n                      $K(\"#\"+remindMeDivId).children(\".txt-reminder\").after(\n                                              makeListItem(\n\t\t                                    null, \n\t\t                                    null, \n\t\t                                    $K(\"<img id='img_\"+globalData.Source+\"_remindMe' src='\"+globalData.RemindMeIconUrl+\"' />\")\n\t\t                              )\n                      );\n                   }\n\n\t\t   if($K(\"#\"+remindMeFlyoutDivId).length) {\n\t\t\t$K(\"#\"+remindMeFlyoutDivId).append(\n\t\t\t                   getFlyoutDetails(\n                                                                obj.name,\n                                                                obj.link, \n                                                                globalData.FlyoutIconUrl, \n                                                                obj.text, \n                                                                obj.icon\n                                           )\n\t\t        );\n  \t\t   }\n\n\t\t   //Increment the counter.\n\t\t   var spanReminders = $K(\"#\"+remindMeDivId).children(\".txt-reminder\").children(\".spanRemindMeNReminders\");\n                   if (spanReminders.length > 0)\n                   {\n                       var totalReminders = parseInt(spanReminders.text());\n                       if (!isNaN(totalReminders))\n                       {\n\t                    totalReminders = totalReminders + 1;\n                            spanReminders.text(String(totalReminders));\n\t                    if(totalReminders == 1) {\n\t\t               $K(\"#\"+remindMeDivId).children(\".txt-reminder\").children(\".spanRemindMeTextReminders\").text(\"Reminder\");\n\t                    }\n\t                    else {\n\t\t               $K(\"#\"+remindMeDivId).children(\".txt-reminder\").children(\".spanRemindMeTextReminders\").text(\"Reminders\");\n\t                    }\n                       }                \n\t\t   }\n                   annotationContent = false;\n                }\n\t     return annotationContent;\n        }\n\n        function registerEvents(remindMeDivId, remindMeFlyoutDivId, isSpotlightEvent) {\t\t\n\t     $K(\"#\"+remindMeDivId).live('mouseover', function () {\n\t\t   $K('#'+remindMeDivId).css({'cursor':'hand','cursor':'pointer'});\n                   $K('#'+remindMeFlyoutDivId).show();\n\t     });\n\n\t     $K(\"#\"+remindMeDivId).live('mouseout', function () {\n                   \n                   if(isSpotlightEvent) {\n                      $K(\"#spotlight-reminders-wrapper\").live('mouseover', function() {\n                           $K('#'+remindMeFlyoutDivId).show();                           \n                      });\n                      $K(\"#spotlight-reminders-wrapper\").live('mouseout', function() {\n                           $K('#'+remindMeFlyoutDivId).hide();   \n\t\t\t   $K(\"#spotlight-reminders-wrapper\").die('mouseover');\n\t\t\t   $K(\"#spotlight-reminders-wrapper\").die('mouseout');\n                      });\n                   }\n\t\t   else {\n\t\t\t$K(\"#\"+remindMeDivId).parent().mouseover(function() {\n                           $K('#'+remindMeFlyoutDivId).show();    \n\t\t\t});\n                      $K(\"#\"+remindMeDivId).parent().mouseout(function() {\n                           $K('#'+remindMeFlyoutDivId).hide();   \n\t\t\t   $K(\"#\"+remindMeDivId).parent().unbind('mouseover');\n\t\t\t   $K(\"#\"+remindMeDivId).parent().unbind('mouseout');\n                      });\n\t\t   }\n\n\t\t   $K('#'+remindMeFlyoutDivId).hide();\n\t     });\n\n\t     $K(\"#\"+remindMeFlyoutDivId).live('mouseover', function () {\n        \t   $K('#'+remindMeFlyoutDivId).show();\n\t     });\n\n\t     $K(\"#\"+remindMeFlyoutDivId).live('mouseout', function () {\n\t\t   $K('#'+remindMeFlyoutDivId).hide();\n\t\t   if(isSpotlightEvent) {\n\t\t\t   $K(\"#spotlight-reminders-wrapper\").die('mouseover');\n\t\t\t   $K(\"#spotlight-reminders-wrapper\").die('mouseout');\n\t\t   }\n\t\t   else {\n\t\t\t   $K(\"#\"+remindMeDivId).parent().unbind('mouseover');\n\t\t\t   $K(\"#\"+remindMeDivId).parent().unbind('mouseout');\n\t\t   }\n             });\n        }\n\n\tfunction createRemindMeDiv(remindMeDivId) {\n             var remindMeMainUl = $K(\"<ul></ul>\");\n             remindMeMainUl.attr({\"id\":remindMeDivId, \"class\":\"spotlightReminders\"});\n\n             remindMeMainUl.append(\n                  makeListItem(null, \"azigo-logo\", $K(\"<img src='http://www.azigo.com/images/rm/azigo_16x16.png' />\"))\n             );\n\n             remindMeMainUl.append(\n                  makeListItem(\n\t\t     \"remindme-txt-reminder\", \n\t\t     \"txt-reminder\", \n\t\t     \"<span class='spanRemindMeNReminders'>1</span> <span class='spanRemindMeTextReminders'>Reminder</span>\"\n\t\t  )\n             );\n\n             remindMeMainUl.append(\n                  makeListItem(\n\t\t     null, \n\t\t     null, \n\t\t     $K(\"<img id='img_\"+globalData.Source+\"_remindMe' src='\"+globalData.RemindMeIconUrl+\"' />\")\n\t\t  )\n             );\n\n             remindMeMainUl.append(\n                  makeListItem(null, null, $K(\"<img src='http://www.azigo.com/images/rm/FlyoutIndicator.png' />\"))\n             );\n\n             return remindMeMainUl;\n        }\n\n\tfunction createRemindMeFlyoutDiv(remindMeFlyoutDivId)\n        {\n\t    var remindMeFlyoutDiv = $K(\"<div></div>\");\n\t    remindMeFlyoutDiv.attr({\"id\":remindMeFlyoutDivId, \"class\":\"remindme-flyout-wrapper\"});\n\t    remindMeFlyoutDiv.append($K(\"<div></div>\").attr(\"class\", \"flyout-pointer\"));\n            return remindMeFlyoutDiv;\n        }\n\n\tfunction makeListItem(listItemId, listItemClass, listItemContent) {\n             var listItem = $K(\"<li></li>\");\n             if(listItemClass != null) {\n                 listItem.attr(\"class\", listItemClass);\n             }\n\t     if(listItemId != null) {\n\t         listItem.attr(\"id\", listItemId);\n\t     }\n             listItem.append(listItemContent);\n             return listItem;        \n        }\n\n\tfunction makeAnchorTag(aUrl, aClass, aText)\n        {\n             var anchorTag = $K(\"<a></a>\");\n             anchorTag.attr(\"href\", aUrl);\n             if(aClass != null) {\n                 anchorTag.attr(\"class\", aClass);\n             }\n             anchorTag.append(aText);\n             return anchorTag;\n        }\n\n    /*\n\tFunction that takes the details to be displayed in the flyout and creates a flyout component with those details.\n    */\n    function getFlyoutDetails(clientName, clientUrl, clientLogo, displayText, buttonType)\n    { \t         \n\tvar flyoutDetailsDiv = $K(\"<div></div>\");\n\tflyoutDetailsDiv.attr(\"class\",\"flyout-reminder-details clearfix\");\n\n        var flyoutDetailsUl = $K(\"<ul></ul>\");\n\n        flyoutDetailsUl.append(\n\t\tmakeListItem(null, null, $K(\"<img src='\"+clientLogo+\"' />\"))\n\t);\n        flyoutDetailsUl.append(\n                makeListItem(null, \"flyout-reminder-url\", makeAnchorTag(clientUrl, null, clientName))\n        );\n        flyoutDetailsUl.append(\n\t\tmakeListItem(null, \"flyout-reminder-text\", displayText)\n\t);\n\tvar discountButton = \"\";\n\t//if(buttonType === \"discount\") {\n\t\tdiscountButton = makeAnchorTag(clientUrl, \"flyout-reminder-button\", \"Get Discount...\");\n\t//}\n        flyoutDetailsUl.append(\n\t\tmakeListItem(null, null, discountButton)\n\t);        \n\n        flyoutDetailsDiv.append(flyoutDetailsUl);\n            \n\treturn flyoutDetailsDiv;\n    }\n\n/*\n    Main function for the Spotlight that will be called from each rule.\n*/\nKOBJ.spotlight = function (source) {\n    /*\n\tCallback function to handle JSON data returned from the nutchfilter url.\n    */\n    function datasetcallback(d){\n        if(d) {\n           var response = d.response;\n           if(response) {\n               if(response.docs.length > 0) {\n               \t    displaySpotlight(response);\n               }\n           }\n        }      \t\n    }\n\n    /* \n\tTake out the search string from the url and construct a remoteUrl for the current source. \n    */\n    var q = String(window.location).replace(/^.*[\\?&][qp]=([^&]+).*$/, \"$1\");\n    var remoteUrl = \"http://service.azigo.com/solr/nutchfilter.jsp?q=\"+q+\"&fq=source:\"+source+\"&callback=?\";\n\n    $K.getJSON(remoteUrl,datasetcallback);\n\n    /*\n\tFunction to create the main div for Spotlight. It just creates the spotlight template that will be displayed \n\tabove the search results.\n    */\n    function createSpotlightMainDiv()\n    {\n\t var spotlightMainDiv = $K(\"<div></div>\");\n\t spotlightMainDiv.attr(\"id\", \"spotlight-reminders-wrapper\");\n\n         var spotlightMainUl = $K(\"<ul></ul>\");\n         spotlightMainUl.attr({\"id\":\"spotlightReminders\", \"class\":\"spotlightReminders\"});\n\n         spotlightMainUl.append(\n                    makeListItem(null, 'azigo-logo', $K(\"<img src='http://www.azigo.com/images/rm/azigo_16x16.png' />\"))\n         );\n\n         var spotlightReminderNSpan = $K(\"<span></span>\");\n         spotlightReminderNSpan.attr(\"id\", \"spanNReminders\");\n         spotlightReminderNSpan.text(\"0\");\n\n         var spotlightReminderTextSpan = $K(\"<span></span>\");\n         spotlightReminderTextSpan.attr(\"id\", \"spanTextReminders\");\n         spotlightReminderTextSpan.text(\"Reminders\");\n\n         spotlightMainUl.append(\n                           makeListItem(\n\t\t\t\t\"spotlight-txt-reminder\", \n\t\t\t\t\"txt-reminder\", \n\t\t\t\t\"<span id='spanNReminders'>0</span> <span id='spanTextReminders'>Reminders</span>\"\n\t\t\t   )\n         );\n\n         spotlightMainUl.append(\n                    makeListItem(null, null, $K(\"<img src='http://www.azigo.com/images/rm/FlyoutIndicator.png' />\"))\n         );\n\n         var spotlightMainP = $K(\"<p></p>\");\n         spotlightMainP.attr(\"class\", \"descriptive-text\");\n         spotlightMainP.text(\"My Sponsored Links\");\n\n         spotlightMainDiv.append(spotlightMainUl);\n         spotlightMainDiv.append(spotlightMainP);\n\n         return spotlightMainDiv;\n    }\n\n    /*\n\tFunction to create the Flyout Div for Spotlight. It just creates the flyout template that will be displayed\n\tonce user hovers over the Spotlight components.\n    */\n    function createSpotlightFlyoutDiv()\n    {\n\tvar spotlightFlyoutDiv = $K(\"<div></div>\");\n\tspotlightFlyoutDiv.attr({\"id\":\"spotlightFlyoutDiv\", \"class\":\"flyout-wrapper\"});\n\tspotlightFlyoutDiv.append($K(\"<div></div>\").attr(\"class\", \"flyout-pointer\"));\n        return spotlightFlyoutDiv;\n    }\n\n    /*\n\tCallback function to handle JSON data returned from fetch url - which gives details requierd for the flyout.\n    */\n    function flyoutContentCallback(data)\n    {\n        if($K('#spotlightFlyoutDiv').length) {\n           $K.each(data, function(){\n                        $K('#spotlightFlyoutDiv').append(\n\t\t\t                  getFlyoutDetails(\n                                                 this.name,\n                                                 this.link, \n                                                 globalData.FlyoutIconUrl, \n                                                 this.text, \n                                                 this.icon\n                                          )\n                        );\n                    }\n           );\n        }\n    }    \n\n    /*\n\tMain function that creates all the components required for Spotlight and injects them in the search page.\n    */\n    function displaySpotlight(response)\n    {\n        var logoUrl = globalData.RemindMeIconUrl;\n\n        if($K(\"#spotlight-reminders-wrapper\").length == 0) {\n\t    var spotlightMainDiv = createSpotlightMainDiv();\n            var spotlightFlyoutDiv = createSpotlightFlyoutDiv();\n \t    var spotlightDiv = $K(\"<div id='spotlight-main-flyout'></div>\");\n\t    spotlightDiv.append(spotlightMainDiv);\n\t    spotlightDiv.append(spotlightFlyoutDiv);\n            if($K(\"#res\").length) {\n                $K(\"#res\").prepend(spotlightDiv);\n            }\n            else if($K(\"#web\").length) {\n                $K(\"#web\").prepend(spotlightDiv);\n            }\n            else if($K(\"#results\").length) {\n                $K(\"#results\").prepend(spotlightDiv);\n            }\n        }\n\n        //Register the mousover and mouseout events to show/hide the flyout.\n\tregisterEvents(\"spotlightReminders\", \"spotlightFlyoutDiv\", true);\n\n\t/*\n\t    If the details for this source has already been injected in the page, we don't need to go further.\n\t*/\n    \tif($K(\"#img_\"+source+\"_spotlight\").length) {\n            return;\n        }\n\n        if($K(\"#spotlight-txt-reminder\").length) {\n             $K(\"#spotlight-txt-reminder\").after(\"<li><img id='img_\"+source+\"_spotlight' src='\"+logoUrl+\"' /></li>\");\n        }\n        var spanReminders = $K(\"#spanNReminders\");\n        if (spanReminders.length > 0)\n        {\n            var totalReminders = parseInt(spanReminders.text());\n\n           if (!isNaN(totalReminders))\n           {\n\t       if(response.docs.length > 3) {\n\t\t   totalReminders = totalReminders + 3;\n\t       }\n\t       else {\n               \t   totalReminders = totalReminders + response.docs.length;\n\t       }\n               spanReminders.text(String(totalReminders));\n\t       if(totalReminders == 1) {\n\t\t   $K(\"#spanTextReminders\").text(\"Reminder\");\n\t       }\n\t       else {\n\t\t   $K(\"#spanTextReminders\").text(\"Reminders\");\n\t       }\n           }\n        }\n\n        /*\n            Make a call to the URL which will get us the detailed content as below.\n        */\n\tvar jsonData = \"\";\n\tvar index = 1;\n\t$K.each(response.docs, function(){\n\t\t\t\tif(index > 1)\n\t\t\t\t    jsonData += \",\";\n\t\t\t\tjsonData += \"'KOBJL\"+index+\"':{'url':'\"+this.url+\"'}\";\n\t\t\t\tindex++;\n\t\t\t\tif(index > 3)\n\t\t\t\t   return false;\n\t\t\t});\n\n        var jsonUrl = \"https://service.azigo.com/remindmeac/fetch?callback=?&jsonData=true&source=\"+source;\n        $K.getJSON(jsonUrl, \"annotatedata={\"+jsonData+\"}\", flyoutContentCallback);\n  }\n};\n            "}],"global_start_line":18,"dispatch":[{"domain":"www.google.com","ruleset_id":null},{"domain":"search.yahoo.com","ruleset_id":null},{"domain":"www.bing.com","ruleset_id":null},{"domain":"search.microsoft.com","ruleset_id":null},{"domain":"hertz.com","ruleset_id":null}],"dispatch_start_col":1,"meta_start_line":2,"rules":[{"cond":{"args":[{"source":"page","predicate":"param","args":[{"val":"datasets","type":"str"}],"type":"qualified"},{"val":"(^|,)ebates(,|$)","type":"str"}],"type":"ineq","op":"like"},"blocktype":"every","actions":[{"action":{"source":null,"name":"annotate_search_results","args":[{"val":"remindMeSelector","type":"var"}],"modifiers":[{"value":{"val":"https://service.azigo.com/remindmeac/fetch?callback=?&jsonData=true&source=ebates","type":"str"},"name":"remote"},{"value":{"val":[{"rhs":{"val":"none","type":"str"},"lhs":"float"},{"rhs":{"val":"0px","type":"str"},"lhs":"margin-left"},{"rhs":{"val":"0px","type":"str"},"lhs":"padding-right"}],"type":"hashraw"},"name":"outer_div_css"},{"value":{"val":[{"rhs":{"val":"0px","type":"str"},"lhs":"margin-left"},{"rhs":{"val":"0px","type":"str"},"lhs":"padding-right"},{"rhs":{"val":"5px","type":"str"},"lhs":"padding-top"}],"type":"hashraw"},"name":"inner_div_css"},{"value":{"val":[{"rhs":{"val":"0px","type":"str"},"lhs":"padding-left"},{"rhs":{"val":"normal","type":"str"},"lhs":"white-space"}],"type":"hashraw"},"name":"li_css"},{"value":{"val":"after","type":"str"},"name":"placement"},{"value":{"val":[{"rhs":{"val":[{"rhs":{"val":".sa_cc","type":"str"},"lhs":"modify"}],"type":"hashraw"},"lhs":"www.bing.com"}],"type":"hashraw"},"name":"domains"}],"vars":null},"label":null}],"post":null,"pre":[],"name":"ebates_remindme","start_col":1,"emit":"","state":"active","callbacks":{"success":[{"attribute":"class","trigger":null,"value":"flyout-reminder-button","type":"click"}],"failure":null},"pagetype":{"event_expr":{"pattern":"^http://www.google.com|^http://www.bing.com","legacy":1,"type":"prim_event","vars":[],"op":"pageview"},"foreach":[]},"start_line":616},{"cond":{"args":[{"source":"page","predicate":"param","args":[{"val":"datasets","type":"str"}],"type":"qualified"},{"val":"(^|,)ebates(,|$)","type":"str"}],"type":"ineq","op":"like"},"blocktype":"every","actions":[{"action":{"source":null,"name":"annotate_search_results","args":[{"val":"remindMeSelector","type":"var"}],"modifiers":[{"value":{"val":"https://service.azigo.com/remindmeac/fetch?callback=?&jsonData=true&source=ebates","type":"str"},"name":"remote"},{"value":{"val":[{"rhs":{"val":"none","type":"str"},"lhs":"float"},{"rhs":{"val":"40px","type":"str"},"lhs":"height"},{"rhs":{"val":"0px","type":"str"},"lhs":"margin-left"},{"rhs":{"val":"-10px","type":"str"},"lhs":"margin-top"},{"rhs":{"val":"0px","type":"str"},"lhs":"padding-right"}],"type":"hashraw"},"name":"outer_div_css"},{"value":{"val":[{"rhs":{"val":"0px","type":"str"},"lhs":"margin-left"},{"rhs":{"val":"0px","type":"str"},"lhs":"padding-right"}],"type":"hashraw"},"name":"inner_div_css"},{"value":{"val":[{"rhs":{"val":"0px","type":"str"},"lhs":"padding-left"},{"rhs":{"val":"normal","type":"str"},"lhs":"white-space"}],"type":"hashraw"},"name":"li_css"},{"value":{"val":"after","type":"str"},"name":"placement"},{"value":{"val":[{"rhs":{"val":[{"rhs":{"val":"#web > ol > li","type":"str"},"lhs":"selector"},{"rhs":{"val":"div.res","type":"str"},"lhs":"modify"}],"type":"hashraw"},"lhs":"search.yahoo.com"}],"type":"hashraw"},"name":"domains"}],"vars":null},"label":null}],"post":null,"pre":[],"name":"ebates_remindme_yahoo","start_col":5,"emit":"","state":"active","callbacks":{"success":[{"attribute":"class","trigger":null,"value":"flyout-reminder-button","type":"click"}],"failure":null},"pagetype":{"event_expr":{"pattern":"^http://search.yahoo.com","legacy":1,"type":"prim_event","vars":[],"op":"pageview"},"foreach":[]},"start_line":641},{"cond":{"val":"true","type":"bool"},"blocktype":"every","actions":[{"action":{"source":null,"name":"float_html","args":[{"val":"absolute","type":"str"},{"val":"top: 50px","type":"str"},{"val":"right: 50px","type":"str"},{"val":"popupWrapperDiv","type":"var"}],"modifiers":null,"vars":null},"label":null}],"post":null,"pre":[{"rhs":"<div id=\"kobj_popup_wrapper\">\n              </div>\n            ","lhs":"popupWrapperDiv","type":"here_doc"}],"name":"insert_blankdiv","start_col":5,"emit":null,"state":"active","callbacks":null,"pagetype":{"event_expr":{"pattern":"^http://www.google.com|^http://search.yahoo.com|^http://www.bing.com","legacy":1,"type":"prim_event","vars":[],"op":"pageview"},"foreach":[]},"start_line":668},{"cond":{"args":[{"args":[{"source":"page","predicate":"param","args":[{"val":"datasets","type":"str"}],"type":"qualified"},{"val":"(^|,)sadv(,|$)","type":"str"}],"type":"ineq","op":"like"},{"within":{"val":24,"type":"num"},"domain":"ent","expr":{"val":0,"type":"num"},"ineq":"==","timeframe":"hours","var":"dismissed","type":"persistent_ineq"}],"type":"pred","op":"&&"},"blocktype":"every","actions":[{"action":{"source":null,"name":"append","args":[{"val":"#kobj_popup_wrapper","type":"str"},{"val":"upgradeReminder","type":"var"}],"modifiers":null,"vars":null},"label":null},{"action":{"source":null,"name":"watch","args":[{"val":".dismiss","type":"str"},{"val":"click","type":"str"}],"modifiers":null,"vars":null},"label":null}],"post":null,"pre":[{"rhs":{"domain":"ent","name":"dismissed","type":"persistent"},"lhs":"dismissed","type":"expr"},{"rhs":"<div id=\"kobj_upgrade_notice\" style=\"background-color: #000000; padding: 1pt; -moz-border-radius: 5px; -webkit-border-radius: 5px; border: solid 2px black;\">\n              <img src='http://frag.kobj.net/clients/azigo_citi_demo/images/azigo_logo_black_34.png'>\n               <div  style=\"padding: 3pt;\n                            -moz-border-radius: 5px;\n                            -webkit-border-radius: 5px;\n                            background-color: #FFFFFF;\n                            width: 300px;\n                            text-align: center;\n                            color: black;\">\n                  <p class=\"content\">A new version of Student Advantage card is available. To continue getting reminders for Student Advantage, please download the new card from <a target='_blank' style=\"color:#710100; text-decoration:underline;\" href='http://www.azigo.com/landing/sadv-upgrade.html'>here</a>.</p>\n                  <a class=\"dismiss\" style=\"cursor:hand; cursor:pointer; color:#2b30d1; text-decoration: underline;\">Remind me tomorrow!</a>\n              </div>\n            </div>\n          ","lhs":"upgradeReminder","type":"here_doc"}],"name":"sadv","start_col":5,"emit":"","state":"active","callbacks":null,"pagetype":{"event_expr":{"pattern":"^http://www.google.com|^http://search.yahoo.com|^http://www.bing.com","legacy":1,"type":"prim_event","vars":[],"op":"pageview"},"foreach":[]},"start_line":681},{"cond":{"val":"true","type":"bool"},"blocktype":"every","actions":[{"action":{"source":null,"name":"set_element_attr","args":[{"val":"#kobj_upgrade_notice","type":"str"},{"val":"style","type":"str"},{"val":"display: none;","type":"str"}],"modifiers":null,"vars":null},"label":null}],"post":{"alt":null,"type":"fired","cons":[{"test":null,"value":{"val":1,"type":"num"},"name":"dismissed","domain":"ent","from":{"val":1,"type":"num"},"action":"iterator","type":"persistent","op":"+="}]},"pre":null,"name":"mark_as_read_and_dismiss_content","start_col":5,"emit":null,"state":"active","callbacks":null,"pagetype":{"event_expr":{"on":null,"domain":"web","type":"prim_event","vars":null,"op":"click","element":".dismiss"},"foreach":[]},"start_line":711},{"cond":{"args":[{"args":[{"source":"page","predicate":"param","args":[{"val":"datasets","type":"str"}],"type":"qualified"},{"val":"(^|,)aaawa(,|$)","type":"str"}],"type":"ineq","op":"like"},{"within":{"val":24,"type":"num"},"domain":"ent","expr":{"val":0,"type":"num"},"ineq":"==","timeframe":"hours","var":"dismissedAAA","type":"persistent_ineq"}],"type":"pred","op":"&&"},"blocktype":"every","actions":[{"action":{"source":null,"name":"append","args":[{"val":"#kobj_popup_wrapper","type":"str"},{"val":"aaaReminder","type":"var"}],"modifiers":null,"vars":null},"label":null},{"action":{"source":null,"name":"watch","args":[{"val":".dismissAAA","type":"str"},{"val":"click","type":"str"}],"modifiers":null,"vars":null},"label":null}],"post":null,"pre":[{"rhs":{"domain":"ent","name":"dismissedAAA","type":"persistent"},"lhs":"dismissedAAA","type":"expr"},{"rhs":"<br/>\n            <div id=\"kobj_AAA_notice\" style=\"background-color: #000000; padding: 1pt; -moz-border-radius: 5px; -webkit-border-radius: 5px; border: solid 2px black;\">\n              <img src='http://frag.kobj.net/clients/azigo_citi_demo/images/azigo_logo_black_34.png'>\n               <div  style=\"padding: 3pt;\n                            -moz-border-radius: 5px;\n                            -webkit-border-radius: 5px;\n                            background-color: #FFFFFF;\n                            width: 300px;\n                            text-align: center;\n                            color: black;\">\n                  <table width=\"100%\">\n                    <tr>\n                      <td colspan=\"2\">\n                        <p class=\"content\">Sorry, but AAA Washington discontinued sponsorship of their Azigo reminder as of July 31, 2010. If you would like to continue to get reminders about AAA deals, please consider Deep Ivy, a new partner of Azigo. Deep Ivy offers reminders for AAA and other discount programs, and is free.</p>\n                      </td>\n                    </tr>\n                    <tr>\n                      <td rowspan=\"2\" width=\"20%\">\n                        <a href=\"http://www.azigo.com/landing/aaa-deepivy.html\"><img style=\"border-style:none;\" src='http://www.azigo.com/store/images/deepivy_120x80.png'></a>\n                      </td>\n                      <td>\n                        <div><a href=\"http://www.azigo.com/landing/aaa-deepivy.html\" style=\"border: none;\">Learn More</a></div>\n                      </td>\n                    </tr>\n                    <tr>\n                      <td>\n                        <a class=\"dismissAAA\" style=\"cursor: hand; cursor: pointer; color: #2b30d1; text-decoration: underline;\">Remind me tomorrow!</a>\n                      </td>\n                    </tr>\n                    <tr>\n                      <td colspan=\"2\">\n                        <p class=\"content\"><a href=\"http://www.azigo.com/landing/aaa-deepivy.html#why\">Why do I keep seeing this popup?</a></p>\n                      </td>\n                    </tr>\n              </div>\n            </div>\n          ","lhs":"aaaReminder","type":"here_doc"}],"name":"aaa","start_col":5,"emit":"","state":"active","callbacks":null,"pagetype":{"event_expr":{"pattern":"^http://www.google.com|^http://search.yahoo.com|^http://www.bing.com","legacy":1,"type":"prim_event","vars":[],"op":"pageview"},"foreach":[]},"start_line":722},{"cond":{"val":"true","type":"bool"},"blocktype":"every","actions":[{"action":{"source":null,"name":"set_element_attr","args":[{"val":"#kobj_AAA_notice","type":"str"},{"val":"style","type":"str"},{"val":"display: none;","type":"str"}],"modifiers":null,"vars":null},"label":null}],"post":{"alt":null,"type":"fired","cons":[{"test":null,"value":{"val":1,"type":"num"},"name":"dismissedAAA","domain":"ent","from":{"val":1,"type":"num"},"action":"iterator","type":"persistent","op":"+="}]},"pre":null,"name":"mark_as_read_and_dismissAAA_content","start_col":5,"emit":null,"state":"active","callbacks":null,"pagetype":{"event_expr":{"on":null,"domain":"web","type":"prim_event","vars":null,"op":"click","element":".dismissAAA"},"foreach":[]},"start_line":773}],"meta_start_col":5,"meta":{"keys":{"errorstack":"1d895cc0802263e1c523349091752b25"},"logging":"off","name":"1024 Production","meta_start_line":2,"description":"Production copy of the Azigo 1024 rule     \n","meta_start_col":5},"dispatch_start_line":11,"global_start_col":4,"ruleset_name":"1024"}