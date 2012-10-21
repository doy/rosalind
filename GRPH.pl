#!/usr/bin/env perl
use strict;
use warnings;
use 5.016;

my %dna;

sub check_pair {
    my ($name, $other) = @_;
    return if $name eq $other;
    if (substr($dna{$name}, 0, 3) eq substr($dna{$other}, -3)) {
        say "$other $name";
    }
    if (substr($dna{$other}, 0, 3) eq substr($dna{$name}, -3)) {
        say "$name $other";
    }
}

my ($name, $dna);
while (<>) {
    chomp;
    if (/^>(.*)/) {
        my $new_name = $1;
        if ($name) {
            $dna{$name} = $dna;
            for my $other (keys %dna) {
                check_pair($name, $other);
            }
        }
        $name = $new_name;
        $dna = '';
    }
    else {
        $dna .= $_;
    }
}
$dna{$name} = $dna;
for my $other (keys %dna) {
    check_pair($name, $other);
}
