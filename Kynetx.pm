

package Kynetx;
# file: Kynetx.pm

use strict;
use warnings;


use XML::XPath;
use LWP::Simple;
use DateTime;
use Log::Log4perl qw(get_logger :levels);
use Cache::Memcached;

use Kynetx::Rules qw(:all);;
use Kynetx::Util qw(:all);;
use Kynetx::Session qw(:all);
use Kynetx::Memcached qw(:all);
use Kynetx::RuleManager qw(:all);
use Kynetx::Console qw(:all);;



# Make this global so we can use memcache all over
our $memd;

my $s = Apache2::ServerUtil->server;

sub handler {
    my $r = shift;

    # configure logging for production, development, etc.
    config_logging($r);

    my $logger = get_logger();

    $r->content_type('text/javascript');
    
    my @host_array = $r->dir_config->get('memcached_hosts');

    if($r->dir_config('memcached_hosts')) {
	Kynetx::Memcached->init(\@host_array);
    }

    # at some point we need a better dispatch function
    if($r->path_info =~ m!/flush/! ) {
	flush_ruleset_cache($r);
    } elsif($r->path_info =~ m!/console/! ) {
	show_context($r);
    } elsif($r->path_info =~ m!/foo/! ) {
	my $uniq = int(rand 999999999);
	$r->content_type('text/html');
	print "$uniq";
	

    } else {

	process_rules($r);
    }

    return Apache2::Const::OK; 
}

1;






sub flush_ruleset_cache {
    my ($r) = @_;

    # nothing to do if no memcache hosts
    return unless $r->dir_config('memcached_hosts');

    my $logger = get_logger();

    my ($site) = $r->path_info =~ m#/(\d+)#;

    Log::Log4perl::MDC->put('site', $site);
    Log::Log4perl::MDC->put('rule', '[global]');  # no rule for now...


    $logger->debug("[flush] flushing rules for $site");
    my $memd = get_memd();
    $memd->delete("ruleset:$site");

    $r->content_type('text/html');
    my $msg = "Rules flushed for site $site";
    print "<title>$msg</title><h1>$msg</h1>";

}

