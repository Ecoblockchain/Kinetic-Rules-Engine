#!/usr/bin/perl -w 

#
# Copyright 2007-2009, Kynetx Inc.  All rights reserved.
# 
# This Software is an unpublished, proprietary work of Kynetx Inc.
# Your access to it does not grant you any rights, including, but not
# limited to, the right to install, execute, copy, transcribe, reverse
# engineer, or transmit it by any means.  Use of this Software is
# governed by the terms of a Software License Agreement transmitted
# separately.
# 
# Any reproduction, redistribution, or reverse engineering of the
# Software not in accordance with the License Agreement is expressly
# prohibited by law, and may result in severe civil and criminal
# penalties. Violators will be prosecuted to the maximum extent
# possible.
# 
# Without limiting the foregoing, copying or reproduction of the
# Software to any other server or location for further reproduction or
# redistribution is expressly prohibited, unless such reproduction or
# redistribution is expressly permitted by the License Agreement
# accompanying this Software.
# 
# The Software is warranted, if at all, only according to the terms of
# the License Agreement. Except as warranted in the License Agreement,
# Kynetx Inc. hereby disclaims all warranties and conditions
# with regard to the software, including all warranties and conditions
# of merchantability, whether express, implied or statutory, fitness
# for a particular purpose, title and non-infringement.
# 
use lib qw(/web/lib/perl);
use strict;

use Test::More;
use Test::LongString;

use APR::URI qw/:all/;
use APR::Pool ();
use LWP::Simple;
use XML::XPath;
use LWP::UserAgent;
use JSON::XS;
use Cache::Memcached;
use Apache::Session::Memcached;
use DateTime;

use Data::Dumper;
$Data::Dumper::Indent = 1;


use Kynetx::Test qw/:all/;
use Kynetx::Parser qw/:all/;
use Kynetx::Operators qw/:all/;
use Kynetx::Environments qw/:all/;
use Kynetx::JavaScript qw/:all/;
use Kynetx::Predicates::Referers qw/:all/;
use Kynetx::Predicates::Markets qw/:all/;
use Kynetx::Predicates::Location qw/:all/;
use Kynetx::Predicates::Weather qw/:all/;
use Kynetx::Predicates::MediaMarkets qw/:all/;
use Kynetx::Predicates::Page qw/:all/;
use Kynetx::Session qw(:all);
use Kynetx::Memcached qw(:all);
use Kynetx::FakeReq qw(:all);

use Log::Log4perl qw(get_logger :levels);
Log::Log4perl->easy_init($INFO);
#Log::Log4perl->easy_init($DEBUG);

my $logger = get_logger();


# is_deeply(decode_json(
# 	      gen_js_expr(
# 		   mk_expr_node('hash', 
# 				{"fizz" => mk_expr_node('num',3), 
# 				 "flip" => mk_expr_node('num',8), 
# 				 "flop" => mk_expr_node('str',"Blackfoot, ID")}))),
# 	  decode_json('{"fizz": 3, "flip": 8, "flop": "Blackfoot, ID"}'),
# 	  "gen_js_exp and hashes");



#
# testing Javascript expression evaluation
# 

# configure KNS
Kynetx::Configure::configure();




my (@expr_testcases, @decl_testcases, @pre_testcases, $str, $val, $krl);

sub add_expr_testcase {
    my($str,$js,$expected,$diag) = @_;
    my $val = Kynetx::Parser::parse_expr($str);

    chomp $str;
    
    diag("$str = ", Dumper($val)) if $diag;

    push(@expr_testcases, {'expr' => $val,
		       'src' => $str,
		       'js' => $js,
		       'diag' => $diag,
		       'val' => $expected eq 'unchanged' ? $val : $expected});
}

sub add_decl_testcase {
    my($str, $expected, $diag) = @_;
    my $val = Kynetx::Parser::parse_decl($str);

    chomp $str;
    
    diag("$str = ", Dumper($val)) if $diag;

    push(@decl_testcases, {'expr' => $val,
			   'src' => $str,
			   'diag' => $diag,
			   'val' => $expected,
	 });
}

sub add_pre_testcase {
    my($str, $expected, $diag) = @_;
    my $val = Kynetx::Parser::parse_pre($str);

    chomp $str;
    
    diag("$str = ", Dumper($val)) if $diag;

    push(@pre_testcases, {'expr' => $val,
			   'src' => $str,
			   'val' => $expected,
	 });
}

