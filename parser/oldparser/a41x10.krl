{"global":[],"global_start_line":null,"dispatch":[{"domain":"google.com","ruleset_id":null},{"domain":"bing.com","ruleset_id":null},{"domain":"yahoo.com","ruleset_id":null}],"dispatch_start_col":5,"meta_start_line":2,"rules":[{"cond":{"val":"true","type":"bool"},"blocktype":"every","actions":[{"action":{"source":null,"name":"annotate_search_results","args":[{"val":"test_selector","type":"var"}],"modifiers":null,"vars":null},"label":null}],"post":null,"pre":null,"name":"annotate","start_col":5,"emit":"KOBJ.tempCount = 0;    function test_selector(obj){    \tstring = '<div id=\"KOBJ_append'+KOBJ.tempCount+'\">Domain'+KOBJ.tempCount+':'+$K(obj).data(\"domain\")+'</div>';    \tKOBJ.tempCount++;  \treturn string;  }            ","state":"active","callbacks":null,"pagetype":{"event_expr":{"pattern":"food.84660","legacy":1,"type":"prim_event","vars":[],"op":"pageview"},"foreach":[]},"start_line":14},{"cond":{"val":"true","type":"bool"},"blocktype":"every","actions":[{"action":{"source":null,"name":"annotate_search_results","args":[],"modifiers":[{"value":{"val":"http://chevelle.caandb.com/annotate_remote.php?jsoncallback=?","type":"str"},"name":"remote"}],"vars":null},"label":null}],"post":null,"pre":null,"name":"remote_annotate","start_col":5,"emit":null,"state":"active","callbacks":null,"pagetype":{"event_expr":{"pattern":"burgers.84660","legacy":1,"type":"prim_event","vars":[],"op":"pageview"},"foreach":[]},"start_line":21},{"cond":{"val":"true","type":"bool"},"blocktype":"every","actions":[{"action":{"source":null,"name":"annotate_local_search_results","args":[{"val":"test_selector","type":"var"}],"modifiers":null,"vars":null},"label":null}],"post":null,"pre":null,"name":"local","start_col":5,"emit":"KOBJ.tempCountLocal = 0;    function test_selector(obj){    \tstring = '<div id=\"KOBJ_append_local'+KOBJ.tempCountLocal+'\">Phone'+KOBJ.tempCountLocal+':'+$K(obj).data(\"phone\")+'</div>';  \t  \tKOBJ.tempCountLocal++;  \treturn string;  }            ","state":"active","callbacks":null,"pagetype":{"event_expr":{"pattern":"food.*84660","legacy":1,"type":"prim_event","vars":[],"op":"pageview"},"foreach":[]},"start_line":28},{"cond":{"val":"true","type":"bool"},"blocktype":"every","actions":[{"action":{"source":null,"name":"annotate_local_search_results","args":[],"modifiers":[{"value":{"val":"http://chevelle.caandb.com/annotate_remote.php?jsoncallback=?","type":"str"},"name":"remote"}],"vars":null},"label":null}],"post":null,"pre":null,"name":"remote_local","start_col":5,"emit":null,"state":"active","callbacks":null,"pagetype":{"event_expr":{"pattern":"burgers.*84660","legacy":1,"type":"prim_event","vars":[],"op":"pageview"},"foreach":[]},"start_line":35},{"cond":{"val":"true","type":"bool"},"blocktype":"every","actions":[{"action":{"source":null,"name":"percolate","args":[{"val":"test_selector","type":"var"}],"modifiers":null,"vars":null},"label":null}],"post":null,"pre":null,"name":"percolate","start_col":5,"emit":"test_data = {  \t\t\"www.eco-furniture.com\" : {}  \t};      \tfunction test_selector(obj){  \t\tvar host = $K(obj).data(\"domain\");  \t\t  \t\tvar o = test_data[host];  \t\tif(o){  \t\t\treturn true;  \t\t} else {  \t\t\treturn false;  \t\t}  \t}\t\t              ","state":"active","callbacks":null,"pagetype":{"event_expr":{"pattern":"furniture","legacy":1,"type":"prim_event","vars":[],"op":"pageview"},"foreach":[]},"start_line":42}],"meta_start_col":5,"meta":{"logging":"off","name":"Search Annotate Test","meta_start_line":2,"description":"Annotates Google Search     \n","meta_start_col":5},"dispatch_start_line":9,"global_start_col":null,"ruleset_name":"a41x10"}
