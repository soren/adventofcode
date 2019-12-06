#!/usr/bin/env perl

use strict;
use warnings;
use v5.28;

sub execute {
    my ($opcode, $param1, $param2) = (@_);

    if ($opcode eq 1) {
        return $param1 + $param2;
    } elsif ($opcode eq 2) {
        return $param1 * $param2;
    } else {
        die "Unknown opcode: $opcode"
    }
}

my @memory=split /,/, <>;

my $noun = $ARGV[0];
my $verb = $ARGV[1];
my $debug = $ARGV[2] || 0;

print join(',',@memory),"\n" if $debug;

$memory[1] = $noun;
$memory[2] = $verb;

print join(',',@memory),"\n" if $debug;

my $instruction_pointer = 0;

while (1) {
    my $opcode = $memory[$instruction_pointer];
    last if $opcode == 99;

    $memory[$memory[$instruction_pointer+3]] =
      execute($opcode,
              $memory[$memory[$instruction_pointer+1]],
              $memory[$memory[$instruction_pointer+2]]);

    $instruction_pointer+=4;
}

print join(',',@memory),"\n" if $debug;

print "$memory[0]\n";
