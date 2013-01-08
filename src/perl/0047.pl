use strict;
use warnings;

my $distinct = 4;
my @prime;
$prime[0] = 2;
$prime[1] = 3;
my $check = 4; #the number i am currently checking
my $end = 0;

while ($end == 0) {
    $check++;
    my $smell = 0;
    while () {
        ($check += $smell and last) if not &cpf($check + $smell);
        $smell ++;
        ($end = 1 and last) if $smell == $distinct;
    }
}

print "$check\n";

sub cpf { #count prime factors
    my $value = $_[0];
    my $factors = 0;
    my $k = 1;
    foreach my $j (@prime) {
        return 0 if ($k > ($value / $j));
        last if $j > $value/2;
        ($factors++ and $k *= $j) if ( $value % $j == 0);
        return 1 if $factors == $distinct;
    }
    push (@prime,$value) if $factors == 0;
    return 0;
}


