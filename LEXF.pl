#!/usr/bin/env perl
use strict;
use warnings;
use 5.016;

my @string = split ' ', scalar(<>);
chomp(my $length = <>);

my $base = @string;

for my $num (0..$base ** $length - 1) {
    my @digits;
    my $remainder = $num;
    for my $digit (1..$length) {
        my $exponent = $length - $digit;
        push @digits, int($remainder / $base ** $exponent);
        $remainder -= $digits[-1] * $base ** $exponent;
    }
    say join('', map { $string[$_] } @digits);
}
