#!/bin/sh
[ -d /mnt/backup/dirvish ] ||
/usr/bin/mh/mhmail -subject 'backup directory unmounted' root << 'EOF'
Mount /mnt/backup, please.  --the backup system
EOF
