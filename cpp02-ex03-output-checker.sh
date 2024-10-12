#!/bin/bash

EXECUTABLE_NAME="main"

EXPECTED_OUTPUT="$(cat <<EOF
A: (-2.17969, 1.62891)
B: (3.60156, 2.48828)
C: (-1.17969, -2.03125)
D: Inside: (1.30078, 1.64844)
E: Outside: (-2.19922, -1.60938)
inside: yes
outside: yes
EOF
)"

make > /dev/null

if [ ! -f $EXECUTABLE_NAME ]; then
    echo "Executable ($EXECUTABLE_NAME) not found"
    exit 1
fi

diff <(./$EXECUTABLE_NAME) <(echo "$EXPECTED_OUTPUT")

if [ $? -eq 0 ]; then
    echo "Output is correct"
else
    echo "Output is incorrect"
fi
