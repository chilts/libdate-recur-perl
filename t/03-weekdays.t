#!/usr/bin/perl
## ----------------------------------------------------------------------------
# Test for weekdays.
# Also test for NOT the weekends.
# Do both inclusive and exclusive methods.
# Test with both explicit and convenience methods.
## ----------------------------------------------------------------------------

use Test::More tests => 28;

use Date::Recur;
use Date::Recur::Rule::OnDaysOfWeek;

my $weekdays_inc_1 = Date::Recur->new();
my $weekdays_inc_2 = Date::Recur->new();
my $weekdays_exc_1 = Date::Recur->new();
my $weekdays_exc_2 = Date::Recur->new();

# match from Monday to Friday
$weekdays_inc_1->include(
    Date::Recur::Rule::OnDaysOfWeek->new(
        days_of_week => [
            Date::Recur::MON,
            Date::Recur::TUE,
            Date::Recur::WED,
            Date::Recur::THU,
            Date::Recur::FRI,
        ]
    )
);
$weekdays_inc_2->include_days_of_week(
    Date::Recur::MON,
    Date::Recur::TUE,
    Date::Recur::WED,
    Date::Recur::THU,
    Date::Recur::FRI,
);

# don't match the weekend
$weekdays_exc_1->exclude(
    Date::Recur::Rule::OnDaysOfWeek->new(
        days_of_week => [
            Date::Recur::SUN,
            Date::Recur::SAT,
        ]
    )
);
$weekdays_exc_2->exclude_days_of_week(
    Date::Recur::SUN,
    Date::Recur::SAT,
);

# do the tests for each one
do_tests( $weekdays_inc_1 );
do_tests( $weekdays_inc_2 );
do_tests( $weekdays_exc_1 );
do_tests( $weekdays_exc_2 );

## ----------------------------------------------------------------------------

sub do_tests {
    my ($r) = @_;

    # match on a Monday
    ok( !$r->matches( '2010-10-31' ), q{Doesn't Match Sunday} );
    ok(  $r->matches( '2010-11-01' ), q{Matches Monday} );
    ok(  $r->matches( '2010-11-02' ), q{Matches Tuesday} );
    ok(  $r->matches( '2010-11-03' ), q{Matches Wednesday} );
    ok(  $r->matches( '2010-11-04' ), q{Matches Thursday} );
    ok(  $r->matches( '2010-11-05' ), q{Matches Friday} );
    ok( !$r->matches( '2010-11-06' ), q{Doesn't Match Saturday} );
}

## ----------------------------------------------------------------------------
