#!/bin/bash

clear
printf "This is informations provided by system-info.sh. Program is starting.\n"

printf "Hello, $USER.\n\n"

printf "Date: $(date) \nWeek: $(date +"%V")\n\n"

printf "User on the server/VM : \n "
w | cut -d " " -f 1 - | grep -v USER | sort -u

printf "\n"

printf "This is $(uname -s) running on a $(uname -m) processor. \n\n"

printf "This is uptime information:\n $(uptime)"

printf "\n That is all folks..."
printf "\n"