my $krl_src;

$krl_src = <<_KRL_;
global {
   datasource twitter_search <- "http://search.twitter.com/search.json";
}
_KRL_

$krl = Kynetx::Parser::parse_global_decls($krl_src);
    
my $rid = 'abcd1234';
my $rule_name = 'foo';

my $rule_env = empty_rule_env();

$rule_env = extend_rule_env(
    ['city','tc','temp','booltrue','boolfalse','a','b','datasource:'.$krl->[0]->{'name'}],
    ['Blackfoot','15',20,'true','false','10','11',$krl->[0]],
    $rule_env);



$rule_env = extend_rule_env('store',{
	"store"=> {
		"book"=> [ 
			{
				"category"=> "reference",
				"author"=> "Nigel Rees",
				"title"=> "Sayings of the Century",
				"price"=> 8.95,
				"ratings"=> [
					1,
					3,
					2,
					10
				]
			},
			{ 
				"category"=> "fiction",
				"author"=> "Evelyn Waugh",
				"title"=> "Sword of Honour",
				"price"=> 12.99,
				"ratings" => [
						"good",
						"bad",
						"lovely"
					]
			},
			{
				"category"=> "fiction",
				"author"=> "Herman Melville",
				"title"=> "Moby Dick",
				"isbn"=> "0-553-21311-3",
				"price"=> 8.99
			},
			{
				"category"=> "fiction",
				"author"=> "J. R. R. Tolkien",
				"title"=> "The Lord of the Rings",
				"isbn"=> "0-395-19395-8",
				"price"=> 22.99
			}
		],
		"bicycle"=> {
			"color"=> "red",
			"price"=> 19.95
		}
	}
 },$rule_env);


# set up session
$logger->debug("Initializing memcached");
Kynetx::Memcached->init();

my $r = new Kynetx::FakeReq();

my $session = process_session($r);

session_store($rid, $session, 'my_count', 2);

session_push($rid, $session, 'my_trail', "http://www.windley.com/foo.html");
session_push($rid, $session, 'my_trail', "http://www.kynetx.com/foo.html");
session_push($rid, $session, 'my_trail', "http://www.windley.com/bar.html");

session_set($rid, $session, 'my_flag');

my $BYU_req_info;
$BYU_req_info->{'ip'} = '128.187.16.242'; # Utah (BYU)
$BYU_req_info->{'referer'} = 'http://www.google.com/search?q=free+mobile+calls&ie=utf-8&oe=utf-8&aq=t&rls=org.mozilla:en-US:official&client=firefox-a'; 
$BYU_req_info->{'caller'} = 'http://www.windley.com/archives/2008/07?q=foo'; 
$BYU_req_info->{'pool'} = APR::Pool->new;
$BYU_req_info->{'kvars'} = '{"foo": 5, "bar": "fizz", "bizz": [1, 2, 3]}';
$BYU_req_info->{'foozle'} = 'Foo';
$BYU_req_info->{'rid'} = $rid;

$BYU_req_info->{"$rid:datasets"} = "aaa,aaawa,ebates";



$str = <<_KRL_;
"absolute"
_KRL_
add_expr_testcase(
    $str,
    "'absolute'",
    mk_expr_node('str', 'absolute'));

$str = <<_KRL_;
city
_KRL_
add_expr_testcase(
    $str,
    'city',
    mk_expr_node('str', 'Blackfoot')
    );

$str = <<_KRL_;
true
_KRL_
add_expr_testcase(
    $str,
    'true',
    mk_expr_node('bool', 'true')
    );

$str = <<_KRL_;
false
_KRL_
add_expr_testcase(
    $str,
    'false',
    mk_expr_node('bool', 'false')
    );

$str = <<_KRL_;
1022
_KRL_
add_expr_testcase(
    $str,
    1022,
    mk_expr_node('num', 1022)
    );


$str = <<_KRL_;
5 + 6
_KRL_
add_expr_testcase(
    $str,
    '(5 + 6)',
    mk_expr_node('num', 11),
    0);

$str = <<_KRL_;
6 - 5
_KRL_
add_expr_testcase(
    $str,
    '(6 - 5)',
    mk_expr_node('num', 1));

