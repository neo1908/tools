#Global Vars
KEY_ID="65D5C4F2"
GIMLI_BASE="/home/ben/gimli/Backup/"
LOG_BASE="${GIMLI_BASE}logs/"
export PASSPHRASE="FROM_PASS_SAFE::PKI/PGP/Duplicity"

#Backup list of files on censt5secdev01p0
censt5secdev01p0()
{

  SRC=" / --exclude /home/ben/gimli/ --include /etc --include /home --include /usr/local --include /usr/share --include /root"  
  DEST_PATH="${GIMLI_BASE}Hosts/$(hostname -s)/"
  DEST="file://${DEST_PATH}"
  OPTS="--progress --archive-dir ${DEST_PATH}local_cache --encrypt-sign-key ${KEY_ID}"
  LOG="$(hostname -s)_duplicity.log"

  # REmove older than 1 month
  OLDER_THAN="1M"

  run "${OPTS}" "${SRC}" "${DEST}" "${LOG}" "${OLDER_THAN}"
}

gimli_local()
{

  SRC=" /home/ben/gimli/ --include /home/ben/gimli/Certificates --include /home/ben/gimli/Infosec --include /home/ben/gimli/Keys --include /home/ben/gimli/LDAP --include /home/ben/gimli/Library --include /home/ben/gimli/Passwords --include /home/ben/gimli/Personal"  
  DEST_PATH="/mnt/aragorn_backup/Gimli/"
  DEST="file://${DEST_PATH}"
  OPTS="--progress --archive-dir ${DEST_PATH}cache --encrypt-sign-key ${KEY_ID}"
  LOG="gimli_local_duplicity.log"

  OLDER_THAN="1M"

  run "${OPTS}" "${SRC}" "${DEST}" "${LOG}" "${OLDER_THAN}"
}

gimli_remote()
{


  SRC=" /home/ben/gimli/ --exclude /home/ben/gimli/Backup/ --exclude /home/ben/gimli/Nexus"   
  DEST_PATH="Backup/Gimli"
  DEST="b2://002e0b7884771a70000000001:K002Fu6+mOR2JXQhml08qcVzX3nmTZE@bckblznasbkp01/${DEST_PATH}"
  OPTS="--progress --encrypt-sign-key ${KEY_ID}"
  LOG="gimli_local_duplicity.log"

  OLDER_THAN="1M"

  duplicity  ${SRC} ${DEST} ${OPTS} --log-file ${LOG}
  duplicity remove-older-than ${OLDER_THAN} --log-file ${LOG} ${DEST}
}

cleanup_remote()
{

  DEST_PATH="Backup/Gimli"
  DEST="b2://002e0b7884771a70000000001:K002Fu6+mOR2JXQhml08qcVzX3nmTZE@bckblznasbkp01/${DEST_PATH}"
  LOG="gimli_local_duplicity.log"

  duplicity cleanup --force ${DEST}
}

run()
{
    OPTS=$1
    SRC=$2
    DEST=$3
    LOG=${LOG_BASE}$4
    OLDER_THAN=$5

    pushd /root

    duplicity  ${SRC} --exclude '**' ${DEST} ${OPTS} --log-file ${LOG}
    duplicity remove-older-than ${OLDER_THAN} --log-file ${LOG} ${DEST}

    popd

}

$1
unset PASSPHRASE
