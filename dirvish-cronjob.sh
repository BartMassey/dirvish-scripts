#! /bin/sh
#
# daily cron job for the dirvish package
#
if [ ! -x /usr/sbin/dirvish-expire  ]; then exit 0; fi
if [ ! -s /etc/dirvish/master.conf ]; then exit 0; fi
if [ ! -f /mnt/backup-tmp/unmounted ]; then exit 0; fi

PIDFILE=/var/run/dirvish.pid
PIDTMP=/var/run/dirvish-$$.pid
trap "rm -f $PIDTMP" 0 1 2 3 15

mount_check() {
	mntout=`tempfile -p mount`
	mount $1 >$mntout 2>&1
	if [ ! -d $1/lost+found ]; then # only works for "real" filesystems :-)
					# (Yes, I know about reiserfs.)
		echo "'mount $1' failed?! Stopping."
		echo "mount output:"
		cat $mntout
		rm -f $mntout
		exit 2
	fi

	if stat $1 | grep 'Inode: 2[^0-9]' >/dev/null; then # ditto
		rm -f $mntout
		return 0 # ok
	fi
	echo "$1 isn't inode 2 ?! Mount must have failed; stopping."
	echo ''
	stat $1
	echo "mount output:"
	cat $mntout
	rm -f $mntout
	umount $1
	exit 2
}

## Example of how to mount and umount a backup partition...
# mount_check /backup

echo $$ >$PIDTMP
mv -n $PIDTMP $PIDFILE
if [ -s $PIDTMP ]
then
    echo "dirvish-cronjob: locked by pid `cat $PIDFILE`" >&2
    exit 1
fi
trap "rm -f $PIDFILE" 0 1 2 3 15
ionice -c 3 /usr/sbin/dirvish-expire --quiet &&
ionice -c 3 /usr/sbin/dirvish-runall --quiet

# Local hack: rsync windows backups
#rsync -HaXxS --delete --delete-before /storage/backup/windows /mnt/backup/
