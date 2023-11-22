#!/bin/bash

for current_number in 1 2 3 4 5 6 7 8 9 10; do
    echo $current_number
    sleep2
done

echo "This is outside of the for loop."

for n in {1..10}; do
    echo $n
    sleep2
done

echo "This is outside of the for loop."

for file in logfiles/*.log; do
    tar -czvf $file.tar.gz $file
done


