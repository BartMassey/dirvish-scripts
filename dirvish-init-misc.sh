#!/bin/sh
# Copyright © 2014 Bart Massey
# [This work is licensed under the Open Software License v. 2.0]
# Please see the file COPYING in the source
# distribution of this software for license terms.
PGM="`basename $0`"
USAGE="$PGM: usage: $PGM vaults ..."
BANK=/mnt/backup-tmp/dirvish-misc
CONF="--config /etc/dirvish/misc-init.conf"

if [ \! -d $BANK ]
then
  echo "$PGM: bank $BANK not found" >&2
  exit 1
fi

cd /etc/dirvish
for VAULT in "$@"
do
  [ -d $BANK/$VAULT ]
  case $? in
  0)
    echo "$PGM: vault $VAULT exists" >&2
    exit 1
    ;;
  esac
  [ -f $VAULT-default.conf.bak ]
  case $? in
  0)
    ;;
  *)
    echo "$PGM: no config for vault $VAULT" >&2
    exit 1
    ;;
  esac
  echo $VAULT
  mkdir $BANK/$VAULT &&
  mkdir $BANK/$VAULT/dirvish &&
  cp $VAULT-default.conf.bak $BANK/$VAULT/dirvish/default.conf &&
  dirvish $CONF --init --vault $VAULT
  case $? in
  0)
    ;;
  *)
    echo "$PGM: initialization of vault $VAULT failed" >&2
    exit 1
    ;;
  esac
done
