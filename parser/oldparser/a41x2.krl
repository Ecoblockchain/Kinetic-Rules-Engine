{"global":[{"source":"http://openlibrary.org/api/search?&prettyprint=true","name":"library_search","type":"datasource","datatype":"JSON","cachable":0},{"source":"http://openlibrary.org/api/get?&prettyprint=true","name":"library_get","type":"datasource","datatype":"JSON","cachable":0},{"source":"http://www.confettibooks.com/?CLSN_706=1244048969706bbe6244a6cf33eab78e&page=shop%2Fas_results","name":"store_search","type":"datasource","datatype":"JSON","cachable":{"period":"hours","value":"3"}}],"global_start_line":12,"dispatch":[{"domain":"amazon.com","ruleset_id":null},{"domain":"www.amazon.com","ruleset_id":null}],"dispatch_start_col":5,"meta_start_line":2,"rules":[{"cond":{"val":"true","type":"bool"},"blocktype":"every","actions":[{"action":{"source":null,"name":"prepend","args":[{"val":"body","type":"str"},{"val":"<div style='background-color:White'>Showing DOM change from Kynetx Rule.</div>","type":"str"}],"modifiers":null,"vars":null},"label":null}],"post":null,"pre":null,"name":"alertmessage","start_col":5,"emit":null,"state":"active","callbacks":null,"pagetype":{"event_expr":{"pattern":".*","legacy":1,"type":"prim_event","vars":[],"op":"pageview"},"foreach":[]},"start_line":17}],"meta_start_col":5,"meta":{"logging":"on","meta_start_line":2,"description":"test \n","meta_start_col":5},"dispatch_start_line":8,"global_start_col":5,"ruleset_name":"a41x2"}