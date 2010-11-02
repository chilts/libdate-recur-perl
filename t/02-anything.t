#!/usr/bin/perl
## ----------------------------------------------------------------------------

use Test::More tests => 4;

use Date::Recur;

# basic recurrance, no start/end dates
my $anything = Date::Recur->new();

ok( $anything->matches( Date::Simple->new() ), q{Matches Real Today} );
ok( $anything->matches( Date::Simple->new()+1 ), q{Matches Real Tomorrow} );
ok( $anything->matches( '2010-11-02' ), q{Matches My Today} );
ok( $anything->matches( '2010-11-03' ), q{Matches My Tomorrow} );

## ----------------------------------------------------------------------------
