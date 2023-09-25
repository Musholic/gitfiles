#!/bin/sh
if [ -e /dev/disk/by-uuid/51d17681-826c-47d7-8a74-29cfe6d72ce8 ]; then
    export DISK=/mnt/disk
    echo "Update gitfiles"
    $DISK/sys/gitfiles/update.sh --puppet-only
fi