$str = <<_KRL_;
5 * 7
_KRL_
add_expr_testcase(
    $str,
    '(5 * 7)',
    mk_expr_node('num', 35),
    0);

$str = <<_KRL_;
25 / 5
_KRL_
add_expr_testcase(
    $str,
    '(25 / 5)',
    mk_expr_node('num', 5));

$str = <<_KRL_;
-5
_KRL_
add_expr_testcase(
    $str,
    '-5',
    mk_expr_node('num', -5),
    0);

$str = <<_KRL_;
"foo" + "bar"
_KRL_
add_expr_testcase(
    $str,
    "('foo' + 'bar')",
    mk_expr_node('str', 'foobar'),
    0);


$str = <<_KRL_;
"/cgi-bin/weather.cgi?city=" + city + "&tc=" + tc
_KRL_
add_expr_testcase(
    $str,
    "('/cgi-bin/weather.cgi?city=' + (city + ('&tc=' + tc)))",
    mk_expr_node('str', '/cgi-bin/weather.cgi?city=Blackfoot&tc=15'),
    0);

$str = <<_KRL_;
"/cgi-bin/weather.cgi?city=" + city + "&tc=" + tc + "foo=" + city + "fizz=" + tc
_KRL_
add_expr_testcase(
    $str,
    "('/cgi-bin/weather.cgi?city=' + (city + ('&tc=' + (tc + ('foo=' + (city + ('fizz=' + tc)))))))",
    mk_expr_node('str', '/cgi-bin/weather.cgi?city=Blackfoot&tc=15foo=Blackfootfizz=15'),
    0);




$str = <<_KRL_;
5 + temp
_KRL_
add_expr_testcase(
    $str,
    "(5 + temp)",
    mk_expr_node('num', 25),
    0);

$str = <<_KRL_;
(5 + 6) * 3
_KRL_
add_expr_testcase(
    $str,
    "((5 + 6) * 3)",
    mk_expr_node('num', 33),
    0);

$str = <<_KRL_;
5 + 6 * 3
_KRL_
add_expr_testcase(
    $str,
    "(5 + (6 * 3))",
    mk_expr_node('num', 23),
    0);

$str = <<_KRL_;
[5, 6, 7]
_KRL_
add_expr_testcase(
    $str,
    "[5, 6, 7]",
     mk_expr_node('array', [mk_expr_node('num', 5),
 			    mk_expr_node('num', 6),
 			    mk_expr_node('num', 7)]),
    0);

$str = <<_KRL_;
[5, 6, temp]
_KRL_
add_expr_testcase(
    $str,
    "[5, 6, temp]",
     mk_expr_node('array', [mk_expr_node('num', 5),
 			    mk_expr_node('num', 6),
 			    mk_expr_node('num', 20)]),
    0);

$str = <<_KRL_;
[false, true, true, booltrue]
_KRL_
add_expr_testcase(
    $str,
    "[false, true, true, booltrue]",
     mk_expr_node('array', [mk_expr_node('bool', 'false'),
 			    mk_expr_node('bool', 'true'),
  			    mk_expr_node('bool', 'true'),
 			    mk_expr_node('bool', 'true')]),
    0);

$str = <<_KRL_;
[boolfalse, booltrue]
_KRL_
add_expr_testcase(
    $str,
    "[boolfalse, booltrue]",
     mk_expr_node('array', [mk_expr_node('bool', 'false'),
 			    mk_expr_node('bool', 'true')]),
    0);


$str = <<_KRL_;
page:id("foo")
_KRL_
add_expr_testcase(
    $str,
    'K$(\'foo\').innerHTML',
    mk_expr_node('JS', 'K$(\'foo\').innerHTML'),
    0);


$str = <<_KRL_;
page:id(city + "_ID")
_KRL_
add_expr_testcase(
    $str,
    'K$((city + \'_ID\')).innerHTML',
    mk_expr_node('JS', 'K$(\'Blackfoot_ID\').innerHTML'),
    0);



$str = <<_KRL_;
page:var("foo");
_KRL_
add_expr_testcase(
    $str,
    "",
     mk_expr_node('num', 5),
    0);



$str = <<_KRL_;
page:var("fo" + "o");
_KRL_
add_expr_testcase(
    $str,
    "",
     mk_expr_node('num', 5),
    0);


