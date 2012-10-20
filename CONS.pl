#!/usr/bin/env perl
use strict;
use warnings;
use 5.016;

use List::Util 'max';
use List::MoreUtils 'firstidx';

my %map = (
    A => 0,
    C => 1,
    G => 2,
    T => 3,
);
my %reverse_map = reverse %map;

my @profile;

my $length;
while (<>) {
    chomp;
    if (!$length) {
        $length = length;
        for my $base (0..3) {
            $profile[$base] = [(0) x $length];
        }
    }
    my $i = 0;
    for my $base (split '') {
        $profile[$map{$base}][$i++]++;
    }
}

my $consensus = '';
for my $index (0..$#{ $profile[0] }) {
    my @vals = map { $profile[$_][$index] } 0..3;
    my $max = max @vals;
    $consensus .= $reverse_map{(firstidx { $_ == $max } @vals)};
}

say $consensus;
for my $base (0..3) {
    say "$reverse_map{$base}: " . join ' ', @{ $profile[$base] };
}
