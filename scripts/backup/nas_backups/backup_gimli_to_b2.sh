#!/bin/bash
export B2_ACCOUNT_KEY=FROM_KEEPASS
export B2_ACCOUNT_ID=FROM_KEEPASS
export RESTIC_REPO=b2:bckblznasbkp02

backup_result=$(restic backup -r $RESTIC_REPO --files-from /root/backups/.restic_conf/gimli_to_b2/gimli_to_b2.lst -p /root/backups/.restic_conf/gimli_to_b2/gimli_to_b2.pass)
prune_result=$(restic forget --keep-within 1m --prune -r $RESTIC_REPO -p /root/backups/.restic_conf/gimli_to_b2/gimli_to_b2.pass)

echo "Backup results: gimli to b2

${backup_result}

Forget and prune:

${prune_result}
" | mail -s "Backup notification - Gimli :: ${RESTIC_REPO}" -r 'backup_alerts@'$(hostname) -S 'smtp=10.0.0.55:25' home_alerts@protonmail.com

unset B2_ACCOUNT_KEY
unset B2_ACCOUNT_ID
unset RESTIC_REPO
