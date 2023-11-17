#!/bin/bash

myvar=1

while [ $myvar -le 10 ]; do
    echo $myvar
    myvar=$(($myvar + 1))
    sleep 0.5
done

while [ -f ~/testfile ]; do
    echo "As of $(date), The file is exist."
done

echo "As of $(date), The file is no longer exist."
