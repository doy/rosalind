#!/usr/bin/env perl
use strict;
use warnings;
use 5.016;

chomp(my $nodes = <>);
chomp(my @edges = <>);

say $nodes - @edges - 1;
