#!/bin/sh

# exit when any command fails
set -e

echo "Starting update of archiso img"
cd $DISK/sys/archiso-config/
./update_from_gitfiles.sh
cd $DISK/tmp
sudo rm work out -rf
sudo mkarchiso -v ../sys/archiso-config
cd $DISK/archiso
old_iso="old_$(date '+%F_%T').iso"
sudo mv -v current.iso "$old_iso"
sudo mv -v $DISK/tmp/out/*.iso current.iso
sudo rm old.iso
sudo ln -s "$old_iso" old.iso
