#!/bin/bash

source ~/.bashrc

backup_result=$(restic backup -r "/mnt/aragorn_backup/gimli" --files-from /root/backups/.restic_conf/gimli_to_aragorn/gimli_local.lst -p /root/backups/.restic_conf/gimli_to_aragorn/gimli_local.pass)
prune_result=$(restic forget --keep-within 5d --prune -r "/mnt/aragorn_backup/gimli" -p /root/backups/.restic_conf/gimli_to_aragorn/gimli_local.pass)

echo "Backup results: gimli to aragorn

${backup_result}

Forget and prune:

${prune_result}
" | mail -s "Backup notification - Gimli :: Aragorn" -r 'backup_alerts@'$(hostname) -S 'smtp=10.0.0.55:25' home_alerts@protonmail.com

