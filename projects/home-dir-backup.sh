#!/bin/bash
set +xv

: <<'END_COMMENTS'
This script makes a backup of my home directory.
Change the values of the variables to make the script work for you:

Single brackets [ ]: This is the traditional test command in Bash. It performs a comparison based on the specified operators and operands. It's a built-in command in Bash.
Double brackets [[ ]]: This is an enhanced version of the single brackets and is also a built-in command in Bash. It provides additional features such as pattern matching and improved syntax for conditional expressions. It's more flexible and usually preferred over single brackets.
END_COMMENTS

set -xv

BACKUPDIR=/home
BACKUPFILES=$(logname)
LOGNAME=$(logname)
TARFILE=/var/tmp/home_$LOGNAME.tar
BZIPFILE=/var/tmp/home_$LOGNAME.tar.bz2
LOGFILE=/home/$LOGNAME/log/home_backup.log

cd $BACKUPDIR

if [[$? -ne 0 ]]; then
    echo "Can not cd to $BACKUPDIR"
    exit 1
fi

# This creates the archive
tar cf $TARFILE $BACKUPFILES >/dev/null 2>&1

# First remove the old bzip2 file.  Redirect errors because this generates some if the archive
# does not exist.  Then create a new compressed file.
rm $BZIPFILE 2>/dev/null
bzip2 $TARFILE

# Create a timestamp in a logfile.
date >>$LOGFILE
echo backup succeeded >>$LOGFILE
