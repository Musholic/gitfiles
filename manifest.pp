node default {
  # Generated automatically >>>>
  $gitfiles_dir = "/mnt/disk/sys/gitfiles"
  $home_files        = []
  $home_dirs        = []
  $root_files        = []
  $root_dirs        = []
  $packages    = []
  $custom_packages = []
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
