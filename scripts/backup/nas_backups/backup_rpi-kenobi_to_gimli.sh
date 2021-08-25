#!/bin/bash

backup_result=$(restic backup -r /mnt/gimli/Backup/rpi-kenobi_restic -p /root/backups/.restic_conf/rpi-kenobi/restic_rpi-kenobi.pass --files-from /root/backups/.restic_conf/rpi-kenobi/rpi-kenobi_files.lst)

prune_result=$(restic forget --keep-within 5d --prune -r /mnt/gimli/Backup/rpi-kenobi_restic -p /root/backups/.restic_conf/rpi-kenobi/restic_rpi-kenobi.pass)

echo "Backup results: rpi-kenobi to gimli

${backup_result}

Forget and prune:

${prune_result}" | mail -s "Backup notification - rpi-kenobi :: Gimli" -r 'backup_alerts@'$(hostname) -S 'mta=smtp://{{ internal_smtp_ip }}:25' {{ alerts_email_address }}
