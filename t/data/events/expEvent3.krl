// composite events
ruleset 10 {
  rule is_expression1 is active {
    select when pageview 
	{
		noop();
	}
    }
}
