#!/usr/bin/env perl
use strict;
use warnings;
use 5.016;

chomp(my $input = <>);

for my $start (1..length($input)) {
    for my $length (4..8) {
        next if $start + $length - 1 > length($input);
        my $substr = substr($input, $start - 1, $length);
        if ($substr eq (reverse $substr =~ tr/ACGT/TGCA/r)) {
            say "$start $length";
        }
    }
}
