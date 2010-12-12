#!/usr/bin/perl
## ----------------------------------------------------------------------------

use Test::More tests => 3;

use Date::Recur;

# basic recurrance, start date only, therefore implicitely daily
my $range = Date::Recur->new();
$range->start( '2010-11-02' );

ok( !$range->matches( '2010-11-01' ), q{Doesn't match yesterday} );
ok(  $range->matches( '2010-11-02' ), q{Matches today} );
ok(  $range->matches( '2010-11-03' ), q{Matches tomorrow} );

## ----------------------------------------------------------------------------
