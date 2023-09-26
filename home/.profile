# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin, dir may be created by npm
PATH="$HOME/.local/bin:$PATH"

# set PATH so it includes snap bin if it exists
if [ -d "/snap/bin" ] ; then
    PATH="/snap/bin:$PATH"
fi
if [ -d "$HOME/rootBin" ] ; then
    PATH="$HOME/rootBin:$PATH"
fi

export EDITOR='vim'
export VISUAL='vim'
export TERMINAL='kitty'
export DISK='/mnt/disk'
export npm_config_prefix="$HOME/.local"
