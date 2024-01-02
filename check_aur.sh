#!/bin/bash

# Absolute pathname to script directory
base_dir=$(readlink -f $(dirname $0))

mkdir -p /tmp/check_aur
cd /tmp/check_aur

for file in $base_dir/PKGBUILDS/*; do
    pkg=$(basename $file)
    yay -G $pkg
    diff=$(diff $file/PKGBUILD $pkg/PKGBUILD -y --suppress-common-lines | grep -v 'sums')
    echo "$diff"
    if [ -n "$diff" ]; then

        echo "Diff detected, do you want to update this PKGBUILD ?"

        read answer

        if [[ $answer =~ ^[yY]$ ]]; then
            rm $file -rf
            mv $pkg $base_dir/PKGBUILDS/
        fi
    fi
done
