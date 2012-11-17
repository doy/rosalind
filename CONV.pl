#!/usr/bin/env perl
use strict;
use warnings;
use 5.016;

my @s1 = map { int($_ * 1000000) } split ' ', <>;
my @s2 = map { int($_ * 1000000) } split ' ', <>;

my %totals;
for my $s1 (@s1) {
    for my $s2 (@s2) {
        say "$s1 $s2" if $s1 - $s2 < 8600000 && $s1 - $s2 > 8500000;
        $totals{$s1 - $s2}++;
    }
}

my %convolution = reverse %totals;
my $max = (sort { $a <=> $b } keys %convolution)[-1];
say $max;
say abs($convolution{$max}) / 1000000;
