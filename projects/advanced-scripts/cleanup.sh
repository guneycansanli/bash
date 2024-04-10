#!bin/bash

: <<'COMMENTS'
Cleanup script, A script to clean up log files in /var/log
COMMENTS

#   Warning
#   -------
#   This script uses quite a number of features that will be explained
#+  later on.

LOG_DIR=/var/log
ROOT_UID=0   # Only users with $UID 0 have root privileges
LINES=50     # Default number of lines saved.
E_XCD=86     # Can not change directory?
E_NOTROOT=87 # Non-root exit error.

# Run as root , of course.
if [[ "$UID" == "$ROOT_UID" ]]; then
    printf "\nMust be root to run this script"
    exit $E_NOTROOT
fi

if [ -n "$1" ]; then # Test whether command-line argument is present (non-empty).
    lines=$1
else
    lines=$LINES # Default, if not specified on command-line.
fi

cd $LOG_DIR

if [[ $(pwd) != "$LOG_DIR" ]]; then # or   if [ "$PWD" != "$LOG_DIR" ]
    echo "Can not change directory to $LOG_DIR"
    exit $E_XCD
fi # double check if in directiry before messing with log file.

tail -n $lines messages >mesg.temp # Save last section of messages log file.
mv mesg.temp messages              # Rename it as system log file.


#   cat /dev/null > messages
#* No longer needed, as athe above method safer

cat /dev/null > wtmp # ': > wtmp' and '> wtmp'  have the same effect.
echo "Log files cleaned up."

exit 0 

#  A zero return value from the script upon exit indicates success
#+ to the shell.