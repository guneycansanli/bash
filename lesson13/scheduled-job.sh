#!/bin/bash


#which at
#at is using for schedule a job

logfile=job_resuls.job

echo "The script ran at the following time: $(date)" >$logfile

#at 15:32 -f ./script.sh

#atq 
#atq is show queued jobs

#atrm <job-number>

#at 18:00 081623  (08/16/2023)
#atq


