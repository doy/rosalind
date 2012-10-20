#!/usr/bin/env perl
use strict;
use warnings;
use 5.016;

say scalar reverse <> =~ tr/ACGT/TGCA/r;
