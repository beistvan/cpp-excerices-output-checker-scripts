#!/bin/bash

EXECUTABLE_NAME="main"

EXPECTED_OUTPUT="$(cat <<EOF
0
0.00390625
0.00390625
0.00390625
0.0078125
10.1016
10.1016
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
