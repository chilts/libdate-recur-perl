#!/usr/bin/perl
## ----------------------------------------------------------------------------
# Test for Tuesdays.
# Test with both the explicit and convenience methods.
## ----------------------------------------------------------------------------

use Test::More tests => 4;

use Date::Recur;
use Date::Recur::Rule::OnDaysOfWeek;

# basic recurrance, no start/end dates
my $tue_1 = Date::Recur->new();
my $tue_2 = Date::Recur->new();

# only match on Tuesdays
$tue_1->include(
    Date::Recur::Rule::OnDaysOfWeek->new( days_of_week => [ Date::Recur::TUESDAY ] )
);
$tue_2->include_days_of_week(
    Date::Recur::TUESDAY,
);

do_tests( $tue_1 );
do_tests( $tue_2 );

## ----------------------------------------------------------------------------

sub do_tests {
    my ($r) = @_;
    ok(  $r->matches( '2010-11-02' ), q{Matches Tuesday} );
    ok( !$r->matches( '2010-11-08' ), q{Doesn't Match Next Monday} );
}

## ----------------------------------------------------------------------------
