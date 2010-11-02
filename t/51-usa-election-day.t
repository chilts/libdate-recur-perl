#!/usr/bin/perl
## ----------------------------------------------------------------------------

# Example from: http://googleappsscript.blogspot.com/2010/10/google-apps-script-and-recurring.html

use Test::More tests => 12;

use Date::Recur;
use Date::Recur::Rule::OnDaysOfWeek;
use Date::Recur::Rule::OnDaysOfMonth;
use Date::Recur::Rule::OnMonthsOfYear;
use Date::Recur::Rule::YearlyInterval;

my ($r1, $r2);

$r1 = Date::Recur->new();
$r1->start( '2010-11-02' );
$r1->include(
    Date::Recur::Rule::OnDaysOfWeek->new( days_of_week => [ Date::Recur::TUESDAY ] )
);
$r1->include(
    Date::Recur::Rule::OnDaysOfMonth->new( days_of_month => [ 2, 3, 4, 5, 6, 7, 8 ] )
);
$r1->include(
    Date::Recur::Rule::OnMonthsOfYear->new( months_of_year => [ Date::Recur::NOVEMBER ] )
);
$r1->include(
    Date::Recur::Rule::YearlyInterval->new( interval => 4 )
);

# start again with the convenience methods
$r2 = Date::Recur->new( start => '2010-11-02' );
$r2->include_days_of_week( Date::Recur::TUE );
$r2->include_days_of_month( 2, 3, 4, 5, 6, 7, 8 );
$r2->include_months_of_year( Date::Recur::NOV );
$r2->include_yearly_interval( 4 );

do_test( $r1 );
do_test( $r2 );

## ----------------------------------------------------------------------------

sub do_test {
    my ($recur) = @_;

    ok(  $recur->matches( '2010-11-02' ), q{Matches first Tuesday in November} );
    ok( !$recur->matches( '2010-11-08' ), q{Doesn't match first Monday in November} );
    ok( !$recur->matches( '2010-12-07' ), q{Doesn't match first Tuesday in December} );

    # try for 2011 (first Tuesday is the 1st, so it's the 2nd Tuesday we want - the 8th)
    ok( !$recur->matches( '2011-11-01' ), q{Doesn't match first Tuesday in November in 2011} );
    ok( !$recur->matches( '2011-11-08' ), q{Doesn't match 2nd Tuesday in November in 2011} );

    # try for 2014 (Tuesday 4th November)
    ok(  $recur->matches( '2014-11-04' ), q{Matches 4th November 2014} );
}

## ----------------------------------------------------------------------------
