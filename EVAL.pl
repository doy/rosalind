#!/usr/bin/env perl
use strict;
use warnings;
use 5.016;

chomp(my ($small_len, $large_len) = split ' ', scalar <>);
chomp(my @probabilities = split ' ', scalar <>);
say join ' ', map { calculate_probability($small_len, $large_len, $_) }
                  @probabilities;

sub calculate_probability {
    my ($small_len, $large_len, $gc) = @_;

    my $single_char_chance = (($gc / 2) ** 2) * 2 + (((1 - $gc) / 2) ** 2) * 2;
    my $substring_chance = $single_char_chance ** $small_len;
    return $substring_chance * ($large_len - $small_len + 1);
}
