class gitfiles::link_home_files (
  $files,
  $dirs,
) {
  $user = $gitfiles::user
  $group = $gitfiles::group
  $home = "/home/$user"
  file { "$gitfiles_dir/home":
    recurse => true,
    group   => "users",
    mode    => "ug+rw,o=",
  }
  # Link files
  $files.each | String $file | {
    $force = $file == '.local/share/autojump' 
    file { "$home/$file":
      ensure => link,
      target => "$gitfiles_dir/home/$file",
      force => $force,
      owner  => $user,
      group  => $group,
    }
  }
  
  $dirs.each | String $dir | {
    file { "$home/$dir":
      ensure => directory,
      owner  => $user,
      group  => $group,
    }
  }

  file { "$gitfiles_dir/home/.ssh":
    recurse => true,
    mode => "u+rw,go-rwx"
  }

}
