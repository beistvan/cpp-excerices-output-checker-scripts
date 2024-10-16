#!/bin/bash

EXECUTABLE_NAME="main"

EXPECTED_OUTPUT="$(cat <<EOF
Triangle vertices:
A: (-2.82031, 5.42969)
B: (0.601562, 1.28906)
C: (-4.92188, -1.28906)

D - inside point: (-3.44141, 1.21094)
E - outside point: (0.480469, 5.57031)

BSP - binary space partitioning algorithm:
Is D inside of the triangle? Answer: yes
Is E outside of the triangle? Answer: yes
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
