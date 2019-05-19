#!/bin/bash

export PASSPHRASE=""

BASEDIR=/mnt/gimli/Backup/Hosts/RaspberryPI/rspst5dnsp0
OPTS="--archive-dir ${BASEDIR}/cache --encrypt-sign-key FD470F6F --log-file ${BASEDIR}/logs/backup/duplicity.log"

duplicity / --include /etc --include /home --include /usr/local --exclude /root/ca --include /root --exclude '**' file://${BASEDIR}/backups ${OPTS} | tee -a /var/log/backup.sh.log

echo "Starting rsync of logs" >> /var/log/backup.sh.log

rsync -av /var/log/* ${BASEDIR}/logs/ | tee -a /var/log/backup.sh.log
rsync -av /root/ca/* /mnt/gimli/Certificates/PKI_v2/ | tee -a /var/log/backup.sh.log
