class gitfiles::create_user (
) {
  $user = $gitfiles::user

  user { $user:
    ensure     => 'present',
    home       => "/home/$user",
    password   => '$6$tlO58W.HRX6ch3XC$Jge0SmDkCAeqrR/eXeifGo9ekwzSB9pPNw/9zXg4w4DwOq.n7qrS599Ox.jkATqELtd08ZHTcdLohZmNoPM/C0',
    shell      => '/bin/zsh',
    groups     => ['users', 'wheel', 'docker', 'vboxsf'],
    managehome => true,
  }
}
