#!/usr/bin/env perl
use strict;
use warnings;
use 5.016;

use List::MoreUtils 'all';

chomp(my @strings = <>);

my $min = length($strings[0]);
my $min_idx = 0;
for my $i (1..$#strings) {
    if (length($strings[$i]) < $min) {
        $min = length($strings[$i]);
        $min_idx = $i;
    }
}
my $str = splice(@strings, $min_idx, 1);

LENGTH: for my $len (reverse 1..length($str)) {
    for my $start (0..(length($str) - $len)) {
        my $substr = substr($str, $start, $len);
        if (all { /$substr/ } @strings) {
            say $substr;
            last LENGTH;
        }
    }
}
