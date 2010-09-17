
// logging pragma in meta block
ruleset 10 {
    meta {
      description <<
Ruleset for testing something or other.
      >>
      logging off
    }

    dispatch {
      domain "www.google.com" -> "966337974"
      domain "google.com" -> "966337974"
      domain "www.circuitcity.com" -> "966337982"
    }

    rule testa is active {
        select using "/test/" setting()
        pre {
        }
        replace("test","test");
    }

    rule testb is active {
        select using "/test/" setting()
        pre {
        }
        replace("test","test");
    }


}
