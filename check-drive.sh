#!/bin/sh
# Copyright © 2014 Bart Massey
# [This work is licensed under the Open Software License v. 2.0]
# Please see the file COPYING in the source
# distribution of this software for license terms.
if [ -d /mnt/backup/dirvish ]
then
    echo "backup directory mounted, aborting" >&2
    exit 1
fi
egrep -v '^#' /local/etc/usb-drives |
awk '$1=="backup"{print $2;}' |
while read DEV
do
  BDEV=/dev/disk/by-id/"$DEV"
  if [ -e "$BDEV" ]
  then
    echo "Trying ${BDEV}"
    sudo cryptsetup create -c aes -s 128 backupcheck "$BDEV" </dev/tty &&
    echo "$BDEV mounted for check" &&
    sudo fsck.jfs -f -a /dev/mapper/backupcheck &&
    sudo cryptsetup remove backupcheck &&
    exit 127
    exit 1
  fi
done
if [ $? -ne 127 ]
then
    echo "backup drive not found or failed" >&2
    exit 1
fi
