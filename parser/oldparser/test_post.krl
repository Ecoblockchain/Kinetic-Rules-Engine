{"global":[],"global_start_line":null,"dispatch":[],"dispatch_start_col":null,"meta_start_line":3,"rules":[{"cond":{"args":[{"domain":"ent","name":"dont_show","type":"persistent"}],"type":"pred","op":"negation"},"blocktype":"every","actions":[{"action":{"source":null,"name":"notify","args":[{"val":"Welcome","type":"str"},{"val":"h","type":"var"}],"modifiers":[{"value":{"val":"true","type":"bool"},"name":"sticky"}],"vars":null},"label":null}],"post":null,"pre":[{"rhs":"Welcome to the CTO Breakfast page!!!<br/>\n<input id=\"KOBJ_clear\" type=\"checkbox\" name=\"option1\" value=\"Clear\">Don't show again\n ","lhs":"h","type":"here_doc"}],"name":"show_note","start_col":1,"emit":null,"state":"active","callbacks":{"success":[{"attribute":"id","trigger":{"domain":"ent","name":"dont_show","action":"set","type":"persistent"},"value":"KOBJ_clear","type":"change"}],"failure":null},"pagetype":{"event_expr":{"pattern":"www.windley.com/cto_forum","legacy":1,"type":"prim_event","vars":[],"op":"pageview"},"foreach":[]},"start_line":7},{"cond":{"val":"true","type":"bool"},"blocktype":"every","actions":[{"action":{"source":null,"name":"notify","args":[{"val":"Notice","type":"str"},{"val":"I'm clearing the notice flag for www.windley.com","type":"str"}],"modifiers":null,"vars":null},"label":null}],"post":{"alt":null,"type":"fired","cons":[{"test":null,"domain":"ent","name":"dont_show","action":"clear","type":"persistent"}]},"pre":null,"name":"clear_notice","start_col":1,"emit":null,"state":"active","callbacks":null,"pagetype":{"event_expr":{"pattern":"www.kynetx.com","legacy":1,"type":"prim_event","vars":[],"op":"pageview"},"foreach":[]},"start_line":29}],"meta_start_col":3,"meta":{"logging":"on","meta_start_line":3,"meta_start_col":3},"dispatch_start_line":null,"global_start_col":null,"ruleset_name":"test_post"}