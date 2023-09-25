#!/bin/sh
cd $DISK/cache
BACKUP=/.backup-$(date '+%F_%T')
mkdir -p $BACKUP
link_cache() {
    dest=$1
    app=$2
    if [ ! -L $dest ]; then
        echo "Linking $app"
        if [ -d $dest ]; then
            mv -v $dest $BACKUP
        fi
        ln -sv $(readlink -f $app) $dest
    fi
}

link_cache /var/cache/pacman/pkg pacman
