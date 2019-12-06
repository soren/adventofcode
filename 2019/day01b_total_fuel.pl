#!/usr/bin/env perl

use strict;
use warnings;
use v5.28;

use POSIX qw/floor/;

sub fuel {
    my $mass = shift;
    my $fuel = floor($mass / 3) - 2;
    return ($fuel > 0) ? $fuel + fuel($fuel) : 0;
}

my $total = 0;
$total += fuel($_) while (<>);
print "$total\n";
