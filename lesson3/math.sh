#!/bin/bash

# expr 30 + 10
# expr 30 - 10
# expr 30 / 10

# expr 100 * 4
# expr: syntax error: unexpected argument ‘xxxxx’
# * is wild card in bash , * is bash is everything like ls -lth /home/*

# expr 100 \* 4 We need to use '\'' escape charater

echo "------------------"

expr 30 + 10
expr 30 - 10
expr 30 / 10
expr 30 \* 10

echo "------------------"

mynum1=100
mynum2=50

expr $mynum1 + $mynum2
expr $mynum1 - $mynum2
expr $mynum1 / $mynum2
expr $mynum1 \* $mynum2

echo "------------------"
echo -e "$mynum1 \n$mynum2"
