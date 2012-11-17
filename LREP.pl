#!/usr/bin/env perl
use strict;
use warnings;
use 5.016;

chomp(my $s = <>);
chomp(my $k = <>);
chomp(my @edges = <>);

my %nodes;
for my $edge (@edges) {
    my ($node1, $node2, $begin, $length) = split ' ', $edge;
    push @{ $nodes{$node1}{children} ||= [] }, $node2;
    $nodes{$node2} = {
        str      => substr($s, $begin - 1, $length),
        parent   => $node1,
        children => [],
    };
}

my ($root) = grep { !exists $nodes{$_}{parent} } keys %nodes;

sub {
    my ($node) = @_;
    my $leaves = 0;
    for my $child (@{ $nodes{$node}{children} }) {
        $leaves++ if @{ $nodes{$child}{children} } == 0;
        $leaves += __SUB__->($child);
    }
    $nodes{$node}{leaves} = $leaves;
    return $leaves;
}->($root);

sub {
    my ($node, $full_str) = @_;
    $nodes{$node}{full_str} = $full_str;
    for my $child (@{ $nodes{$node}{children} }) {
        __SUB__->($child, $full_str . $nodes{$child}{str});
    }
}->($root, '');

my $longest = '';

sub {
    my ($node) = @_;
    if ($nodes{$node}{leaves} >= $k) {
        if (length($nodes{$node}{full_str}) > length($longest)) {
            $longest = $nodes{$node}{full_str};
        }
    }
    for my $child (@{ $nodes{$node}{children} }) {
        __SUB__->($child);
    }
}->($root, '');

say $longest;
