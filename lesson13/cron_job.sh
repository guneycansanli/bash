#!/bin/bash

logfile=job_resuls.job

/usr/bin/echo "The script ran at the following time: $(usr/bin/date)" >$logfile

# edit crontab
# crontab -e
# It open temp file 
# 30 1 * * 5 /usr/local/bin/script

# crontab -u <user-name> -e 