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
my @crossings;
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
    my ($direction, $distance, $wire, $other) = (@_);

    my $steps = exists $grid[$x][$y]{$wire}?$grid[$x][$y]{$wire}:0;

    printf STDERR "move: %d %s from (%d,%d)\n", $distance, $direction, $x-5000, $y-5000 if $debug;

    for (1..$distance) {
        printf STDERR "(%d,%d) => %d\n", $x-5000, $y-5000, $steps if $debug;
        if ($x != 5000 && $y != 5000 && defined $grid[$x][$y] && exists $grid[$x][$y]{$other}) {
            printf STDERR "X (%d,%d)\n", $x-5000, $y-5000 if $debug;
            push @crossings, {x=>$x,y=>$y};
            $grid[$x][$y]={$other=>$grid[$x][$y]{$other}, $wire=>$steps};
        } else {
            $grid[$x][$y]={$wire=>$steps};
        }
        if ($direction eq "R") {
            $visual_grid[$x++][$y]=$_==1?"+":"-";
        } elsif ($direction eq "L") {
            $visual_grid[$x--][$y]=$_==1?"+":"-";
        } elsif ($direction eq "U") {
            $visual_grid[$x][$y++]=$_==1?"+":"|";
        } elsif ($direction eq "D") {
            $visual_grid[$x][$y--]=$_==1?"+":"|";
        }
        $steps++;
    }
    if ($x != 5000 && $y != 5000 && defined $grid[$x][$y] && exists $grid[$x][$y]{$other}) {
        printf STDERR "X (%d,%d)\n", $x-5000, $y-5000 if $debug;
        push @crossings, {x=>$x,y=>$y};
        $grid[$x][$y]={$other=>$grid[$x][$y]{$other}, $wire=>$steps};
    } else {
        $grid[$x][$y]={$wire=>$steps};
    }
    printf STDERR "(%d,%d) => %d\n", $x-5000, $y-5000, $steps if $debug;
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
    move_on_grid $direction, $distance, 1, 2;
}

dump_grid if $debug;

print STDERR "Moving wire2...\n" if $debug;
($x,$y)=(5000,5000);
foreach my $segment (@wire2) {
    my $direction = substr($segment, 0, 1);
    chomp(my $distance = substr($segment, 1));
    move_on_grid $direction, $distance, 2, 1;
}

my $min_steps;

foreach my $crossing (@crossings) {
    printf STDERR "(%d,%d):", $crossing->{x}, $crossing->{x} if $debug;
    my $steps = 0;
    for(1..2) {
        print STDERR " $_=",$grid[$crossing->{x}][$crossing->{y}]{$_} if $debug;
        $steps+=$grid[$crossing->{x}][$crossing->{y}]{$_};
    }
    if (! defined $min_steps || $steps < $min_steps) {
        $min_steps=$steps;
    }
    print STDERR "\n" if $debug;
}

dump_grid if $debug;

print "$min_steps\n";