$str = <<_KRL_;
c = page:id("foo")
_KRL_
add_decl_testcase(
    $str,
    'K$(\'foo\').innerHTML',
    0);


# not in allowed (until we reinstate security patch, this will return Foo
$str = <<_KRL_;
page:env("foozle");
_KRL_
add_expr_testcase(
    $str,
    "",
    mk_expr_node('str','Foo'),
    0);

$str = <<_KRL_;
page:env("ip");
_KRL_
add_expr_testcase(
    $str,
    "",
     mk_expr_node('str', '128.187.16.242'),
    0);

$str = <<_KRL_;
page:url("protocol");
_KRL_
add_expr_testcase(
    $str,
    "",
     mk_expr_node('str', 'http'),
    0);


$str = <<_KRL_;
page:url("hostname");
_KRL_
add_expr_testcase(
    $str,
    "",
     mk_expr_node('str', 'www.windley.com'),
    0);


$str = <<_KRL_;
page:url("domain");
_KRL_
add_expr_testcase(
    $str,
    "",
     mk_expr_node('str', 'windley.com'),
    0);


$str = <<_KRL_;
page:url("tld");
_KRL_
add_expr_testcase(
    $str,
    "",
     mk_expr_node('str', 'com'),
    0);


$str = <<_KRL_;
page:url("port");
_KRL_
add_expr_testcase(
    $str,
    "",
     mk_expr_node('num', 80),
    0);

$str = <<_KRL_;
page:url("path");
_KRL_
add_expr_testcase(
    $str,
    "",
     mk_expr_node('str', '/archives/2008/07'),
    0);


$str = <<_KRL_;
page:url("query");
_KRL_
add_expr_testcase(
    $str,
    "",
    mk_expr_node('str', 'q=foo'),
    0);


$str = <<_KRL_;
page:param("datasets");
_KRL_
add_expr_testcase(
    $str,
    "",
     mk_expr_node('str', "aaa,aaawa,ebates"),
    0);



$str = <<_KRL_;
{"fizz": 3,
 "flip": 3 + 5,
 "flop": city + ", ID"}
_KRL_
add_expr_testcase(
    $str,
    "{'fizz' : 3, 'flip' : (3 + 5), 'flop' : (city + ', ID')}",
     mk_expr_node('hash', 
		  {"fizz" => mk_expr_node('num',3), 
		   "flip" => mk_expr_node('num',8), 
		   "flop" => mk_expr_node('str',"Blackfoot, ID")}),
    0);



$str = <<_KRL_;
c = 3;
_KRL_
add_decl_testcase(
    $str,
    '3',
    0);

$str = <<_KRL_;
c = 3 + a;
_KRL_
add_decl_testcase(
    $str,
    '13',
    0);


$str = <<_KRL_;
c = b * a;
_KRL_
add_decl_testcase(
    $str,
    '110',
    0);


$str = <<_KRL_;
c = b + store.pick("\$..book[1].price");
_KRL_
add_decl_testcase(
    $str,
    '23.99',
    0);


$str = <<_KRL_;
c = b + store.pick("\$..book[-1:].price");
_KRL_
add_decl_testcase(
    $str,
    '33.99',
    0);


$str = <<_KRL_;
c = "I love " + store.pick("\$..book[0].author");
_KRL_
add_decl_testcase(
    $str,
    'I love Nigel Rees',
    0);


my $re1 = extend_rule_env(['c'], 
			  ['Hello'],
			  $rule_env);
$str = <<_KRL_;
pre {
    c = "Hello";
}
_KRL_
add_pre_testcase(
    $str,
    $re1,
    0);


$re1 = extend_rule_env(['c','d'], 
		       ['Hello','Hello world!'],
		       $rule_env);
$str = <<_KRL_;
pre {
    c = "Hello";
    d = c + " world!";
}
_KRL_
add_pre_testcase(
    $str,
    $re1,
    0);


$str = <<_KRL_;
d = ent:my_count + 3
_KRL_
add_decl_testcase(
    $str,
    5,
    0);

$str = <<_KRL_;
d = 2 * ent:my_count 
_KRL_
add_decl_testcase(
    $str,
    4,
    0);

$str = <<_KRL_;
d = current ent:my_trail
_KRL_
add_decl_testcase(
    $str,
    "http://www.windley.com/bar.html",
    0);

