#!/usr/bin/env perl
use strict;
use warnings;

my $string = <>;
$string =~ s/[^ACGT]//g;
my $length = length($string);

$string =~ s/A//g;
print $length - length($string);
$length = length($string);

print " ";

$string =~ s/C//g;
print $length - length($string);
$length = length($string);

print " ";

$string =~ s/G//g;
print $length - length($string);
$length = length($string);

print " ";
print $length;
