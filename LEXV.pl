#!/usr/bin/env perl
use strict;
use warnings;
use 5.016;

my @string = split ' ', scalar(<>);
chomp(my $length = <>);

unshift @string, undef;
my $base = @string;

for my $num (0..$base ** $length - 1) {
    my @digits;
    my $remainder = $num;
    for my $digit (1..$length) {
        my $exponent = $length - $digit;
        push @digits, int($remainder / $base ** $exponent);
        $remainder -= $digits[-1] * $base ** $exponent;
    }
    @digits = map { $string[$_] } @digits;
    next unless valid(@digits);
    say join('', grep { defined } @digits);
}

sub valid {
    my @digits = @_;

    return unless grep { defined } @digits;

    my $seen_undef;
    for my $digit (@digits) {
        return if $seen_undef && defined($digit);
        $seen_undef = 1 if !defined($digit);
    }

    return 1;
}
