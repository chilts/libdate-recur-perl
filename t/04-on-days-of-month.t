#!/usr/bin/perl
## ----------------------------------------------------------------------------

use Test::More tests => 6;

use Date::Recur;
use Date::Recur::Rule::OnDaysOfMonth;

# basic recurrance, no start/end dates
my $the_2nd_1 = Date::Recur->new();
my $the_2nd_2 = Date::Recur->new();

# only match on the 2nd
$the_2nd_1->include(
    Date::Recur::Rule::OnDaysOfMonth->new( days_of_month => [ 2 ] )
);

# convenience methods
$the_2nd_2->include_days_of_month( 2 );

do_tests( $the_2nd_1 );
do_tests( $the_2nd_2 );

## ----------------------------------------------------------------------------

sub do_tests {
    my ($r) = @_;

    ok( !$r->matches( '2010-11-01' ), q{Doesn't Match the 1st} );
    ok(  $r->matches( '2010-11-02' ), q{Matches the 2nd} );
    ok( !$r->matches( '2010-11-08' ), q{Doesn't Match the 3th} );
}

## ----------------------------------------------------------------------------