$str = <<_KRL_;
d = history 2 ent:my_trail
_KRL_
add_decl_testcase(
    $str,
    "http://www.windley.com/foo.html",
    0);


$str = <<_KRL_;
d = (history 2 ent:my_trail).replace(/foo.html/,"hello.html") + ''
_KRL_
add_decl_testcase(
    $str,
    "http://www.windley.com/hello.html",
    0);


#$krl = Kynetx::Parser::parse_decl($str);
#diag(Dumper($krl));


plan tests => 45 + (@expr_testcases * 2) + (@decl_testcases * 1) + (@pre_testcases * 1);


# now test each test case twice
foreach my $case (@expr_testcases) {
    # diag(Dumper($case->{'expr'}));
    
    my $js = gen_js_expr($case->{'expr'});
    my $e = eval_js_expr($case->{'expr'}, $rule_env, $rule_name,$BYU_req_info, $session);

    #diag(Dumper($e));
    is($js,
       $case->{'js'},
       "Generating Javascript " . $case->{'src'});
    is_deeply($e, 
	      $case->{'val'},
	      "Evaling Javascript " . $case->{'src'});
    
}


# now test each test case twice
foreach my $case (@decl_testcases) {
    #diag(Dumper($case->{'expr'}));
    
    my ($v,$e) = Kynetx::JavaScript::eval_js_decl(
	$BYU_req_info, 
	$rule_env, $rule_name, $session, 
	$case->{'expr'}) ;
    diag Dumper($e) if $case->{'diag'};
    is_deeply($e, 
	      $case->{'val'},
	      "Evaling Javascript " . $case->{'src'});
}

# now test each test case twice
foreach my $case (@pre_testcases) {
    #diag(Dumper($case->{'expr'}));
    
    my $e = Kynetx::JavaScript::eval_js_pre(
	       $BYU_req_info, 
	       $rule_env, $rule_name, $session, 
	       $case->{'expr'}) ;
    #diag(Dumper($e));
    is_deeply($e, 
	      $case->{'val'},
	      "Evaling Javascript " . $case->{'src'});
}



# 
# testing declarations and data sources
#

#sub gen_js_decl {
#   my ($req_info, $rule_env, $rule_name, $session, $decl) = @_;



sub mk_datasource_function {
    my ($source, $args, $diag) = @_;

    return sub {

	my $function = shift; # name to test

	my $decl_src = <<_KRL_;
something = $source:$function($args);
_KRL_
        my $decl = Kynetx::Parser::parse_decl($decl_src);

	diag(Dumper($decl)) if $diag;

	my ($v,$js_decl) = Kynetx::JavaScript::eval_js_decl(
	    $BYU_req_info,
	    $rule_env,
	    $rule_name,
	    $session,
	    $decl
	    );

	my $result = $js_decl;
	
        diag($decl->{'function'} . " --> " . $result) if $diag;
	return $result;
    };

}


# check referer datasource

my $referer_function = mk_datasource_function('referer','', 0);

is(&{$referer_function}('search_terms'), 
   'free+mobile+calls',
   'keywords from search engine referer' );



# check markets datasource
# http://www.webservicex.net//stockquote.asmx/GetQuote?symbol=GOOG

