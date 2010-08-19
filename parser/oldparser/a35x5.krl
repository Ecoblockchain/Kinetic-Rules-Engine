{"global":[{"source":"http://pipes.yahoo.com/pipes/pipe.run?_id=8008eddc07e120ac18b80f38210b82ec&_render=json","name":"helloworld_pipes","type":"dataset","datatype":"JSON","cachable":{"period":"seconds","value":"5"}}],"global_start_line":16,"dispatch":[{"domain":"www.google.com","ruleset_id":null},{"domain":"www.baconsalt.com","ruleset_id":null},{"domain":"www.craigburton.com","ruleset_id":null},{"domain":"www.kynetx.com","ruleset_id":null}],"dispatch_start_col":5,"meta_start_line":2,"rules":[{"cond":{"val":"true","type":"bool"},"blocktype":"every","actions":[{"action":{"source":null,"name":"notify","args":[{"val":"json_header","type":"var"},{"val":"json_content","type":"var"}],"modifiers":null,"vars":null},"label":null}],"post":null,"pre":[{"rhs":{"obj":{"val":"helloworld_pipes","type":"var"},"args":[{"val":"$.value.items[0].content","type":"str"}],"name":"pick","type":"operator"},"lhs":"first_content","type":"expr"},{"rhs":{"obj":{"val":"helloworld_pipes","type":"var"},"args":[{"val":"$.value.items[0].header","type":"str"}],"name":"pick","type":"operator"},"lhs":"first_header","type":"expr"},{"rhs":{"val":"first_header","type":"var"},"lhs":"json_header","type":"expr"},{"rhs":{"val":"first_content","type":"var"},"lhs":"json_content","type":"expr"}],"name":"baconsalt","start_col":5,"emit":null,"state":"active","callbacks":null,"pagetype":{"event_expr":{"pattern":"www.baconsalt.com","legacy":1,"type":"prim_event","vars":[],"op":"pageview"},"foreach":[]},"start_line":19},{"cond":{"val":"true","type":"bool"},"blocktype":"every","actions":[{"action":{"source":null,"name":"notify","args":[{"val":"json_header","type":"var"},{"val":"json_content","type":"var"}],"modifiers":null,"vars":null},"label":null}],"post":null,"pre":[{"rhs":{"obj":{"val":"helloworld_pipes","type":"var"},"args":[{"val":"$.value.items[1].content","type":"str"}],"name":"pick","type":"operator"},"lhs":"second_content","type":"expr"},{"rhs":{"obj":{"val":"helloworld_pipes","type":"var"},"args":[{"val":"$.value.items[1].header","type":"str"}],"name":"pick","type":"operator"},"lhs":"second_header","type":"expr"},{"rhs":{"val":"second_header","type":"var"},"lhs":"json_header","type":"expr"},{"rhs":{"val":"second_content","type":"var"},"lhs":"json_content","type":"expr"}],"name":"craigburton","start_col":5,"emit":null,"state":"active","callbacks":null,"pagetype":{"event_expr":{"pattern":"www.craigburton.com","legacy":1,"type":"prim_event","vars":[],"op":"pageview"},"foreach":[]},"start_line":30},{"cond":{"val":"true","type":"bool"},"blocktype":"every","actions":[{"action":{"source":null,"name":"notify","args":[{"val":"json_header","type":"var"},{"val":"json_content","type":"var"}],"modifiers":null,"vars":null},"label":null}],"post":null,"pre":[{"rhs":{"obj":{"val":"helloworld_pipes","type":"var"},"args":[{"val":"$.value.items[2].content","type":"str"}],"name":"pick","type":"operator"},"lhs":"third_content","type":"expr"},{"rhs":{"obj":{"val":"helloworld_pipes","type":"var"},"args":[{"val":"$.value.items[2].header","type":"str"}],"name":"pick","type":"operator"},"lhs":"third_header","type":"expr"},{"rhs":{"val":"third_header","type":"var"},"lhs":"json_header","type":"expr"},{"rhs":{"val":"third_content","type":"var"},"lhs":"json_content","type":"expr"}],"name":"kynetx","start_col":5,"emit":null,"state":"active","callbacks":null,"pagetype":{"event_expr":{"pattern":"www.kynetx.com","legacy":1,"type":"prim_event","vars":[],"op":"pageview"},"foreach":[]},"start_line":41}],"meta_start_col":5,"meta":{"logging":"on","name":"Hello Json","meta_start_line":2,"author":"Craig Burton","description":"Hello test application using external data in Json format.    \n","meta_start_col":5},"dispatch_start_line":10,"global_start_col":5,"ruleset_name":"a35x5"}
