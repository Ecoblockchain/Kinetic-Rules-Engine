{"global":[],"global_start_line":null,"dispatch":[],"dispatch_start_col":null,"meta_start_line":2,"rules":[{"cond":{"val":"true","type":"bool"},"blocktype":"every","actions":[{"action":{"source":null,"name":"notify","args":[{"val":"Placed","type":"str"},{"val":"Discount code should now be placed","type":"str"}],"modifiers":null,"vars":null},"label":null}],"post":null,"pre":[{"rhs":{"val":"<p style ='font-size:150%;color:#0000FF;'>pjw33</p>","type":"str"},"lhs":"placer","type":"expr"}],"name":"place_code","start_col":5,"emit":"var doStuff = function() {    \tif ($K('#discountCode').length) {    \t\t$K('#discountCode').replaceWIth(placer);    \t} else {    \t\talert(\"Nothing Placed\");    \t}    };        doStuff();                ","state":"active","callbacks":null,"pagetype":{"event_expr":{"pattern":"alexkolson.com","legacy":1,"type":"prim_event","vars":[],"op":"pageview"},"foreach":[]},"start_line":10}],"meta_start_col":5,"meta":{"logging":"off","name":"Discount Code","meta_start_line":2,"author":"AKO","description":"A little app that places a discount code on my blog when clicked     \n","meta_start_col":5},"dispatch_start_line":null,"global_start_col":null,"ruleset_name":"a369x13"}