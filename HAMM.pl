#!/usr/bin/env perl
use strict;
use warnings;
use 5.016;

chomp(my $line1 = <>);
chomp(my $line2 = <>);
say length(($line1 ^ $line2) =~ s/\x00//gr);
