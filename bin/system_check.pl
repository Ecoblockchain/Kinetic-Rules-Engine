#!/usr/bin/perl
# Adapted from http://www.cyberciti.biz/tips/howto-write-perl-script-to-monitor-disk-space.html
use strict;
use warnings;
use lib qw(/web/lib/perl);

use Filesys::Df;
use Getopt::Std;
use Log::Log4perl qw(get_logger :levels);
use Mail::SendGrid;
use Mail::SendGrid::Transport::REST;

use Data::Dumper;


use Kynetx::Configure qw/:all/;

my $logger=get_logger();

 # configure KNS
Kynetx::Configure::configure();

# file system to monitor
my $dir = "/";
 
# warning level
my $diskspace_warning_level=get_config("DISK_SPACE_THRESHOLD") || 10;

# check diskspace 
# get df
my $df = df $dir;

# warn Dumper df $dir;
 
# calculate 
my $df_free = 100 - $df->{"per"};

# If $out is undefined below, no email is sent
my $out;

# Add checks for anything here. Set $out to force email to send
if ($df_free < $diskspace_warning_level) {
 $out .= sprintf("WARNING Disk Space on $dir lower than threshold value (%0.2f%%): %0.2f%% \n", $diskspace_warning_level, $df_free);
}
 

if (defined $out) {

    my $this_host = get_config("EVAL_HOST");
    # email setup
    my $acct_system_owner =  Kynetx::Configure::get_config('ACCT_SYSTEM_OWNER') || "KRE System";
    my $acct_system_owner_email =  Kynetx::Configure::get_config('ACCT_SYSTEM_OWNER_EMAIL') || 'noreply@'. $this_host;
 
    my $to = get_config("SERVER_ADMIN");
    my $subject='KRE System Check Alert';
 
    $out .= "Occured at " . localtime(time) . "\n";
    $out .= "\n$acct_system_owner on ". $this_host;
    #warn $out;

    my $sg = Mail::SendGrid->new( from => $acct_system_owner_email,
				  to => $to,
				  subject => $subject,
				  text => $out,
				);

    #disable click tracking filter for this request
    $sg->disableClickTracking();

    #set a category
    $sg->header->setCategory('system_check_alert');

    my $un = Kynetx::Configure::get_config('SENDGRID_USERNAME');
    my $pw = Kynetx::Configure::get_config('SENDGRID_PASSWORD');

    my $trans = Mail::SendGrid::Transport::REST->new( username =>  $un, 
						      password =>  $pw
						    );

    my $error = $trans->deliver($sg);
    if ($error) {
	my $msg = "Sendgrid error sending system check alert: " . $error;
	$logger->warn($msg);
	warn $msg;
    }
}
