{"global":[],"global_start_line":null,"dispatch":[{"domain":"cnn.com","ruleset_id":null},{"domain":"facebook.com","ruleset_id":null},{"domain":"google.com","ruleset_id":null},{"domain":"bing.com","ruleset_id":null}],"dispatch_start_col":5,"meta_start_line":2,"rules":[{"cond":{"val":"true","type":"bool"},"blocktype":"every","actions":[{"action":{"source":null,"name":"prepend","args":[{"val":"#medium_rectangle","type":"str"},{"val":"content","type":"var"}],"modifiers":null,"vars":null},"label":null}],"post":null,"pre":[{"rhs":{"source":"math","predicate":"random","args":[{"val":999999999999,"type":"num"}],"type":"qualified"},"lhs":"cb","type":"expr"},{"rhs":"<center>    <div id=\"optini_ad\" text-align: center; visibility: visible;>   <!-- VuLiquid Invocation Code goes here (replace span) -->    <!---->    <iframe id='ac748690' name='ac748690' src='http:\\/\\/vue.us.vucdn.com/x282/www/delivery/afr.php?zoneid=53&amp;cb=#{cb}' framespacing='0' frameborder='no' scrolling='no' width='300' height='250' allowtransparency='true'><a href='http:\\/\\/vue.us.vucdn.com/x282/www/delivery/ck.php?n=aa9c7ae4&amp;cb=#{cb}' target='_blank'><img src='http:\\/\\/vue.us.vucdn.com/x282/www/delivery/avw.php?zoneid=53&amp;cb=#{cb}&amp;n=aa9c7ae4' border='0' alt='' /></a></iframe>      </div>    <br>    \n ","lhs":"content","type":"here_doc"}],"name":"cnn_com_homepage","start_col":5,"emit":null,"state":"active","callbacks":null,"pagetype":{"event_expr":{"pattern":"http://www.cnn.com/|http://www.cnn.com/?.*","legacy":1,"type":"prim_event","vars":[],"op":"pageview"},"foreach":[]},"start_line":15},{"cond":{"val":"true","type":"bool"},"blocktype":"every","actions":[{"action":{"source":null,"name":"prepend","args":[{"val":"#home_sidebar","type":"str"},{"val":"content","type":"var"}],"modifiers":null,"vars":null},"label":null}],"post":null,"pre":[{"rhs":{"source":"math","predicate":"random","args":[{"val":999999999999,"type":"num"}],"type":"qualified"},"lhs":"cb","type":"expr"},{"rhs":"<div class=\"optini_content\">              <!-- VuLiquid invocation code goes here (delete span) -->  <!---->    <iframe id='abc8c520' name='abc8c520' src='http:\\/\\/vue.us.vucdn.com/x282/www/delivery/afr.php?zoneid=54&amp;cb=#{cb}' framespacing='0' frameborder='no' scrolling='no' width='300' height='250' allowtransparency='true'><a href='http:\\/\\/vue.us.vucdn.com/x282/www/delivery/ck.php?n=ab9f7b97&amp;cb=#{cb}' target='_blank'><img src='http:\\/\\/vue.us.vucdn.com/x282/www/delivery/avw.php?zoneid=54&amp;cb=#{cb}&amp;n=ab9f7b97' border='0' alt='' /></a></iframe>        </div>    \n ","lhs":"content","type":"here_doc"}],"name":"facebook_com_homepage","start_col":5,"emit":null,"state":"active","callbacks":null,"pagetype":{"event_expr":{"pattern":"facebook.com","legacy":1,"type":"prim_event","vars":[],"op":"pageview"},"foreach":[]},"start_line":26},{"cond":{"val":"true","type":"bool"},"blocktype":"every","actions":[{"action":{"source":null,"name":"after","args":[{"val":"selector","type":"var"},{"val":"content","type":"var"}],"modifiers":null,"vars":null},"label":null}],"post":null,"pre":[{"rhs":{"source":"math","predicate":"random","args":[{"val":999999999999,"type":"num"}],"type":"qualified"},"lhs":"cb","type":"expr"},{"rhs":"\"font[size=-1]:first,#footer_about_igoogle_link,#flp\"\n ","lhs":"selector","type":"here_doc"},{"rhs":"<!---->  <center>  <div id=\"optini_content\" text-align: center; visibility: visible;>  <!-- vuLiquid Invocation code goes here (delete span below) -->    <!---->    <iframe id='a56a2de3' name='a56a2de3' src='http:\\/\\/vue.us.vucdn.com/x282/www/delivery/afr.php?zoneid=57&amp;cb=#{cb}' framespacing='0' frameborder='no' scrolling='no' width='468' height='60' allowtransparency='true'><a href='http:\\/\\/vue.us.vucdn.com/x282/www/delivery/ck.php?n=a398b2e4&amp;cb=#{cb}' target='_blank'><img src='http:\\/\\/vue.us.vucdn.com/x282/www/delivery/avw.php?zoneid=57&amp;cb=#{cb}&amp;n=a398b2e4' border='0' alt='' /></a></iframe>      </div>  </center>    \n ","lhs":"content","type":"here_doc"}],"name":"google_com_homepage","start_col":5,"emit":null,"state":"active","callbacks":null,"pagetype":{"event_expr":{"pattern":"http://www.google.com.*","legacy":1,"type":"prim_event","vars":[],"op":"pageview"},"foreach":[]},"start_line":37},{"cond":{"val":"true","type":"bool"},"blocktype":"every","actions":[{"action":{"source":null,"name":"prepend","args":[{"val":"#results_area","type":"str"},{"val":"content","type":"var"}],"modifiers":null,"vars":null},"label":null}],"post":null,"pre":[{"rhs":{"source":"math","predicate":"random","args":[{"val":999999999999,"type":"num"}],"type":"qualified"},"lhs":"cb","type":"expr"},{"rhs":"<center>  <br>    <div id=\"optini_ad\" text-align: center; visibility: visible;>  <!--Optini Ad goes here-->    <!---->    <iframe id='a2b3643f' name='a2b3643f' src='http:\\/\\/vue.us.vucdn.com/x282/www/delivery/afr.php?zoneid=62&amp;cb=#{cb}' framespacing='0' frameborder='no' scrolling='no' width='468' height='60' allowtransparency='true'><a href='http:\\/\\/vue.us.vucdn.com/x282/www/delivery/ck.php?n=add42ad5&amp;cb=#{cb}' target='_blank'><img src='http:\\/\\/vue.us.vucdn.com/x282/www/delivery/avw.php?zoneid=62&amp;cb=#{cb}&amp;n=add42ad5' border='0' alt='' /></a></iframe>      </div>  </center>  <br>    \n ","lhs":"content","type":"here_doc"}],"name":"bing_com_search_result","start_col":5,"emit":null,"state":"active","callbacks":null,"pagetype":{"event_expr":{"pattern":"^http://www.bing.com/.*q=.*&.*","legacy":1,"type":"prim_event","vars":[],"op":"pageview"},"foreach":[]},"start_line":51}],"meta_start_col":5,"meta":{"logging":"off","name":"EOnline","meta_start_line":2,"description":"E! Online   \n","meta_start_col":5},"dispatch_start_line":9,"global_start_col":null,"ruleset_name":"a244x9"}
