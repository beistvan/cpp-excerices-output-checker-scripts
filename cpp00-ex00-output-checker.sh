#!/bin/bash

make -s
if [ $? -ne 0 ]; then
    echo "Compilation failed. Exiting."
    exit 1
fi

echo "Comparing two logs: one from running the megaphone and one from the subject."

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

passed_tests=0

for i in "${!test_cases[@]}"; do
    test_case=${test_cases[$i]}
    expected_output=${expected_outputs[$i]}

    echo -e "\nTest case $((i + 1)): ./${executable_name} $test_case"

    megaphone_log=$(eval ./${executable_name} "$test_case")

    echo "Megaphone: $megaphone_log"
    echo "Expected : $expected_output"

    if [ "$megaphone_log" = "$expected_output" ]; then
        echo "Test case $((i + 1)) passed.✅"
        ((passed_tests++))
    else
        echo "Test case $((i + 1)) failed.❌"
    fi
done

if [ $passed_tests -eq ${#test_cases[@]} ]; then
    echo -e "\n\033[0;32mAll tests passed 😊 ($passed_tests of ${#test_cases[@]}\033[0m)"
else
    echo -e "\n\033[0;31mPassed $passed_tests of ${#test_cases[@]}\033[0m"
fi
