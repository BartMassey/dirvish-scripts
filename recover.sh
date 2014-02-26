#!/bin/sh
TARGET=$1/$2
TARGET_DIR=$1
shift 2
LINKS="`for i in \"$@\"; do echo --link-dest /mnt/backup/dirvish/$TARGET_DIR/$i/tree/ ; done`"
echo cd / '&&' ionice -c 3 rsync -aHAXxS \
  --bwlimit=10240 --ignore-existing \
  --exclude-from=/etc/dirvish/excludes \
  $LINKS \
  . /mnt/backup/dirvish/$TARGET/tree/
