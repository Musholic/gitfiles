class gitfiles::clone_git_repo (
) {
  $user = $gitfiles::user
  $home = "/home/$user"

  vcsrepo { "$home/git/sys/base16-shell":
    ensure   => present,
    provider => git,
    source   => 'https://github.com/chriskempson/base16-shell.git',
    user     => $user,
  }

  vcsrepo { "$home/git/sys/zgen":
    ensure   => present,
    provider => git,
    source   => 'https://github.com/tarjoilija/zgen.git',
    user     => $user,
  }

  vcsrepo { "$home/git/sys/rofi-power-menu":
    ensure   => present,
    provider => git,
    source   => 'https://github.com/jluttine/rofi-power-menu.git',
    user     => $user,
  }

  vcsrepo { "$home/.vim/bundle/Vundle.vim":
    ensure   => present,
    provider => git,
    source   => 'https://github.com/VundleVim/Vundle.vim.git',
    user     => $user,
  }
}
