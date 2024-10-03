#!/bin/bash

make -s
if [ $? -ne 0 ]; then
    echo "Compilation failed. Exiting."
    exit 1
fi

echo -e "Comparing two logs: one from running the megaphone and one from the subject.\n"

executable_name="megaphone"

test_cases=(
    "\"shhhhh... I think the students are asleep...\""
    "Damnit \" ! \" \"Sorry students, I thought this thing was off.\""
    ""
)

expected_outputs=(
    "SHHHHH... I THINK THE STUDENTS ARE ASLEEP..."
    "DAMNIT ! SORRY STUDENTS, I THOUGHT THIS THING WAS OFF."
    "* LOUD AND UNBEARABLE FEEDBACK NOISE *"
)

for i in "${!test_cases[@]}"; do
    test_case=${test_cases[$i]}
    expected_output=${expected_outputs[$i]}

    echo "Test case $((i + 1)): ./${executable_name} $test_case"

    megaphone_log=$(eval ./${executable_name} "$test_case")

    echo "Megaphone: $megaphone_log"
    echo -e "Expected : $expected_output\n"

    if [ "$megaphone_log" = "$expected_output" ]; then
        echo "Test case $((i + 1)) passed.✅"
    else
        echo "Test case $((i + 1)) failed.❌"
    fi
done
