#!/bin/bash

for ((noun=0; noun<100; noun++)); do
    for ((verb=0; verb<100; verb++)); do
        output=$(./day02a_intcode_computer.pl day02_input.txt $noun $verb)
        if [[ "$output" == "19690720" ]]; then
            printf "%02d%02d\n" $noun $verb
            exit
        fi
    done
done
