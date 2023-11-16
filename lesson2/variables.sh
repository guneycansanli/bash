#!/bin/bash

#Declare variables
myname="Guney"
myage="25"

#Print your variables
echo "Hello, my name is $myname."
echo "I'm $myage years old."

#Echo strings
echo "-------------------"
echo "Linux is awesome"
echo "Sunny days are awesome"
echo "-------------------"

#using same variable multuiple times
word="awesome"
echo "Linux is $word"
echo "Sunny days are $word"

echo "---------------"

#Using variables as sub-shell, We can declare commands out put as variable, with --> variable-name=$(command)
now=$(date)
echo "Sysyem time and date is:"
echo $now

echo "-----------------"
date
echo "------------------"

#Example using
name="Guneycan Sanli"
now=$(date)
echo "Hello $name"
echo "System time and date is:"
echo $now
echo "Your username is: $USER"
echo "-------------------"
