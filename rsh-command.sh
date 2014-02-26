#!/bin/sh
# Copyright © 2014 Bart Massey
# [This work is licensed under the Open Software License v. 2.0]
# Please see the file COPYING in the source
# distribution of this software for license terms.
SSHPREFIX=/root/.ssh/id-dsa-dirvish
LOG=/var/log/dirvish/rsh.log
ERRLOG=/var/log/dirvish/rsh-error.log
WHO=$1
exec 2>>$ERRLOG
echo "start $WHO `date`" >&2
HOST="`echo $WHO | sed 's/-.*$//'`"
if [ -f $SSHPREFIX-$HOST ] ; then
  CMD="ssh -i $SSHPREFIX-$HOST $2"
else
  echo "`date`  error: no key for $WHO" >&2
  exit 1
fi
shift 2
echo "`date`  $CMD $*" >>$LOG
$CMD "$@"
echo "finish $WHO `date`" >&2
