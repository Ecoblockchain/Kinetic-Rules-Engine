{"global":[],"global_start_line":26,"dispatch":[{"domain":"nytimes.com","ruleset_id":null},{"domain":"google.com","ruleset_id":null}],"dispatch_start_col":1,"meta_start_line":2,"rules":[{"cond":{"source":"facebook","predicate":"authorized","args":[],"type":"qualified"},"blocktype":"every","actions":[{"action":{"source":null,"name":"notify","args":[{"val":"Authorized","type":"str"},{"val":"Good","type":"str"}],"modifiers":null,"vars":null},"label":null}],"post":null,"pre":null,"name":"first_rull","start_col":1,"emit":null,"state":"active","callbacks":null,"pagetype":{"event_expr":{"pattern":".*","legacy":1,"type":"prim_event","vars":[],"op":"pageview"},"foreach":[]},"start_line":30},{"cond":{"args":[{"source":"facebook","predicate":"authorized","args":[],"type":"qualified"}],"type":"pred","op":"negation"},"blocktype":"every","actions":[{"action":{"source":"facebook","name":"authorize","args":[{"val":[{"val":"publish_stream","type":"str"},{"val":"email","type":"str"},{"val":"user_photos","type":"str"},{"val":"read_stream","type":"str"},{"val":"user_notes","type":"str"},{"val":"offline_access","type":"str"},{"val":"user_about_me","type":"str"},{"val":"user_notes","type":"str"},{"val":"user_photos","type":"str"},{"val":"user_likes","type":"str"},{"val":"user_online_presence","type":"str"}],"type":"array"}],"modifiers":[{"value":{"val":1,"type":"num"},"name":"opacity"},{"value":{"val":"true","type":"bool"},"name":"sticky"}],"vars":null},"label":null}],"post":{"alt":null,"type":"fired","cons":[{"test":null,"statement":"last","type":"control"}]},"pre":null,"name":"auth_app","start_col":1,"emit":null,"state":"active","callbacks":null,"pagetype":{"event_expr":{"pattern":".*","legacy":1,"type":"prim_event","vars":[],"op":"pageview"},"foreach":[]},"start_line":37},{"cond":{"val":"true","type":"bool"},"blocktype":"every","actions":[{"action":{"source":null,"name":"alert","args":[{"val":"littletest","type":"var"}],"modifiers":null,"vars":null},"label":null}],"post":null,"pre":[{"rhs":{"source":"facebook","predicate":"get","args":[{"val":[{"rhs":{"val":"home","type":"str"},"lhs":"connection"}],"type":"hashraw"},{"val":30,"type":"num"}],"type":"qualified"},"lhs":"alldata","type":"expr"},{"rhs":{"obj":{"val":"alldata","type":"var"},"args":[{"val":"string","type":"str"}],"name":"as","type":"operator"},"lhs":"littletest","type":"expr"},{"rhs":{"obj":{"val":"littletest","type":"var"},"args":[{"val":"/data/g","type":"regexp"},{"val":"datar","type":"str"}],"name":"replace","type":"operator"},"lhs":"rpls","type":"expr"}],"name":"just_the_data","start_col":1,"emit":null,"state":"active","callbacks":null,"pagetype":{"event_expr":{"pattern":".*","legacy":1,"type":"prim_event","vars":[],"op":"pageview"},"foreach":[]},"start_line":50},{"cond":{"val":"true","type":"bool"},"blocktype":"every","actions":[{"action":{"source":null,"name":"notify","args":[{"val":"feed","type":"str"},{"val":"blob","type":"var"}],"modifiers":[{"value":{"val":1,"type":"num"},"name":"opacity"},{"value":{"val":"true","type":"bool"},"name":"sticky"}],"vars":null},"label":null}],"post":{"alt":null,"type":"fired","cons":[{"test":{"args":[{"val":"exists","type":"var"}],"type":"pred","op":"negation"},"domain":"ent","name":"sent_from","action":"mark","type":"persistent","with":{"val":"fid","type":"var"}}]},"pre":[{"rhs":{"val":"itm","type":"var"},"lhs":"thing","type":"expr"},{"rhs":{"obj":{"val":"itm","type":"var"},"args":[{"val":"$.from.name","type":"str"}],"name":"pick","type":"operator"},"lhs":"fname","type":"expr"},{"rhs":{"obj":{"val":"itm","type":"var"},"args":[{"val":"$.from.id","type":"str"}],"name":"pick","type":"operator"},"lhs":"fid","type":"expr"},{"rhs":{"obj":{"val":"itm","type":"var"},"args":[{"val":"$.message","type":"str"}],"name":"pick","type":"operator"},"lhs":"message","type":"expr"},{"rhs":{"obj":{"val":"itm","type":"var"},"args":[{"val":"$.link","type":"str"}],"name":"pick","type":"operator"},"lhs":"link","type":"expr"},{"rhs":{"obj":{"val":"itm","type":"var"},"args":[{"val":"$.picture","type":"str"}],"name":"pick","type":"operator"},"lhs":"picture","type":"expr"},{"rhs":{"obj":{"val":"itm","type":"var"},"args":[{"val":"$.name","type":"str"}],"name":"pick","type":"operator"},"lhs":"pname","type":"expr"},{"rhs":{"obj":{"val":"itm","type":"var"},"args":[{"val":"$.caption","type":"str"}],"name":"pick","type":"operator"},"lhs":"caption","type":"expr"},{"rhs":{"obj":{"val":"itm","type":"var"},"args":[{"val":"$.description","type":"str"}],"name":"pick","type":"operator"},"lhs":"descr","type":"expr"},{"rhs":{"obj":{"val":"itm","type":"var"},"args":[{"val":"$.source","type":"str"}],"name":"pick","type":"operator"},"lhs":"source","type":"expr"},{"rhs":{"obj":{"val":"itm","type":"var"},"args":[{"val":"$.icon","type":"str"}],"name":"pick","type":"operator"},"lhs":"icon","type":"expr"},{"rhs":{"obj":{"val":"itm","type":"var"},"args":[{"val":"$.attribution","type":"str"}],"name":"pick","type":"operator"},"lhs":"attrib","type":"expr"},{"rhs":{"obj":{"val":"itm","type":"var"},"args":[{"val":"$.likes","type":"str"}],"name":"pick","type":"operator"},"lhs":"likes","type":"expr"},{"rhs":{"obj":{"val":"itm","type":"var"},"args":[{"val":"$.created_time","type":"str"}],"name":"pick","type":"operator"},"lhs":"created","type":"expr"},{"rhs":{"obj":{"val":"itm","type":"var"},"args":[{"val":"$.updated_time","type":"str"}],"name":"pick","type":"operator"},"lhs":"updated","type":"expr"},{"rhs":{"expr":{"args":[{"val":"x","type":"var"},{"val":"fid","type":"var"}],"type":"ineq","op":"=="},"vars":["x"],"type":"function","decls":[]},"lhs":"f","type":"expr"},{"rhs":{"obj":{"domain":"ent","name":"sent_from","type":"persistent"},"args":[{"val":"array","type":"str"}],"name":"as","type":"operator"},"lhs":"marry","type":"expr"},{"rhs":{"obj":{"val":"marry","type":"var"},"args":[{"val":"f","type":"var"}],"name":"filter","type":"operator"},"lhs":"exists","type":"expr"},{"rhs":"<div><div class=\"pic#{fid}\">.</div><span><strong>#{fname}</strong><br />\n      #{message}<br />\n       #{fid}</span><span>#{descr}</span></div>\n    ","lhs":"blob","type":"here_doc"}],"name":"get_feed","start_col":1,"emit":null,"state":"active","callbacks":null,"pagetype":{"event_expr":{"pattern":".*","legacy":1,"type":"prim_event","vars":[],"op":"pageview"},"foreach":[{"expr":{"obj":{"source":"facebook","predicate":"get","args":[{"val":[{"rhs":{"val":"home","type":"str"},"lhs":"connection"},{"rhs":{"val":"message,link,source,from","type":"str"},"lhs":"fields"}],"type":"hashraw"},{"val":30,"type":"num"}],"type":"qualified"},"args":[{"val":"$.data","type":"str"}],"name":"pick","type":"operator"},"var":["itm"]}]},"start_line":60},{"cond":{"val":"true","type":"bool"},"blocktype":"every","actions":[{"action":{"source":null,"name":"after","args":[{"val":"#{divid}","type":"str"},{"val":"pblob","type":"var"}],"modifiers":null,"vars":null},"label":null}],"post":null,"pre":[{"rhs":{"source":"facebook","predicate":"picture","args":[{"val":[{"rhs":{"val":"user","type":"var"},"lhs":"id"},{"rhs":{"val":"small","type":"str"},"lhs":"type"}],"type":"hashraw"},{"val":300,"type":"num"}],"type":"qualified"},"lhs":"pobj","type":"expr"},{"rhs":{"args":[{"val":".pic","type":"str"},{"val":"user","type":"var"}],"type":"prim","op":"+"},"lhs":"divid","type":"expr"},{"rhs":"<img src=\"#{pobj}\">\n        ","lhs":"pblob","type":"here_doc"},{"rhs":{"obj":{"domain":"ent","name":"sent_from","type":"persistent"},"args":[{"val":"array","type":"str"}],"name":"as","type":"operator"},"lhs":"mtrail","type":"expr"}],"name":"get_picture","start_col":3,"emit":null,"state":"active","callbacks":null,"pagetype":{"event_expr":{"pattern":".*","legacy":1,"type":"prim_event","vars":[],"op":"pageview"},"foreach":[{"expr":{"obj":{"domain":"ent","name":"sent_from","type":"persistent"},"args":[{"val":"array","type":"str"}],"name":"as","type":"operator"},"var":["user"]}]},"start_line":96},{"cond":{"val":"true","type":"bool"},"blocktype":"every","actions":[{"action":{"source":null,"name":"notify","args":[{"val":"Got metadata","type":"str"},{"val":"","type":"str"}],"modifiers":null,"vars":null},"label":null}],"post":null,"pre":[{"rhs":{"source":"facebook","predicate":"get","args":[{"val":[{"rhs":{"val":"home","type":"str"},"lhs":"connection"},{"rhs":{"val":"first_name,email","type":"str"},"lhs":"fields"}],"type":"hashraw"}],"type":"qualified"},"lhs":"mdata","type":"expr"}],"name":"get_metadata","start_col":3,"emit":null,"state":"active","callbacks":null,"pagetype":{"event_expr":{"pattern":".*","legacy":1,"type":"prim_event","vars":[],"op":"pageview"},"foreach":[]},"start_line":109}],"meta_start_col":1,"meta":{"keys":{"facebook":{"consumer_secret":"c14b66576bb0bc0cae57f18feab0f697","consumer_key":"116175265079774"}},"logging":"on","name":"Facebook integration","meta_start_line":2,"author":"MEH","description":"Facebook and OAuth2.0 test\n  ","meta_start_col":1},"dispatch_start_line":21,"global_start_col":1,"ruleset_name":"a144x22"}
