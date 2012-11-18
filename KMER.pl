#!/usr/bin/env perl
use strict;
use warnings;
use 5.016;

my @bases = qw(A C G T);
my @tetranucleotides = (
    map { s/(..)/$bases[oct("0b$1")]/egr } map { sprintf("%08b", $_) } 0..255
);
my %tetranucleotide_map = (
    map { $tetranucleotides[$_] => $_ } 0..255
);

<>;
chomp(my @dna = <>);
my $dna = join('', @dna);

my @found = (0) x 256;
for my $i (0..(length($dna) - 4)) {
    $found[$tetranucleotide_map{substr($dna, $i, 4)}]++;
}

say join(' ', @found);
