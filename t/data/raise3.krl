// testing postlude raise
ruleset 10 {
  rule frequent_archive_visitor is active {
    select using "/archives/(\d+)/\d+/" setting (year)

    noop();

    fired {
      raise explicit event foo with
         x = 5 and
         y = "hello"
       if(bar eq "bizz");
    } 

  }
}
