{"global":[{"source":"http://qa.ahika.com/page/jSample.html?req=3","name":"ksearch","type":"dataset","datatype":"JSON","cachable":1}],"global_start_line":5,"dispatch":[],"dispatch_start_col":null,"meta_start_line":2,"rules":[{"cond":{"val":"true","type":"bool"},"blocktype":"every","actions":[{"action":{"source":null,"name":"notify","args":[{"val":"top-right","type":"str"},{"val":"#FFF","type":"str"},{"val":"#000","type":"str"},{"val":"Billeo","type":"str"},{"val":"true","type":"bool"},{"val":"invite","type":"var"}],"modifiers":null,"vars":null},"label":null},{"label":null,"emit":"$K(\"span.no_thanks\").bind(\"click.kGrowl\", function() {       $K(this).unbind('click.kGrowl').parent().parent().parent().parent().trigger('kGrowl.beforeClose').animate({opacity: \t'hide'}, \"normal\", \"swing\", function() {  \t\t\t\t\t$K(this).trigger('kGrowl.close').remove();  \t\t\t\t\t});});                  "}],"post":null,"pre":[{"rhs":"<div id=\"kobj_discount\" style=\"padding: 3pt;    -moz-border-radius: 5px;    -webkit-border-radius: 5px;    background-color: #cf9414;    width: 240px;    text-align: center\">  <p style=\"color: #fff\" >  Use your American Express card and save 5% off your entire purchase  </p>  <p style=\"color: #000; background-color: #fff; margin:0;padding:0;\">  <img width=\"218px\" src=\"http://img8.imageshack.us/img8/5348/cardri.gif\">  </p>  <p style=\"color: #fff; text-align: center\">  Offer Expires 07/20/09  </p>  <p style=\"color: #fff; text-align: center; margin: 0; padding: 0;\">  <a href=\"http://offers.amexnetwork.com/selects/us/grid?categoryPath=/amexnetwork/category/Shopping&issuerName=us_prop\" target=\"_blank\" style=\"color: #fff\">Click here to learn more</a>  </p>  <p style=\"color: #000\">  <img style=\"cursor: pointer;\" onclick=\"javascript:KOBJ.fill_card();false;\" style=\"opacity: 1.0;\" src=\"http://img25.imageshack.us/img25/859/useit.gif\">  <span class=\"no_thanks\" style=\"cursor: pointer; \"><img  style=\"opacity: 1.0;\" src=\"http://img25.imageshack.us/img25/59/nothanks.gif\"></span>  </p>  </div>     \n ","lhs":"invite","type":"here_doc"}],"name":"zapposnotify","start_col":5,"emit":"KOBJ.fill_card = function() {   $K('input[name=ccard_z_number]').attr('value','372155554444432');   $K('select[name=ccard_z_exp_month]>option[value=02]').attr('selected','selected');   $K('select[name=ccard_z_exp_year]>option[value=2011]').attr('selected','selected');  $K('select[name=ccard_type]>option[value=amex]').attr('selected','selected');  $K(\"div.kGrowl\").trigger(\"kGrowl.close\").remove();    };    $K.kGrowl.defaults.opacity = 1.0;  $K.kGrowl.defaults.width = \"250px\";            ","state":"active","callbacks":null,"pagetype":{"event_expr":{"pattern":"https://shopping.zappos.com/(r|reqauth)/checkout.cgi","legacy":1,"type":"prim_event","vars":[],"op":"pageview"},"foreach":[]},"start_line":8},{"cond":{"val":"true","type":"bool"},"blocktype":"every","actions":[{"action":{"source":null,"name":"annotate_search_results","args":[{"val":"billeo_selector","type":"var"}],"modifiers":[{"value":{"val":"li.g, div.g, li div.res, #results>ul>li","type":"str"},"name":"results_lister"},{"value":{"val":"div.s, div.std, div.abstr,p","type":"str"},"name":"element_to_modify"},{"value":{"val":"div.s, div.std, div.abstr, p","type":"str"},"name":"result_to_modify"}],"vars":null},"label":null}],"post":null,"pre":null,"name":"search","start_col":5,"emit":"function billeo_selector(obj){    function mk_anchor (o, key) {      var link_text = {        \"ksearch\": \"<img style='padding-top: 5px' src='http://img8.imageshack.us/img8/6153/amexlogo.jpg' border='0'>\"      };      return $K('<a href=' + o.link + '/>').attr(        {\"class\": 'KOBJ_'+key,         \"title\": o.text || \"Click here for discounts!\"        }).html(link_text[key]);    }      var host = KOBJ.get_host($K(obj).find(\"span.url, cite, span.a\").text());    var o = KOBJ.pick(KOBJ['data']['ksearch'][host]);    if(o) {       return mk_anchor(o,'ksearch');    } else {      false;    }  }      KOBJ.search_annotation.defaults.head_background_image = \"http://img356.imageshack.us/img356/3992/remindmebar40l.png\";  KOBJ.search_annotation.defaults.name = \"billeo\";  KOBJ.search_annotation.defaults.height = \"40px\";  KOBJ.search_annotation.defaults.left_margin = \"46px\";            ","state":"active","callbacks":null,"pagetype":{"event_expr":{"pattern":"www.google.com|search.yahoo.com|www.bing.com","legacy":1,"type":"prim_event","vars":[],"op":"pageview"},"foreach":[]},"start_line":25},{"cond":{"val":"true","type":"bool"},"blocktype":"every","actions":[{"action":{"source":null,"name":"notify","args":[{"val":"top-right","type":"str"},{"val":"#FFF","type":"str"},{"val":"#000","type":"str"},{"val":"Billeo","type":"str"},{"val":"true","type":"bool"},{"val":"invite","type":"var"}],"modifiers":null,"vars":null},"label":null},{"label":null,"emit":"$K(\"span.no_thanks\").bind(\"click.kGrowl\", function() {       $K(this).unbind('click.kGrowl').parent().parent().parent().parent().trigger('kGrowl.beforeClose').animate({opacity: \t'hide'}, \"normal\", \"swing\", function() {  \t\t\t\t\t$K(this).trigger('kGrowl.close').remove();  \t\t\t\t\t});});                  "}],"post":null,"pre":[{"rhs":"<div id=\"kobj_discount\" style=\"padding: 3pt;    -moz-border-radius: 5px;    -webkit-border-radius: 5px;    background-color: #cf9414;    width: 240px;    text-align: center\">  <p style=\"color: #fff\" >  Use your American Express card and save 20% off your entire purchase with Free shipping and Free returns  </p>  <p style=\"color: #000; background-color: #fff; margin:0;padding:0;\">  <img width=\"218px\" src=\"http://img8.imageshack.us/img8/5348/cardri.gif\">  </p>  <p style=\"color: #fff; text-align: center\">  Offer Expires 12/31/09  </p>  <p style=\"color: #fff; text-align: center; margin: 0; padding: 0;\">  <a href=\"http://offers.amexnetwork.com/portal/site/selects/menuitem.5e69a2019665ca81e0ba4d10101000f7/?vgnextoid=3fe92f824aa8f110VgnVCM1000001445640aRCRD&localLocale=en-us&categoryPath=%2Famexnetwork%2Fcategory%2FShopping&localCountryId=ccfb43b68d898110VgnVCM2000007cc6410aRCRD&countryId=ccfb43b68d898110VgnVCM2000007cc6410aRCRD&issuerName=us_prop\" target=\"_blank\" style=\"color: #fff\">Click here to learn more</a>  </p>  <p style=\"color: #000\">  <img style=\"cursor: pointer;\" onclick=\"javascript:KOBJ.fill_card();false;\" style=\"opacity: 1.0;\" src=\"http://img25.imageshack.us/img25/859/useit.gif\">  <span class=\"no_thanks\" style=\"cursor: pointer; \"><img  style=\"opacity: 1.0;\" src=\"http://img25.imageshack.us/img25/59/nothanks.gif\"></span>  </p>  </div>     \n ","lhs":"invite","type":"here_doc"}],"name":"shoescom","start_col":5,"emit":"KOBJ.fill_card = function() {   $K('input[name=ctl00$cphPageMain$PaymentTypeSelector$CreditCardNumber]').attr('value','372155554444432');   $K('input[name=ctl00$cphPageMain$PromoCodeAndGiftCodeUC$Code]').attr('value','SHOEVIP');  $K('input[name=ctl00$cphPageMain$PromoCodeAndGiftCodeUC$SubmitButton]').click();   $K('select[name=ctl00$cphPageMain$PaymentTypeSelector$ExpiryMonth]>option[value=2]').attr('selected','selected');   $K('select[name=ctl00$cphPageMain$PaymentTypeSelector$ExpiryYear]>option[value=2011]').attr('selected','selected');  $K('input[name=ctl00$cphPageMain$PaymentTypeSelector$PaymentMethods]').val('RadioButton_New_Amex');  $K('input[id=ctl00_cphPageMain_PaymentTypeSelector_RadioButton_New_Amex]').attr('checked','checked');  $K(\"div.kGrowl\").trigger(\"kGrowl.close\").remove();    };    $K.kGrowl.defaults.opacity = 1.0;  $K.kGrowl.defaults.width = \"250px\";            ","state":"active","callbacks":null,"pagetype":{"event_expr":{"pattern":"https://secure.shoes.com/Checkout2/BillingInfo.aspx","legacy":1,"type":"prim_event","vars":[],"op":"pageview"},"foreach":[]},"start_line":36}],"meta_start_col":5,"meta":{"logging":"on","meta_start_line":2,"meta_start_col":5},"dispatch_start_line":null,"global_start_col":5,"ruleset_name":"996338028"}