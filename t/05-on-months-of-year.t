#!/usr/bin/perl
## ----------------------------------------------------------------------------

use Test::More tests => 8;

use Date::Recur;
use Date::Recur::Rule::OnMonthsOfYear;

# basic recurrance, no start/end dates
my $month_1 = Date::Recur->new();
my $month_2 = Date::Recur->new();

# only match in February
$month_1->include(
    Date::Recur::Rule::OnMonthsOfYear->new( months_of_year => [ Date::Recur::FEB ] )
);

# convenience methods
$month_2->include_months_of_year( Date::Recur::FEB );

do_tests( $month_1 );
do_tests( $month_2 );

## ----------------------------------------------------------------------------

sub do_tests {
    my ($r) = @_;

    ok( !$r->matches( '2011-01-31' ), q{Doesn't Match January} );
    ok(  $r->matches( '2011-02-01' ), q{Matches February} );
    ok(  $r->matches( '2011-02-28' ), q{Matches February} );
    ok( !$r->matches( '2011-03-01' ), q{Doesn't Match March} );
}

## ----------------------------------------------------------------------------
