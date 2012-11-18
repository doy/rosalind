#!/usr/bin/env perl
use strict;
use warnings;
use 5.016;

use List::Util 'min';
use Memoize;

chomp(my $str1 = <>);
chomp(my $str2 = <>);

say distance($str1, $str2);

sub distance {
    my ($str1, $str2) = @_;

    return length($str2) if !length($str1);
    return length($str1) if !length($str2);

    return min(
        distance(substr($str1, 1), $str2) + 1,
        distance($str1, substr($str2, 1)) + 1,
        distance(substr($str1, 1), substr($str2, 1))
            + (substr($str1, 0, 1) eq substr($str2, 0, 1) ? 0 : 1)
    );
}
BEGIN { memoize('distance') };
