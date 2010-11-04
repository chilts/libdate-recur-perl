#!/usr/bin/perl
## ----------------------------------------------------------------------------

# The Wellington PerlMongers group meets on the Tuesday _after_ the first
# Monday of every month, except January (when it doesn't meet at all).

use Test::More tests => 30;

use Date::Recur;
use Date::Recur::Rule::OnDaysOfWeek;
use Date::Recur::Rule::OnDaysOfMonth;
use Date::Recur::Rule::OnMonthsOfYear;

my ($r1, $r2);

$r1 = Date::Recur->new();
$r1->include(
    Date::Recur::Rule::OnDaysOfWeek->new( days_of_week => [ Date::Recur::TUESDAY ] )
);
$r1->include(
    Date::Recur::Rule::OnDaysOfMonth->new( days_of_month => [ 2..8 ] )
);
$r1->exclude(
    Date::Recur::Rule::OnMonthsOfYear->new( months_of_year => [ Date::Recur::JANUARY ] )
);

# start again with the convenience methods
$r2 = Date::Recur->new();
$r2->include_days_of_week( Date::Recur::TUE );
$r2->include_days_of_month( 2..8 );
$r2->exclude_months_of_year( Date::Recur::JAN );

do_test( $r1 );
do_test( $r2 );

## ----------------------------------------------------------------------------

sub do_test {
    my ($recur) = @_;

    # meetings
    ok(  $recur->matches( '2010-02-02' ), q{Feb} );
    ok(  $recur->matches( '2010-03-02' ), q{Mar} );
    ok(  $recur->matches( '2010-04-06' ), q{Apr} );
    ok(  $recur->matches( '2010-05-04' ), q{May} );
    ok(  $recur->matches( '2010-06-08' ), q{Jun} );
    ok(  $recur->matches( '2010-07-06' ), q{Jul} );
    ok(  $recur->matches( '2010-08-03' ), q{Aug} );
    ok(  $recur->matches( '2010-09-07' ), q{Sep} );
    ok(  $recur->matches( '2010-10-05' ), q{Oct} );
    ok(  $recur->matches( '2010-11-02' ), q{Nov} );
    ok(  $recur->matches( '2010-12-07' ), q{Dec} );

    # not meetings
    ok( !$recur->matches( '2010-01-03' ), q{Not in January} );
    ok( !$recur->matches( '2010-02-09' ), q{Not 9th Feb} );
    ok( !$recur->matches( '2010-03-09' ), q{Not 9th Mar} );
    ok( !$recur->matches( '2010-06-01' ), q{Not 1st Jun} );
}

## ----------------------------------------------------------------------------
