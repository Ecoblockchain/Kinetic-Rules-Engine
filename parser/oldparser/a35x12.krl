{"global":[{"source":"http://pipes.yahoo.com/pipes/pipe.run?_id=45232d78204923c0adb3172916f318da&_render=json","name":"site_data","type":"dataset","datatype":"JSON","cachable":{"period":"minutes","value":"1"}},{"rhs":{"obj":{"val":"site_data","type":"var"},"args":[{"val":"$.value.items","type":"str"}],"name":"pick","type":"operator"},"lhs":"items","type":"expr"}],"global_start_line":16,"dispatch":[{"domain":"baconsalt.com","ruleset_id":null},{"domain":"craigburton.com","ruleset_id":null},{"domain":"kynetx.com","ruleset_id":null},{"domain":"cnn.com","ruleset_id":null}],"dispatch_start_col":5,"meta_start_line":2,"rules":[{"cond":{"val":"true","type":"bool"},"blocktype":"every","actions":[{"action":{"source":null,"name":"notify","args":[{"val":"header","type":"var"},{"val":"content","type":"var"}],"modifiers":[{"value":{"val":"true","type":"bool"},"name":"sticky"}],"vars":null},"label":null}],"post":null,"pre":[{"rhs":{"source":"page","predicate":"url","args":[{"val":"domain","type":"str"}],"type":"qualified"},"lhs":"thesite","type":"expr"},{"rhs":{"obj":{"val":"site_data","type":"var"},"args":[{"args":[{"val":"$..items[?(@.page eq '","type":"str"},{"args":[{"val":"thesite","type":"var"},{"val":"')].content","type":"str"}],"type":"prim","op":"+"}],"type":"prim","op":"+"}],"name":"pick","type":"operator"},"lhs":"content","type":"expr"},{"rhs":{"obj":{"val":"site_data","type":"var"},"args":[{"args":[{"val":"$..items[?(@.page eq '","type":"str"},{"args":[{"val":"thesite","type":"var"},{"val":"')].header","type":"str"}],"type":"prim","op":"+"}],"type":"prim","op":"+"}],"name":"pick","type":"operator"},"lhs":"header","type":"expr"}],"name":"dynamic_data","start_col":5,"emit":null,"state":"active","callbacks":null,"pagetype":{"event_expr":{"pattern":".*","legacy":1,"type":"prim_event","vars":[],"op":"pageview"},"foreach":[]},"start_line":19}],"meta_start_col":5,"meta":{"logging":"off","name":"Dynamic Data","meta_start_line":2,"author":"Craig Burton","description":"Rule using dynamic data from Google Docs.     \n","meta_start_col":5},"dispatch_start_line":10,"global_start_col":5,"ruleset_name":"a35x12"}
