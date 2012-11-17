#!/usr/bin/env perl
use strict;
use warnings;
use 5.016;

no warnings 'recursion';

use Memoize;

chomp(my $str1 = <>);
chomp(my $str2 = <>);

say lcsq($str1, $str2);

sub lcsq {
    my ($str1, $str2) = @_;

    return '' unless length($str1) && length($str2);
    if (substr($str1, 0, 1) eq substr($str2, 0, 1)) {
        return substr($str1, 0, 1)
             . lcsq(substr($str1, 1), substr($str2, 1));
    }
    else {
        my $lcsq1 = lcsq(substr($str1, 1), $str2);
        my $lcsq2 = lcsq($str1, substr($str2, 1));
        return length($lcsq1) > length($lcsq2) ? $lcsq1 : $lcsq2;
    }
}
BEGIN { memoize('lcsq') };
