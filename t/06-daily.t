#!/usr/bin/perl
## ----------------------------------------------------------------------------

use Test::More tests => 20;

use Date::Recur;
use Date::Recur::Rule::DailyInterval;

my ($daily_1, $daily_2);
$daily_1 = Date::Recur->new( start => '2010-11-02' );
$daily_2 = Date::Recur->new( start => '2010-11-02' );

# explicit method
$daily_1->include(
    Date::Recur::Rule::DailyInterval->new( interval => 3 )
);

# convenience method
$daily_2->include_daily_interval( 3 );

do_tests( $daily_1 );
do_tests( $daily_2 );

## ----------------------------------------------------------------------------

sub do_tests {
    my ($r) = @_;

    ok( !$r->matches( '2010-11-01' ), q{Doesn't Match the First (before start date)} );
    ok(  $r->matches( '2010-11-02' ), q{Matches the 2nd (on start date)} );
    ok( !$r->matches( '2010-11-03' ), q{Doesn't Match the 3rd} );
    ok( !$r->matches( '2010-11-04' ), q{Doesn't Match the 4th} );
    ok(  $r->matches( '2010-11-05' ), q{Matches the 5th} );

    ok( !$r->matches( '2010-12-25' ), q{Doesn't Match Christmas Day} );
    ok( !$r->matches( '2010-12-31' ), q{Doesn't Match New Year's Eve} );
    ok(  $r->matches( '2011-01-01' ), q{Matches New Year's Day} );
    ok(  $r->matches( '2011-02-06' ), q{Matches Waitangi Day} );
    ok( !$r->matches( '2011-02-14' ), q{Doesn't Match Valentines Day} );
}

## ----------------------------------------------------------------------------
