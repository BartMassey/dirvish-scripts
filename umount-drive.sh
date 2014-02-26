#!/bin/sh
if [ -f /mnt/backup/unmounted ] && [ -f /mnt/backup-tmp/unmounted ]
then
    echo "drive not mounted" >&2
    if [ -f /dev/mapper/backup ]
    then
	echo "no drive mapping" >&2
    else
	sudo cryptsetup remove backup
    fi
    exit 1
fi
[ -f /mnt/backup/unmounted ] || sudo umount /mnt/backup
[ -f /mnt/backup-tmp/unmounted ] || sudo umount /mnt/backup-tmp
sudo cryptsetup remove backup
