#!/bin/sh
find_files() {
    dir=$1
    for file in $dir/{*,.[^.]*}; do
        if [[ $file != *.swp ]]; then
            if [ -f "$file/.skip" ]; then
                # Skip this directory
                find_files $file
            elif [ -f "$file/.nolink" ]; then
                if [ ! -L "/home/musholic/$file" ]; then
                    # Exclude existing directory symlinks which could point to a disk config
                    dirs+="'${file:2}', "
                fi
                find_files $file
            elif [[ ( -f $file || -d $file ) && $file != */.nolink && $file != */.skip ]]; then
                # Remove ./ prefix
                files+="'${file:2}', "
            fi
        fi
    done
}

if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root" 1>&2
  exit 1
fi

if [ "$1" == "--puppet-only" ]; then
    puppet_only=y
    shift
fi

# Refresh the pacman db if needed
if [ ! -e /var/lib/pacman/sync/core.db ]; then
    sudo pacman -Sy
fi

# Install puppet if needed
type puppet > /dev/null 2>&1 || (echo "Installing required dependency puppet"; pacman -S puppet --noconfirm)
puppet module install puppetlabs-vcsrepo
puppet module install saz-timezone

# Absolute pathname to script directory
base_dir=$(readlink -f $(dirname $0))
manifest=$base_dir/manifest.pp

# Update $gitfiles_dir
sed -re 's|(\$gitfiles_dir *= ).*$|\1"'"$base_dir"'"|g' $manifest -i

# Construct $home_files variable
files='[ '
dirs='[ '
cd $base_dir/home
find_files .
files+=']'
dirs+=']'

# Update variables in manifest.pp
sed -re 's|(\$home_files *= ).*$|\1'"$files"'|g' $manifest -i
sed -re 's|(\$home_dirs *= ).*$|\1'"$dirs"'|g' $manifest -i

# Construct $root_files variable
files='[ '
dirs='[ '
cd $base_dir/root
find_files .
files+=']'
dirs+=']'

# Update variables in manifest.pp
sed -re 's|(\$root_files *= ).*$|\1'"$files"'|g' $manifest -i
sed -re 's|(\$root_dirs *= ).*$|\1'"$dirs"'|g' $manifest -i

packages='['
for pkg in $(grep -h -v '^#' $base_dir/packages); do
    packages+="'$pkg',"
done
packages+=']'

# Update variables in manifest.pp
sed -re 's|(\$packages *= ).*$|\1'"$packages"'|g' $manifest -i

custom_packages='['
for pkg in $base_dir/PKGBUILDS/*; do
    pkg=$(basename $pkg)
    custom_packages+="'$pkg',"
done
custom_packages+=']'

# Update variables in manifest.pp
sed -re 's|(\$custom_packages *= ).*$|\1'"$custom_packages"'|g' $manifest -i

# Apply puppet recipe with option $1 if present
puppet apply --modulepath=$base_dir/puppet-module:/etc/puppetlabs/code/modules $manifest $1

if [ "$1" != "--noop" -a "$puppet_only" != "y" ]; then
        su - musholic -c 'source .zshrc; zgen-update'
        echo "Updating vim plugins"
        su - musholic -c 'vim -i NONE -c VundleUpdate -c quitall' > /dev/null
fi

