#!/usr/bin/env perl
use strict;
use warnings;
use 5.016;

chomp(my $string = <>);
chomp(my $substr = <>);
$substr = '(' . join(').*?(', split '', $substr) . ')';
$string =~ $substr;
say join(' ', map { $_ + 1 } @-[1..$#-]);
