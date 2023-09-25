#!/bin/sh
if [ -d /run/archiso/img_dev ]; then
    echo "Remount img_dev rw"
    mount -o remount,rw /run/archiso/img_dev
fi
if [ -e /dev/disk/by-uuid/51d17681-826c-47d7-8a74-29cfe6d72ce8 ]; then
    echo "Mount disk"
    export DISK=/mnt/disk
    mkdir -p $DISK
    mount /dev/disk/by-uuid/51d17681-826c-47d7-8a74-29cfe6d72ce8 $DISK
    echo "Link system cache"
    $DISK/sys/gitfiles/root/opt/rootScripts/linkCache.sh
    echo "Link app configs"
    su musholic -c "DISK=$DISK $DISK/sys/gitfiles/home/flashScripts/link_configs.sh"
    swapon /dev/disk/by-uuid/db23da33-e5f9-4957-acad-84a44ff99841
fi
