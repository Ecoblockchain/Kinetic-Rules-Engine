// adding name to meta
ruleset 10 {

    meta {
      name "Ruleset for Orphans"
      description <<
Ruleset for testing something or other.
>>
      // put these in alphabetical order for the sake of testing
      key errorstack "192345"
      key googleanalytics  "fg593940"
    }

    rule test0 is active {
        select using "/test/" setting()

	alert("hello");

    }
}
