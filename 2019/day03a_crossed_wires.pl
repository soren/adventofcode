#!/usr/bin/env perl

use strict;
use warnings;
use v5.28;

my @wire1=split /,/, <>;
my @wire2=split /,/, <>;

my $debug = 0;

print STDERR "wire1: ", join(',',@wire1) if $debug;
print STDERR "wire2: ", join(',',@wire2) if $debug;

my @grid;
my @visual_grid;
my $manhattan_distance;
my ($x,$y) = (5000,5000);
my ($min_x, $min_y, $max_x, $max_y);

sub dump_grid {
    for (my $y = $max_y+1; $y >= $min_y-1; $y--) {
        for (my $x = $min_y-1; $x <= $max_x+1; $x++) {
            if ($x == 5000 && $y == 5000) {
                print STDERR 'o';
            } else {
                print STDERR defined $visual_grid[$x][$y] ? $visual_grid[$x][$y] : '.';
            }
        }
        print STDERR "\n";
    }
}

sub manhattan_distance {
    my ($x,$y) = (@_);
    return abs($x-5000)+abs($y-5000);
}

sub move_on_grid {
    my ($direction, $distance, $wire) = (@_);

    print STDERR "move: $direction $distance\n" if $debug;

    for (1..$distance) {
        if ($x != 5000 && $y != 5000 && defined $grid[$x][$y] && $grid[$x][$y] != $wire) {
            print STDERR "X ($x,$y)=$grid[$x][$y] dist=", manhattan_distance($x,$y), "\n" if $debug;
            if (! defined $manhattan_distance || manhattan_distance($x,$y) < $manhattan_distance) {
                $manhattan_distance = manhattan_distance($x,$y);
                print STDERR "New distance=$manhattan_distance\n" if $debug;
            }
        }
        if ($direction eq "R") {
            $grid[$x][$y]=$wire;
            $visual_grid[$x++][$y]=$_==1?"+":"-";
        } elsif ($direction eq "L") {
            $grid[$x][$y]=$wire;
            $visual_grid[$x--][$y]=$_==1?"+":"-";
        } elsif ($direction eq "U") {
            $grid[$x][$y]=$wire;
            $visual_grid[$x][$y++]=$_==1?"+":"|";
        } elsif ($direction eq "D") {
            $grid[$x][$y]=$wire;
            $visual_grid[$x][$y--]=$_==1?"+":"|";
        }
    }
    if ($x != 5000 && $y != 5000 && defined $grid[$x][$y] && $grid[$x][$y] != $wire) {
        print STDERR "X ($x,$y)=$grid[$x][$y] dist=", $x+$y-200, "\n" if $debug;
        if (! defined $manhattan_distance || $x+$y-200 < $manhattan_distance) {
            $manhattan_distance = $x + $y - 200;
            print STDERR "New distance=$manhattan_distance\n" if $debug;
        }
    }
    $grid[$x][$y]=$wire;
    $visual_grid[$x][$y]=$direction=~/[RL]/?"-":"|";
    $min_x = $x if ! defined $min_x || $x < $min_x;
    $min_y = $y if ! defined $min_y || $y < $min_y;
    $max_x = $x if ! defined $max_x || $x > $max_x;
    $max_y = $y if ! defined $max_y || $y > $max_y;

}

print STDERR "Moving wire1...\n" if $debug;
foreach my $segment (@wire1) {
    my $direction = substr($segment, 0, 1);
    chomp(my $distance = substr($segment, 1));
    move_on_grid $direction, $distance, 1;
}

dump_grid if $debug;

print STDERR "Moving wire2...\n" if $debug;
($x,$y)=(5000,5000);
foreach my $segment (@wire2) {
    my $direction = substr($segment, 0, 1);
    chomp(my $distance = substr($segment, 1));
    move_on_grid $direction, $distance, 2;
}

dump_grid if $debug;

print "$manhattan_distance\n";
