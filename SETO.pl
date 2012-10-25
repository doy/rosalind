#!/usr/bin/env perl
use strict;
use warnings;
use 5.016;

chomp(my $size = <>);
my %universe = map { $_ => 1 } 1..$size;
my %A = parse_set(scalar <>);
my %B = parse_set(scalar <>);

my %union        = (%A, %B);
my %intersection = (map { $_ => 1 } grep { $B{$_} } keys %A);
my %differenceA  = %A;
delete $differenceA{$_} for keys %B;
my %differenceB  = %B;
delete $differenceB{$_} for keys %A;
my %Ac           = %universe;
delete $Ac{$_} for keys %A;
my %Bc           = %universe;
delete $Bc{$_} for keys %B;

say show_set(%union);
say show_set(%intersection);
say show_set(%differenceA);
say show_set(%differenceB);
say show_set(%Ac);
say show_set(%Bc);

sub parse_set {
    my ($str) = @_;

    chomp($str);
    $str =~ s/^{|}$//g;
    return map { $_ => 1 } split ', ', $str;
}

sub show_set {
    my %set = @_;
    return '{' . join(', ', sort { $a <=> $b } keys(%set)) . '}';
}
