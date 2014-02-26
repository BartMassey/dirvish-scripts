#!/bin/sh
# Copyright © 2014 Bart Massey
# [This work is licensed under the Open Software License v. 2.0]
# Please see the file COPYING in the source
# distribution of this software for license terms.
TARGET=$1/$2
TARGET_DIR=$1
shift 2
LINKS="`for i in \"$@\"; do echo --link-dest /mnt/backup/dirvish/$TARGET_DIR/$i/tree/ ; done`"
echo cd / '&&' ionice -c 3 rsync -aHAXxS \
  --bwlimit=10240 --ignore-existing \
  --exclude-from=/etc/dirvish/excludes \
  $LINKS \
  . /mnt/backup/dirvish/$TARGET/tree/
