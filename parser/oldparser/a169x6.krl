{"global":[{"source":"http://demo.freshbuzz.net/annotations.json","name":"annotations","type":"dataset","datatype":"JSON","cachable":{"period":"seconds","value":"5"}}],"global_start_line":15,"dispatch":[{"domain":"www.google.com","ruleset_id":null},{"domain":"www.bing.com","ruleset_id":null},{"domain":"search.yahoo.com","ruleset_id":null}],"dispatch_start_col":5,"meta_start_line":2,"rules":[{"cond":{"val":"true","type":"bool"},"blocktype":"every","actions":[{"label":null,"emit":"annotations = KOBJ['data']['annotations'];\n            \n            function annotate_freshbuzz_search(obj) {\n              var domain = $K(obj).data(\"domain\");\n              var url = $K(obj).data(\"url\");\n              var matchdata = annotations[domain];\n              \n              if (matchdata) {\n                return \"<span><a href='\"+matchdata['linkurl']\n                  +\"'><img border='0' src='\"+matchdata['logourl']\n                  +\"' alt='\"+matchdata['logoalt']\n                  +\"' /></a></span>\";\n              }\n              else {\n                return false;\n              }\n            }\n          "},{"action":{"source":null,"name":"annotate_search_results","args":[{"val":"annotate_freshbuzz_search","type":"var"}],"modifiers":null,"vars":null},"label":null}],"post":null,"pre":null,"name":"search_annotate_rule","start_col":5,"emit":null,"state":"active","callbacks":null,"pagetype":{"event_expr":{"pattern":"google.com/search|bing.com/search|search.yahoo.com/search","legacy":1,"type":"prim_event","vars":[],"op":"pageview"},"foreach":[]},"start_line":18},{"cond":{"val":"true","type":"bool"},"blocktype":"every","actions":[{"label":null,"emit":"annotations = KOBJ['data']['annotations'];\n        \n          function selector_freshbuzz_search(obj) {\n            var domain = $K(obj).data(\"domain\");\n            var matchdata = annotations[domain];\n          \n            return (matchdata);\n          }\n        "},{"action":{"source":null,"name":"percolate","args":[{"val":"selector_freshbuzz_search","type":"var"}],"modifiers":null,"vars":null},"label":null}],"post":null,"pre":null,"name":"search_percolate_rule","start_col":5,"emit":null,"state":"active","callbacks":null,"pagetype":{"event_expr":{"pattern":"google.com/search|bing.com/search|search.yahoo.com/search","legacy":1,"type":"prim_event","vars":[],"op":"pageview"},"foreach":[]},"start_line":47}],"meta_start_col":5,"meta":{"logging":"off","name":"SouthWest Airlines Loyalty Program","meta_start_line":2,"author":"Ed Orcutt <edo@aculis.com>","description":"SouthWest Airlines Loyalty program search augmentation and percolate\n        ","meta_start_col":5},"dispatch_start_line":10,"global_start_col":5,"ruleset_name":"a169x6"}
