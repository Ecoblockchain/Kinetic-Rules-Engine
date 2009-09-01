package Kynetx::Parser;
# file: Kynetx/Parser.pm
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
use strict;
use warnings;

use Exporter;
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK %EXPORT_TAGS);

our $VERSION     = 1.00;
our @ISA         = qw(Exporter);

our %EXPORT_TAGS = (all => [ 
qw(
parse_ruleset
remove_comments
mk_expr_node
) ]);
our @EXPORT_OK   =(@{ $EXPORT_TAGS{'all'} }) ;

use Log::Log4perl qw(get_logger :levels);

use Parse::RecDescent;
use Data::Dumper;

use vars qw(%VARIABLE);

# Enable warnings within the Parse::RecDescent module.

$::RD_ERRORS = 1; # Make sure the parser dies when it encounters an error
#$::RD_WARN   = 1; # Enable warnings. This will warn on unused rules &c.
#$::RD_HINT   = 1; # Give out hints to help fix problems.

#$::RD_AUTOSTUB = 1;
#$::RD_TRACE = 1;

my $grammar = <<'_EOGRAMMAR_';
{my $errors = "";
} # startup action

# Terminals (macros that can't expand further)
#
REGEXP: /\/(\\.|[^\/])+\/(i|g){0,2}/
HTML: /<<.*?>>/s  {$return=Kynetx::Parser::html($item[1]) }
STRING: /"(\\"|[^"])*"|'[^']'/ {$return=Kynetx::Parser::string($item[1]) }
VAR:   /[_A-Za-z]\w*/ 
NUM:   /\d*\.\d+|\d+/          
COMMA: /,/ 
INCR: /\+=/ 
DECR: /-=/ 
DOT: /\./ 
OP:   m([+-/*])          
LBRACKET: /\[/ 
RBRACKET: /\]/ 
LPAREN: /\(/ 
RPAREN: /\)/ 
EQUALS: /=/ 
INEQUALITY: /[<>]/ 
COLON: /:/ 
SEMICOLON: /;/ 
LOGICAL_AND: /&&/ 
BOOL: 'true' | 'false' 

eofile: /^\Z/

ruleset: 'ruleset' ruleset_name  '{' 
           meta_block(0..1)
           dispatch_block(0..1)
           global_decls(0..1)
           rule(s?)   #??
         '}' eofile
             {$return = {
		 'ruleset_name' => $item{ruleset_name},
		 'meta' => $item[4][0] || {},
		 'dispatch' => $item[5][0] || [],
		 'global' => $item[6][0] || [],
		 'rules' => $item[7]
	         }
	     }
       | { foreach (@{$thisparser->{errors}}) {
              $errors .= "Line $_->[1]:$_->[0]\n";
           }
          $thisparser->{errors} = undef;
          $return = {'error' => $errors}
          }

ruleset_name: VAR  # {return $item[1]}
            | NUM  # {return $item[1]}
            | <error>

meta_block_top: meta_block
   | { foreach (@{$thisparser->{errors}}) {
              $errors .= "Line $_->[1]:$_->[0]\n";
           }
       $thisparser->{errors} = undef;
       $return = {'error' => $errors}
     }



meta_block: 'meta' '{' 
       pragma(s?)
      '}' 
    { my $r = {};
      foreach my $a ( @{ $item[3] } ) {
        foreach my $k (keys %{ $a } ) {
           if($r->{$k} && ref $r->{$k} eq 'HASH' && ref $a->{$k} eq 'HASH') {
               foreach my $k1 (keys %{ $a->{$k} }) {
                  $r->{$k}->{$k1} = $a->{$k}->{$k1}; 
               }
           } else {
               $r->{$k} = $a->{$k};
           }
        }
      }

      $return = $r;
    }
 | <error>

pragma: desc_block 
    {$return = {
        'description' => $item[1]
        }
    }
 | 'name' STRING
    {$return = {
        'name' => $item[2]
        }
    }
 | 'author' STRING
    {$return = {
        'author' => $item[2]
        }
    }
 | 'key' ('errorstack' | 'googleanalytics') STRING
    {$return = {
        keys => { $item[2] => $item[3] }
      }
    }
 | logging_pragma
    {$return = {
        'logging' => $item[1]
        }
    }
 | <error>

desc_block: 'description' (HTML | STRING)
   {$return = $item[2];}
 | <error>


logging_pragma: 'logging' ('on' | 'off')
   {$return = $item[2];}
 | <error>


dispatch_block_top: dispatch_block
   | { $errors = "";
       foreach (@{$thisparser->{errors}}) {
              $errors .= "Line $_->[1]:$_->[0]\n";
           }
       $thisparser->{errors} = undef;
       $return = {'error' => $errors}
     }


dispatch_block: 'dispatch' '{' dispatch(s?) '}' #?
     {$return = $item[3]}

dispatch: 'domain' STRING dispatch_target(?)
     {$return = {
	 'domain' => $item[2],
	 'ruleset_id' => $item[3][0] 
         }
     }
   | <error>

dispatch_target: '->' STRING
     {$return = $item[2]
     }
                   

dataset: 'dataset' VAR '<-' STRING cachable(?)
     {$return = {
	 'name' => $item[2],
	 'type' => 'dataset',
	 'source' => $item[4],
	 'cachable' => $item[5][0] || 0
         }
     }

datasource: 'datasource' VAR '<-' STRING cachable(?)
     {$return = {
	 'name' => $item[2],
	 'type' => 'datasource',
	 'source' => $item[4],
	 'cachable' => $item[5][0] || 0
         }
     }

cachable: 'cachable' cachetime(?)
     {$return = $item[2][0] || 1
     }
   | <error>

cachetime: 'for' NUM (periods | period)
     {$return = {
	 'value' => $item[2],
	 'period' => $item[3]
      }
     }
   | <error>

css_emit: 'css' (HTML | STRING)
   {$return = {
       'type' => 'css',
       'content' => $item[2]
    }
   }


global_decls_top: global_decls
   | { $errors = "";
       foreach (@{$thisparser->{errors}}) {
              $errors .= "Line $_->[1]:$_->[0]\n";
           }
       $thisparser->{'errors'} = undef;
       $return = {'error' =>  $errors}
     }


global_decls: 'global' '{' global(s? /;/)  SEMICOLON(?) '}' #?
     {$return = $item[3]}
    | <error>

global: emit_block
          {$return = {'emit' => $item[1]
                     }
          }
       | dataset
          {$return = $item[1]
          }
       | datasource
          {$return = $item[1]
          }
       | css_emit
          {$return = $item[1]
          }
       | <error>


rule_top: rule
   | { $errors = "";
       foreach (@{$thisparser->{errors}}) {
              $errors .= "Line $_->[1]:$_->[0]\n";
           }
       $thisparser->{errors} = undef;
       $return = {'error' => $errors}
     }



rule: 'rule' VAR 'is' rule_state '{'
        select
        pre_block(0..1)
        emit_block(0..1)
        action SEMICOLON(?)
        callbacks(0..1)
        post_block(0..1)
       '}'
  {$return = {'name' => $item{VAR},
	      'state' => $item{rule_state},
	      'pagetype' => $item{select},
  	      'pre' => $item[7][0],
	      'emit' => $item[8][0],
  	      'actions' => $item{action}->{'actions'},
	      'blocktype' => $item{action}->{'blocktype'} || 'every',
	      'cond' => $item{action}->{'cond'} || 
		        Kynetx::Parser::mk_expr_node('bool','true'),
	      'callbacks' => $item[11][0],
	      'post' => $item[12][0]
           } }
  | <error>


rule_state: 'active'
          | 'inactive'
          | 'test'
          | <error>


select:  'select' 'using' STRING 
            'setting' '(' VAR(s? /,/) ')' SEMICOLON(?) #?
	  {$return =
	   { 'pattern' => $item[3],
	     'vars' => $item[6]
	   } 
	  }
      | <error>


pre_block: 'pre' '{' decl(s? /;/) SEMICOLON(?) '}' #?
           {$return=$item[3]}
         | <error>


decl: VAR '=' expr
      {$return =
       {'lhs' => $item[1],
        'type' => 'expr',
        'rhs' => $item[3]
       }
      }
    | VAR '=' HTML
      {$return =
       {'lhs' => $item[1],
        'type' => 'here_doc',
        'rhs' => $item[3]
       }
      }
    | <error: Invalid decl: $text>



emit_block: 'emit' (HTML | STRING)
   {$return = $item[2];}


action: conditional_action 
        {$return = $item{conditional_action}}
      | unconditional_action 
        {$return = $item{unconditional_action}}
      | <error>

conditional_action: 'if' predexpr 'then' unconditional_action
        {$return=
         {'cond' => $item{predexpr},
          'blocktype' => $item{unconditional_action}->{'blocktype'} || 'every',
          'actions' => $item{unconditional_action}->{'actions'},
         }
        }

unconditional_action: primrule 
        {$return =
         {'blocktype' => 'every',
          'actions' => [$item{primrule}],
         }
        }
   | actionblock
        {$return = $item{actionblock}}

primrule: rule_label(?) action_name '(' expr(s? /,/) ')' modifier_clause(?)
        {$return =
         {'label' => $item[1][0],
          'action' => 
             {'args' => $item[4],
              'modifiers' => $item[6][0],  # returned as array of array
              'name' => $item{action_name}
             }
         }
        }
     | rule_label(?) emit_block
        {$return = 
	 {'label' => $item[1][0],
          'emit' => $item[2],
         }
	}
     | <error>

rule_label: VAR ':'
        {$return = $item[1]}

modifier_clause: 'with' modifier(s /and/)
        {$return = $item[2]}

modifier: VAR '=' expr
        {$return=
         {'name' => $item{VAR},
          'value' => $item{expr}
         }
        }

action_name: 'after'
           | 'alert'
           | 'annotate_search_results'
           | 'append'
           | 'before'
           | 'close_notification'
           | 'float_html'
           | 'float'
           | 'move_after'
           | 'move_to_top'
           | 'notify'
           | 'noop'
           | 'popup'
           | 'prepend'
           | 'redirect'
           | 'replace_html'
           | 'replace_image_src'
           | 'replace'
           | <error>

actionblock: blocktype(?) '{' primrule(s /;/) SEMICOLON(?) '}'
      {$return =
       {'blocktype' => $item[1][0] || 'every',
	'actions' => $item[3]
       }
      }

blocktype: 'choose'
         | 'every'


#
# Predicate expressions
#
predexpr: conjunction '||' predexpr
      {$return=
       {'type' => 'pred',
        'op' => '||',
        'args' => [$item[1], $item[3]]
       }
      }
    | conjunction


conjunction: pred '&&' conjunction
      {$return=
       {'type' => 'pred',
        'op' => '&&',
        'args' => [$item[1], $item[3]]
       }
      }
    | pred


# FIXME: move all pred terms into expression?  
pred: 'not' pred
      {$return =
       {'type' => 'pred',
        'op' => 'negation',
        'args' => [$item[2]]
       }
      }
    | '(' predexpr ')'
      {$return = $item[2]}
    | 'seen' STRING 'in' var_domain ':' VAR timeframe(?)
      {$return=
       {'type' => 'seen_timeframe',
	'domain' => $item[4],
        'var' => $item[6],
	'regexp' => $item[2],
        'within' => (ref $item[7][0] eq 'HASH') ? $item[7][0]->{'within'} : undef,
        'timeframe' => (ref $item[7][0] eq 'HASH') ? $item[7][0]->{'period'} : undef,
       }
      }
    | 'seen' STRING ('before' | 'after') STRING 'in' var_domain ':' VAR
      {$return=
       {'type' => 'seen_compare',
	'domain' => $item[6],
        'var' => $item[8],
	'regexp_1' => $item[2],
	'regexp_2' => $item[4],
	'op' => $item[3],
       }
      }
    | var_domain ':' VAR predop expr timeframe 
      {$return=
       {'type' => 'persistent_ineq',
	'domain' => $item[1],
        'var' => $item[3],
        'ineq' => $item[4],
        'expr' => $item[5],
        'within' => (ref $item[6] eq 'HASH') ? $item[6]->{'within'} : undef,
        'timeframe' => (ref $item[6] eq 'HASH') ? $item[6]->{'period'} : undef,
       }
      }
    | var_domain ':' VAR timeframe 
      {$return=
       {'type' => 'persistent_ineq',
	'domain' => $item[1],
        'var' => $item[3],
        'ineq' => '==',
        'expr' => Kynetx::Parser::mk_expr_node('bool','true'),
        'within' => (ref $item[4] eq 'HASH') ? $item[4]->{'within'} : undef,
        'timeframe' => (ref $item[4] eq 'HASH') ? $item[4]->{'period'} : undef,
       }
      }
    | expr predop expr
      {$return =
       {'type' => 'ineq',
	'op' => $item[2],
	'args' => [$item[1], $item[3]]
       }
      }
    | expr
    | <error>

predop: '<=' | '>=' | '<' | '>' | '==' | '!=' | 'eq' | 'neq' | 'like'

var_domain: 'ent' | 'app'


#
# Callbacks
#
callbacks: 'callbacks' '{' success(?) failure(?) '}'
     {$return=
      {'success' => $item[3][0],
       'failure' => $item[4][0]
      }
     }

success: 'success' '{' click(s /;/)  SEMICOLON(?) '}'
     {$return= $item[3] }
   
failure: 'failure' '{' click(s /;/)  SEMICOLON(?) '}'
     {$return= $item[3] }
   
click: ('click' | 'change') VAR '=' STRING click_link(?)
     {$return=
      {'type' => $item[1],
       'attribute' => $item{VAR},
       'value' => $item{STRING},
       'trigger' => $item[5][0],
      }
     }
     | <error>

click_link: 'triggers' persistent_expr
  {$return=$item[2]}

post_block: post '{' persistent_expr(s? /;/) SEMICOLON(?) '}' post_alternate(?)
     {$return=
      {'type' => $item[1],
       'cons' => $item[3],
       'alt' => $item[6][0],
      }
     }
  
post: 'fired'
    | 'always'
    | 'notfired'


post_alternate: 'else' '{' persistent_expr(s?  /;/) SEMICOLON(?) '}'
      {$return=$item[3]}

persistent_expr: persistent_clear
   | persistent_set
   | persistent_iterate
   | trail_forget
   | trail_mark


persistent_clear: 'clear' var_domain ':' VAR 
     {$return=
      {'action' => 'clear',
       'type' => 'persistent',
       'domain' => $item[2],
       'name' => $item[4],
      }
     }

persistent_set: 'set' var_domain ':' VAR 
     {$return=
      {'action' => 'set',
       'type' => 'persistent',
       'domain' => $item[2],
       'name' => $item[4],
      }
     }

persistent_iterate: var_domain ':' VAR counter_op expr counter_start(?)
     {$return=
      {'action' => 'iterator',
       'type' => 'persistent',
       'domain' => $item[1],
       'name' => $item[3],
       'op' => $item[4],
       'value' => $item[5],
       'from' => defined $item[6][0] ? $item[6][0] : 1 ,
      }
     }
    
trail_forget: 'forget' STRING 'in' var_domain ':' VAR
     {$return=
      {'action' => 'forget',
       'type' => 'persistent',
       'domain' => $item[4],
       'name' => $item[6],
       'regexp' => $item[2],
      }
     }

trail_mark: 'mark' var_domain ':' VAR trail_with(?)
     {$return=
      {'action' => 'mark',
       'type' => 'persistent',
       'domain' => $item[2],
       'name' => $item[4],
       'with' => $item[5][0],
      }
     }

trail_with: 'with' expr
   {$return = $item[2]}
   

counter_op: '+='
          | '-='
          | <error>

counter_start: 'from' expr

expr: term term_op expr
      {$return=
       {'type' => 'prim',
        'op' => $item[2],
        'args' => [$item[1], $item[3]]
       }
      }
    | term

term_op: '+'|'-'

term: factor factor_op term
      {$return=
       {'type' => 'prim',
        'op' => $item[2],
        'args' => [$item[1], $item[3]]
       }
      }
    | factor '.' operator '(' expr(s? /,/) ')'
        {$return =
	 {'type' => 'operator',
          'name' => $item[3],
	  'args' => $item[5],
	  'obj' => $item[1]
         }}
    | factor

factor_op: '*'|'/'

operator: 'pick'|'length'|'replace'

factor: NUM
        {$return=Kynetx::Parser::mk_expr_node('num',$item[1])}
      | '-' NUM
        {$return=Kynetx::Parser::mk_expr_node('num',$item[2] * -1)}
      | STRING
        {$return=Kynetx::Parser::mk_expr_node('str',$item[1])}
      | REGEXP
        {$return=Kynetx::Parser::mk_expr_node('regexp',$item[1])}
      | 'true'
        {$return=Kynetx::Parser::mk_expr_node('bool',$item[1])}
      | 'false'
        {$return=Kynetx::Parser::mk_expr_node('bool',$item[1])}
      | persistent_var
      | trail_exp
      | simple_pred 
      | qualified_pred
      | VAR   # if this isn't after 'true' and 'false' they'll be vars
        {$return=Kynetx::Parser::mk_expr_node('var',$item[1])}
      | '[' expr(s? /,/) ']'
        {$return=Kynetx::Parser::mk_expr_node('array',$item[2])}
      | '{' hash_line(s? /,/) '}'
          {$return=Kynetx::Parser::mk_expr_node('hashraw',$item[2])}
      | '(' expr ')'
        {$return=$item[2]}
      | <error>


hash_line: STRING ':' expr
   {$return= {'lhs' => $item[1], 
              'rhs' => $item[3]}}

persistent_var: var_domain ':' VAR
     {$return=
      {'type' => 'persistent',
       'domain' => $item[1],
       'name' => $item[3],
      }
     }

trail_exp: 'current' var_domain ':' VAR 
     {$return=
      {'type' => 'trail_history',
       'offset' => Kynetx::Parser::mk_expr_node('num','0'),
       'domain' => $item[2],
       'name' => $item[4],
      }
     }
 | 'history' expr var_domain ':' VAR 
     {$return=
      {'type' => 'trail_history',
       'offset' => $item[2],
       'domain' => $item[3],
       'name' => $item[5],
      }
     }

simple_pred: VAR '(' expr(s? /,/) ')' 
      {$return=
       {'type' => 'simple',
        'predicate' => $item{VAR},
        'args' => $item[3]
       }
      }

qualified_pred: VAR ':' VAR '(' expr(s? /,/) ')'
      {$return=
       {'type' => 'qualified',
        'source' => $item[1],
        'predicate' => $item[3],
        'args' => $item[5]
       }
      }


timeframe: 'within' expr (periods | period)
      {$return=
       {'within' => $item[2],
        'period' => $item[3]
       }
      }

period: 'year'
   {$return = $item[1].'s'}
 | 'month'
   {$return = $item[1].'s'}
 | 'week'
   {$return = $item[1].'s'}
 | 'day'
   {$return = $item[1].'s'}
 | 'hour'
   {$return = $item[1].'s'}
 | 'minute'
   {$return = $item[1].'s'}
 | 'second'
   {$return = $item[1].'s'}
 | <error>

periods: 'years'
      | 'months'
      | 'weeks'
      | 'days'
      | 'hours'
      | 'minutes'
      | 'seconds'
      | <error>



_EOGRAMMAR_

sub html {
    my ($value) = @_;
    $value =~ s/^<<\s*//;
    $value =~ s/>>\s*$//;
    $value =~ s/[\n\r]/  /sg;
    return $value;
}

sub string {
    my ($value) = @_;
    $value =~ s/^["']//;
    $value =~ s/["']$//;
    return $value;
}


my $parser = Parse::RecDescent->new($grammar);

# this removes KRL-style comments taking into account quotes
my $comment_re = qr%
       /\*         ##  Start of /* ... */ comment
       [^*]*\*+    ##  Non-* followed by 1-or-more *'s
       (
         [^/*][^*]*\*+
       )*          ##  0-or-more things which don't start with /
                   ##    but do end with '*'
       /           ##  End of /* ... */ comment
     |
        //[^\n]*    ## slash style comments
     |         ##     OR  various things which aren't comments:

       (
         "           ##  Start of " ... " string
         (
           \\.           ##  Escaped char
         |               ##    OR
           [^"\\]        ##  Non "\
         )*
         "           ##  End of " ... " string
       # |         ##     OR  various things which aren't comments:
       #   <<           ##  Start of << ... >> string
       #   .*
       #   >>           ##  End of " ... " string

       |         ##     OR
        .           ##  Anything other char
         [^/"'<\\]*   ##  Chars which doesn't start a comment, string or escape
#         [^/"'<\\]*   ##  Chars which doesn't start a comment, string or escape
       )
     %xs;

sub remove_comments {

    my($ruleset) = @_;

    $ruleset =~ s%$comment_re%defined $2 ? $2 : ""%gxse;
    return $ruleset;

}

sub parse_ruleset {
    my ($ruleset) = @_;

    my $logger = get_logger();

    $ruleset = remove_comments($ruleset);


#    print $ruleset; exit;

    # remove newlines
#    $ruleset =~ s%\n%%g;


    my $result = ($parser->ruleset($ruleset));
    if (defined $result->{'error'}) {
	$logger->error("Can't parse ruleset: $result->{'error'}");
    } else {
	$logger->debug("Parsed rules");
    }

    return $result;

#    print Dumper($result);


}

# Helper function used in testing  
sub parse_expr {
    my ($expr) = @_;
    
    my $logger = get_logger();

    $expr = remove_comments($expr);

    # remove newlines
    $expr =~ s%\n%%g;


    my $result = ($parser->expr($expr));
    if (defined $result->{'error'}) {
	$logger->error("Can't parse expression: $result->{'error'}");
    } else {
	$logger->debug("Parsed expression");
    }

    return $result;

#    print Dumper($result);


}

# Helper function used in testing  
sub parse_decl {
    my ($expr) = @_;
    
    my $logger = get_logger();

    $expr = remove_comments($expr);

    # remove newlines
    $expr =~ s%\n%%g;

    my $result = ($parser->decl($expr));
    if (defined $result->{'error'}) {
	$logger->error("Can't parse expression: $result->{'error'}");
    } else {
	$logger->debug("Parsed expression");
    }

    return $result;

#    print Dumper($result);


}

# Helper function used in testing  
sub parse_pre {
    my ($expr) = @_;
    
    my $logger = get_logger();

    $expr = remove_comments($expr);

    # remove newlines
    $expr =~ s%\n%%g;

    my $result = ($parser->pre_block($expr));
    # if (defined $result->{'error'}) {
    # 	$logger->error("Can't parse expression: $result->{'error'}");
    # } else {
    # 	$logger->debug("Parsed expression");
    # }

    return $result;

#    print Dumper($result);


}

# Helper function used in testing  
sub parse_predexpr {
    my ($expr) = @_;
    
    my $logger = get_logger();

    $expr = remove_comments($expr);

    # remove newlines
    $expr =~ s%\n%%g;

    my $result = ($parser->predexpr($expr));
    if (defined $result->{'error'}) {
	$logger->error("Can't parse expression: $result->{'error'}");
    } else {
	$logger->debug("Parsed expression");
    }

    return $result;

#    print Dumper($result);


}


sub parse_rule {
    my ($rule) = @_;
    
    my $logger = get_logger();

    $rule = remove_comments($rule);


#    print $rule; exit;

    # remove newlines
    $rule =~ s%\n%%g;


    my $result = ($parser->rule_top($rule));

    if (ref $result eq 'HASH' && $result->{'error'}) {
	$logger->debug("Can't parse rule: $result->{'error'}");
    } else {
	$logger->debug("Parsed rules");
    }

    return $result;

#    print Dumper($result);


}


sub parse_action {
    my $rule = shift;
    
    my $logger = get_logger();

    $rule = remove_comments($rule);

    # remove newlines
    $rule =~ s%\n%%g;

    my $result = $parser->action($rule);
    if (defined $result->{'error'}) {
	$logger->error("Can't parse actions: $result->{'error'}");
    } else {
	$logger->debug("Parsed rules");
    }

    return $result;

}

sub parse_callbacks {
    my $rule = shift;
    
    my $logger = get_logger();

    $rule = remove_comments($rule);

    # remove newlines
    $rule =~ s%\n%%g;

    my $result = $parser->callbacks($rule);
    if (defined $result->{'error'}) {
	$logger->error("Can't parse actions: $result->{'error'}");
    } else {
	$logger->debug("Parsed rules");
    }

    return $result;

}

sub parse_post {
    my $rule = shift;
    
    my $logger = get_logger();

    $rule = remove_comments($rule);

    # remove newlines
    $rule =~ s%\n%%g;

    my $result = $parser->post_block($rule);
    if (defined $result->{'error'}) {
	$logger->error("Can't parse actions: $result->{'error'}");
    } else {
	$logger->debug("Parsed rules");
    }

    return $result;

}

sub parse_global_decls {
    my $element = shift;
    
    my $logger = get_logger();

    $element = remove_comments($element);

    my $result = $parser->global_decls_top($element);

#    $logger->debug(Dumper($result));
    if (ref $result eq 'HASH' && $result->{'error'}) {
	$logger->debug("Can't parse global declarations: $result->{'error'}");
    } else {
	$logger->debug("Parsed global decls");#, 
    }
    

    return $result;

}

sub parse_dispatch {
    my $element = shift;
    
    my $logger = get_logger();

    $element = remove_comments($element);

    my $result = $parser->dispatch_block_top($element);

    if (ref $result eq 'HASH' && $result->{'error'}) {
	$logger->debug("Can't parse dispatch declaration: $result->{'error'}");
    } else {
	$logger->debug("Parsed dispatch declaration");
    }

    return $result;

}


sub parse_meta {
    my $element = shift;
    
    my $logger = get_logger();

    $element = remove_comments($element);

    my $result = $parser->meta_block_top($element);
    
    if (ref $result eq 'HASH' && $result->{'error'}) {
	$logger->debug("Can't parse meta information: $result->{'error'}");
    } else {
	$logger->debug("Parsed meta information");
    }


    return $result;

}


sub mk_expr_node {
    my($type, $val) = @_;
    return {'type' => $type,
	    'val' => $val};
}


1;
