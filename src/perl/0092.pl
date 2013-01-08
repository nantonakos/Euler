#!/usr/bin/perl

use warnings;
use strict;

my @squares;
foreach ( 0 .. 9 ) { #put the squares of each number in array, i'll need them a bit
    $squares[$_] = $_ * $_;
}

my $max = 9999999;
my $sum = 0;
my %finals;
my @sols;
my $realmax;

foreach ( split( //, $max ) ) { #no need to check 10M numbers, only 500 some
    $realmax += $squares[$_];
}

foreach my $num ( 1 .. $realmax ) {#check the short list to see what leads to 89
    undef @sols;
    my $result = &squaresum($num);
    foreach (@sols) { #the sub stores every link in the chain, so we don't duplicate
        $finals{$_} = $result; #push em all in
    }
}
my $temp = 1;#next few lines calc factorials for 1-7 because we need them to calc permus
my @factorials;
foreach ( 1 .. 7 ) {
    $temp *= $_;
    $factorials[$_] = $temp;
}

for ( &p( 7, [], 0 .. 9 ) ) { #generate list of combos
    my $sqsum;
    foreach (@$_) {
        $sqsum += $squares[$_];
    }
    if ( $finals{$sqsum} == 1 ) {#if that combo leads to 89
        my %countof;
        foreach (@$_) {#we'll look at how many repeats there are
            $countof{$_}++;
        }
        my $denom = 1;
        foreach my $jj ( values(%countof) ) {#and, based on the number of repeats
            $denom *= $factorials[$jj];#we can use maths to finish the job
        }
        $sum += ( $factorials[7] / $denom );
    }
}

print "$sum\n";

sub p { #combo generator
    if ( $_[0] ) {
        map &p( $_[0] - 1, [ @{ $_[1] }, $_[$_] ], @_[ $_ .. $#_ ] ), 2 .. $#_;
    }
    else {
        $_[1];
    }
}

sub squaresum { #squares and junk
    my $val = shift;
    return $finals{$val} if exists( $finals{$val} );
    push( @sols, $val );
    return 0 if $val == 1;
    return 1 if $val == 89;
    my $next;
    foreach my $j ( split( //, $val ) ) {
        $next += $squares[$j];
    }
    &squaresum($next);
}

