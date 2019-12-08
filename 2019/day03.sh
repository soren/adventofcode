#!/bin/bash

echo "------------------------------------------------------------------------"
echo "-                        Advent of Code - day 3                        -"
echo "------------------------------------------------------------------------"
echo

function test_script() {
    script=$1
    expected_result=$2
    echo "Testing $script"
    result=$(while read l; do echo $l; done | ./$script)
    if [[ $result -eq $expected_result ]]; then
        echo "OK (result=$result)" 
    else
        echo "Fail (expected $expected_result, but got $result)"
        ok=false
    fi
    echo
}

ok=true

test_script day03a_crossed_wires.pl 6 <<EOF
R8,U5,L5,D3
U7,R6,D4,L4
EOF

test_script day03a_crossed_wires.pl 4 <<EOF
D2,R4,U4,L3
R2,D4,R4,U5,L4
EOF

test_script day03a_crossed_wires.pl 159 <<EOF
R75,D30,R83,U83,L12,D49,R71,U7,L72
U62,R66,U55,R34,D71,R55,D58,R83
EOF

test_script day03a_crossed_wires.pl 135 <<EOF
R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51
U98,R91,D20,R16,D67,R40,U7,R15,U6,R7
EOF

test_script day03b_crossed_wires.pl 30 <<EOF
R8,U5,L5,D3
U7,R6,D4,L4
EOF

test_script day03b_crossed_wires.pl 610 <<EOF
R75,D30,R83,U83,L12,D49,R71,U7,L72
U62,R66,U55,R34,D71,R55,D58,R83
EOF

test_script day03b_crossed_wires.pl 410 <<EOF
R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51
U98,R91,D20,R16,D67,R40,U7,R15,U6,R7
EOF

if $ok; then
    echo "All tests passed"
else
    echo "One or more tests failed"
    exit 1
fi

echo
echo "Puzzle answer 1: $(./day03a_crossed_wires.pl day03_input.txt)"
echo "Puzzle answer 2: $(./day03b_crossed_wires.pl day03_input.txt)"
echo
