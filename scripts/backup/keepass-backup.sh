#!/bin/bash

SRC="/mnt/gimli/Passwords/Keepass/bd-personal-safe.kdbx"
DEST_PATH="/keybase/private/neo1911/backups/passwords"
DEST="${DEST_PATH}/$(date +%Y-%m-%d)_bd-personal-safe.kbdx"
RETENTION=5

# check Keybase is up -- and we have network access

keybase ping > /dev/null 2>&1

if [ ! $? -eq 0 ]
then
    failmsg="Keybase is not available"
elif [ ! -f ${SRC} ]
then
    failmsg="${SRC} is not available. May not be mounted"
else
    failmsg="none"
fi

# Check for failures
if [[ ${failmsg} != "none" ]]
then
    echo "${failmsg}"
    exit
fi

cp -a ${SRC} ${DEST}

todelete=$(find ${DEST_PATH} -name "*_bd-personal-safe.kbdx" -mtime +${RETENTION})

for file in ${todelete[@]}
do
    echo "Deleting file ${todelete} - older than ${RETENTION} days"
   # rm -f ${todelete}
done
