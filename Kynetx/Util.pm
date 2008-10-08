package Kynetx::Util;
# file: Kynetx/Util.pm

use strict;
use warnings;

use Log::Log4perl qw(get_logger :levels);
use Kynetx::Memcached qw(:all);


use Exporter;
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK %EXPORT_TAGS);

our $VERSION     = 1.00;
our @ISA         = qw(Exporter);

our %EXPORT_TAGS = (all => [ 
qw(
reduce
before_now
after_now
mk_created_session_name
config_logging
) ]);
our @EXPORT_OK   =(@{ $EXPORT_TAGS{'all'} }) ;


# set up logging
sub config_logging {
    my ($r) = @_;
    # we can use the 'debug' config parameter to force detailed logging
    if($r->dir_config('run_mode') eq 'development' || 
       $r->dir_config('debug') eq 'on') {
	Log::Log4perl->init('/web/lib/perl/dev-log4perl.conf');
    } elsif($r->dir_config('run_mode') eq 'production') {
	Log::Log4perl->init('/web/lib/perl/prod-log4perl.conf');
    }
}

# takes a counter name and makes a uniform session var name from it
sub mk_created_session_name {
    my $name = shift;
    return $name.'_created';
}

# From HOP
# reduce(sub { $a + $b }, @VALUES)
sub reduce (&@) {
    my $code = shift;
    my $val = shift;
    for (@_) {
	local($a, $b) = ($val, $_);
	$val = $code->($val, $_);
    }
    return $val;
}


sub before_now {
    my $desired = shift;

    my $now = DateTime->now;

    # print("Comparing ", $now . " with " . $desired . "\n");

    # 1 if first greater than second
    return DateTime->compare($now,$desired) == 1;

}


sub after_now {
    my $desired = shift;

    return not before_now($desired);

}


