#!/usr/bin/perl
## ----------------------------------------------------------------------------

use Test::More tests => 4;

use Date::Recur;

my $recur1 = Date::Recur->new();
$recur1->start( '2010-11-02' );
$recur1->end( '2010-12-31' );

is( $recur1->start->isa('Date::Simple'), 1, 'check the Start Date has been converted'  );
is( $recur1->end->isa('Date::Simple'), 1, 'check the End Date has been converted'  );

my $recur2 = Date::Recur->new();
$recur2->start( Date::Simple->new('2010-11-02') );
$recur2->end( Date::Simple->new('2010-12-31') );

is( $recur2->start->isa('Date::Simple'), 1, 'check the Start Date has been converted'  );
is( $recur2->end->isa('Date::Simple'), 1, 'check the End Date has been converted'  );

## ----------------------------------------------------------------------------
