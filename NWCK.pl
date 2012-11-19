#!/usr/bin/env perl
use strict;
use warnings;
use 5.016;

use constant DEBUG => 0;

my @distances;
while (defined(my $newick = <>)) {
    chomp($newick);
    $newick =~ s/;$//;

    my $sym;
    my $getsym = sub {
        $newick =~ s/^(\(|\)|,|\w+)//;
        $sym = $1 // '';
    };

    no warnings 'recursion';

    my $actions;
    $actions = {
        full => sub {
            my $children;
            if ($sym eq '(') {
                $getsym->();
                $children = $actions->{children}->();
                die "syntax error" unless $sym eq ')';
                $getsym->();
            }
            else {
                $children = [];
            }

            my $node;
            if ($sym =~ /\w+/) {
                $node = $sym;
                $getsym->();
            }
            else {
                $node = '';
            }

            return [$node, $children];
        },
        children => sub {
            if ($sym eq ')') {
                return [];
            }

            my $child = $actions->{full}->();

            if ($sym eq ',') {
                $getsym->();
            }
            elsif ($sym ne ')') {
                die "syntax error";
            }

            return [$child, @{ $actions->{children}->() }];
        },
    };

    $getsym->();
    my $tree = $actions->{full}->();
    render_dot($tree) if DEBUG;

    my @paths = map { [ path($tree, $_) ] } split ' ', scalar <>;
    while ($paths[0][0] == $paths[1][0]) {
        shift @{ $paths[0] };
        shift @{ $paths[1] };
        last unless @{ $paths[0] } && @{ $paths[1] };
    }
    push @distances, @{ $paths[0] } + @{ $paths[1] };

    last unless <>;
}

say join(' ', @distances);

sub path {
    my ($tree, $node) = @_;

    return ($tree) if $tree->[0] eq $node;

    for my $child (@{ $tree->[1] }) {
        if (my @path = path($child, $node)) {
            return ($tree, @path);
        }
    }

    return;
}

sub render_dot {
    my ($tree) = @_;

    state $i = 1;

    open my $fh, '>', "tree$i.dot" or die "Couldn't open tree$i.dot: $!";
    $i++;

    say $fh "graph tree$i {";
    sub {
        my ($tree) = @_;
        my $node = $tree+0;
        say $fh "    $node [label=\"$tree->[0]\"]";
        for my $child (@{ $tree->[1] }) {
            my $child_node = $child+0;
            say $fh "    $node -- $child_node";
            __SUB__->($child);
        }
    }->($tree);
    say $fh "}";
}
