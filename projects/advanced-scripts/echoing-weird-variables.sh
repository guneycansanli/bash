#!/bin/bash

# weirdvars.sh echoing weird variables.

echo

var="'(]\\{}\$\""
echo $var   # '(]\{}$"
echo "$var" # '(]\{}$"     Doesn't make a difference.

echo

IFS='\'
echo $var   # '(] {}$"     \ converted to space. Why?
echo "$var" # '(]\{}$"

var2="\\\\\""
echo $var2   #   "
echo "$var2" # \\"
echo
# But ... var2="\\\\"" is illegal. Why?
var3='\\\\'
echo "$var3" # \\\\
# Strong quoting works, though.

