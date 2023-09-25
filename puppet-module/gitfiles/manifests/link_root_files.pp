class gitfiles::link_root_files (
  $files,
  $dirs,
){
  file { "$gitfiles_dir/root":
    recurse => true,
    owner   => "root",
    group   => "root",
  }
  # Link files
  $files.each | String $file | {
    file { "/$file":
      ensure => link,
      target => "$gitfiles_dir/root/$file",
      owner  => "root",
      group  => "root",
      # To replace directories by links
      force  => true,
    }
  }
  
  $dirs.each | String $dir | {
    file { "/$dir":
      ensure => directory,
      owner  => "root",
      group  => "root",
    }
  }
  exec { "/usr/bin/locale-gen":
      subscribe     => File["/etc/locale.gen"],
      refreshonly => true,
  }
}
