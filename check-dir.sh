#!/bin/sh
# Copyright © 2014 Bart Massey
# [This work is licensed under the Open Software License v. 2.0]
# Please see the file COPYING in the source
# distribution of this software for license terms.
[ -d /mnt/backup/dirvish ] ||
/usr/bin/mh/mhmail -subject 'backup directory unmounted' root << 'EOF'
Mount /mnt/backup, please.  --the backup system
EOF
