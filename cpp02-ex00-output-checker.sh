#!/bin/bash

EXECUTABLE="main"

EXPECTED_OUTPUT="$(cat <<EOF
Default constructor called
Copy constructor called
Copy assignment operator called
getRawBits member function called
Default constructor called
Copy assignment operator called
getRawBits member function called
getRawBits member function called
0
getRawBits member function called
0
getRawBits member function called
0
Destructor called
Destructor called
Destructor called
EOF
)"

make > /dev/null

if [ ! -f $EXECUTABLE ]; then
    echo "Executable not found"
    exit 1
fi

diff <(./$EXECUTABLE) <(echo "$EXPECTED_OUTPUT")

if [ $? -eq 0 ]; then
    echo "Output is correct"
else
    echo "Output is incorrect"
fi
