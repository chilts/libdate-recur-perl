#!/usr/bin/perl
## ----------------------------------------------------------------------------

use Test::More tests => 32;

use Date::Recur;
use Date::Recur::Rule::MonthlyInterval;

my ($quarterly_1, $quarterly_2);
$quarterly_1 = Date::Recur->new( start => '2010-11-02' );
$quarterly_2 = Date::Recur->new( start => '2010-11-02' );

# explicit method
$quarterly_1->include(
    Date::Recur::Rule::MonthlyInterval->new( interval => 3 )
);

# convenience method
$quarterly_2->include_monthly_interval( 3 );

do_tests( $quarterly_1 );
do_tests( $quarterly_2 );

## ----------------------------------------------------------------------------

sub do_tests {
    my ($r) = @_;

    ok( !$r->matches( '2010-11-01' ), q{Doesn't Match November (before start date)} );
    ok(  $r->matches( '2010-11-02' ), q{Matches November (on start date)} );
    ok(  $r->matches( '2010-11-03' ), q{Matches November (after start date)} );
    ok( !$r->matches( '2010-12-01' ), q{Doesn't Match December} );

    ok( !$r->matches( '2011-01-01' ), q{Doesn't Match January} );
    ok(  $r->matches( '2011-02-01' ), q{Matches Feburary} );
    ok( !$r->matches( '2011-03-01' ), q{Doesn't Match March} );
    ok( !$r->matches( '2011-04-01' ), q{Doesn't Match April} );
    ok(  $r->matches( '2011-05-01' ), q{Matches May} );
    ok( !$r->matches( '2011-06-01' ), q{Doesn't Match June} );
    ok( !$r->matches( '2011-07-01' ), q{Doesn't Match July} );
    ok(  $r->matches( '2011-08-01' ), q{Matches August} );
    ok( !$r->matches( '2011-09-01' ), q{Doesn't Match September} );
    ok( !$r->matches( '2011-10-01' ), q{Doesn't Match October} );
    ok(  $r->matches( '2011-11-01' ), q{Matches November} );
    ok( !$r->matches( '2011-12-01' ), q{Doesn't Match December} );
}

## ----------------------------------------------------------------------------
