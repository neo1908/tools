#!/bin/bash

#OUTDIR="/mnt/gimli/Plex/Youtube/"
OUTDIR="./stage/"
#OUTDIR="/home/ben/youtubedl/Staging/"
FORMAT=${OUTDIR}"%(uploader)s/%(title)s/%(uploader)s-%(title)s_%(upload_date)s_%(resolution)s.%(ext)s"
ARCHIVE_FILE=${OUTDIR}downloads.lst
OPTS="-i --restrict-filenames -a ./channels.lst --write-description --write-info-json --write-annotations --write-thumbnail --all-subs --audio-quality 0 -o ${FORMAT} --download-archive ${ARCHIVE_FILE} -f best"
#OPTS="--restrict-filenames -a ./one_off.txt --write-description --write-info-json --write-annotations --write-thumbnail --all-subs --audio-quality 0 -o ${FORMAT} --download-archive ${ARCHIVE_FILE} -f best"

youtube-dl ${OPTS}
