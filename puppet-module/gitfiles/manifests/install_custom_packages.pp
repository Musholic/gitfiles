class gitfiles::install_custom_packages (
  $packages,
) {
  file { "$gitfiles::gitfiles_dir/PKGBUILDS":
    recurse      => true,
    recurselimit => 1,
    mode         => "ug+rw,o=",
    group        => "users",
  }

  gitfiles::install_custom_package { $packages: }
}
