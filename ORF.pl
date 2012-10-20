#!/usr/bin/env perl
use strict;
use warnings;
use 5.016;

my %map = qw(
    UUU F      CUU L      AUU I      GUU V
    UUC F      CUC L      AUC I      GUC V
    UUA L      CUA L      AUA I      GUA V
    UUG L      CUG L      AUG M      GUG V
    UCU S      CCU P      ACU T      GCU A
    UCC S      CCC P      ACC T      GCC A
    UCA S      CCA P      ACA T      GCA A
    UCG S      CCG P      ACG T      GCG A
    UAU Y      CAU H      AAU N      GAU D
    UAC Y      CAC H      AAC N      GAC D
    UAA Stop   CAA Q      AAA K      GAA E
    UAG Stop   CAG Q      AAG K      GAG E
    UGU C      CGU R      AGU S      GGU G
    UGC C      CGC R      AGC S      GGC G
    UGA Stop   CGA R      AGA R      GGA G
    UGG W      CGG R      AGG R      GGG G
);

my $rna = <> =~ tr/T/U/r;
my @proteins;

for my $string ($rna, scalar(reverse($rna =~ tr/ACGU/UGCA/r))) {
    my $start = 0;
    while ((my $pos = index($string, 'AUG', $start)) != -1) {
        my $orf = substr($string, $pos);
        my $protein;
        my $stop;
        for my $amino (map { $map{$_} } $orf =~ /.../g) {
            if ($amino eq 'Stop') {
                $stop = 1;
                last;
            }
            $protein .= $amino;
        }
        push @proteins, $protein
            if $stop;
        $start = $pos + 1;
    }
}

my %seen;
say for grep { !$seen{$_}++ } @proteins;
