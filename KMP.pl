#!/usr/bin/env perl
use strict;
use warnings;
use 5.016;

chomp(my $str = <>);

my @failure = (0);

my $idx = 0;
for my $start (1..(length($str) - 1)) {
    while (1) {
        if (substr($str, $start, 1) eq substr($str, $idx, 1)) {
            ++$idx;
            last;
        }
        else {
            last if $idx == 0;
            $idx = $failure[$idx - 1];
        }
    }
    push @failure, $idx;
}

say join(' ', @failure);
