{"global":[],"global_start_line":20,"dispatch":[{"domain":"bestbuy.com","ruleset_id":null}],"dispatch_start_col":3,"meta_start_line":2,"rules":[{"cond":{"val":"true","type":"bool"},"blocktype":"every","actions":[{"action":{"source":null,"name":"after","args":[{"val":"#reviewband","type":"str"},{"val":"CR_info","type":"var"}],"modifiers":null,"vars":null},"label":null}],"post":null,"pre":[{"rhs":{"val":"\n          <div id=\"CR_Reviews\">\n            <strong>I plan to put CR data here ...</strong>\n          </div>","type":"str"},"lhs":"CR_info","type":"expr"}],"name":"first_rule","start_col":3,"emit":null,"state":"active","callbacks":null,"pagetype":{"event_expr":{"pattern":"http://www.bestbuy.com/site/.*skuId","legacy":1,"type":"prim_event","vars":[],"op":"pageview"},"foreach":[]},"start_line":24}],"meta_start_col":3,"meta":{"logging":"off","name":"BestBuy Reviews","meta_start_line":2,"author":"Kevin Liles","description":"","meta_start_col":3},"dispatch_start_line":13,"global_start_col":3,"ruleset_name":"a198x8"}