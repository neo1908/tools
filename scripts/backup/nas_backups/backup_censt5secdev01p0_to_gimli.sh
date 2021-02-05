#!/bin/bash

backup_result=$(restic backup -r /mnt/gimli/Backup/censt5secdev01p0_restic -p /root/backups/.restic_conf/censt5secdev01p0/restic_censt5secdev01p0.pass --files-from /root/backups/.restic_conf/censt5secdev01p0/censt5secdev01p0_files.lst
)

prune_result=$(restic forget --keep-within 5d --prune -r /mnt/gimli/Backup/censt5secdev01p0_restic -p /root/backups/.restic_conf/censt5secdev01p0/restic_censt5secdev01p0.pass)

echo "Backup results: censt5secdev01p0 to gimli

${backup_result}

Forget and prune:

${prune_result}" | mail -s "Backup notification - censt5secdev01p0 :: Gimli" -r 'backup_alerts@'$(hostname) -S 'smtp=10.0.0.55:25' home_alerts@protonmail.com
