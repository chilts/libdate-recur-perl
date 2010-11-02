#!/usr/bin/perl
## ----------------------------------------------------------------------------

use Test::More tests => 7;

use Date::Recur;

# basic recurrance, no start/end dates
my $range = Date::Recur->new();
$range->start( '2010-11-02' );
$range->end( '2011-01-31' );

ok( !$range->matches( '2010-11-01' ), q{Doesn't match yesterday} );
ok(  $range->matches( '2010-11-02' ), q{Matches today} );

ok( !$range->matches( '2011-02-01' ), q{Doesn't match Feb 2011} );
ok(  $range->matches( '2011-01-31' ), q{Matches end of Jan 2011} );

ok(  $range->matches( '2010-12-25' ), q{Matches Christmas 2010} );
ok(  $range->matches( '2010-12-31' ), q{Matches New Year's Eve 2010} );
ok(  $range->matches( '2011-01-01' ), q{Matches New Year's Day 2011} );

## ----------------------------------------------------------------------------
