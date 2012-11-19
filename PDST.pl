#!/usr/bin/env perl
use strict;
use warnings;
use 5.016;

my @dna;

{
    my $dna;
    while (<>) {
        chomp;
        if (/^>(.*)/) {
            push @dna, $dna if $dna;
            $dna = '';
        }
        else {
            $dna .= $_;
        }
    }
    push @dna, $dna;
}

for my $dna1 (@dna) {
    my @row;
    for my $dna2 (@dna) {
        push @row, sprintf "%0.2f", hamming($dna1, $dna2) / length($dna1);
    }
    say join(' ', @row);
}

sub hamming {
    my ($str1, $str2) = @_;
    return length(($str1 ^ $str2) =~ s/\x00//gr);
}
