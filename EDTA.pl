#!/usr/bin/env perl
use strict;
use warnings;
use 5.016;

use List::Util 'min';
use Memoize;

chomp(my $str1 = <>);
chomp(my $str2 = <>);

my ($distance, $aligned1, $aligned2) = align($str1, $str2);
say $distance;
say $aligned1;
say $aligned2;

sub align {
    my ($str1, $str2) = @_;

    return (length($str2), ('-' x length($str2)), $str2) if !length($str1);
    return (length($str1), $str1, ('-' x length($str1))) if !length($str2);

    my @delete = align(substr($str1, 1), $str2);
    $delete[0]++;
    $delete[1] = substr($str1, 0, 1) . $delete[1];
    $delete[2] = '-' . $delete[2];

    my @insert = align($str1, substr($str2, 1));
    $insert[0]++;
    $insert[1] = '-' . $insert[1];
    $insert[2] = substr($str2, 0, 1) . $insert[2];

    my @substitute = align(substr($str1, 1), substr($str2, 1));
    $substitute[0]++ if substr($str1, 0, 1) ne substr($str2, 0, 1);
    $substitute[1] = substr($str1, 0, 1) . $substitute[1];
    $substitute[2] = substr($str2, 0, 1) . $substitute[2];

    if ($delete[0] <= $insert[0] && $delete[0] <= $substitute[0]) {
        return @delete;
    }
    elsif ($insert[0] <= $delete[0] && $insert[0] <= $substitute[0]) {
        return @insert;
    }
    else {
        return @substitute;
    }
}
BEGIN { memoize('align') };
