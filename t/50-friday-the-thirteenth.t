#!/usr/bin/perl
## ----------------------------------------------------------------------------

# Example from: http://googleappsscript.blogspot.com/2010/10/google-apps-script-and-recurring.html

use Test::More tests => 6;

use Date::Recur;
use Date::Recur::Rule::OnDaysOfWeek;
use Date::Recur::Rule::OnDaysOfMonth;

my ($r1, $r2);

# basic recurrance, no start/end dates
$r1 = Date::Recur->new();
$r1->include(
    Date::Recur::Rule::OnDaysOfWeek->new( days_of_week => [ Date::Recur::FRIDAY ] )
);
$r1->include(
    Date::Recur::Rule::OnDaysOfMonth->new( days_of_month => [ 13 ] )
);

# start again with the convenience methods
$r2 = Date::Recur->new();
$r2->include_days_of_week( Date::Recur::FRI );
$r2->include_days_of_month( 13 );

do_test( $r1 );
do_test( $r2 );

## ----------------------------------------------------------------------------

sub do_test {
    my ($recur) = @_;

    ok( !$recur->matches( '2010-11-12' ), q{Matches Friday, but it's the 12th} );
    ok( !$recur->matches( '2010-11-13' ), q{Matches 13th, but it's a Saturday} );
    ok(  $recur->matches( '2010-08-13' ), q{Friday the 13th} );
}

## ----------------------------------------------------------------------------
