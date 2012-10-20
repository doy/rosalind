#!/usr/bin/env perl
use strict;
use warnings;
use 5.016;

sub calculate_gc {
    my ($dna) = @_;
    return(($dna =~ tr/GC/GC/) / length($dna));
}

my ($max_name, $max_gc);
sub process_string {
    my ($name, $dna) = @_;
    if ($max_name) {
        my $gc = calculate_gc($dna);
        if ($gc > $max_gc) {
            $max_name = $name;
            $max_gc   = $gc;
        }
    }
    else {
        $max_name = $name;
        $max_gc   = calculate_gc($dna);
    }
}

{
    my ($name, $dna);
    while (<>) {
        chomp;
        if (/^>(.*)/) {
            process_string($name, $dna) if $name;
            $name = $1;
            $dna = '';
        }
        else {
            $dna .= $_;
        }
    }
    process_string($name, $dna);
}

say $max_name;
say $max_gc * 100 . '%';
