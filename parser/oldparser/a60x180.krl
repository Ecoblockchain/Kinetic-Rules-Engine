{"global":[],"global_start_line":null,"dispatch":[{"domain":"www.familysearch.org","ruleset_id":null}],"dispatch_start_col":5,"meta_start_line":2,"rules":[{"cond":{"val":"true","type":"bool"},"blocktype":"every","actions":[{"action":{"source":null,"name":"notify","args":[{"val":"I have run!","type":"str"},{"val":"Check your console for example output.","type":"str"}],"modifiers":null,"vars":null},"label":null},{"label":null,"emit":"$K(\"iframe\").contents().find(\"table:eq(0) table:eq(1) tr\").each(function() {            var number = $K(this).find(\"td:eq(1) strong\").text();            var link = $K(this).find(\"td:eq(1) a\").attr(\"href\");            var name = $K(this).find(\"td:eq(1) a\").text();            var meta = $K(this).find(\"td:eq(1) span\").text();            if( number == 23 ) {              console.log(found);            }            console.log(\"Number: \" + number + \"\\nName: \" + name + \"\\nMeta: \" + meta + \"\\nLink: \" + link);          });                        "}],"post":null,"pre":[{"rhs":"###########################\\n###########################\\n## I found 23!!!!!\\n###########################\\n###########################        \n ","lhs":"found","type":"here_doc"}],"name":"newrule","start_col":5,"emit":null,"state":"active","callbacks":null,"pagetype":{"event_expr":{"pattern":"http://www.familysearch.org/eng/search/frameset_search.asp.*","legacy":1,"type":"prim_event","vars":[],"op":"pageview"},"foreach":[]},"start_line":10}],"meta_start_col":5,"meta":{"logging":"on","name":"Family Search example","meta_start_line":2,"author":"Mike Grace","meta_start_col":5},"dispatch_start_line":7,"global_start_col":null,"ruleset_name":"a60x180"}
