#!/bin/bash

# -ne option is if equal
mynum1=200
if [ $mynum1 -eq 200 ]; then
    echo "The condition is true."
fi

# -ne option is if equal
mynum2=300
if [ $mynum2 -eq 200 ]; then
    echo "The condition is true."
fi

# -ne option is if equal
mynum3=200
if [ $mynum3 -eq 200 ]; then
    echo "The condition is true."
else
    echo "The variable does not equal 200."
fi

# -ne option is if equal
mynum4=300
if [ ! $mynum4 -eq 200 ]; then
    echo "The condition is true."
else
    echo "The variable does not equal 200."
fi

# -ne option is if not equal
mynum5=300
if [ $mynum5 -ne 200 ]; then
    echo "The condition is true."
else
    echo "The variable does not equal 200."
fi

# -gt option is if greter than
mynum6=300
if [ $mynum6 -gt 200 ]; then
    echo "The condition is true."
else
    echo "The variable does not equal 200."
fi

# -f option is files if exit
if [ -f ~/myfile ]; then
    echo "The file exist"
else
    echo "The file does not exist"
fi

# -f option is files if exit
command=/usr/bin/htop
if [ -f $command ]; then
    echo "$command is available, let's run it"
else
    echo "$command is not found"
fi

command=htop
if command -v $command; then
    echo "$command is available, let's run it"
else
    echo "$command is not found"
fi


#man test