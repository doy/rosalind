#!/usr/bin/env perl
use strict;
use warnings;
use 5.016;

use List::MoreUtils 'uniq';

chomp(my @k1mers = <>);
@k1mers = uniq map { $_, reverse_complement($_) } @k1mers;
my $k = length($k1mers[0]) - 1;
say for map { '(' . substr($_, 0, $k) . ', ' . substr($_, 1, $k) . ')' }
            @k1mers;

sub reverse_complement {
    my ($str) = @_;
    return scalar reverse $str =~ tr/ACGT/TGCA/r;
}
