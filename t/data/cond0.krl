// adding conditional test (single)
ruleset 10 {
    rule test0 is active {
        select using "/test/" setting()
        pre {
      	    tc = weather:tomorrow_cond_code();
	    city = geoip:city();
	}     
        if nighttime()
        then 
           float("absolute", "top: 10px", "right: 10px", "url")
             with delay = 0 and
                  draggable = true and
                  scrollable = true and
                  effect = "appear";


    }
}
