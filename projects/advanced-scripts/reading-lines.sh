#!/bin/bash

: <<'COMMENTS'
This script will be an example for I/O direction and using code of block in bash script {}
Block of code [curly brackets]. Also referred to as an inline group, this construct, in effect, creates an anonymous function (a function without a name)
Let's read lines from fstab file.
COMMENTS

file=/etc/fstab

{
    read line1
    read line2
} <$file

echo "First line of $file is:"
echo "$line1"
echo
echo "Second line of $file is:"
echo "$line2"

exit 0

# Now, how do you parse the separate fields of each line?
# Hint: use awk, or . . .
# . . . Hans-Joerg Diers suggests using the "set" Bash builtin.