SKIP: {
    my $ua = LWP::UserAgent->new;

    my $check_url = "http://www.webservicex.net//stockquote.asmx/GetQuote?symbol=GOOG";
#    my $check_url = "http://foo";

    diag "Checking $check_url";
    my $response = $ua->get($check_url);
    skip "No server available", 11 if (! $response->is_success);

    my $symbol = 'GOOG'; 

# $symbol has to be a string that is itself a valid KRL string
    my $market_function = mk_datasource_function('stocks', '"'.$symbol.'"' , 0);

    my $curr_qr = qr#\d+\.\d\d|N/A#;

    is(&{$market_function}('symbol'), $symbol , "Returned symbol is the one we sent");


    like(&{$market_function}('last'), $curr_qr, 'last price is a currency');
    like(&{$market_function}('date'), qr#\d+/\d+/\d+#, "market date is a date");
    like(&{$market_function}('time'), qr#\d+:\d#, "market time is a time");
    like(&{$market_function}('change'), qr#[+|-]?\d+\.\d+#, 'market change');
    like(&{$market_function}('open'), $curr_qr, 'open price is a currency');
    like(&{$market_function}('high'), $curr_qr, 'high price is a currency');
    like(&{$market_function}('low'), $curr_qr, 'low price is a currency');
    like(&{$market_function}('volume'), qr#\d+#, 'volume is string of digits');
    like(&{$market_function}('previous_close'), $curr_qr, 'previous close price is a currency');
    like(&{$market_function}('name'), qr#[A-Za-z ]+#, 'name is a string');

}


# check locations datasource

# http://www.webservicex.net//stockquote.asmx/GetQuote?symbol=GOOG

my $location_function = mk_datasource_function('location', '', 0);



like(&{$location_function}('country_code'), qr#[A-Z]+#, 'country code');
like(&{$location_function}('country_code3'), qr#[A-Z]+#, 'country code3');
is(&{$location_function}('region'), 'UT', 'BYU is in Utah');
is(&{$location_function}('city'), 'Provo', 'BYU is in Provo');
is(&{$location_function}('postal_code'), '84602', 'BYU is in 84602');
like(&{$location_function}('latitude'), qr#[-]*\d+\.\d+#, 'latitude is a number');
like(&{$location_function}('longitude'), qr#[-]*\d+\.\d+#, 'longitude is a number');
is(&{$location_function}('dma_code'), '770', 'BYU is in DMA 770');
is(&{$location_function}('area_code'), '801', 'BYU is in area 801');

# check weather datasource

my $weather_function = mk_datasource_function('weather','', 0);

my $temp_qr = qr#\d+\.*\d*#;  # what a temperature looks like
like(&{$weather_function}('curr_temp'), $temp_qr, 'curr_temp');
like(&{$weather_function}('curr_cond'), qr#\w#, 'curr_cond');
like(&{$weather_function}('curr_cond_code'), qr#\d#, 'curr_cond_code');
like(&{$weather_function}('tomorrow_low'), $temp_qr, 'tomorrow_low');
like(&{$weather_function}('tomorrow_high'), $temp_qr, 'tomorrow_high');
like(&{$weather_function}('tomorrow_cond'), qr#\w#, 'tomorrow_cond');
like(&{$weather_function}('tomorrow_cond_code'), qr#\d+#, 'tomorrow_cond_code');


# check media market datasource

my $mm_function = mk_datasource_function('mediamarket','', 0);

like(&{$mm_function}('dma'), qr#\d\d\d#, 'dma');
like(&{$mm_function}('rank'), qr#\d+#, 'rank');
like(&{$mm_function}('name'), qr#\w#, 'name');
like(&{$mm_function}('households'), qr#\d+#, 'households');


# check user defined data sources
SKIP: {
    my $ua = LWP::UserAgent->new;

    my $check_url = "http://search.twitter.com/search.json?q=apple";

    diag "Checking $check_url";
    my $response = $ua->get($check_url);
    skip "No server available", 1 unless ($response->is_success);

    my $ds_function = mk_datasource_function('datasource','"?q=rootbeer"', 0);
    $logger->debug("Got $ds_function");
    contains_string(encode_json(&{$ds_function}('twitter_search')), 
		    '{"page":1,"query":"rootbeer","completed_in":', 
		    'user defined datasource');

}

my $no_escape = "foo bar is a boo bar";
my $pls_escape = "foo bar isn't a boo bar";
my $escaped = "foo bar isn\\'t a boo bar";
is(escape_js_str($no_escape), $no_escape, "Escape a string");
is(escape_js_str($pls_escape), $escaped, "Escape a string");

is(infer_type('hello'),'str','inferring simple string');
is(infer_type('5'),'num','inferring single digit number number');
is(infer_type('0'),'num','inferring 0 as a number number');
is(infer_type('15'),'num','inferring integer as number');
is(infer_type('0.4'),'num','inferring real number');
is(infer_type('0847564'),'str','inferring number with leading 0');
is(infer_type('true'),'bool','inferring boolean');
is(infer_type('false'),'bool','inferring boolean');
is(infer_type([0,1,2]),'array','inferring array');
is(infer_type({'a' => 0}),'hash','inferring hash');

session_delete($rid, $session, 'my_count');
session_delete($rid, $session, 'my_trail');
session_delete($rid, $session, 'my_flag');

session_cleanup($session);


1;


