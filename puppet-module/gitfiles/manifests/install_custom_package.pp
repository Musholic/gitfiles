define gitfiles::install_custom_package (
  $package = $title,
) {
  exec { "Install $package":
    command     => "/usr/bin/ls $package*.pkg.tar.* -t | /usr/bin/head -n1 | /usr/bin/xargs /usr/bin/pacman -U --noconfirm",
    cwd         => "$gitfiles::gitfiles_dir/PKGBUILDS/$package",
    unless      => "/usr/bin/su musholic -c '/usr/bin/makepkg -c'; /usr/bin/pacman -Q $package && /usr/bin/expr \$(/usr/bin/ls $package*.pkg.tar.* -t | /usr/bin/head -n1) : \"$package-\$(/usr/bin/pacman -Q $package | /usr/bin/cut -f 2 -d' ')\"",
  }
}
