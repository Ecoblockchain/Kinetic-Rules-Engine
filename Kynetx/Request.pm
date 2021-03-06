package Kynetx::Request;

# file: Kynetx/Request.pm
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
use strict;

#use warnings;

use Data::Dumper;
use Log::Log4perl qw(get_logger :levels);
use IPC::Lock::Memcached;
use JSON::XS;
use DateTime;

use Kynetx::Rids;

use Exporter;
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK %EXPORT_TAGS);

our $VERSION = 1.00;
our @ISA     = qw(Exporter);

# put exported names inside the "qw"
our %EXPORT_TAGS = (
  all => [
    qw(
      build_request_env
      log_request_env
      merge_request_env
      set_capabilities
      )
  ]
);
our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

sub retrieve_json_from_post {
    my ($r)  = @_;
    my $len  = $r->headers_in()->get('Content-Length');

    return "{}" if($r->method ne 'POST');

    my ($buf, $content);

    while( $r->read($buf,$len) ){
        $content .= $buf;
    }

    return $content;
}

sub path_params {
  my ($r) = @_;
  my $logger= get_logger();
  my @path_components = split( /\//, $r->path_info );
  return \@path_components;
}

sub query_params {
  my ($r) = @_;
  my $req= Apache2::Request->new($r);
  
}

sub build_request_env {
  my ( $r, $method, $rids, $eventtype, $eid, $options ) = @_;

  my $logger = get_logger();

  # grab request params
  my $req = Apache2::Request->new($r);

# $logger->debug("Raw request ", sub { Dumper $r });

  my $content_type = $r->headers_in->{'Content-Type'};

  my $req_params = {};

  my @req_param_keys = $req->param;
  foreach my $k (@req_param_keys) {
    $req_params->{$k} = $req->param($k);
  }

  my $body_params;
#  $logger->debug("Request body: ",sub {Dumper($req->body())});
#  $logger->debug("Request param: ",sub {Dumper($req->param())});
  if ($content_type eq 'application/json') {

    my $body = retrieve_json_from_post($r);
    # $logger->debug("Body: ", $body);
    $body_params = JSON::XS::->new->convert_blessed(1)->pretty(1)->decode($body || "{}");
    #$logger->debug("Body params: ", sub { Dumper $body_params});

    # you'd think you could just grab the POST body and parse it here, setting the 
    # params as necessary. Unfortunately, it's not that simple since parsing the request
    # with Apache2::Request doesn't work and destroys the body...
    # BTW, this is MUCH slower than a form encoded body. Need to optimize
  }

  foreach my $k ( keys %{$body_params}) {
    $req_params->{$k} = $body_params->{$k};
  }
  

  my $domain = 
       $method                   # give path component precedence
    || $req_params->{'_domain'}
    || $body_params->{'_domain'} 
    || 'discovery';

  $eventtype =
       $eventtype                # give path component precedence
    || $req_params->{'_type'}
    || $req_params->{'_name'}
    || $body_params->{'_name'}
    || $body_params->{'_type'}
    || 'hello';

  if ( $domain eq "discovery" && $eventtype eq "hello" ) {
    $logger->debug("No domain:type given; defaulting to discovery:hello");
  }

  # we rely on this being undef if nothing passed in
  $rids = $req_params->{'_rids'} || $body_params->{'_rids'} || $rids;
  my $explicit_rids = defined $req_params->{'_rids'};
  $logger->debug("Explicitly declared rids ", $rids) if $explicit_rids;

  # endpoint identifier
  my $epi = $req_params->{'_epi'} || 'any';

  # endpoint location
  my $epl = $req_params->{'_epl'} || 'none';

  # manage optional params
  # The ID token comes in as a header in Blue API
  my $id_token = $options->{'id_token'} 
                  || $req_params->{'_eci'} 
                  || $body_params->{'_eci'}
                  || $r->headers_in->{'Kobj-Session'};
  my $api      = $options->{'api'}      || 'ruleset';

  # allow the random EID to be overridden
  $eid =  $req_params->{'_eid'} 
       || $body_params->{'_eid'}
       || $eid;


  # build initial envv
  my $ug = new Data::UUID;

  my $caller =
       $req_params->{'url'}
    || $req_params->{'caller'}
    || $r->headers_in->{'Referer'}
    || '';

  my $cookie = $r->headers_in->{'Cookie'};
  $cookie =~ s/^.*[;]?SESSION_ID=(\w*)[;]?.*$/$1/ if ( defined $cookie );

  my $request_info = {

    host => $r->connection->get_remote_host || $req_params->{'host'} || '',
    caller => $caller,    # historical
    page   => $caller,
    url    => $caller,
    now    => time,
    timestamp => DateTime->now(),
    method => $domain,

    # this is also determines the endpint capability type
    domain    => $domain,
    eventtype => $eventtype,
    eid       => $eid,

    id_token => $id_token,
    eci => $id_token,  # add this without removing other 

    explicit_rids => $explicit_rids,

    epl => $epl,
    epi => $epi,

    _api => $api,

    hostname => $r->hostname(),
    ip       => $r->connection->remote_ip() || '0.0.0.0',
    ua       => $r->headers_in->{'User-Agent'} || '',

    #	pool => $r->pool,
    uri => $r->uri(),

    # set the default major and minor version for this endpoint
    # these may get overridden by parameters below
    majv => 0,
    minv => 0,

    txn_id => $ug->create_str(),
    g_id   => $cookie,

    # directives
    directives => [],
  };

  foreach my $n (keys %{$req_params}) {
    # $logger->debug( "Param $n -> ", sub{Dumper $req_params->{$n} });
    my $not_attr = {
      '_rids'   => 1,
      '_eci'   => 1,
      'referer' => 1
    };
    if ( $not_attr->{$n} ) {
      	$request_info->{$n} = $req_params->{$n};
    }
    else {
      add_event_attr( $request_info, $n, $req_params->{$n} );
    }
  }

  # handle explicit $rids
  if ( defined $rids ) {
    my $rid_array = [];
    foreach my $rid ( split( /;/, $rids ) ) {

      my $rid_info = Kynetx::Rids::mk_rid_info( $request_info, $rid );

      push( @{$rid_array}, $rid_info );
    }
    $rids = $rid_array;
  }

  $request_info->{'rids'} = $rids;
  $request_info->{'site'} = $rids;    #historical
       # this will get overridden with a single RID later
  $request_info->{'rid'} = $rids->[0];
  $request_info->{'version'} = Kynetx::Rids::get_version($rids->[0]);

  set_capabilities($request_info);

  $logger->debug("Returning request information");

  return $request_info;
}

# mutates $req_info with a new event_attribute
sub add_event_attr {
    my ( $req_info, $attr_name, $attr_val ) = @_;

    my $logger = get_logger();
    # not doing UTF encoding on attributes for now...
    # my $enc = Kynetx::Util::str_in( $attr_val );

    my $reserved = {"type" => 1
		   };

    if (not $reserved->{$attr_name}) {

	$req_info->{'event_attrs'}->{$attr_name} = $attr_val;
	push( @{ $req_info->{'event_attrs'}->{'attr_names'} }, $attr_name );

    } else {
	$logger->warn("$attr_name is a reserved word and cannot be used as an event attribute");
    }

}

sub get_attr_names {
  my ($req_info) = @_;
  # my $logger = get_logger();
  # $logger->debug("Getting attr names ", sub{ Dumper $req_info->{'event_attrs'}->{'attr_names'} });
  return $req_info->{'event_attrs'}->{'attr_names'} || [] ;
}

sub get_attrs {
  my ($req_info) = @_;
  return $req_info->{'event_attrs'};
}

sub get_attr {
  my ( $req_info, $name ) = @_;
  return $req_info->{'event_attrs'}->{$name};
}

# events
sub get_event_domain {
  my ( $req_info ) = @_;
  return $req_info->{'domain'}
}

sub get_event_type {
  my ( $req_info ) = @_;
  return $req_info->{'eventtype'}
}

sub set_event_domain {
  my ( $req_info, $new_domain ) = @_;
  $req_info->{'domain'} = $new_domain;
}

sub set_event_type {
  my ( $req_info, $new_type ) = @_;
  $req_info->{'eventtype'} = $new_type;
}

### final
sub set_final_flag {
  my ($self) = @_;

  $self->{ Kynetx::Rids::get_rid( $self->{rid} ) }->{'final_flag'} = 1;
}

sub clr_final_flag {
  my ($self) = @_;

  undef $self->{ Kynetx::Rids::get_rid( $self->{rid} ) }->{'final_flag'};
}

sub get_final_flag {
  my ($self) = @_;

  return $self->{ Kynetx::Rids::get_rid( $self->{rid} ) }->{'final_flag'};
}

# merge multiple request environments, last wins
sub merge_req_env {
  my $first = shift;

  # don't overwrite the schedule or bad things happen...
  foreach my $req (@_) {
    foreach my $k ( keys %{$req} ) {
      $first->{$k} = $req->{$k} unless $k eq 'schedule';
    }
  }
  return $first;
}

sub log_request_env {
  my ( $logger, $request_info ) = @_;

  my $skip = {
	      "KOBJ.eventtree" => 1,
	     };

  my $max_val_length = 100;
  if ( $logger->is_debug() ) {
    my $req_type = defined $request_info->{"function_name"} ? "Query" : "Event";
    $logger->info("-----***---- Decode $req_type ----***-----");
    foreach my $entry ( sort keys %{$request_info} ) {

      next if $skip->{$entry};

      my $value = $request_info->{$entry};
      if ( $entry eq 'rids'
        || $entry eq 'site'
        || $entry eq 'rid' )
      {
        if ( ref $value eq 'ARRAY' ) {
          $value = Kynetx::Rids::print_rids($value);
	} elsif ( ref $value eq 'HASH' ) {
	  $value = Kynetx::Rids::print_rid_info($value);
        }
      }
      elsif ( $entry eq 'event_attrs' ) {
	my @attrs = ();
        while ( my ( $k, $v ) = each %{ $request_info->{$entry} } ) {
	  next if $k eq "attr_names";
          push  @attrs, "$k:" . substr( $v, 0, $max_val_length );
        }
        $value = "{" . join(", ", @attrs) . "}";

      }
      elsif ( ref $value eq 'ARRAY' ) {
        my @tmp = map { substr( $_, 0, $max_val_length ) } @$value;
        $value = '[' . join( ',', @tmp ) . ']';
      }
      else {
        if ($value) {
          $value = substr( $value, 0, $max_val_length );
        }
        else {
          $value = '';
        }

      }

      my $debug_only = {"directives" => 1,
			"majv" => 1,
			"minv" => 1,
			"KOBJ.eventtree" => 1,
			"g_id" => 1,
			"url" => 1,
			"epi" => 1,
			"epl" => 1,
			"caller" => 1,
			"id_token" => 1,
			"ip" => 1,
			"now" => 1,
			"page" => 1,
			"site" => 1,
			"ua" => 1
		       };
      
      # print out first 50 chars of the request string
      $entry = 'undef' unless defined $entry;
      $value = 'undef' unless defined $value;
      if ( $debug_only->{$entry} ) {
	  $logger->debug("$entry:$value");
      } else {
	  $logger->info("$entry:$value");
      }

    }

    # 	foreach my $h (keys %{ $r->headers_in }) {
    # 	    $logger->debug($h . ": " . $r->headers_in->{$h});
    # 	}
  }

}

sub set_capabilities {
  my $req_info = shift;
  my $capspec  = shift;

  my $logger = get_logger();

  $capspec = Kynetx::Configure::get_config('capabilities') unless $capspec;

  #  $logger->debug("Cap spec ", sub { Dumper $capspec });

  if (
    $capspec->{ $req_info->{'domain'} }->{'capabilities'}
    ->{'understands_javascript'}
    || $req_info->{'domain'} eq 'eval'
    ||    # old style evaluation
    (
      $req_info->{'domain'} eq 'web'
      && !
      defined $capspec->{'web'}->{'capabilities'}->{'understands_javascript'}
    )
    || $req_info->{'domain'} eq 'oauth_callback'
    )
  {
    $req_info->{'understands_javascript'} = 1;
  }

}

### top level storage for module envs
my $module_key = 'module:defs';
sub put_module_in_request_info {

    my($sig, $name, $version, $provides, $module_env, $js, $export_keys, $request_info) = @_;
    my $module_rep = {"name" => $name,
		      "version" => $version,
		      "sig" => $sig,
		      "provides" => $provides,
		      "module_env" => $module_env,
		      "js" => $js,
		      "export_keys" => $export_keys
		     };
    $request_info->{$module_key}->{$sig} = $module_rep;
    return $request_info
      
}

sub module_loaded {
  my($sig, $request_info) = @_;
  return defined $request_info->{$module_key}->{$sig}->{"module_env"};
}

sub get_module_provides {
    my($sig, $request_info) = @_;
    # my $logger = get_logger();
    # $logger->debug("looking up $sig ", sub {Dumper $request_info->{$module_key}});
    my $result = defined $sig && defined $request_info ? $request_info->{$module_key}->{$sig}->{"provides"}
               : {};
    return $result
}

sub get_module_env {
    my($sig, $request_info) = @_;
    # my $logger = get_logger();
    # $logger->debug("looking up $sig ", sub {Dumper $request_info->{$module_key}});
    return $request_info->{$module_key}->{$sig}->{"module_env"}
}

sub get_module {
    my($sig, $request_info) = @_;
    # my $logger = get_logger();
    # $logger->debug("looking up $sig ", sub {Dumper $request_info->{$module_key}});
    return $request_info->{$module_key}->{$sig}
}


1;
