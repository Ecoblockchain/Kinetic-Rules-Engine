// select without var
ruleset 10 {
    rule test0 is active {
        select using "/test/" setting()
        pre {
      	    tc = weather:tomorrow_cond_code();
	    city = geoip:city();
	}     
      float("absolute", "top: 10px", "right: 10px",
            "/cgi-bin/weather.cgi?city=" + city + "&tc=" + tc)
        with delay = 0 and
             draggable = true and
             scrollable = true and
             effect = "appear";

    }
}
