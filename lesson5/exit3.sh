#!/bin/bash

directory=/etc

if [ -d $directory ]; then
    echo "Directory is exist"
    exit 0
else
    echo "Directory does not exist"
    exit 1
fi

echo "-------"
echo "-------"
echo "-------"


