#!/bin/sh
# Copyright © 2014 Bart Massey
# [This work is licensed under the Open Software License v. 2.0]
# Please see the file COPYING in the source
# distribution of this software for license terms.
HOST=`hostname`
RSYNC_BASE="rsync --server --sender -vlHogDtprxSe.iLs --bwlimit=20000 --numeric-ids ."
exec 2>>/var/log/dirvish/rsh.log
echo "starting `date`" >&2
for TREE in / /stash/ /boot/
do
    case "$SSH_ORIGINAL_COMMAND" in
    "$HOST $RSYNC_BASE $TREE")
	echo "executing '$RSYNC_BASE $TREE'" >&2
	exec /usr/bin/$RSYNC_BASE $TREE
	echo "rsync command failed to execute" >&2
	exit 1
	;;
    esac
done
echo "rsync command '$SSH_ORIGINAL_COMMAND' bad match" >&2
exit 1
