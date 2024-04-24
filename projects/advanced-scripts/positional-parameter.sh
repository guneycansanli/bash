#!/bin/bash

: <<'COMMENTS'
Call this script with at least 10 parameters, for example
 ./script 1 2 3 4 5 6 7 8 9 10
COMMENTS

MINPARAMS=10

echo

echo "The name of script is \"$0\"."
# Adds ./ for current diectory
echo "The name of scipt is \"$(basename $0)\"."
#Stripts out path name is (see 'basename')

echo

if [ -n "$1" ]; then          # Tested variable is quoted
    echo "Parameter #1 is $1" # Need quatos to escape
fi

if [ -n "$2" ]; then          # Tested variable is quoted
    echo "Parameter #2 is $2" # Need quatos to escape
fi

if [ -n "$3" ]; then          # Tested variable is quoted
    echo "Parameter #3 is $3" # Need quatos to escape
fi

if [ -n "$4" ]; then          # Tested variable is quoted
    echo "Parameter #4 is $4" # Need quatos to escape
fi

if [ -n "$5" ]; then          # Tested variable is quoted
    echo "Parameter #5 is $5" # Need quatos to escape
fi

if [ -n "$6" ]; then          # Tested variable is quoted
    echo "Parameter #6 is $6" # Need quatos to escape
fi

if [ -n "$7" ]; then          # Tested variable is quoted
    echo "Parameter #7 is $7" # Need quatos to escape
fi

if [ -n "$8" ]; then          # Tested variable is quoted
    echo "Parameter #8 is $8" # Need quatos to escape
fi

if [ -n "$9" ]; then          # Tested variable is quoted
    echo "Parameter #9 is $9" # Need quatos to escape
fi

if [ -n "${10}" ]; then # Parameters > $9 must be enclosed in {brackets}.
    echo "Parameter #10 is ${10}"
fi

echo "----------------------------------"
echo "All variables are : $*"

if [ $# -lt "$MINPARAMS" ]; then
    echo
    echo "This script needs at least $MINPARAMS command-line arguments!"
fi

echo 
exit 0

