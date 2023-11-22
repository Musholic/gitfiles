#!/bin/sh
cd $DISK/user/appconfigs
BACKUP=~/.backup-$(date '+%F_%T')
mkdir -p $BACKUP
link_config() {
    dest=$1
    app=$2
    if [ ! -L ~/$dest ]; then
        echo "Linking $app"
        if [ -d ~/$dest ]; then
            mv -v ~/$dest $BACKUP
        fi
        mkdir -p "$app"
        ln -sv $(readlink -f $app) ~/$dest
    fi
}

link_config .config/google-chrome google-chrome
link_config .ssh ssh
link_config .local/share/JetBrains JetBrains
link_config .config/JetBrains JetBrains-conf
link_config .cache/JetBrains JetBrains-cache
link_config .cache/vcpkg vcpkg-cache
link_config .gradle gradle
link_config .vcpkg vcpkg
link_config .vcpkg-clion vcpkg-clion

ln -sT $DISK/user ~/disk &> /dev/null
