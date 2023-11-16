#!/bin/bash

directory=/etc

if [ -d $diretory ]; then
        echo "The directory $directory exist"
else
        echo "The directory $directory does not exist"
fi

echo "The exit code for this script is: $?"

echo "---------------------"
echo "---------------------"

directory=/non-exit
if [ -d $diretory ]; then
        echo "$?"
        echo "The directory $directory exist"
else
        echo "$?"
        echo "The directory $directory does not exist"
fi

echo "The exit code for this script is: $?"



