#!/usr/bin/perl -w
#
# This file is part of the Kinetic Rules Engine (KRE)
# Copyright (C) 2007-2011 Kynetx, Inc. 
#
# KRE is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 2 of
# the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be
# useful, but WITHOUT ANY WARRANTY; without even the implied
# warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
# PURPOSE.  See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public
# License along with this program; if not, write to the Free
# Software Foundation, Inc., 59 Temple Place, Suite 330, Boston,
# MA 02111-1307 USA
#
use lib qw(/web/lib/perl);
use strict;

use Test::More;
use Test::LongString;
use Cache::Memcached;
use Apache::Session::Memcached;


# most Kyentx modules require this
use Log::Log4perl qw(get_logger :levels);
Log::Log4perl->easy_init($INFO);
#Log::Log4perl->easy_init($DEBUG);

use Kynetx::Test qw/:all/;
use Kynetx::Predicates::Page qw/:all/;
use Kynetx::JavaScript qw/:all/;
use Kynetx::Session qw/:all/;
use Kynetx::Configure qw/:all/;


use Kynetx::FakeReq qw/:all/;

use Data::Dumper;
$Data::Dumper::Indent = 1;


my $preds = Kynetx::Predicates::Page::get_predicates();
my @pnames = keys (%{ $preds } );


my $r = Kynetx::Test::configure();

my $rid = 'cs_test';

# test choose_action and args



my $rule_name = 'foo';

my $rule_env = Kynetx::Test::gen_rule_env();


my $session = Kynetx::Test::gen_session($r, $rid);
my $session_id = Kynetx::Session::session_id($session);
my $options = {'g_id' => $session_id, 'ridver' => 'dev'};
my $my_req_info = Kynetx::Test::gen_req_info($rid,$options);


my %rule_env = ();



# check that predicates at least run without error
my @dummy_arg = (0);
foreach my $pn (@pnames) {
    ok(&{$preds->{$pn}}($my_req_info, $rule_env,\@dummy_arg) ? 1 : 1, "$pn runs");
}


##
## page:url
##

is(get_pageinfo($my_req_info, 'url', ['hostname']),
   'www.windley.com',
   'page:url hostname');

is(get_pageinfo($my_req_info, 'url', ['domain']),
   'windley.com',
   'page:url domain');


is(get_pageinfo($my_req_info, 'url', ['tld']),
   'com',
   'page:url tld');

is(get_pageinfo($my_req_info, 'url', ['protocol']),
   'http',
   'page:url protocol');

is(get_pageinfo($my_req_info, 'url', ['query']),
   undef,
   'page:url query');

is(get_pageinfo($my_req_info, 'url', ['path']),
   "/",
   'page:url path');

is(get_pageinfo($my_req_info, 'url', ['port']),
   80,
   'page:url path');

# new domain
#diag "testing with two element hostname";
$my_req_info->{'caller_url'} = undef; # reset
$my_req_info->{'caller'} = 'http://windley.com';
is(get_pageinfo($my_req_info, 'url', ['hostname']),
   'windley.com',
   'page:url windley.com hostname');

is(get_pageinfo($my_req_info, 'url', ['domain']),
   'windley.com',
   'page:url windley.com domain');


is(get_pageinfo($my_req_info, 'url', ['tld']),
   'com',
   'page:url windley.com tld');

is(get_pageinfo($my_req_info, 'url', ['protocol']),
   'http',
   'page:url windley.com protocol');

is(get_pageinfo($my_req_info, 'url', ['query']),
   undef,
   'page:url windley.com query');

is(get_pageinfo($my_req_info, 'url', ['path']),
   '',
   'page:url windley.com path');

is(get_pageinfo($my_req_info, 'url', ['port']),
   80,
   'page:url windley.com path');


# new domain with path and query
#diag "testing with path and query";
$my_req_info->{'caller_url'} = undef; #reset
$my_req_info->{'caller'} = 'http://www.windley.com/foo?x=y&foog=goog';
is(get_pageinfo($my_req_info, 'url', ['hostname']),
   'www.windley.com',
   'page:url path & query hostname');

is(get_pageinfo($my_req_info, 'url', ['domain']),
   'windley.com',
   'page:url path & query domain');


is(get_pageinfo($my_req_info, 'url', ['tld']),
   'com',
   'page:url path & query tld');

is(get_pageinfo($my_req_info, 'url', ['protocol']),
   'http',
   'page:url path & query protocol');

is(get_pageinfo($my_req_info, 'url', ['query']),
   'x=y&foog=goog',
   'page:url path & query query');

is(get_pageinfo($my_req_info, 'url', ['path']),
   '/foo',
   'page:url path & query path');

is(get_pageinfo($my_req_info, 'url', ['port']),
   80,
   'page:url path & query path');

is(get_pageinfo($my_req_info, 'env', ['rid']), 'cs_test', 'page:env("rid")');
is(get_pageinfo($my_req_info, 'env', ['ip']), '72.21.203.1', 'page:env("ip")');
is(get_pageinfo($my_req_info, 'env', ['rule_version']), 'dev', 'page:env("dev")');

my $params = {
   'msg' => 'Hello World!',
 };


is_deeply(get_pageinfo($my_req_info, 'params', []), $params, "Params gives all");

is(get_pageinfo($my_req_info, 'param', ['msg']), $params->{'msg'}, "Param");


is_deeply(get_pageinfo($my_req_info, 'attrs', []), $params, "Attrs gives all");

is(get_pageinfo($my_req_info, 'attr', ['msg']), $params->{'msg'}, "Attr");

is(get_pageinfo($my_req_info, 'env', ['g_id']),
   $session_id,
   'event:env("g_id")');

done_testing(29 + int(@pnames));


1;


