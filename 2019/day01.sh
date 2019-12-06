#!/bin/bash

echo "------------------------------------------------------------------------"
echo "-                        Advent of Code - day 1                        -"
echo "------------------------------------------------------------------------"
echo

function test_script() {
    script=$1
    echo "Testing $script"
    while read l; do 
        mass=${l/,*/}
        expected_result=${l/*,/}
        result=$(./$script <<<$mass)
        [[ $? -ne 0 ]] && exit 255
        echo -n "mass=$mass "
        if [[ $result -eq $expected_result ]]; then
            echo "OK" 
        else
            echo "Fail (expected $expected_result, but got $result)"
            ok=false
        fi
    done
    echo
}

ok=true

test_script day01a_total_fuel.pl <<EOF
12,2
14,2
1969,654
100756,33583
EOF

test_script day01b_total_fuel.pl <<EOF
14,2
1969,966
100756,50346
EOF

if $ok; then
    echo "All tests passed"
else
    echo "One or more tests failed"
    exit 1
fi

echo
echo "Puzzle answer 1: $(./day01a_total_fuel.pl day01_input.txt)"
echo "Puzzle answer 2: $(./day01b_total_fuel.pl day01_input.txt)"
echo
