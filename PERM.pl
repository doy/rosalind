#!/usr/bin/env perl
use strict;
use warnings;
use 5.016;

sub factorial {
    my ($n) = @_;
    return 1 if $n < 2;
    return $n * factorial($n - 1);
}

sub permutations {
    my ($n) = @_;
    my $string = join('', 1..$n);
    return map { _permutation($string, $_) } 0..(factorial($n) - 1);
}

sub _permutation {
    my ($string, $index) = @_;

    return '' if $string eq '';

    my $fact = factorial(length($string) - 1);

    my $current_index = int($index / $fact);
    my $rest          = $index % $fact;

    my $first_digit = substr($string, $current_index, 1);
    substr($string, $current_index, 1, '');

    return $first_digit . _permutation($string, $rest);
}

my $n = <>;
say factorial($n);
say join(' ', split '') for permutations($n);
