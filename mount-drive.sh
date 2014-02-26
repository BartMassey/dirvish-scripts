#!/bin/sh
PGM="`basename $0`"
USAGE="$PGM: usage: $PGM [-t]"
DIR=backup
if [ $# -gt 0 ]
then
    case $1 in
    -t) DIR=backup-tmp ;;
    *)  echo "$USAGE" >&2; exit 1 ;;
    esac
    shift
fi
if [ $# -gt 0 ]
then
    echo "$USAGE" >&2; exit 1
fi
/usr/local/bin/mount-usb -m /mnt/$DIR -o relatime -C backup aes 128 backup
