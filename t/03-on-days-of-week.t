#!/usr/bin/perl
## ----------------------------------------------------------------------------
# Test for Tuesdays.
# Test with both the explicit and convenience methods.
## ----------------------------------------------------------------------------

use Test::More tests => 20;

use Date::Recur;
use Date::Recur::Rule::OnDaysOfWeek;

# basic recurrance, no start/end dates
my $tue_1 = Date::Recur->new();
my $tue_2 = Date::Recur->new();

my $sun_1 = Date::Recur->new();
my $sun_2 = Date::Recur->new();
my $sun_3 = Date::Recur->new();
my $sun_4 = Date::Recur->new();

# only match on Tuesdays
$tue_1->include(
    Date::Recur::Rule::OnDaysOfWeek->new( days_of_week => [ Date::Recur::TUESDAY ] )
);
$tue_2->include_days_of_week(
    Date::Recur::TUESDAY,
);

# only match on Sundays
$sun_1->include(
    Date::Recur::Rule::OnDaysOfWeek->new( days_of_week => [ Date::Recur::SUNDAY ] )
);
$sun_2->include_days_of_week(
    Date::Recur::SUNDAY,
);
$sun_3->include(
    Date::Recur::Rule::OnDaysOfWeek->new( days_of_week => [ Date::Recur::SUN ] )
);
$sun_4->include_days_of_week(
    Date::Recur::SUN,
);

do_tue_tests( $tue_1 );
do_tue_tests( $tue_2 );
do_sun_tests( $sun_1 );
do_sun_tests( $sun_2 );
do_sun_tests( $sun_3 );
do_sun_tests( $sun_4 );

## ----------------------------------------------------------------------------

sub do_tue_tests {
    my ($r) = @_;
    ok(  $r->matches( '2010-11-02' ), q{Matches Tuesday} );
    ok( !$r->matches( '2010-11-08' ), q{Doesn't Match Next Monday} );
}

sub do_sun_tests {
    my ($r) = @_;
    ok(  $r->matches( '2010-12-12' ), q{Matches Sunday} );
    ok( !$r->matches( '2010-12-13' ), q{Doesn't Match Monday} );
    ok( !$r->matches( '2010-12-18' ), q{Doesn't Match Saturday} );
    ok(  $r->matches( '2010-12-19' ), q{Matches Sunday} );
}

## ----------------------------------------------------------------------------
