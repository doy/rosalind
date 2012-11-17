#!/usr/bin/env perl
use strict;
use warnings;
use 5.016;

use constant DEBUG => 0;

chomp(my $str = <>);
my @suffixes = map { substr($str, $_ - 1) } 1..length($str);

my %nodes = (
    node1 => {
        str      => '',
        children => [],
    },
);

my $i = 1;
my $step = 1;
SUFFIX: for my $suffix (@suffixes) {
    insert($suffix, 'node1');
    render_as_dot(\%nodes, $step++) if DEBUG;
}

delete $nodes{node1};
say for map { $_->{str} } values %nodes;

sub insert {
    my ($str, $root) = @_;

    return unless length($str);

    for my $child (@{ $nodes{$root}{children} }) {
        my $child_str = $nodes{$child}{str};
        my @prefixes = reverse map { substr($child_str, 0, $_) }
                                   1..length($child_str);
        for my $prefix (@prefixes) {
            if ($str =~ s/^\Q$prefix//) {
                $child_str =~ s/^\Q$prefix//;

                $nodes{$child}{str} = $prefix;

                if (@{ $nodes{$child}{children} } && length($child_str)) {
                    my $new_node = 'node' . ++$i;
                    $nodes{$new_node} = {
                        str      => $child_str,
                        children => $nodes{$child}{children},
                        parent   => $child,
                    };
                    $nodes{$child}{children}  = [$new_node];
                    $nodes{$_}{parent} = $new_node
                        for @{ $nodes{$new_node}{children} };
                }
                else {
                    insert($child_str, $child);
                }

                insert($str, $child);

                return;
            }
        }
    }

    my $new_node = 'node' . ++$i;
    push @{ $nodes{$root}{children} }, $new_node;
    $nodes{$new_node} = {
        str      => $str,
        children => [],
        parent   => $root,
    };
}

sub render_as_dot {
    my ($graph, $step) = @_;
    open my $fh, '>', "step$step.dot" or die "Couldn't open step$step.dot: $!";
    say $fh "graph step$step {";
    for my $node (keys %$graph) {
        next unless $nodes{$node}{parent};
        say $fh "    $nodes{$node}{parent} -- $node [label=\"$nodes{$node}{str}\"];";
    }
    say $fh "}";
}
