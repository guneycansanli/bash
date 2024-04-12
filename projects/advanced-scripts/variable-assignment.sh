#!/bin/bash

# This script will be an example for using variables
#+ Also let command example

: <<'COMMENTS'
Bash let is a built-in command in Linux systems used for evaluating arithmetic expressions
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
COMMENTS

# Naked Variables

echo

# When is a variable "naked", i.e., lacking the '$' in front?
# When it is being assigned, rather than referenced.

#Assignment
a=879
echo "The value of \"a\" is now $a"

# Assignment using 'let'
let a=16+5
echo "The value of \"a\" is now $a"

echo

# In a 'for' loop (Actually a type of disguised assignment)
echo -n "Values of \"a\" is the loop are: "

for a in 7 8 9 11; do
    echo -n "$a "       # -n   Do not output a trailing newline.
done

echo
echo

# In a 'read' statement (also type of assignment)

echo -n "Enter \"a\" "
read a
echo "The vlaue of \"a\" is now: $a"

echo 


# Variable Assignment, plain and fancy

b=23    #simple case
echo $b
c=$b
echo $c

# Now, getting a little bit fancier (sommand substitution).

a=`echo Hello!` #Assign resukt of echo command to a
echo $a

#  Note that including an exclamation mark (!) within a
#+ command substitution construct will not work from the command-line,
#+ since this triggers the Bash "history mechanism."
#  Inside a script, however, the history functions are disabled by default.

a=`ls -l`   # assign result of ls -l 
echo $a     # Unquoted, however, it removes tabs and newlines. <<<<<<<<<<< Trick echo "$a"
echo
echo "$a"   # The quoted variable preserves whitespace.

exit 0
