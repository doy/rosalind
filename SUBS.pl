#!/usr/bin/env perl
use strict;
use warnings;
use 5.016;

chomp(my $string = <>);
chomp(my $substr = <>);
my @positions;

my $start = 0;
while((my $pos = index($string, $substr, $start)) != -1) {
    push @positions, $pos + 1;
    $start = $pos + 1;
}

say join(' ', @positions);
