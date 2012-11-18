#!/usr/bin/env perl
use strict;
use warnings;
use 5.016;

use List::Util 'min';

chomp(my $str = <>);
my $max = 0;
for my $n (1..length($str)) {
    $max += min(4**$n, length($str) - ($n - 1));
}

my @nodes = (
    [''],
);

for my $suffix (reverse map { substr($str, $_ - 1) } 1..length($str)) {
    insert($suffix, 0);
}

printf "%.4f\n", observed() / $max;

sub insert {
    my ($str, $root) = @_;

    return unless length($str);

    for my $child (@{ $nodes[$root][1] || [] }) {
        my $child_str = $nodes[$child][0];
        next unless substr($str, 0, 1) eq substr($child_str, 0, 1);

        my $min = 1;
        my $max = min(length($child_str), length($str));

        while (1) {
            my $next = int(($max + $min) / 2);
            last if $next == $min;
            if (substr($str, $min, $next - $min) eq substr($child_str, $min, $next - $min)) {
                $min = $next;
            }
            else {
                $max = $next;
            }
        }
        my $prefix = substr($str, 0, $min);
        $child_str = substr($child_str, $min);
        $str = substr($str, $min);

        $nodes[$child][0] = $prefix;

        if ($nodes[$child][1] && @{ $nodes[$child][1] } && length($child_str)) {
            push @nodes, [$child_str, $nodes[$child][1]];
            $nodes[$child][1] = [$#nodes];
        }
        else {
            insert($child_str, $child);
        }

        insert($str, $child);

        return;
    }

    push @nodes, [$str];
    push @{ $nodes[$root][1] ||= [] }, $#nodes;
}

sub observed {
    sub {
        my ($node, $cur) = @_;

        my $count = length($nodes[$node][0]);
        for my $child (@{ $nodes[$node][1] || [] }) {
            $count += __SUB__->($child, $cur);
        }

        return $count;
    }->(0, '');
}
