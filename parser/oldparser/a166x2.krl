{"global":[],"global_start_line":null,"dispatch":[{"domain":"usbchainsaw.com","ruleset_id":null}],"dispatch_start_col":5,"meta_start_line":2,"rules":[{"cond":{"val":"true","type":"bool"},"blocktype":"every","actions":[{"action":{"source":null,"name":"noop","args":[],"modifiers":null,"vars":null},"label":null}],"post":null,"pre":null,"name":"simple","start_col":5,"emit":"alert(\"test alert\");            ","state":"active","callbacks":null,"pagetype":{"event_expr":{"pattern":".","legacy":1,"type":"prim_event","vars":[],"op":"pageview"},"foreach":[]},"start_line":10},{"cond":{"val":"true","type":"bool"},"blocktype":"every","actions":[{"action":{"source":null,"name":"noop","args":[],"modifiers":null,"vars":null},"label":null}],"post":null,"pre":null,"name":"errorstack","start_col":5,"emit":"try {   var foo = 7 / 0;  } catch(e) { KOBJ.errorstack_submit(\"1eeefa6eeaa5c01ce7cff7c471da5a3b\", e); }             ","state":"inactive","callbacks":null,"pagetype":{"event_expr":{"pattern":"","legacy":1,"type":"prim_event","vars":[],"op":"pageview"},"foreach":[]},"start_line":17},{"cond":{"val":"true","type":"bool"},"blocktype":"every","actions":[{"action":{"source":null,"name":"noop","args":[],"modifiers":null,"vars":null},"label":null}],"post":null,"pre":null,"name":"log","start_col":5,"emit":"KOBJ.log(\"runtime info\");            ","state":"active","callbacks":null,"pagetype":{"event_expr":{"pattern":"","legacy":1,"type":"prim_event","vars":[],"op":"pageview"},"foreach":[]},"start_line":24},{"cond":{"val":"true","type":"bool"},"blocktype":"every","actions":[{"action":{"source":null,"name":"noop","args":[],"modifiers":null,"vars":null},"label":null}],"post":null,"pre":null,"name":"errorstackfull","start_col":5,"emit":"try {    x = 1 / 0;    } catch(e) {          var txt=\"_s=1eeefa6eeaa5c01ce7cff7c471da5a3b&_r=img\";          txt+=\"&Msg=\"+escape(e.message ? e.message : e);          txt+=\"&URL=\"+escape(e.fileName ? e.fileName : \"\");          txt+=\"&Line=\"+ (e.lineNumber ? e.lineNumber : 0);          txt+=\"&name=\"+escape(e.name ? e.name : e);          txt+=\"&Platform=\"+escape(navigator.platform);          txt+=\"&UserAgent=\"+escape(navigator.userAgent);          txt+=\"&stack=\"+escape(e.stack ? e.stack : \"\");          var i = document.createElement(\"img\");          i.setAttribute(\"src\", \"http://www.errorstack.com/submit?\" + txt);          document.body.appendChild(i);  }              ","state":"inactive","callbacks":null,"pagetype":{"event_expr":{"pattern":"","legacy":1,"type":"prim_event","vars":[],"op":"pageview"},"foreach":[]},"start_line":31}],"meta_start_col":5,"meta":{"keys":{"errorstack":"1eeefa6eeaa5c01ce7cff7c471da5a3b"},"logging":"off","name":"JS Emit","meta_start_line":2,"meta_start_col":5},"dispatch_start_line":7,"global_start_col":null,"ruleset_name":"a166x2"}