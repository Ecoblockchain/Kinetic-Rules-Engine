{"global":[],"global_start_line":null,"dispatch":[{"domain":"google.com","ruleset_id":null},{"domain":"bing.com","ruleset_id":null}],"dispatch_start_col":5,"meta_start_line":2,"rules":[{"cond":{"val":"true","type":"bool"},"blocktype":"every","actions":[{"action":{"source":null,"name":"annotate_search_results","args":[{"val":"my_select","type":"var"}],"modifiers":null,"vars":null},"label":null}],"post":null,"pre":null,"name":"buy_computer","start_col":5,"emit":"function my_select(obj) {  \tvar ftext = $K(obj).text();  \tif (ftext.match(/buy computer/)) {  \t\treturn \"<span><strong><a href=\"http:\t} else {  \t\tfalse;  \t}  }          ","state":"active","callbacks":null,"pagetype":{"event_expr":{"pattern":"www.google.com/(.)","legacy":1,"type":"prim_event","vars":[],"op":"pageview"},"foreach":[]},"start_line":14}],"meta_start_col":5,"meta":{"logging":"off","name":"Buy Dell","meta_start_line":2,"author":"Mark Mugleston","description":"Dell Marketing     \n","meta_start_col":5},"dispatch_start_line":10,"global_start_col":null,"ruleset_name":"a171x7"}