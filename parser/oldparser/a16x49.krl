{"global":[],"global_start_line":null,"dispatch":[],"dispatch_start_col":null,"meta_start_line":2,"rules":[{"cond":{"args":[{"source":"kpds","predicate":"authorized","args":[],"type":"qualified"}],"type":"pred","op":"negation"},"blocktype":"every","actions":[{"action":{"source":"kpds","name":"authorize","args":[],"modifiers":[{"value":{"val":1,"type":"num"},"name":"opacity"},{"value":{"val":"true","type":"bool"},"name":"sticky"}],"vars":null},"label":null}],"post":{"alt":null,"type":"fired","cons":[{"test":null,"statement":"last","type":"control"}]},"pre":null,"name":"authorize","start_col":5,"emit":null,"state":"active","callbacks":null,"pagetype":{"event_expr":{"pattern":".*","legacy":1,"type":"prim_event","vars":[],"op":"pageview"},"foreach":[]},"start_line":15},{"cond":{"val":"true","type":"bool"},"blocktype":"every","actions":[{"action":{"source":null,"name":"notify","args":[{"val":"Friends Tweets","type":"str"},{"val":"init_div","type":"var"}],"modifiers":[{"value":{"val":"true","type":"bool"},"name":"sticky"},{"value":{"val":1,"type":"num"},"name":"opacity"}],"vars":null},"label":null}],"post":null,"pre":[{"rhs":"<div id=\"tweet_list\">  </div>  \n            ","lhs":"init_div","type":"here_doc"}],"name":"init_kpds","start_col":5,"emit":null,"state":"inactive","callbacks":null,"pagetype":{"event_expr":{"pattern":".*","legacy":1,"type":"prim_event","vars":[],"op":"pageview"},"foreach":[]},"start_line":29},{"cond":{"val":"true","type":"bool"},"blocktype":"every","actions":[{"action":{"source":null,"name":"notify","args":[{"val":"PDS Data","type":"str"},{"val":"div","type":"var"}],"modifiers":[{"value":{"val":"true","type":"bool"},"name":"sticky"}],"vars":null},"label":null}],"post":null,"pre":[{"rhs":{"source":"kpds","predicate":"number_of_adults","args":[],"type":"qualified"},"lhs":"num_adults","type":"expr"},{"rhs":{"source":"kpds","predicate":"length_of_residence","args":[],"type":"qualified"},"lhs":"len_residence","type":"expr"},{"rhs":{"source":"kpds","predicate":"home_owner_or_renter","args":[],"type":"qualified"},"lhs":"owner","type":"expr"},{"rhs":{"source":"kpds","predicate":"adult_age_range","args":[],"type":"qualified"},"lhs":"age_range","type":"expr"},{"rhs":{"source":"kpds","predicate":"dwelling_type","args":[],"type":"qualified"},"lhs":"dwelling","type":"expr"},{"rhs":"Number of adults is #{num_adults}<br/>  Length of residence is #{len_residence}<br/>  Owner is #{owner}<br/>  Adult age range is #{age_range}<br/>  #(dwelling)    \n            ","lhs":"div","type":"here_doc"}],"name":"get_data","start_col":5,"emit":null,"state":"active","callbacks":null,"pagetype":{"event_expr":{"pattern":".*","legacy":1,"type":"prim_event","vars":[],"op":"pageview"},"foreach":[]},"start_line":42}],"meta_start_col":5,"meta":{"keys":{"kpds":{"consumer_secret":"jSoxjSQygeznrtJ9sGH1JuiytO64T1hdvfVErif1","consumer_key":"jc1Du1U0ETA0I9crNu25"}},"logging":"on","name":"KPDS Demo","meta_start_line":2,"author":"Phil Windley","description":"Demonstrate the ability to grab KPDS data from behind an OAuth gateway.     \n        ","meta_start_col":5},"dispatch_start_line":null,"global_start_col":null,"ruleset_name":"a16x49"}
