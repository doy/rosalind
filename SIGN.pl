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

sub apply_signs {
    my ($list) = @_;
    my $len = @$list;
    my @ret;
    for my $n (0..(2 ** $len - 1)) {
        my @coefs = map { $_ ? 1 : -1 } split '', sprintf("%0${len}b", $n);
        push @ret, [ map { $list->[$_] * $coefs[$_] } 0..($len - 1) ];
    }
    return @ret;
}

my $n = <>;
say factorial($n) * (2 ** $n);
say join(' ', @$_) for map { apply_signs($_) } map { [split ''] } permutations($n);
