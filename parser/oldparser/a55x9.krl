{"global":[{"source":"http://weather.yahooapis.com/forecastrss","name":"dsYahooWeather","type":"datasource","datatype":"JSON","cachable":{"period":"minutes","value":"1"}},{"source":"http://query.yahooapis.com/v1/public/yql","name":"dsYahooWoeid","type":"datasource","datatype":"JSON","cachable":{"period":"minutes","value":"1"}},{"rhs":{"source":"geoip","predicate":"city","args":[],"type":"qualified"},"lhs":"city","type":"expr"},{"rhs":{"source":"geoip","predicate":"state","args":[],"type":"qualified"},"lhs":"state","type":"expr"},{"content":"div#kGrowl div#WeatherList {        background-color: #e56e1b;        margin: 2px;        clear: both;      }    ","type":"css"}],"global_start_line":10,"dispatch":[],"dispatch_start_col":null,"meta_start_line":2,"rules":[{"cond":{"val":"true","type":"bool"},"blocktype":"every","actions":[{"action":{"source":null,"name":"notify","args":[{"args":[{"val":"Yahoo! Weather <br />","type":"str"},{"args":[{"val":"city","type":"var"},{"val":"state","type":"var"}],"type":"prim","op":"+"}],"type":"prim","op":"+"},{"val":"InitializedDiv","type":"var"}],"modifiers":[{"value":{"val":"green","type":"str"},"name":"background_color"},{"value":{"val":"true","type":"bool"},"name":"sticky"},{"value":{"val":0.8,"type":"num"},"name":"opacity"}],"vars":null},"label":null}],"post":null,"pre":[{"rhs":"<div id=\"WeatherList\">  </div>  \n ","lhs":"InitializedDiv","type":"here_doc"}],"name":"initialize","start_col":5,"emit":null,"state":"active","callbacks":null,"pagetype":{"event_expr":{"pattern":".*","legacy":1,"type":"prim_event","vars":[],"op":"pageview"},"foreach":[]},"start_line":15},{"cond":{"val":"true","type":"bool"},"blocktype":"every","actions":[{"action":{"source":null,"name":"append","args":[{"val":"#WeatherList","type":"str"},{"val":"InitializedNotifyList","type":"var"}],"modifiers":null,"vars":null},"label":null}],"post":null,"pre":[{"rhs":{"args":[{"val":"?q=select%20*%20from%20geo.places%20where%20text%3D%22","type":"str"},{"args":[{"val":"city","type":"var"},{"args":[{"val":"%20","type":"str"},{"args":[{"val":"state","type":"var"},{"val":"%22&format=xml","type":"str"}],"type":"prim","op":"+"}],"type":"prim","op":"+"}],"type":"prim","op":"+"}],"type":"prim","op":"+"},"lhs":"appendUrl","type":"expr"},{"rhs":{"source":"datasource","predicate":"dsYahooWoeid","args":[{"val":"appendUrl","type":"var"}],"type":"qualified"},"lhs":"woeidData","type":"expr"},{"rhs":{"obj":{"val":"woeidData","type":"var"},"args":[{"val":"$..woeid.$t","type":"str"}],"name":"pick","type":"operator"},"lhs":"woeid","type":"expr"},{"rhs":{"source":"datasource","predicate":"dsYahooWeather","args":[{"val":"?w=#{woeid}&u=f","type":"str"}],"type":"qualified"},"lhs":"weatherData","type":"expr"},{"rhs":{"obj":{"val":"weatherData","type":"var"},"args":[{"val":"$..yweather$condition.@temp","type":"str"}],"name":"pick","type":"operator"},"lhs":"temp","type":"expr"},{"rhs":{"obj":{"val":"weatherData","type":"var"},"args":[{"val":"$..yweather$condition.@text","type":"str"}],"name":"pick","type":"operator"},"lhs":"text","type":"expr"},{"rhs":{"obj":{"val":"weatherData","type":"var"},"args":[{"val":"$..image.url.$t","type":"str"}],"name":"pick","type":"operator"},"lhs":"imgsrc","type":"expr"},{"rhs":"<div style = 'background-color:#ffee8c;margin:3px;'>          <a href = ''>  \t           #{text} - #{temp}          </a>  \t<img src=\"#{imgsrc}\"/>        </div>    \n ","lhs":"InitializedNotifyList","type":"here_doc"}],"name":"populate","start_col":5,"emit":null,"state":"active","callbacks":null,"pagetype":{"event_expr":{"pattern":".*","legacy":1,"type":"prim_event","vars":[],"op":"pageview"},"foreach":[]},"start_line":29}],"meta_start_col":5,"meta":{"logging":"on","name":"Yahoo Weather","meta_start_line":2,"author":"Chris Jensen","description":"Yahoo Weather     \n","meta_start_col":5},"dispatch_start_line":null,"global_start_col":5,"ruleset_name":"a55x9"}
