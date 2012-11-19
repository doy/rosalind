#!/usr/bin/env perl
use strict;
use warnings;
use 5.016;

chomp(my @lines = <>);

my $full = shift @lines;
while (@lines) {
    my $found;
    my $found_length = 0;
    my $before;
    for my $i (0..$#lines) {
        for my $len (reverse 1..length($lines[0])) {
            last if $len <= $found_length;
            if (substr($full, 0, $len) eq substr($lines[$i], -$len)) {
                $found_length = $len;
                $found = $i;
                $before = 1;
            }
            elsif (substr($full, -$len) eq substr($lines[$i], 0, $len)) {
                $found_length = $len;
                $found = $i;
                $before = 0;
            }
        }
    }
    my $str = splice(@lines, $found, 1);
    if ($before) {
        $full = substr($str, 0, -$found_length) . $full;
    }
    else {
        $full = $full . substr($str, $found_length);
    }
}

say $full;
