#!/usr/bin/perl
use warnings;
use strict;

open (FOOL,"<0059.in") or die $!;

my %ascii;
my $current=0;
foreach my $k (split(/,/,<FOOL>)) { #split input into 3 hashes, one that will be
    $ascii{$current}{$k}++;         #associated with each key character 
    $current++;
    $current = 0 if $current == 3;
}

close FOOL;
my @string;
foreach my $l (0..2) { #makes the most common character in each group space (ascii 32)
    my @sort = sort {$ascii{$l}{$b} <=> $ascii{$l}{$a}} keys %{$ascii{$l}};
    push(@string,($sort[0]^32));
}


my $sum;
foreach my $jj (0..2) { #XORs with the keys and sums (one XOR multiplied by count of char)
    foreach (keys %{$ascii{$jj}}) {
        my $temp = $_^$string[$jj];
        $sum+=(($temp)*$ascii{$jj}{$_});
    }
}



print "$sum\n";
