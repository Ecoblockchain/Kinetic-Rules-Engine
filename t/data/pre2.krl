// pre decl emty
ruleset 10 {
    rule test0 is active {
        select using "/test/" setting()
        pre {

	}     
        replace("test","test");
    }
}
