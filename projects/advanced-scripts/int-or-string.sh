#!/bin/bash

# Interger or string script

a=2345          #Int
let "a += 1"
echo "a = $a"   #integer, still
echo

b=${a/23/BB}        #Subsitute "BB" for "23".
                    # This transforms $b into a string.
echo "b = $b"       #b = BB35
declare -i b        #Declaring it an integer does not help.
echo "b = $b"       #b = BB35

let "b += 1"             # BB35 + 1
echo "b = $b"            # b = 1
echo                     # Bash sets the "integer value" of a string to 0.

c=BB34
echo "c = $c"      #c = BB34
d=${c/BB/23}        # Substitute "23" for "BB". 