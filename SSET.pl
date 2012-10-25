#!/usr/bin/env perl
use strict;
use warnings;
use 5.016;

chomp(my $length = <>);
my @elements = 1..$length;

say 2 ** $length;

for my $i (0..(2 ** $length - 1)) {
    my @included = split '', sprintf("%0${length}b", $i);
    say '{'
          . join(', ', map { $elements[$_] } grep { $included[$_] } 0..$length)
      . '}';
}
