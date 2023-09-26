node default {
  # Generated automatically >>>>
  $gitfiles_dir = "/mnt/disk/sys/gitfiles"
  $home_files        = [ 'flashScripts', 'polybar-scripts', '.config/bspwm', '.config/polybar', '.config/sxhkd', '.p10k.zsh', '.profile', '.vim/colors/base16-bright.vim', '.vimrc', '.xprofile', '.Xresources', '.zshrc', ]
  $home_dirs        = [ '.config', '.vim', '.vim/colors', ]
  $root_files        = [ 'etc/locale.conf', 'etc/locale.gen', 'etc/sudoers', 'etc/systemd/system/onBoot-network.service', 'etc/systemd/system/onBoot.service', 'etc/vconsole.conf', 'etc/X11/xorg.conf.d/10-keyboard-layout.conf', 'opt/rootScripts', ]
  $root_dirs        = [ 'etc/systemd', 'etc/systemd/system', 'etc/X11', 'etc/X11/xorg.conf.d', ]
  $packages    = ['base','base-devel','cloud-init','hyperv','linux','mkinitcpio','mkinitcpio-archiso','open-vm-tools','openssh','pv','qemu-guest-agent','syslinux','virtualbox-guest-utils','puppet','ranger','gvim','tree','ncdu','zsh-completions','htop','iotop','rsync','man-db','gparted','terminus-font','ttf-dejavu','ack','pulseaudio-alsa','erofs-utils','mtools','arch-install-scripts','libisoburn','archiso','go','git','npm','docker','docker-compose','ntfs-3g','asciidoc','xf86-video-intel','gnome-themes-extra','thunar-volman','feh','gimp','pavucontrol','autorandr','xorg-xclock','xorg-xinit','xorg-xprop','xfce4-notifyd','zathura-pdf-mupdf','numlockx','pasystray','polybar','wmname','sxhkd','pacman-contrib','galculator','kitty','ttf-liberation','xdg-utils','bspwm','rofi','wget','xdo','moreutils','unzip','linux-firmware','maim','lightdm','lightdm-gtk-greeter',]
  $custom_packages = ['gitflow-avh','google-chrome','jetbrains-toolbox','srandrd','yay',]
  # <<<<<<<
  filebucket { "main":
  }

  File { backup => main }

  class { 'timezone':
    timezone => 'Europe/Paris',
  }

  class { 'gitfiles':
    gitfiles_dir => $gitfiles_dir,
    user         => 'musholic',
    group        => 'musholic',
  }
  class { 'gitfiles::create_user': }
  ->
  class { 'gitfiles::link_home_files':
    files => $home_files,
    dirs  => $home_dirs,
  }

  class { 'gitfiles::install_custom_packages': 
    packages => $custom_packages,
  }
  ->
  class { 'gitfiles::link_root_files':
    files => $root_files,
    dirs  => $root_dirs,
  }

  Class['gitfiles::create_user']
  ->
  class { 'gitfiles::clone_git_repo': }


  class { 'gitfiles::enable_services': }

  package {$packages:
    ensure => 'installed',
    install_only => true
  }
  ->
  Class['gitfiles::link_root_files']

  Package['docker']
  ->
  Class['gitfiles::create_user']
}
