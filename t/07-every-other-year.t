#!/usr/bin/perl
## ----------------------------------------------------------------------------

use Test::More tests => 20;

use Date::Recur;
use Date::Recur::Rule::YearlyInterval;

my ($yearly_1, $yearly_2);
$yearly_1 = Date::Recur->new( start => '2010-11-02' );
$yearly_2 = Date::Recur->new( start => '2010-11-02' );

# explicit method
$yearly_1->include(
    Date::Recur::Rule::YearlyInterval->new( interval => 2 )
);

# convenience method
$yearly_2->include_yearly_interval( 2 );

do_tests( $yearly_1 );
do_tests( $yearly_2 );

## ----------------------------------------------------------------------------

sub do_tests {
    my ($r) = @_;

    ok( !$r->matches( '2010-11-01' ), q{Doesn't match prior to start date} );
    ok(  $r->matches( '2010-11-02' ), q{Matches the same date as the start} );
    ok(  $r->matches( '2010-11-03' ), q{Matches the day after start} );
    ok(  $r->matches( '2010-12-01' ), q{Matches December} );

    ok( !$r->matches( '2011-04-08' ), q{Doesn't Match 8th April 2011} );
    ok( !$r->matches( '2011-07-20' ), q{Doesn't Match 20th July 2011} );
    ok( !$r->matches( '2011-10-31' ), q{Doesn't Match 31st October 2011} );

    ok(  $r->matches( '2012-04-08' ), q{Matches 8th April 2012} );
    ok(  $r->matches( '2012-07-20' ), q{Matches 20th July 2012} );
    ok(  $r->matches( '2012-10-31' ), q{Matches 31st October 2012} );
}

## ----------------------------------------------------------------------------
