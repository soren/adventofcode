#!/usr/bin/env perl

use strict;
use warnings;
use v5.28;

use POSIX qw/floor/;

my $total = 0;
$total += floor($_ / 3) - 2 while (<>);
print "$total\n";
