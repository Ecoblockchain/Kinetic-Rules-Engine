{"global":[{"source":"http://search.yahooapis.com/WebSearchService/V1/webSearch?appid=YahooDemo&results=2&language=szh&output=json&","name":"i18n_search","type":"datasource","datatype":"JSON","cachable":0}],"global_start_line":12,"dispatch":[{"domain":"kynetx.com","ruleset_id":null}],"dispatch_start_col":5,"meta_start_line":2,"rules":[{"cond":{"val":"true","type":"bool"},"blocktype":"every","actions":[{"action":{"source":null,"name":"notify","args":[{"val":"i18n Datasource request to Yahoo Web Search API","type":"str"},{"val":"temp","type":"var"}],"modifiers":[{"value":{"val":"true","type":"bool"},"name":"sticky"}],"vars":null},"label":null}],"post":null,"pre":[{"rhs":{"source":"datasource","predicate":"i18n_search","args":[{"val":"query=information+card+selector","type":"str"}],"type":"qualified"},"lhs":"card_data","type":"expr"},{"rhs":{"obj":{"val":"card_data","type":"var"},"args":[{"val":"$..Result[0].Title","type":"str"}],"name":"pick","type":"operator"},"lhs":"temp","type":"expr"}],"name":"chimera_rule_1","start_col":5,"emit":null,"state":"active","callbacks":null,"pagetype":{"event_expr":{"pattern":"www.kynetx.com/(\\w*)","legacy":1,"type":"prim_event","vars":["nada"],"op":"pageview"},"foreach":[]},"start_line":15}],"meta_start_col":5,"meta":{"logging":"on","name":"Chimera","meta_start_line":2,"description":"Ruleset instance     \n","meta_start_col":5},"dispatch_start_line":9,"global_start_col":5,"ruleset_name":"a144x1"}
