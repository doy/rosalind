#!/usr/bin/env perl
use strict;
use warnings;
use 5.016;

my $first = 1;
for my $prob (split ' ', scalar <>) {
    my $gc_prob = $prob / 2;
    my $at_prob = (1 - $prob) / 2;
    my $same_prob = ($gc_prob ** 2) * 2 + ($at_prob ** 2) * 2;
    print $first ? '' : ' ';
    print $same_prob;
    $first = 0;
}
